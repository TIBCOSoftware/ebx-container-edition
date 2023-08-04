#!/usr/bin/env bash
#
#
# Copyright Cloud Software Group, Inc. 2023.
#
# Create PostgreSQL user and database for an EBX instance
#
# The script is designed to be executed more than once.
#
# PSQL environment must be set to login a super user to the database.
# PGUSER, PGPASSWORD and PGDATABASE variables are initialized from the "install.sh" bash script of the postgres directory when the postgres server is deployed. (location :_ebx-build/ece/kubernetes/helm/postgres/install.sh)
# The EBX instance will use the variables set in the secret-postgres-server.yaml file (location : _ebx-build/ece/kubernetes/helm/postgres/chart/postgres/templates/secret-postgres-server.yaml)
# The variables of the secret-postgres-server.yaml file must match values set in the install.sh postgres file.
#
# The following input environment variables are mandatory:
#  PGUSER: The postgres super user name (selected default value: postgres).
#  PGPASSWORD: The postgres super user password.
#  PGPORT: The port number to connect to at the server host (selected default value: 5432).
#  PGHOST: The name of host to connect to.
#  PGDATABASE: The database name (selected default value: masterdb).
#  EBX_DB_USER: The ebx user name.
#  EBX_DB_PASSWORD: The ebx user password.
#  EBX_DB_DATABASE: The database name.
#
# This script does the following:
#  - If user does not exist, create it.
#  - Always set the user's password.
#  - If database does not exists, create it.
#  - Always give user full access to the database.
#  - Always remove all access from role public to the database.
#

# Stop on first error.
set -e

PSQL="psql -v ON_ERROR_STOP=1 -q"

if [[ -z "${EBX_DB_USER}" ]]; then
  echo "ERROR:  Variable EBX_DB_USER is not set."
  exit 1
fi

if [[ -z "${EBX_DB_PASSWORD}" ]]; then
  echo "ERROR:  Variable EBX_DB_PASSWORD is not set."
  exit 1
fi

if [[ -z "${EBX_DB_DATABASE}" ]]; then
  echo "ERROR:  Variable EBX_DB_DATABASE is not set."
  exit 1
fi

#
# Using a heredoc for the SQL script allows shell variables substitution. PSQL equivalent is somewhat limited especially
# when using PL/pgSQL code.
#

$PSQL <<EOF
do
\$\$

-- Create or update user.

begin
    create user ${EBX_DB_USER};
exception
    when duplicate_object then raise INFO 'User ''${EBX_DB_USER}'' already exists.';
end
\$\$;

alter user ${EBX_DB_USER} with password '${EBX_DB_PASSWORD}';

-- Create or update database.

\o /dev/null
select exists(select 1 from pg_database where datname=lower('${EBX_DB_DATABASE}')) as is_database;
\gset

\if :is_database
    \echo 'INFO:  Database ''${EBX_DB_DATABASE}'' already exists.'
\else
    create database ${EBX_DB_DATABASE};
\endif

revoke all on database ${EBX_DB_DATABASE} from public;
grant all on database ${EBX_DB_DATABASE} to group ${EBX_DB_USER};

EOF

echo "INFO:  Database '${EBX_DB_DATABASE}' and user '${EBX_DB_USER}' are correctly set"
