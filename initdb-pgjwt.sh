#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"


# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading pgjwt & pgagent extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA $POSTGRES_EXTENSION_SCHEMA;
		CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA $POSTGRES_EXTENSION_SCHEMA;
EOSQL
done
