#!/bin/bash

# tag::doc[]
# Purge old hostory from all public joinable rooms
# # end::doc[]

set -ex

exit 1

#!/bin/bash

. mda.config

set -x
set -e

time_stamp=$(date +%s%3N --date='40 days ago')


curl --header "Authorization: Bearer $BEARER_TOKEN" \
    'http://127.0.0.1:8008/_synapse/admin/v1/rooms?limit=1000' | jq -r '.rooms[] | select(.federatable == true and .canonical_alias != null) | .room_id' > histwipe_rooms.txt


while read -r room_id
do
  purge_id=$(curl --header "Authorization: Bearer $BEARER_TOKEN" \
    -X POST -H "Content-Type: application/json" -d "{ \"purge_up_to_ts\": $time_stamp }" "http://127.0.0.1:8008/_synapse/admin/v1/purge_history/${room_id}" | jq -r '.purge_id')

  while true ; do
    status=$(curl -sSLf --header "Authorization: Bearer $BEARER_TOKEN" \
      "http://127.0.0.1:8008/_synapse/admin/v1/purge_history_status/$purge_id" | jq -r '.status')

    echo "status: $status"

    if [ $status != "active" ]; then
      break
    fi

    echo "15 sec pennen..."
    sleep 15s

  done
done < histwipe_rooms.txt



exit 0
