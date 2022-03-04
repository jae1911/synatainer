#!/bin/sh

# tag::doc[]
# Vacuum the database
# end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

psql_cmd="psql -U $DB_USER -d $DB_NAME -h $DB_HOST"

for table in $($psql_cmd --tuples-only -P pager=off -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';"); do
  $psql_cmd -c "VACUUM FULL VERBOSE $table;"
done
