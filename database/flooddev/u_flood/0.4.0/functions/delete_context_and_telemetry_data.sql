-- Function: delete_context_and_telemetry_data()

-- DROP FUNCTION delete_context_and_telemetry_data();

CREATE OR REPLACE FUNCTION delete_context_and_telemetry_data()
  RETURNS void AS
$BODY$
  begin

    truncate u_flood.telemetry_context cascade;

    truncate u_flood.telemetry_file cascade;

    refresh materialized view u_flood.telemetry_context_mview with data;

  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION delete_context_and_telemetry_data()
  OWNER TO u_flood;
