#!/bin/bash

# tag::doc[]
# Purge the remote media cache
# # end::doc[]

set -eux

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

curl --header "Authorization: Bearer $BEARER_TOKEN" \
    -X POST -H "Content-Type: application/json" -d "{}" \
    '$SYNAPSE_HOST/_synapse/admin/v1/purge_media_cache?before_ts='`date --date='$MEDIA_MAX_AGE days ago' +%s`'000'
