-- 7246 remove 061FWB23DitIslnd
DELETE from u_flood.ffoi_station_threshold where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 7246 and fwis_code = '061FWB23DitIslnd'
);

-- 2175 Remove 0.62 thresholds and replace with 031FWFFG10 and 031FWFFG20
DELETE from u_flood.ffoi_station_threshold where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 2175 and value = 0.62
);
INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
Values ((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2175), '031FWFFG20',0.62),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 2175), '031FWFFG10',0.62);

-- 5026 new property flooding target area
INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
Values ((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5026), '013FWFGM100',1.68);

-- 8048 change 2.10 to 2.80
Update u_flood.ffoi_station_threshold
set value = 2.80
where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 8048 and value = 2.10
);

--8097 update 0.75 to 1.60
Update u_flood.ffoi_station_threshold
set value = 1.60
where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 8097 and value = 0.75
);

-- 8191 update 2.35 to 2.00
Update u_flood.ffoi_station_threshold
set value = 2.00
where ffoi_station_threshold_id in (
	select t.ffoi_station_threshold_id from u_flood.ffoi_station s
	inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
	where s.rloi_id = 8191 and value = 2.35
);

-- 8205 add 123FWF306 to property flooding
INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
Values ((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 8205), '123FWF306',1.50);

