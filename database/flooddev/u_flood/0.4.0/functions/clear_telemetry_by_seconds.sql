-- Function: clear_telemetry_by_seconds(bigint)

-- DROP FUNCTION clear_telemetry_by_seconds(bigint);

CREATE OR REPLACE FUNCTION clear_telemetry_by_seconds(bigint)
  RETURNS void AS
$BODY$
  begin
  	DELETE
  	FROM	u_flood.telemetry_file
  	WHERE	imported < to_timestamp(EXTRACT(EPOCH FROM now()) - $1) at time zone 'utc';
  end;
  $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION clear_telemetry_by_seconds(bigint)
  OWNER TO u_flood;
