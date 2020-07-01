-- Function: u_flood.ffoi_process()

-- DROP FUNCTION u_flood.ffoi_process();

-- select u_flood.ffoi_process();

CREATE OR REPLACE FUNCTION u_flood.ffoi_process()
  RETURNS void AS
$BODY$
declare
    ffoi record;
begin

	-- All timestamps in the source data are in GMT.
	set session time zone 'utc';
	
	for ffoi in select * from u_flood.ffoi_file where not processed and not erred
	loop
		begin
			PERFORM u_flood.ffoi_process_file(ffoi.ffoi_file_id, ffoi.filename);
			Update u_flood.ffoi_file set processed = true where filename = ffoi.filename;
		exception when others then
			Update u_flood.ffoi_file set erred = true where filename = ffoi.filename;
			RAISE WARNING 'Error: processing file %', ffoi.filename;
		end;		
	end loop;

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.ffoi_process()
  OWNER TO u_flood;
