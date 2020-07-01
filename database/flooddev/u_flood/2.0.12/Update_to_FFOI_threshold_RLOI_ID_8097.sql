-- Remove the threshold 'River Calder and Hebden Water at Hebden Bridge (TA 123FWF312)' from station 8097
DELETE FROM u_flood.ffoi_station_threshold
WHERE fwis_code IN ('123FWF312') 
AND ffoi_station_id IN (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 8097);
