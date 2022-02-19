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

set -eux

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

remote_cache_purge.sh

purge_rooms_no_local_members.sh

purge_history.sh

synapse_auto_compressor -p "postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST/synapse" -n 100 -c 500

vacuum-db.sh
