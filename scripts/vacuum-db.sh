#!/bin/bash

# tag::doc[]
# Vacuum the database
# end::doc[]

set -ex

for table in $(psql -d synapse --tuples-only -P pager=off -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name NOT IN ('state_groups_state');"); do
  psql -d synapse -c "VACUUM FULL VERBOSE $table;"
done
