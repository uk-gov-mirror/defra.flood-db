-- Function: u_flood.ffoi_cleanup_by_seconds(bigint)

-- DROP FUNCTION u_flood.ffoi_cleanup_by_seconds(bigint);

CREATE OR REPLACE FUNCTION u_flood.ffoi_cleanup_by_seconds(bigint)
  RETURNS void AS
$BODY$
declare
    ffoi record;
begin

	-- All timestamps in the source data are in GMT.
	set session time zone 'utc';

	Delete
	FROM u_flood.ffoi_file
	WHERE imported < to_timestamp(EXTRACT(EPOCH FROM now()) - $1);
	
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.ffoi_cleanup_by_seconds(bigint)
  OWNER TO u_flood;
