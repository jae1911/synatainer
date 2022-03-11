#!/bin/sh

set -eu

# if a command was given, execute it
if [ -n "$*" ]
then
  # if run as root (uid 0), downgrade yourself to nobody (uid 65534)
  if [ $(id -u) -eq 0 ]
  then
    cd /tmp
    exec su -s /bin/sh nobody -c "$*"
  else
    exec "$@"
  fi
fi

# no command given, setup the background service

su -s /bin/sh nobody -c "/setup-crontab.sh"

# start crond

crond -f -l 8

echo "If you can read this, something went terrible wrong."
