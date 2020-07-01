-- Add threshold for River Tyne and Cockshaw Burn at Tyne Green Mews Hexham (new target area released on August 22 2018)
-- to Hexham (9006)
INSERT INTO u_flood.ffoi_station_threshold( ffoi_station_id, fwis_code, value )
VALUES
( (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 9006), '121FWF205', 34.95 );
