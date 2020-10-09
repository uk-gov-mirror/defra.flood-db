-- Remove forecast from station 7287
DELETE FROM u_flood.ffoi_station where rloi_id = 7287;

--Remove thresholds River Irwell at Rawtenstall and Folly Clough Brook at Crawshawbooth from station 5116
DELETE FROM u_flood.ffoi_station_threshold
WHERE fwis_code IN ('013FWFL62', '013FWFL37') 
AND ffoi_station_id IN (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 5116);
