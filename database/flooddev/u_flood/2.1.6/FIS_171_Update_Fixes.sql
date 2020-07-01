-- Remove forecast for station 7154

DELETE FROM u_flood.ffoi_station where rloi_id = 7154;

-- Add forecast station 7177 back in

INSERT INTO u_flood.ffoi_station(rloi_id) VALUES (7177);

INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value) VALUES
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7177), '062WAF28Mimmshal', 0.96),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7177), '062WAF28UpColne', 2.3),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7177), '062FWF28Warrengt', 2.24),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7177), '062FWF28CHeath', 2.7);
