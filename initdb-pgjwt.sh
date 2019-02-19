#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"


# Load pgjwt into $POSTGRES_DB
for DB in "$POSTGRES_DB"; do

	echo "Loading pgjwt extensions into $DB"
	psql --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS pgcrypto;
		CREATE EXTENSION IF NOT EXISTS pgjwt;
EOSQL
done
