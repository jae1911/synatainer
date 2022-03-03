#!/bin/sh

# tag::doc[]
# Automagic synapse maintenance script.
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
#
# This script is intended to be run by cron daily
# # end::doc[]

set -eu


CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

# daily 
purge_rooms_no_local_members.sh

# weekly, monday
if [ $(date '+%u') -eq 1 ]; then
  remote_cache_purge.sh
  purge_history.sh
fi

# monthly, first
if [ $(date '+%d') -eq 1 ]; then
  autocompressor-big.sh
  vacuum-db.sh
else
  autocompressor-small.sh
fi
