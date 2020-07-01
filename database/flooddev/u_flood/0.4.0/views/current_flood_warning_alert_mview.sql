-- Materialized View: current_flood_warning_alert_mview
-- Author: Tedd Mason
-- Date: 15/02/2016
-- History 
-- 1.0: Base lining Development database for release 0.4.0

DROP MATERIALIZED VIEW IF EXISTS current_flood_warning_alert_mview;

CREATE MATERIALIZED VIEW current_flood_warning_alert_mview AS 
 SELECT cf.fwa_code,
    cf.fwa_key,
    cf.description,
    faa.e_qdial AS area_floodline_quickdial_id,
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
  WHERE cf.fwa_code::bpchar = faa.fwis_code::bpchar
UNION
 SELECT cf.fwa_code,
    cf.fwa_key,
    cf.description,
    fwa.e_qdial AS area_floodline_quickdial_id,
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
  WHERE cf.fwa_code::bpchar = fwa.fwis_code::bpchar
WITH DATA;

ALTER TABLE current_flood_warning_alert_mview
  OWNER TO u_flood;
