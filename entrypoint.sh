#!/bin/sh

set -eu

# if run as root (uid 0), downgrade yourself to nobody (uid 65534)
if [ $(id -u) -eq 0 ]
then
  exec su -s /bin/sh nobody -c "$0 $*"
fi

if [ -n "$*" ]
then
    exec "$@"
else
    exec /bin/sh
fi

echo "If you can read this, something went terrible wrong."
