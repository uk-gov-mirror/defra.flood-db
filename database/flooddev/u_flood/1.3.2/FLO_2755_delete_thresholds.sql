DELETE from u_flood.ffoi_station_threshold where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 5060 and fwis_code = '011FWFNC6KC'
);

DELETE from u_flood.ffoi_station_threshold where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 5075 and (fwis_code = '013FWFL50' or fwis_code = '013FWFL37' or fwis_code = '013FWFL36')
);