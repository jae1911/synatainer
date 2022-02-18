#!/bin/bash

# tag::doc[]
# Purges all rooms without local members from the database
# # end::doc[]

set -x
set -e

for room_id in $(curl -sSL --header "Authorization: Bearer $BEARER_TOKEN" \
    'http://127.0.0.1:8008/_synapse/admin/v1/rooms?limit=1000&order_by=joined_local_members&dir=b' | jq -r '.rooms[] | select(.joined_local_members == 0) | .room_id'); do
  echo "purge room $room_id.."
  curl --header "Authorization: Bearer $BEARER_TOKEN" \
    -X DELETE -H "Content-Type: application/json" -d "{ \"purge\": true }" "http://127.0.0.1:8008/_synapse/admin/v1/rooms/${room_id}"
  echo "done."
done
