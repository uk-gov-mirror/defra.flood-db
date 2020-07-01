-- Function: backup_context_and_telemetry_data()

-- DROP FUNCTION backup_context_and_telemetry_data();

CREATE OR REPLACE FUNCTION backup_context_and_telemetry_data()
  RETURNS void AS
$BODY$
  begin

    insert into u_flood.telemetry_context_bkp
      select * from u_flood.telemetry_context;

    insert into u_flood.telemetry_file_bkp
      select * from u_flood.telemetry_file;

    insert into u_flood.telemetry_value_parent_bkp
      select * from u_flood.telemetry_value_parent;

    insert into u_flood.telemetry_value_bkp
      select * from u_flood.telemetry_value;

  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION backup_context_and_telemetry_data()
  OWNER TO u_flood;
