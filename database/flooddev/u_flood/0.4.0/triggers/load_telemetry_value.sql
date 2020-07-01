-- Function: load_telemetry_value()

-- DROP FUNCTION load_telemetry_value();

CREATE OR REPLACE FUNCTION load_telemetry_value()
  RETURNS trigger AS
$BODY$
begin

  insert into u_flood.telemetry_value(telemetry_value_parent_id, value, processed_value, value_timestamp, formatted_value_timestamp, error)
  select
    t1.telemetry_value_parent_id,
    t1.value,
    -- Remove processed values for all error conditions (values less than zero for non-coastal stations).
    case when t1.processed_value is not null and lower(t1.station_type) != 'c' and processed_value < 0 then null
         else round(t1.processed_value, 2)
    end as processed_value,
    t1.value_timestamp,
    -- FLO-976 - Format dates using standard year rather than ISO year.
    -- NOTE - Precomputed formatted value timestamps  produced here are UTC based and should not be used for UK local time dependent display.  The function u_flood.get_telemetry_with_context
    -- has been refactored to compute UK local time dependent timestamps for display to users.  However UTC formatted value timestamps are retained to avoid potential risk associated with
    -- removing a database column and/or changing formatted value timestamps to use UK local time while retaining UTC value timestamps.
    -- If the timestamp is the start of a new day (00:00 hours), the full timestamp should be displayed.
    case when extract('hour' from t1.value_timestamp)::integer = 0 and extract('minute' from t1.value_timestamp)::integer = 0 then to_char(t1.value_timestamp, 'DD FMMonth YYYY FMHH12:MIam')
         -- If the hour is divisible by six the time should be displayed.
         when extract('hour' from t1.value_timestamp)::integer % 6 = 0 and extract('minute' from t1.value_timestamp)::integer = 0 then to_char(t1.value_timestamp, 'FMHH12:MIam')
         -- In all other cases nothing should be displayed so the chart is not cluttered.
         else ''
    end as formatted_value_timestamp,
    -- Flag an error for telemetry values less than zero for non-coastal stations.
    case when t1.processed_value is not null then (lower(t1.station_type) != 'c' and processed_value < 0)
         else false
    end as error
  from
    (
      -- Perform telemetry value post processing as required.
      select
        ttv.telemetry_value_parent_id,
        ttv.value::numeric,
        case when ttv.post_process and ttv.subtract is not null then ttv.value::numeric - ttv.subtract
             else ttv.value::numeric
        end as processed_value,
        to_timestamp(ttv.value_date || ' ' || ttv.value_time, 'YYYY-MM-DD HH24:MI:SS') as value_timestamp,
        ttv.por_max_value,
        ttv.station_type
      from
        u_flood.tmp_telemetry_value ttv
      where
        tmp_telemetry_value_id = new.tmp_telemetry_value_id
    ) t1;

  return new;

exception when others then
  -- Ignore the row if any error occurs such as type conversion failure or null insertion into a non-null column.
  return null;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION load_telemetry_value()
  OWNER TO u_flood;


-- Trigger: trg_ai_tmp_telemetry_value on tmp_telemetry_value

-- DROP TRIGGER trg_ai_tmp_telemetry_value ON tmp_telemetry_value;

CREATE TRIGGER trg_ai_tmp_telemetry_value
  AFTER INSERT
  ON tmp_telemetry_value
  FOR EACH ROW
  EXECUTE PROCEDURE load_telemetry_value();

