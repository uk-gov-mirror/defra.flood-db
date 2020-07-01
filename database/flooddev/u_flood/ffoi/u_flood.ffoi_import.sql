-- Function: u_flood.ffoi_import()

-- DROP FUNCTION u_flood.ffoi_import();

-- select u_flood.ffoi_import();

CREATE OR REPLACE FUNCTION u_flood.ffoi_import()
  RETURNS void AS
$BODY$
declare
    ffoi_files cursor for select pg_ls_dir as filename from pg_ls_dir('ffoi/');
begin

  -- All timestamps in the source data are in GMT.
  set session time zone 'utc';

  for file in ffoi_files loop

      if ((select count(1) from u_flood.ffoi_file where filename = file.filename) = 0) and lower(right(file.filename, 4)) = '.xml' then
	  begin

	     insert into u_flood.ffoi_file(filename, imported)
	     values (file.filename, current_timestamp at time zone 'utc');

	  exception when others then
	     RAISE WARNING 'Error: processing ffoi file %', file.filename;
	  end;
      end if;
  end loop;

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.ffoi_import()
  OWNER TO u_flood;
