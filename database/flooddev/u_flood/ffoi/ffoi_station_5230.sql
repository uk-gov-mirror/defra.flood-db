Insert into u_flood.ffoi_station (rloi_id) Values (5230);

INSERT INTO u_flood.ffoi_station_threshold (ffoi_station_id, fwis_code, value)
Values ((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5230), '013WAFUI',2.70),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5230), '013FWFGM100',4.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5230), '013FWFGM41',4.00),
((select ffoi_station_id from u_flood.ffoi_station where rloi_id = 5230), '013FWFGM42',4.00);
