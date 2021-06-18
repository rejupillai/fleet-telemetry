FROM postgres:10.0
MAINTAINER rejupillai

WORKDIR /

COPY init-fleet-telemetry-db.sh /docker-entrypoint-initdb.d/init-fleet-telemetry-db.sh 

ENV POSTGRES_PASSWORD=postgres_password