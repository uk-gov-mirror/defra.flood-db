-- Edit thresholds for Mytholmroyd temporary (gauge 9167)

-- Delete old thresholds for River Calder and Cragg Brook at Mytholmroyd and
-- River Calder at Central Mytholmroyd
DELETE FROM u_flood.ffoi_station_threshold
WHERE fwis_code IN ('123FWF315', '123FWF316') 
AND ffoi_station_id IN (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 9167);

-- Add new thresholds
INSERT INTO u_flood.ffoi_station_threshold( ffoi_station_id, fwis_code, value )
VALUES
( (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 9167), '123FWF315', 3.82 ),
( (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 9167), '123FWF316', 4.5 );
