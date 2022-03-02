#!/bin/sh

# tag::doc[]
# Synapse maintenance script.
# What it does:
#     purge all rooms without local members
#     run the state autocompressor (small setting)
#     delete old remote media
#     delete old message history
#     run the state autocompressor (big setting)
#     vacuum the database
#
# Usage: synatainer.sh [emergency]
#     emergency: do a complete service run with settings to free as much space as possible 
# end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

remote_cache_purge.sh

purge_rooms_no_local_members.sh

purge_history.sh

synapse_auto_compressor -p "user=$DB_USER password=$DB_PASSWORD dbname=$DB_NAME host=$DB_HOST" -n ${STATE_AUTOCOMPRESSOR_CHUNKS_TO_COMPRESS:-100} -c ${STATE_AUTOCOMPRESSOR_CHUNK_SIZE:-500}

vacuum-db.sh
