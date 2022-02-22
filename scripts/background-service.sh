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

LOCK_FILE=/var/lock/cron_configured

if [ ! -f $LOCK_FILE ]; then

  ln /usr/local/bin/purge_rooms_no_local_members.sh /etc/periodic/daily
  ln /usr/local/bin/autocompressor-small.sh /etc/periodic/daily

  ln /usr/local/bin/remote_cache_purge.sh /etc/periodic/weekly
  ln /usr/local/bin/purge_history.sh /etc/periodic/weekly

  ln /usr/local/bin/autocompressor-big.sh /etc/periodic/monthly
  ln /usr/local/bin/vacuum-db.sh /etc/periodic/monthly

  touch $LOCK_FILE

fi

echo "Starting cron."

crond -f -l 8 -L /var/log/crond

echo "cron stopped unexpexted."
