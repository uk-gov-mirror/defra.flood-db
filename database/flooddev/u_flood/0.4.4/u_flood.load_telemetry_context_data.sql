-- Function: u_flood.load_telemetry_context_data()

-- DROP FUNCTION u_flood.load_telemetry_context_data();

-- History
-- Release	Ticket		Author		Notes
-- 0.4.4	771		Tedd Mason	Adding deletion functionality

CREATE OR REPLACE FUNCTION u_flood.load_telemetry_context_data()
  RETURNS void AS
$BODY$
  begin

    set datestyle to european;
    
    set session time zone 'utc';

    CREATE TEMP TABLE tmp_telemetry_context AS SELECT * FROM u_flood.telemetry_context where 1 = 0;

    --probably not needed but get rid of pk
    ALTER TABLE tmp_telemetry_context DROP telemetry_context_id;
    
    copy tmp_telemetry_context
      (telemetry_id,
	wiski_id,
	rloi_id,
	station_type,
	post_process,
	subtract,
	region,
	area,
	catchment,
	display_region,
	display_area,
	display_catchment,
	agency_name,
	external_name,
	location_info,
	x_coord_actual,
	y_coord_actual,
	actual_ngr,
	x_coord_display,
	y_coord_display,
	site_max,
	wiski_river_name,
	date_open,
	stage_datum,
	period_of_record,
	por_max_value,
	date_por_max,
	highest_level,
	date_highest_level,
	por_min_value,
	date_por_min,
	percentile_5,
	percentile_95,
	comments,
	d_stage_datum,
	d_period_of_record,
	d_por_max_value,
	d_date_por_max,
	d_highest_level,
	d_date_highest_level,
	d_por_min_value,
	d_date_por_min,
	d_percentile_5,
	d_percentile_95,
	d_comments,
	status,
	status_reason,
	status_date) from 'station/local/rloiStationData.csv' delimiter ',' escape E'\n' csv header;

	--Update context data based on our new file coming through
	UPDATE u_flood.telemetry_context AS tsc
	SET telemetry_id = ttsc.telemetry_id,
	wiski_id = ttsc.wiski_id,
	rloi_id = ttsc.rloi_id,
	station_type = ttsc.station_type,
	post_process = ttsc.post_process,
	subtract = ttsc.subtract,
	region = ttsc.region,
	area = ttsc.area,
	catchment = ttsc.catchment,
	display_region = ttsc.display_region,
	display_area = ttsc.display_area,
	display_catchment = ttsc.display_catchment,
	agency_name = ttsc.agency_name,
	external_name = ttsc.external_name,
	location_info = ttsc.location_info,
	x_coord_actual = ttsc.x_coord_actual,
	y_coord_actual = ttsc.y_coord_actual,
	actual_ngr = ttsc.actual_ngr,
	x_coord_display = ttsc.x_coord_display,
	y_coord_display = ttsc.y_coord_display,
	site_max = ttsc.site_max,
	wiski_river_name = ttsc.wiski_river_name,
	date_open = ttsc.date_open,
	stage_datum = ttsc.stage_datum,
	period_of_record = ttsc.period_of_record,
	por_max_value = ttsc.por_max_value,
	date_por_max = ttsc.date_por_max,
	highest_level = ttsc.highest_level,
	date_highest_level = ttsc.date_highest_level,
	por_min_value = ttsc.por_min_value,
	date_por_min = ttsc.date_por_min,
	percentile_5 = ttsc.percentile_5,
	percentile_95 = ttsc.percentile_95,
	comments = ttsc.comments,
	d_stage_datum = ttsc.d_stage_datum,
	d_period_of_record = ttsc.d_period_of_record,
	d_por_max_value = ttsc.d_por_max_value,
	d_date_por_max = ttsc.d_date_por_max,
	d_highest_level = ttsc.d_highest_level,
	d_date_highest_level = ttsc.d_date_highest_level,
	d_por_min_value = ttsc.d_por_min_value,
	d_date_por_min = ttsc.d_date_por_min,
	d_percentile_5 = ttsc.d_percentile_5,
	d_percentile_95 = ttsc.d_percentile_95,
	d_comments = ttsc.d_comments,
	status = ttsc.status,
	status_reason = ttsc.status_reason,
	status_date = ttsc.status_date
	FROM tmp_telemetry_context as ttsc
	WHERE tsc.rloi_id = ttsc.rloi_id;

	--Now insert if not already existing in the table
	INSERT INTO u_flood.telemetry_context(telemetry_id,
	wiski_id,
	rloi_id,
	station_type,
	post_process,
	subtract,
	region,
	area,
	catchment,
	display_region,
	display_area,
	display_catchment,
	agency_name,
	external_name,
	location_info,
	x_coord_actual,
	y_coord_actual,
	actual_ngr,
	x_coord_display,
	y_coord_display,
	site_max,
	wiski_river_name,
	date_open,
	stage_datum,
	period_of_record,
	por_max_value,
	date_por_max,
	highest_level,
	date_highest_level,
	por_min_value,
	date_por_min,
	percentile_5,
	percentile_95,
	comments,
	d_stage_datum,
	d_period_of_record,
	d_por_max_value,
	d_date_por_max,
	d_highest_level,
	d_date_highest_level,
	d_por_min_value,
	d_date_por_min,
	d_percentile_5,
	d_percentile_95,
	d_comments,
	status,
	status_reason,
	status_date)
	SELECT ttsc.telemetry_id,
	ttsc.wiski_id,
	ttsc.rloi_id,
	ttsc.station_type,
	ttsc.post_process,
	ttsc.subtract,
	ttsc.region,
	ttsc.area,
	ttsc.catchment,
	ttsc.display_region,
	ttsc.display_area,
	ttsc.display_catchment,
	ttsc.agency_name,
	ttsc.external_name,
	ttsc.location_info,
	ttsc.x_coord_actual,
	ttsc.y_coord_actual,
	ttsc.actual_ngr,
	ttsc.x_coord_display,
	ttsc.y_coord_display,
	ttsc.site_max,
	ttsc.wiski_river_name,
	ttsc.date_open,
	ttsc.stage_datum,
	ttsc.period_of_record,
	ttsc.por_max_value,
	ttsc.date_por_max,
	ttsc.highest_level,
	ttsc.date_highest_level,
	ttsc.por_min_value,
	ttsc.date_por_min,
	ttsc.percentile_5,
	ttsc.percentile_95,
	ttsc.comments,
	ttsc.d_stage_datum,
	ttsc.d_period_of_record,
	ttsc.d_por_max_value,
	ttsc.d_date_por_max,
	ttsc.d_highest_level,
	ttsc.d_date_highest_level,
	ttsc.d_por_min_value,
	ttsc.d_date_por_min,
	ttsc.d_percentile_5,
	ttsc.d_percentile_95,
	ttsc.d_comments,
	ttsc.status,
	ttsc.status_reason,
	ttsc.status_date
	FROM tmp_telemetry_context ttsc
	left join u_flood.telemetry_context tsc on ttsc.rloi_id = tsc.rloi_id
	WHERE tsc.rloi_id is null;

	DELETE FROM
	u_flood.telemetry_context tc
	WHERE tc.rloi_id NOT IN (
					SELECT rloi_id
					FROM tmp_telemetry_context
				);

	REFRESH MATERIALIZED VIEW u_flood.telemetry_context_mview with data;
	REFRESH MATERIALIZED VIEW u_flood.station_split_mview with data;

	DROP TABLE tmp_telemetry_context;


  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.load_telemetry_context_data()
  OWNER TO u_flood;
