#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE telemetry;
    \connect telemetry;
	CREATE TABLE tracks (
    	vehicle_name    char(30),
    	lat             decimal,
        lon             decimal
	);

	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('amritsar_packers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('amritsar_packers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('amritsar_packers', 0,0);


	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('jammu_carriers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('jammu_carriers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('jammu_carriers', 0,0);

	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('namma_bengaluru_logistics', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('namma_bengaluru_logistics', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('namma_bengaluru_logistics', 0,0);

	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('purani_dilli_trucking', 0,0);
    INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('purani_dilli_trucking', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('purani_dilli_trucking', 0,0);

	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('worli_packers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('worli_packers', 0,0);
	INSERT INTO tracks (vehicle_name, lat, lon) VALUES ('worli_packers', 0,0);

EOSQL