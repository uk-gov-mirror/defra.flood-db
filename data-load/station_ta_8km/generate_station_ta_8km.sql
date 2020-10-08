-- Note that this can take 4 to 6 hours depending on the size of the database
truncate table u_flood.station_ta_8km;

insert into station_ta_8km
--flood alert areas -- 2 hr 35 min
select tc.rloi_id, 
a.fws_tacode
from u_flood.telemetry_context tc
inner join u_flood.flood_alert_area a on st_intersects( ST_Buffer(st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)::geography, 8000),a.geom);

insert into station_ta_8km
--flood warning areas --1hr 21 min
select tc.rloi_id, 
w.fws_tacode
from u_flood.telemetry_context tc
inner join u_flood.flood_warning_area w on st_intersects( ST_Buffer(st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)::geography, 8000),w.geom);
