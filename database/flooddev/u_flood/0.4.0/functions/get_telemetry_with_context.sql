-- Function: get_telemetry_with_context(integer, character)

-- DROP FUNCTION get_telemetry_with_context(integer, character);

CREATE OR REPLACE FUNCTION get_telemetry_with_context(IN _rloi_id integer, IN _preferred_direction character)
  RETURNS TABLE(direction text, telemetry_context_id bigint, telemetry_id text, wiski_id text, rloi_id integer, station_type character, post_process boolean, subtract numeric, region text, area text, catchment text, display_region text, display_area text, display_catchment text, agency_name text, external_name text, location_info text, x_coord_actual integer, y_coord_actual integer, actual_ngr text, x_coord_display integer, y_coord_display integer, site_max numeric, wiski_river_name text, date_open date, stage_datum numeric, period_of_record text, por_max_value numeric, date_por_max timestamp with time zone, highest_level numeric, date_highest_level timestamp with time zone, por_min_value numeric, date_por_min timestamp with time zone, percentile_5 numeric, percentile_95 numeric, comments text, d_stage_datum numeric, d_period_of_record text, d_por_max_value numeric, d_date_por_max timestamp with time zone, d_highest_level numeric, d_date_highest_level timestamp with time zone, d_por_min_value numeric, d_date_por_min timestamp with time zone, d_percentile_5 numeric, d_percentile_95 numeric, d_comments text, status text, status_reason text, status_date timestamp with time zone, time_series_region text, coordinates text, processed_values numeric[], value_timestamps timestamp with time zone[], formatted_value_timestamps text[], por_max_values numeric[], percentile_5_values numeric[], errors boolean[]) AS
$BODY$
declare

  sql text :=
    'select ' ||
      't.* ' ||
    'from ' ||
      '( ' ||
        'select ' ||
          '/* Provide a short indication of the returned direction.  Downstream data is only applicable for multi-stations */ ' ||
          'case when "position"(lower(tv2.qualifier), ''downstream''::text) > 0 and lower(tcm2.station_type) = ''m'' then ''d'' ' ||
               'else ''u'' ' ||
          'end as direction, ' ||
          'tcm2.telemetry_context_id, ' ||
          'tcm2.telemetry_id, ' ||
          'tcm2.wiski_id, ' ||
          'tcm2.rloi_id, ' ||
          'tcm2.station_type, ' ||
          'tcm2.post_process, ' ||
          'tcm2.subtract, ' ||
          'tcm2.region, ' ||
          'tcm2.area, ' ||
          'tcm2.catchment, ' ||
          'tcm2.display_region, ' ||
          'tcm2.display_area, ' ||
          'tcm2.display_catchment, ' ||
          'tcm2.agency_name, ' ||
          'tcm2.external_name, ' ||
          'tcm2.location_info, ' ||
          'tcm2.x_coord_actual, ' ||
          'tcm2.y_coord_actual, ' ||
          'tcm2.actual_ngr, ' ||
          'tcm2.x_coord_display, ' ||
          'tcm2.y_coord_display, ' ||
          'tcm2.site_max, ' ||
          'tcm2.wiski_river_name, ' ||
          'tcm2.date_open, ' ||
          'tcm2.stage_datum, ' ||
          'tcm2.period_of_record, ' ||
          'tcm2.por_max_value, ' ||
          'tcm2.date_por_max, ' ||
          'tcm2.highest_level, ' ||
          'tcm2.date_highest_level, ' ||
          'tcm2.por_min_value, ' ||
          'tcm2.date_por_min, ' ||
          'tcm2.percentile_5, ' ||
          'tcm2.percentile_95, ' ||
          'tcm2.comments, ' ||
          'tcm2.d_stage_datum, ' ||
          'tcm2.d_period_of_record, ' ||
          'tcm2.d_por_max_value, ' ||
          'tcm2.d_date_por_max, ' ||
          'tcm2.d_highest_level, ' ||
          'tcm2.d_date_highest_level, ' ||
          'tcm2.d_por_min_value, ' ||
          'tcm2.d_date_por_min, ' ||
          'tcm2.d_percentile_5, ' ||
          'tcm2.d_percentile_95, ' ||
          'tcm2.d_comments, ' ||
          'tcm2.status, ' ||
          'tcm2.status_reason, ' ||
          'tcm2.status_date, ' ||
          'tcm2.time_series_region, ' ||
          'tcm2.coordinates, ' ||
          'tv2.processed_values, ' ||
          'tv2.value_timestamps, ' ||
          '/* Ensure full timestamps are displayed for the first and final readings on the chart.*/ ' ||
          'array_append((array_prepend(to_char(tv2.value_timestamps[1], ''DD FMMonth YYYY FMHH12:MIam''::text), tv2.formatted_value_timestamps[2:array_upper(tv2.formatted_value_timestamps, 1)]))[1:array_upper(tv2.formatted_value_timestamps, 1) -1], to_char(tv2.value_timestamps[array_length(tv2.value_timestamps, 1)], ''DD FMMonth YYYY FMHH12:MIam''::text)) AS formatted_value_timestamps, ' ||
          'tv2.por_max_values, ' ||
          'tv2.percentile_5_values, ' ||
          'tv2.errors ' ||
        'from ' ||
          '/* Collapse water level data for the requested station into an individual row per direction.  Individual telemetry value data to be displayed on the web application chart ' ||
          'is aggregated into a set of arrays in the format expected by the chart.  Use left outer joins to ensure station context data is returned when no telemetry data is available.*/ ' ||
          'u_flood.telemetry_context_mview tcm2 left outer join ' ||
          '( ' ||
             'select ' ||
               'tv.rloi_id, ' ||
               'tv.qualifier, ' ||
               'array_agg(tv.processed_value) as processed_values, ' ||
               'array_agg(tv.value_timestamp) as value_timestamps, ' ||
               'array_agg(tv.formatted_value_timestamp) as formatted_value_timestamps, ' ||
               'array_agg(tv.por_max_value) as por_max_values, ' ||
               'array_agg(tv.percentile_5) as percentile_5_values, ' ||
               'array_agg(tv.error) as errors ' ||
             'from ' ||
               '( ' ||
                  '/* If station context and in date water level telemetry data is present for the requested station, sort the telemetry values by timestamp so that they are ordered for display . ' ||
                  'on the web application chart. */' ||
                  'select ' ||
                    'tv_1.value, ' ||
                    'tv_1.processed_value, ' ||
                    'tv_1.value_timestamp, ' ||
                    '/* FLO-976 - Ignore precomputed formatted timestamps as they are always GMT based. Format timestamps based on the GB timezone set for the duration on the function call so that GMT/BST is handled correctly. */' ||
                    '/* If the timestamp is the start of a new day (00:00 hours), the full timestamp should be displayed. */' ||
                    'case when extract(''hour'' from tv_1.value_timestamp)::integer = 0 and extract(''minute'' from tv_1.value_timestamp)::integer = 0 then to_char(tv_1.value_timestamp, ''DD FMMonth YYYY FMHH12:MIam'') ' ||
                          '/* If the hour is divisible by six the time should be displayed. */' ||
                          'when extract(''hour'' from tv_1.value_timestamp)::integer % 6 = 0 and extract(''minute'' from tv_1.value_timestamp)::integer = 0 then to_char(tv_1.value_timestamp, ''FMHH12:MIam'') ' ||
                          '/* In all other cases nothing should be displayed so the chart is not cluttered. */ ' ||
                          'else '''' ' ||
                    'end as formatted_value_timestamp, ' ||
                    'tv_1.error, ' ||
                    'tvp.rloi_id, ' ||
                    'tvp.parameter, ' ||
                    'tvp.qualifier, ' ||
                     '/* FLO-971 -Ignore preformatted por_max and percentile_5 values in favour of formatting the current values in the station context data.  This ' ||
                     ' produces up to date information for display on the station chart. ' ||
                     ' Round station context values to two decimal places ' ||
                     ' Use the station context data qualifier to determine if upstream or downstream values ' ||
                     ' should be rounded. */' ||
                     'case when position(''downstream'' in lower(tvp.qualifier)) > 0 then round(tcm.d_por_max_value, 2) ' ||
                     '      else round(tcm.por_max_value, 2) ' ||
                     'end as por_max_value, ' ||
                     'case when position(''downstream'' in lower(tvp.qualifier)) > 0 then round(tcm.d_percentile_5, 2) ' ||
                     '      else round(tcm.percentile_5, 2) ' ||
                     'end as percentile_5 ' ||
                  'from ' ||
                    'u_flood.telemetry_context_mview tcm left outer join ' ||
                    'u_flood.telemetry_value_parent tvp on tvp.rloi_id = tcm.rloi_id left outer join ' ||
                    'u_flood.telemetry_value tv_1 on tv_1.telemetry_value_parent_id = tvp.telemetry_value_parent_id ' ||
                  'where ' ||
                    '/* Only consider water level telemetry values taken after the latest station status date (if one exists). */ ' ||
                    'lower(tvp.parameter) = ''water level''::text and ' ||
                    '(tcm.status_date is null or tv_1.value_timestamp >= tcm.status_date) and ' ||
                    '/* For multi-stations((station_type = ''m''), attemmpt to provide upstream/downstream data as requested. ' ||
                    'Downstream data should only be provided for multi-stations.   However, some non-multi-stations have downstream telemetry data.  Such stations have ' ||
                    'inconsistent station context and telemetry data and the telemetry data should not be available to the general public. ' ||
                    'NOTE ' ||
                    'If a multi-station is misclassified, this logic stops legitimate downstream telemetry values from being shown to the general public until the station is ' ||
                    'classified as a multi-station.  Unavailable downstream telemetry values for multi-stations should result in the general public receiving a message ' ||
                    'to the effect of ''No downstream data is available for this station.''*/ ' ||
                    '(("position"(lower(tvp.qualifier), ''downstream''::text) = 0 and (' ||
                    (_preferred_direction = 'u')::boolean || ' or ' ||
                    'lower(tcm.station_type) != ''m'')) or ("position"(lower(tvp.qualifier), ''downstream''::text) > 0 and lower(tcm.station_type) = ''m'')) and ' ||
                    'tvp.rloi_id = $1 ' ||
                  'order by ' ||
                    'tv_1.value_timestamp asc ' ||
               ') tv ' ||
             'group by ' ||
               'tv.rloi_id, ' ||
               'tv.qualifier ' ||
          ') tv2 on tcm2.rloi_id = tv2.rloi_id ' ||
        'where ' ||
          'tcm2.rloi_id = $1 ' ||
      ') t ' ||
      'order by t.direction ';

begin

  -- FLO-976 Set the timezone to Europe/London so for the duration of the transaction dates and timestamps are displayed in UK local time.
  set local time zone 'Europe/London';

  if _preferred_direction = 'd' then
    -- If the preferred direction is downstream, specify an ascending direction sort so that any downstream data is first in the recordset.
    sql := sql || 'asc';
  else
    -- If the preferred direction is upstream, specify a descending sort so that any upstream data is first in the recordset.
    sql := sql || 'desc';
  end if;

  -- Only return the first row in the recordset.  If downstream data is preferred and available it will be returned.  In all other cases upstream data will be returned.
  sql := sql || ' limit 1;';

  return query
  execute sql
  using _rloi_id;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION get_telemetry_with_context(integer, character)
  OWNER TO u_flood;
