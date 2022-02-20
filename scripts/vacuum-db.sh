#!/bin/bash

# tag::doc[]
# Vacuum the database
# end::doc[]

set -eux

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

psql_cmd="user=$DB_USER password=$DB_PASSWORD -d $DB_NAME -h $DB_HOST"

for table in $($psql_cmd --tuples-only -P pager=off -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"); do
  $psql_cmd -c "VACUUM FULL VERBOSE $table;"
done
