DELETE FROM u_flood.ffoi_station where rloi_id = 5230;

REFRESH MATERIALIZED VIEW station_split_mview with data;