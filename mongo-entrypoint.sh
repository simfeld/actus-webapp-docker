#!/bin/sh

echo "Migrating forms and demos data to MongoDB"
# list of all form and demo files
demos=$(find /data/json -name '*.json')

# remove database
mongo --host mongo actusweb --eval "printjson(db.dropDatabase())"

# add new demos collection
for f in $demos; do
	mongoimport --host mongo --db actusweb --collection demos --file $f
done

exec "$@"
