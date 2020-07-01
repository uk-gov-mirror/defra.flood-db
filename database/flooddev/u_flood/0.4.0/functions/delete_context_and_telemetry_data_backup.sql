-- Function: delete_context_and_telemetry_data_backup()

-- DROP FUNCTION delete_context_and_telemetry_data_backup();

CREATE OR REPLACE FUNCTION delete_context_and_telemetry_data_backup()
  RETURNS void AS
$BODY$
  begin

    truncate u_flood.telemetry_context_bkp cascade;

    truncate u_flood.telemetry_file_bkp cascade;

  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION delete_context_and_telemetry_data_backup()
  OWNER TO u_flood;
