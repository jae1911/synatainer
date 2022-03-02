#!/bin/sh

# if i figure out the syntax this may go inlined in entrypoint

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

(echo "2 2 * * * /usr/local/bin/synatainer.sh") | crontab -

if [ -n "${MAILTO:-}" ]; then
  (echo "MAILTO=$MAILTO"; crontab -l) | crontab -
fi

crontab -l
