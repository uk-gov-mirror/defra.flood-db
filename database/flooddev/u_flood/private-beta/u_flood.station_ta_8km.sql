-- create table
Create table if not exists u_flood.station_ta_8km (
rloi_id integer,
fws_tacode text);

--create indeces
CREATE INDEX if not exists station_ta_8km_rloi_id
    ON u_flood.station_ta_8km USING btree
    (rloi_id ASC NULLS LAST)
    TABLESPACE flood_tables;

CREATE INDEX if not exists station_ta_8km_fws_tacode
    ON u_flood.station_ta_8km USING btree
    (fws_tacode ASC NULLS LAST)
    TABLESPACE flood_tables;
	
CREATE INDEX if not exists station_ta_8km_rloi_id_tacode
ON u_flood.station_ta_8km USING btree
(rloi_id ASC NULLS LAST, fws_tacode COLLATE pg_catalog."default" ASC NULLS LAST)
TABLESPACE flood_tables;
