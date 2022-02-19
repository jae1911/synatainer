#!/bin/bash

# tag::doc[]
# Vacuum the database
# end::doc[]

set -eux

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

for table in $(psql -d synapse --tuples-only -P pager=off -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name NOT IN ('state_groups_state');"); do
  psql -d synapse -c "VACUUM FULL VERBOSE $table;"
done
