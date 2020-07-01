-- Update u_flood.current_fwis timestamps to be timestamp with timezone

DROP MATERIALIZED VIEW U_flood.current_flood_warning_alert_mview;

ALTER TABLE u_flood.current_fwis
ALTER COLUMN time_raised
SET DATA TYPE timestamp with time zone;

ALTER TABLE u_flood.current_fwis
ALTER COLUMN severity_changed
SET DATA TYPE timestamp with time zone;

ALTER TABLE u_flood.current_fwis
ALTER COLUMN rim_changed
SET DATA TYPE timestamp with time zone;

-- Materialized View: current_flood_warning_alert_mview

-- DROP MATERIALIZED VIEW U_flood.current_flood_warning_alert_mview;

CREATE MATERIALIZED VIEW u_flood.current_flood_warning_alert_mview AS 
 SELECT cf.fwa_code,
    cf.fwa_key,
    cf.description,
    faa.qdial AS area_floodline_quickdial_id,
    cf.region,
    cf.area,
    cf.tidal AS flood_type,
    cf.severity AS severity_description,
    cf.severity_value AS severity,
    cf.warning_key,
    cf.time_raised AS raised,
    cf.severity_changed,
    cf.rim_changed AS message_changed,
    cf.rim AS message,
    faa.geom,
    st_centroid(faa.geom) AS st_centroid
   FROM current_fwis cf,
    flood_alert_area faa
  WHERE cf.fwa_code::bpchar = faa.fws_tacode::bpchar
UNION
 SELECT cf.fwa_code,
    cf.fwa_key,
    cf.description,
    fwa.qdial AS area_floodline_quickdial_id,
    cf.region,
    cf.area,
    cf.tidal AS flood_type,
    cf.severity AS severity_description,
    cf.severity_value AS severity,
    cf.warning_key,
    cf.time_raised AS raised,
    cf.severity_changed,
    cf.rim_changed AS message_changed,
    cf.rim AS message,
    fwa.geom,
    st_centroid(fwa.geom) AS st_centroid
   FROM current_fwis cf,
    flood_warning_area fwa
  WHERE cf.fwa_code::bpchar = fwa.fws_tacode::bpchar
WITH DATA;

ALTER TABLE u_flood.current_flood_warning_alert_mview
  OWNER TO u_flood;
