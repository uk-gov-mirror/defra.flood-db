--remove any possible old entries for 7176 and 1087 stations
DELETE FROM u_flood.ffoi_station_threshold 
WHERE ffoi_station_id in (
(SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7176),
(SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 1087));

DELETE FROM u_flood.ffoi_station 
WHERE rloi_id in (7176, 1087);

--insert new entries
INSERT INTO u_flood.ffoi_station (rloi_id)
VALUES (7176), (1087);

INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
VALUES 
--7176
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7176), '062WAF28Mimmshal', 1.80),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 7176), '062FWF28Warrengt', 3.60),
-- 1087
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 1087), '064WAF8LowTeise', 1.78),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 1087), '064FWF8Teise', 2.38),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 1087), '064FWF8CollStreet', 2.38),
((SELECT ffoi_station_id FROM u_flood.ffoi_station WHERE rloi_id = 1087), '064FWF8PaddWood', 2.38);
