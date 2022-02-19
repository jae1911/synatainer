#!/bin/bash

# tag::doc[]
# Purge the remote media cache
# # end::doc[]

set -ex

curl --header "Authorization: Bearer $BEARER_TOKEN" \
    -X POST -H "Content-Type: application/json" -d "{}" \
    'http://127.0.0.1:8008/_synapse/admin/v1/purge_media_cache?before_ts='`date --date='1 days ago' +%s`'000'
