#!/bin/bash

# tag::doc[]
# Automagic synapse maintenance background service.
# What it does (default):
#    daily:
#      purge all rooms without local members
#      run the state autocompressor (small setting)
#    weekly:
#      delete old remote media
#      delete old message history
#    monthly:
#      run the state autocompressor (big setting)
#      vacuum the database
# # end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

echo "not yet."

#crond -f -l 8

exit 0
