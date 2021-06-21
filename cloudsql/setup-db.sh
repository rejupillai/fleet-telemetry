#! /bin/bash

#  @rejupillai

#  Purpose :  This script creates a master and replica database and sets a synchronous replication ON.#

# Project Config

export PROJECT_NAME="delhidc-ce-demo"

# Master DB configurations
export MASTER="master-db"
export MASTER_REGION="us-central1"
export DB_FLAVOR="POSTGRES_10"
export DB_PASSWORD="password123"
export PG_ROOT_USER="postgres"


# Replica configurations
export REPLICA="replica-db"
export REPLICA_REGION="europe-west1"
export REPLICATION_TYPE="synchronous"


# gcloud sql instances create ${MASTER} \
#             --database-version=${DB_FLAVOR} --cpu=2 --memory=8GiB \
#             --region=${MASTER_REGION} --root-password=${DB_PASSWORD} 


gcloud sql instances create ${REPLICA}  --master-instance-name=${MASTER} --replication=${REPLICATION_TYPE} \
            --database-version=${POSTGRES_10} --cpu=2 --memory=8GiB \
            --region= --root-password=${DB_PASSWORD}

# chmod +x postgres-db/init-fleet-telemetry-db.sh
# postgres-db/init-fleet-telemetry-db.sh


# Userful commands

# ./cloud_sql_proxy -credential_file=./sql-sa.json  -instances=awesome-anthos:us-east1:master-db=tcp:5432 &
# ./cloud_sql_proxy -credential_file=./sql-sa.json  -instances=awesome-anthos:us-west1:replica-db=tcp:5432 &
# PGPASSWORD=password123 psql -h 127.0.0.1 -U postgres

# gcloud sql instances describe master-db
# gcloud sql instances describe replica-db