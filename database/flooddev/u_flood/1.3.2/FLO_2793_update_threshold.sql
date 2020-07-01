UPDATE u_flood.ffoi_station_threshold
SET value = 4.31 
WHERE ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 5128 and value = 2.30
);