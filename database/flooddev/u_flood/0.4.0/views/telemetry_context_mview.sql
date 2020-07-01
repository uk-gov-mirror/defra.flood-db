-- Materialized View: telemetry_context_mview
-- Author: Tedd Mason
-- Date: 15/02/2016
-- History 
-- 1.0: Base lining Development database for release 0.4.0

DROP MATERIALIZED VIEW IF EXISTS telemetry_context_mview;

CREATE MATERIALIZED VIEW telemetry_context_mview AS 
 SELECT tc.telemetry_context_id,
    tc.telemetry_id,
    tc.wiski_id,
    tc.rloi_id,
    tc.station_type,
    tc.post_process,
    tc.subtract,
    tc.region,
    tc.area,
    tc.catchment,
    tc.display_region,
    tc.display_area,
    tc.display_catchment,
    tc.agency_name,
    tc.external_name,
    tc.location_info,
    tc.x_coord_actual,
    tc.y_coord_actual,
    tc.actual_ngr,
    tc.x_coord_display,
    tc.y_coord_display,
    tc.site_max,
    tc.wiski_river_name,
    tc.date_open,
    tc.stage_datum,
    tc.period_of_record,
    tc.por_max_value,
    tc.date_por_max,
    tc.highest_level,
    tc.date_highest_level,
    tc.por_min_value,
    tc.date_por_min,
    tc.percentile_5,
    tc.percentile_95,
    tc.comments,
    tc.d_stage_datum,
    tc.d_period_of_record,
    tc.d_por_max_value,
    tc.d_date_por_max,
    tc.d_highest_level,
    tc.d_date_highest_level,
    tc.d_por_min_value,
    tc.d_date_por_min,
    tc.d_percentile_5,
    tc.d_percentile_95,
    tc.d_comments,
    tc.status,
    tc.status_reason,
    tc.status_date,
    tsl.region_name AS time_series_region,
    st_asgeojson(st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)) AS coordinates,
    st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326)::geography AS geography,
    st_transform(st_setsrid(st_makepoint(tc.x_coord_actual::double precision, tc.y_coord_actual::double precision), 27700), 4326) AS centroid
   FROM telemetry_context tc,
    time_series_region_lkp tsl
  WHERE tc.region = tsl.context_region_name
WITH DATA;

ALTER TABLE telemetry_context_mview
  OWNER TO u_flood;
