-- Update changes based on test feedback, Change threshold value from 8.85 to 0.85 for station 7333

UPDATE u_flood.ffoi_station_threshold SET value = 0.85 
WHERE ffoi_station_id in (select ffoi_station_id from u_flood.ffoi_station where rloi_id = 7333)
and fwis_code in ('062FWF46Hertford', '062FWF46Lemsford');


-- Remove forecast for station 7177

DELETE FROM u_flood.ffoi_station where rloi_id = 7177;

