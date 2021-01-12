-- SEQUENCE: u_flood.sls_telemetry_station_id_seq

-- DROP SEQUENCE u_flood.sls_telemetry_station_id_seq;

CREATE SEQUENCE IF NOT EXISTS u_flood.sls_telemetry_station_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE u_flood.sls_telemetry_station_id_seq
    OWNER TO u_flood;

-- Table: u_flood.sls_telemetry_station

-- DROP TABLE u_flood.sls_telemetry_station;

CREATE TABLE IF NOT EXISTS u_flood.sls_telemetry_station
(
    telemetry_station_id bigint NOT NULL DEFAULT nextval('sls_telemetry_station_id_seq'::regclass),
	station_reference text NOT NULL,
	region text,
	station_name text,
	ngr varchar(50),
	easting integer,
	northing integer,

    CONSTRAINT pk_sls_telemetry_station_id PRIMARY KEY (telemetry_station_id)
        USING INDEX TABLESPACE flood_indexes,
	
	CONSTRAINT unique_station UNIQUE (station_reference, region)
        USING INDEX TABLESPACE flood_indexes
)
WITH (
    OIDS = FALSE
)
TABLESPACE flood_tables;
