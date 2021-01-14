-- View: u_flood.rainfall_stations_mview

-- DROP MATERIALIZED VIEW u_flood.rainfall_stations_mview;

-- select * from u_flood.rainfall_stations_mview;
-- REFRESH MATERIALIZED VIEW u_flood.rainfall_stations_mview WITH DATA;

CREATE MATERIALIZED VIEW IF NOT EXISTS u_flood.rainfall_stations_mview
TABLESPACE flood_tables
AS

	Select s.*,
	st_transform(st_setsrid(st_makepoint((s.easting)::double precision, (s.northing)::double precision), 27700), 4326) AS centroid, 
	p.data_type, 
	p.period, 
	v.*
	From u_flood.sls_telemetry_station s
	-- get latest Rainfall parent
	inner join (select distinct on (station, region) station, region, telemetry_value_parent_id, data_type, period
	from u_flood.sls_telemetry_value_parent
	where parameter = 'Rainfall'
	order by station, region, end_timestamp desc) as p on s.station_reference = p.station and s.region = p.region
	--get latest value from that parent
	inner join (
	select distinct on (telemetry_value_parent_id) telemetry_value_parent_id, "value", value_timestamp
	from u_flood.sls_telemetry_value v 
	order by telemetry_value_parent_id, value_timestamp desc
	) v on v.telemetry_value_parent_id = p.telemetry_value_parent_id
	order by s.region, s.station_name

WITH DATA;

ALTER TABLE u_flood.rainfall_stations_mview
    OWNER TO u_flood;


CREATE INDEX IF NOT EXISTS idx_rainfall_stations_mview_geom_gist
    ON u_flood.rainfall_stations_mview USING gist
    (centroid)
    TABLESPACE flood_indexes;
