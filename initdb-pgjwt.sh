#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'template_pgjwt' template db
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE template_pgjwt;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_pgjwt';
EOSQL

# Load pgjwt into both template_database and $POSTGRES_DB
for DB in template_pgjwt "$POSTGRES_DB"; do
	echo "Loading pgjwt & pgagent extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE SCHEMA IF NOT EXISTS $POSTGRES_EXTENSION_SCHEMA;
		CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA $POSTGRES_EXTENSION_SCHEMA;
		CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA $POSTGRES_EXTENSION_SCHEMA;
EOSQL
done
