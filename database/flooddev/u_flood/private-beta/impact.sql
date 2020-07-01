-- SEQUENCE: u_flood.impact_id_seq

-- DROP SEQUENCE u_flood.impact_id_seq;

CREATE SEQUENCE u_flood.impact_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE u_flood.impact_id_seq
    OWNER TO u_flood;

-- Table: u_flood.impact

-- DROP TABLE u_flood.impact;

CREATE TABLE IF NOT EXISTS u_flood.impact
(
    id bigint NOT NULL DEFAULT nextval('impact_id_seq'::regclass),
    rloi_id integer NOT NULL,
    value numeric,
    units text COLLATE pg_catalog."default",
    comment text COLLATE pg_catalog."default",
    short_name text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    type text COLLATE pg_catalog."default",
    obs_flood_year text COLLATE pg_catalog."default",
    obs_flood_month text COLLATE pg_catalog."default",
    source text COLLATE pg_catalog."default",
    lat numeric,
    lng numeric,
    geom geometry,
    CONSTRAINT impact_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE flood_tables;

ALTER TABLE u_flood.impact
    OWNER to u_flood;
