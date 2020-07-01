-- Function: load_telemetry_value_parent()

-- DROP FUNCTION load_telemetry_value_parent();

CREATE OR REPLACE FUNCTION load_telemetry_value_parent()
  RETURNS trigger AS
$BODY$
begin

  insert into u_flood.telemetry_value_parent(telemetry_file_id, rloi_id, station, region, start_timestamp, end_timestamp, parameter, qualifier, units, values, post_process, subtract, por_max_value, percentile_5, station_type)
  select
    ttvp.telemetry_file_id,
    -- Type cast required for rloi_id.
    ttvp.rloi_id::integer,
    ttvp.station,
    ttvp.region,
    -- Combine dates and times into timestamps.
    to_timestamp(ttvp.start_date || ' ' || ttvp.start_time, 'YYYY-MM-DD HH24:MI:SS') as start_timestamp,
    to_timestamp(ttvp.end_date || ' ' || ttvp.end_time, 'YYYY-MM-DD HH24:MI:SS') as end_timestamp,
    ttvp.parameter,
    ttvp.qualifier,
    ttvp.units,
    ttvp.values,
    ttvp.post_process,
    ttvp.subtract,
    ttvp.por_max_value,
    ttvp.percentile_5,
    ttvp.station_type
  from
    u_flood.tmp_telemetry_value_parent ttvp
  where
    tmp_telemetry_value_parent_id = new.tmp_telemetry_value_parent_id;

  return new;

exception when others then
  -- Ignore the row if any error occurs such as type conversion failure or null insertion into a non-null column.
  return null;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION load_telemetry_value_parent()
  OWNER TO u_flood;

-- Trigger: trg_ai_tmp_telemetry_value_parent on tmp_telemetry_value_parent

-- DROP TRIGGER trg_ai_tmp_telemetry_value_parent ON tmp_telemetry_value_parent;

CREATE TRIGGER trg_ai_tmp_telemetry_value_parent
  AFTER INSERT
  ON tmp_telemetry_value_parent
  FOR EACH ROW
  EXECUTE PROCEDURE load_telemetry_value_parent();

