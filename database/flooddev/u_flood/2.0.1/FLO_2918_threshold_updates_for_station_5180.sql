-- Delete existing values for Seaton Mill
DELETE FROM u_flood.ffoi_station_threshold
WHERE fwis_code IN ('011WAFCD','011FWFNC22','011FWFNC23') 
AND ffoi_station_id = (SELECT ffoi_station_id FROM ffoi_station WHERE rloi_id = 5180);

-- Add Rivers Cocker, Marron and Derwent at 1.60m
INSERT INTO u_flood.ffoi_station_threshold(ffoi_station_id, fwis_code, value)
SELECT ffoi_station_id, '011WAFCD', 1.60 FROM ffoi_station WHERE rloi_id = 5180;
-- Add River Derwent at Camerton at 2.10m
INSERT INTO u_flood.ffoi_station_threshold(ffoi_station_id, fwis_code, value)
SELECT ffoi_station_id, '011FWFNC22', 2.10 FROM ffoi_station WHERE rloi_id = 5180;
-- Add River Derwent at Workington, Seaton Mill and Barepot at 2.10m
INSERT INTO u_flood.ffoi_station_threshold(ffoi_station_id, fwis_code, value)
SELECT ffoi_station_id, '011FWFNC23', 2.10 FROM ffoi_station WHERE rloi_id = 5180;