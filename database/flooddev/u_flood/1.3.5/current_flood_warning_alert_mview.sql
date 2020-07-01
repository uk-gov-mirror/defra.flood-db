-- Materialized View: current_flood_warning_alert_mview

-- DROP MATERIALIZED VIEW u_flood.current_flood_warning_alert_mview;

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
   FROM u_flood.current_fwis cf,
    u_flood.flood_alert_area faa
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
   FROM u_flood.current_fwis cf,
    u_flood.flood_warning_area fwa
  WHERE cf.fwa_code::bpchar = fwa.fws_tacode::bpchar
WITH DATA;

ALTER TABLE u_flood.current_flood_warning_alert_mview
  OWNER TO u_flood;
