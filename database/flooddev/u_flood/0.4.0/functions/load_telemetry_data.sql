-- Function: u_flood.load_telemetry_data()

-- DROP FUNCTION u_flood.load_telemetry_data();

CREATE OR REPLACE FUNCTION u_flood.load_telemetry_data()
  RETURNS void AS
$BODY$
declare
    telemetry_json json;
    telemetry_files cursor for select pg_ls_dir as filename from pg_ls_dir('telemetry/local/');
begin

  -- All timestamps in the source data are in GMT.
  set session time zone 'utc';

  create temp table temp_telemetry_json(data json);

  -- Load JSON representations of all unprocessed telemetry XML files received from FWFI hub.
  for file in telemetry_files loop

      if ((select count(1) from u_flood.telemetry_file where filename = file.filename) = 0) and lower(right(file.filename, 5)) = '.json' then
	
          truncate temp_telemetry_json;
          begin
		  execute format('copy temp_telemetry_json(data) from %s csv quote e''\x01'' delimiter e''\x02''', '''telemetry/local/' || file.filename || '''');

		  select data from temp_telemetry_json into telemetry_json;
		  
		  if (telemetry_json IS NOT NULL) then
		     insert into u_flood.telemetry_file(filename, imported, data)
		     values (file.filename, current_timestamp at time zone 'utc', telemetry_json);
		  end if;
	  exception when others then
	     RAISE WARNING 'Error: processing file %', file.filename;
	  end;
      end if;
  end loop;

  -- Load 'header' information associated with telemetry values for each station.  To avoid erroneous data causing the entire bulk insert to fail, unprocessed telemetry data is loaded into
  -- an intermediate table with nullable text columns.  In theory, this should never fail.  A row level trigger exists on the intermediate table to process the data associated with a station
  -- and insert it into the real 'header' information table.  If processing in the trigger fails a row level failure occurs rather than a bulk insert failure.  This approach makes processing
  -- slower but more reliable. As nested subqueries are used it is advised to read nested subquery comments from the inside outwards.
  insert into u_flood.tmp_telemetry_value_parent(telemetry_file_id, rloi_id, station, region, start_date, start_time, end_date, end_time, parameter, qualifier, units, values, post_process, subtract, por_max_value, percentile_5, station_type)
  select
    t3.telemetry_file_id,
    tcm.rloi_id,
    t3.station_reference,
    tcm.region,
    t3.start_date,
    t3.start_time,
    t3.end_date,
    t3.end_time,
    t3.parameter,
    t3.qualifier,
    t3.units,
    t3.values,
    tcm.post_process,
    tcm.subtract,
    -- Round station context values needed for subsequent processing to two decimal places.
    -- Use the station context data qualifier to determine if upstream or downstream values
    -- should be rounded.
    case when position('downstream' in lower(t3.qualifier)) > 0 then round(tcm.d_por_max_value, 2)
         else round(tcm.por_max_value, 2)
         end as por_max_value,
    case when position('downstream' in lower(t3.qualifier)) > 0 then round(tcm.d_percentile_5, 2)
         else round(tcm.percentile_5, 2)
         end as tcm_percentile_5,
    tcm.station_type
  from
    (
      -- Transform station 'header' JSON into a form suitable for subsequent processing.
      -- All extracted JSON text data appears to be double quoted by design.  As such btrim is used to remove the double quotes.
      -- After this further processing can be performed as expected (for example concatenating dates and times into timestamps and table joins based on textual data).
      select
        t2.telemetry_file_id,
         btrim((t2.station_reference)::text, '"') as station_reference,
         btrim((t2.region)::text, '"') as region,
         btrim((t2.data->'$'->'startDate')::text, '"') as start_date,
         btrim((t2.data->'$'->'startTime')::text, '"') as start_time,
         btrim((t2.data->'$'->'endDate')::text, '"') as end_date,
         btrim((t2.data->'$'->'endTime')::text, '"') as end_time,
         btrim((t2.data->'$'->'parameter')::text, '"') as parameter,
         btrim((t2.data->'$'->'qualifier')::text, '"') as qualifier,
         btrim((t2.data->'$'->'units')::text, '"') as units,
         t2.data->'Value' as values
      from
        (
          -- Extract station reference, region and telemetry values.
          -- The telemetry values will be in JSON form ready for subsequent extraction and processing.
          select
            t1.telemetry_file_id, t1.data->'$'->'stationReference' as station_reference,
            t1.data->'$'->'region' as region, json_array_elements(t1.data->'SetofValues') as data
          from
            (
              -- Extract top level station data of unprocessed telemetry files.
              select
                telemetry_file_id,
                json_array_elements(data->'EATimeSeriesDataExchangeFormat'->'Station') as data
              from
                u_flood.telemetry_file
              where
                not processed
            ) t1
        ) t2
    ) t3,
    u_flood.telemetry_context_mview tcm
  where
    -- Join telemetry and station context data based on telemetry ID (station reference) and region.
    t3.station_reference = tcm.telemetry_id and
    t3.region = tcm.time_series_region;

     -- Process individual telemetry values using the same approach as for the 'header' information (i.e. use an intermediate table and a trigger to avoid
     -- erroneous data causing bulk insert failures).
     insert into u_flood.tmp_telemetry_value(telemetry_value_parent_id, value, value_date, value_time, post_process, subtract, por_max_value, station_type)
     select
       t1.telemetry_value_parent_id,
       btrim((t1.value->'_')::text, '"') as value,
       btrim((t1.value->'$'->'date')::text, '"') as value_date,
       btrim((t1.value->'$'->'time')::text, '"') as value_time,
       t1.post_process,
       t1.subtract,
       t1.por_max_value,
       t1.station_type
     from
       ( -- Extract individual telemetry readings for all telemetry stations associated with unprocessed files.
         select
           tvp.telemetry_value_parent_id,
           json_array_elements(tvp.values) as value,
           tvp.post_process,
           tvp.subtract,
           tvp.por_max_value,
           tvp.station_type
         from
           u_flood.telemetry_value_parent tvp,
           u_flood.telemetry_file tf
         where
           tvp.telemetry_file_id = tf.telemetry_file_id and
           not tf.processed
       ) t1;

  update u_flood.telemetry_file set processed = true where not processed;

  drop table temp_telemetry_json;

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.load_telemetry_data()
  OWNER TO u_flood;
