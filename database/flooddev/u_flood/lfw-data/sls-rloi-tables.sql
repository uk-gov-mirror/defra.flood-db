-- Sequence: telemetry_value_parent_telemetry_value_parent_id_seq

-- DROP SEQUENCE telemetry_value_parent_telemetry_value_parent_id_seq;

CREATE SEQUENCE sls_telemetry_value_parent_telemetry_value_parent_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE sls_telemetry_value_parent_telemetry_value_parent_id_seq
  OWNER TO u_flood;


-- Sequence: telemetry_value_telemetry_value_id_seq

-- DROP SEQUENCE telemetry_value_telemetry_value_id_seq;

CREATE SEQUENCE sls_telemetry_value_telemetry_value_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE sls_telemetry_value_telemetry_value_id_seq
  OWNER TO u_flood;

-- Table: telemetry_value_parent

-- DROP TABLE sls_telemetry_value_parent;

CREATE TABLE sls_telemetry_value_parent
(
  telemetry_value_parent_id bigint NOT NULL DEFAULT nextval('sls_telemetry_value_parent_telemetry_value_parent_id_seq'::regclass),
  filename text NOT NULL,
  imported timestamp with time zone NOT NULL,
  rloi_id integer NOT NULL,
  station text NOT NULL,
  region text NOT NULL,
  start_timestamp timestamp with time zone NOT NULL,
  end_timestamp timestamp with time zone NOT NULL,
  parameter text NOT NULL,
  qualifier text,
  units text NOT NULL,
  post_process boolean,
  subtract numeric(6,3),
  por_max_value numeric(6,3),
  station_type character(1),
  percentile_5 numeric(6,3)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sls_telemetry_value_parent
  OWNER TO u_flood;

-- Index: idx_tvp_region

-- DROP INDEX idx_tvp_region;

CREATE INDEX idx_sls_tvp_region
  ON sls_telemetry_value_parent
  USING btree
  (region COLLATE pg_catalog."default")
TABLESPACE flood_indexes;

-- Index: idx_tvp_rloi_id

-- DROP INDEX idx_tvp_rloi_id;

CREATE INDEX idx_sls_tvp_rloi_id
  ON sls_telemetry_value_parent
  USING btree
  (rloi_id)
TABLESPACE flood_indexes;

-- Index: idx_tvp_station

-- DROP INDEX idx_tvp_station;

CREATE INDEX idx_sls_tvp_station
  ON sls_telemetry_value_parent
  USING btree
  (station COLLATE pg_catalog."default")
TABLESPACE flood_indexes;

-- Table: telemetry_value

-- DROP TABLE sls_telemetry_value;

CREATE TABLE sls_telemetry_value
(
  telemetry_value_id bigint NOT NULL DEFAULT nextval('sls_telemetry_value_telemetry_value_id_seq'::regclass),
  telemetry_value_parent_id bigint NOT NULL,
  value numeric,
  processed_value numeric,
  value_timestamp timestamp with time zone NOT NULL,
  error boolean NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sls_telemetry_value
  OWNER TO u_flood;

-- Index: idx_tv_telemetry_value_parent_id

-- DROP INDEX idx_tv_telemetry_value_parent_id;

CREATE INDEX idx_sls_tv_telemetry_value_parent_id
  ON sls_telemetry_value
  USING btree
  (telemetry_value_parent_id)
TABLESPACE flood_indexes;

-- Keys
ALTER TABLE sls_telemetry_value_parent
  ADD CONSTRAINT pk_sls_telemetry_value_parent_id PRIMARY KEY(telemetry_value_parent_id)
  USING INDEX TABLESPACE flood_indexes;

ALTER TABLE sls_telemetry_value
  ADD CONSTRAINT pk_sls_telemetry_value_id PRIMARY KEY(telemetry_value_id)
  USING INDEX TABLESPACE flood_indexes;

ALTER TABLE sls_telemetry_value
  ADD CONSTRAINT fk_sls_telemetry_value_parent_id FOREIGN KEY (telemetry_value_parent_id)
      REFERENCES sls_telemetry_value_parent (telemetry_value_parent_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE;





