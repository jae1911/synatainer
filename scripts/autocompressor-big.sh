#!/bin/bash

# tag::doc[]
# 
# end::doc[]

set -eu

CONFIG_FILE=/conf/synatainer.conf && test -f $CONFIG_FILE && source $CONFIG_FILE

synapse_auto_compressor -p "user=$DB_USER password=$PGPASSWORD dbname=$DB_NAME host=$DB_HOST" -n ${STATE_AUTOCOMPRESSOR_CHUNKS_TO_COMPRESS_BIG:-300} -c ${STATE_AUTOCOMPRESSOR_CHUNK_SIZE_BIG:-1500}
