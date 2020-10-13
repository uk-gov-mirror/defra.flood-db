-- FUNCTION: u_flood.station_ta_8km_update()

-- DROP FUNCTION u_flood.station_ta_8km_update();

CREATE OR REPLACE FUNCTION u_flood.station_ta_8km_update()
    RETURNS void
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
begin

	-- Update station_ta_8km with any stations that don't have an entry in the table (should catch new stations) not including Welsh stations 
  	
	INSERT INTO u_flood.station_ta_8km
  	select tc.rloi_id, 
	a.fws_tacode
	from u_flood.telemetry_context tc
	inner join u_flood.flood_alert_area a on st_intersects( ST_Buffer(st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)::geography, 8000),a.geom)
	where tc.rloi_id not in (
		select distinct(rloi_id)
	from u_flood.station_ta_8km
	)
	and tc.region != 'Wales'
	union
	select tc.rloi_id, 
	w.fws_tacode
	from u_flood.telemetry_context tc
	inner join u_flood.flood_warning_area w on st_intersects( ST_Buffer(st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)::geography, 8000),w.geom)
	where tc.rloi_id not in (
		select distinct(rloi_id)
	from u_flood.station_ta_8km
	)
	and tc.region != 'Wales';
  
  
  
  end;
$BODY$;

ALTER FUNCTION u_flood.station_ta_8km_update()
    OWNER TO u_flood;
