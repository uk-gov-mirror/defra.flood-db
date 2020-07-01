-- Table: u_flood.ffoi_max

-- DROP TABLE u_flood.ffoi_max;

CREATE TABLE IF NOT EXISTS u_flood.ffoi_max
(
  telemetry_id text NOT NULL,
  value numeric,
  value_date timestamp with time zone,
  filename text,
  updated_date timestamp with time zone,
  CONSTRAINT pk_ffoi_max_telemetry_id PRIMARY KEY (telemetry_id)
  USING INDEX TABLESPACE flood_indexes
)
WITH (
  OIDS=FALSE
);
ALTER TABLE u_flood.ffoi_max
  OWNER TO u_flood;
