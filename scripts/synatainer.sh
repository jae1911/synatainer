#!/bin/bash

# tag::doc[]
# Automagic synapse maintenance script.
# What it does:
#    delete old remote media
#    purge all rooms without local members
#    delete old message history
#    run the state autocompressor
#    vacuum the database
# # end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

remote_cache_purge.sh

purge_rooms_no_local_members.sh

purge_history.sh

synapse_auto_compressor -p "user=$DB_USER password=$DB_PASSWORD dbname=$DB_NAME host=$DB_HOST" -n ${STATE_AUTOCOMPRESSOR_CHUNKS_TO_COMPRESS:-100} -c ${STATE_AUTOCOMPRESSOR_CHUNK_SIZE:-500}

vacuum-db.sh
