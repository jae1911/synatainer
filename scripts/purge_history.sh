#!/bin/sh

# tag::doc[]
# Purge old hostory from all public joinable rooms
# # end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

before_ts=$(expr $(date '+%s') - $(expr ${HISTORY_MAX_AGE:-180} \* 86400))

room_list=$(curl -sSL --header "Authorization: Bearer $BEARER_TOKEN" \
    "${SYNAPSE_HOST:-http://127.0.0.1:8008}/_synapse/admin/v1/rooms?limit=1000" | jq -r '.rooms[] | select(.federatable == true and .canonical_alias != null) | .room_id')

for room_id in $room_list; do
  echo "Purge history from room: $room_id"
  purge_id=$(curl -sSL --header "Authorization: Bearer $BEARER_TOKEN" \
    -X POST -H "Content-Type: application/json" -d "{ \"purge_up_to_ts\": $before_ts }" "${SYNAPSE_HOST:-http://127.0.0.1:8008}/_synapse/admin/v1/purge_history/${room_id}" | jq -r '.purge_id')

  while true ; do
    status=$(curl -sSL --header "Authorization: Bearer $BEARER_TOKEN" \
      "${SYNAPSE_HOST:-http://127.0.0.1:8008}/_synapse/admin/v1/purge_history_status/$purge_id" | jq -r '.status')

    echo "status: $status"

    if [ $status != "active" ]; then
      break
    fi

    echo "sleep 5 sec ..."
    sleep 5s

  done

  echo "Done."

done
