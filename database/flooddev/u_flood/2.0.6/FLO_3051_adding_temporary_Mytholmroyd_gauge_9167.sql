-- Create New Station
INSERT INTO u_flood.ffoi_station (rloi_id)
VALUES (9167);

INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
VALUES 
-- 9167
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 9167), '123FWF315', 4.00),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 9167), '123FWF316', 4.00),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 9167), '123WAF963', 2.80);