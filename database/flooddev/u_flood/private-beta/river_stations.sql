-- Table: u_flood.river_stations

-- DROP TABLE u_flood.river_stations;

CREATE TABLE IF NOT EXISTS u_flood.river_stations
(
    id character varying(200) COLLATE pg_catalog."default",
    name character varying(200) COLLATE pg_catalog."default",
    rloi_id integer,
    rank integer
)
WITH (
    OIDS = FALSE
)
TABLESPACE flood_tables;

ALTER TABLE u_flood.river_stations
    OWNER to u_flood;

-- Index: idx_river_stations_id

-- DROP INDEX u_flood.idx_river_stations_id;

CREATE INDEX IF NOT EXISTS idx_river_stations_id
    ON u_flood.river_stations USING btree
    (id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE flood_indexes;

-- Index: idx_river_stations_rloi_id

-- DROP INDEX u_flood.idx_river_stations_rloi_id;

CREATE INDEX IF NOT EXISTS idx_river_stations_rloi_id
    ON u_flood.river_stations USING btree
    (rloi_id ASC NULLS LAST)
    TABLESPACE flood_indexes;

