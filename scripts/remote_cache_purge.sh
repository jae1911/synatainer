#!/bin/bash

# tag::doc[]
# Purge the remote media cache older than MEDIA_MAX_AGE days.
# Default: 90
# # end::doc[]

set -eux

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

curl --header "Authorization: Bearer $BEARER_TOKEN" \
    -X POST -H "Content-Type: application/json" -d "{}" \
    "${SYNAPSE_HOST:-http://127.0.0.1:8008}/_synapse/admin/v1/purge_media_cache?before_ts="`date --date="${MEDIA_MAX_AGE:-90} days ago" +%s`'000'
