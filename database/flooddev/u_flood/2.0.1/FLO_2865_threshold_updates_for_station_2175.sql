--Remove thresholds for 217: River Frome at Stonehouse and Bridgend and River Frome at Stroud and Ryeford
DELETE FROM u_flood.ffoi_station_threshold
WHERE fwis_code IN ('031FWFFG30','031FWFFG40') AND ffoi_station_id=20;

--Replace with River Frome at Chalford and River Frome at Brimscombe and Thrupp
INSERT INTO u_flood.ffoi_station_threshold( ffoi_station_id, fwis_code, value )
VALUES
( 20, '031FWFFG10', 0.62 ),
( 20, '031FWFFG20', 0.62 );
