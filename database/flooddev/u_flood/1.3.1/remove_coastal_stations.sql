/*select * from u_flood.ffoi_station s
inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
where s.rloi_id in (1021,1028,6002,6008)

select * from u_flood.telemetry_context c
inner join u_flood.ffoi_station s on s.rloi_id = c.rloi_id
where c.station_type = 'C'*/

 --Remove coastal stations from ffoi beta
 DELETE FROM u_flood.ffoi_station where rloi_id in (1021,1028,6002,6008);