#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE telemetry;
    \connect telemetry;
	CREATE TABLE vehicle_position (
    	name    		char(50),
    	lat             decimal,
        lng             decimal,
		timestamp		timestamptz,
		speed			decimal
	);

	set timezone to 'Asia/Calcutta';
	table vehicle_position ; 
	

	INSERT INTO vehicle_position (name, lat, lng, timestamp, speed) VALUES ('Worli Packers', 28.411666329813748,76.9801210284278,'Fri Jun 18 22:11:17 UTC 2021', 6.89962010918011048);
	INSERT INTO vehicle_position (name, lat, lng, timestamp, speed) VALUES ('Purani Dilli Trucking', 28.601848312286357, 77.26435899909696,'Fri Jun 18 22:11:16 UTC 2021', 47.1793279924594491240);

	commit ; 

EOSQL

# 	INSERT INTO vehicle_position (name, lat, lng, timestamp, speed) VALUES 
# 	('Worli Packers', 28.411666329813748,76.9801210284278,'Fri Jun 18 22:11:17 UTC 2021', 6.89962010918011048);

# 	INSERT INTO vehicle_position (name, lat, lng, timestamp, speed) VALUES 
#    ('Purani Dilli Trucking', 28.601848312286357, 77.26435899909696,'Fri Jun 18 22:11:16 UTC 2021', 47.1793279924594491240);
