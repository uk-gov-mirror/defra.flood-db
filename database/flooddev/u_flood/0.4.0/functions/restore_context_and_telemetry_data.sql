-- Function: restore_context_and_telemetry_data()

-- DROP FUNCTION restore_context_and_telemetry_data();

CREATE OR REPLACE FUNCTION restore_context_and_telemetry_data()
  RETURNS void AS
$BODY$
  begin

    insert into u_flood.telemetry_context
      select * from u_flood.telemetry_context_bkp;

    insert into u_flood.telemetry_file
      select * from u_flood.telemetry_file_bkp;

    insert into u_flood.telemetry_value_parent
      select * from u_flood.telemetry_value_parent_bkp;

    insert into u_flood.telemetry_value
      select * from u_flood.telemetry_value_bkp;

    refresh materialized view u_flood.telemetry_context_mview with data;

  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION restore_context_and_telemetry_data()
  OWNER TO u_flood;
