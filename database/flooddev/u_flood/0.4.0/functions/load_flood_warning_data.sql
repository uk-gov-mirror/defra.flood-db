-- Function: load_flood_warning_data()

-- DROP FUNCTION load_flood_warning_data();

CREATE OR REPLACE FUNCTION load_flood_warning_data()
  RETURNS void AS
$BODY$
declare
  number_of_flood_warning_files bigint;
  flood_warnings_filename text;
begin

   number_of_flood_warning_files := (select count(pg_ls_dir) from pg_ls_dir('fwis'));
  
  -- Defensive programming.
  -- Only one current FWIS XML file should be available to load.  If there
  -- are any more the Linux cron job that transfers data hasn't had chance to
  -- remove old FWIS XML files before this stored procedure was called.  In
  -- this case simply abort the stored procedure and wait for its next
  -- scheduled run.  If the cron job and Postgres jobs are timed to work
  -- with one another this should never happen.
  
  if number_of_flood_warning_files = 1 then
  
    flood_warnings_filename := (select pg_ls_dir as filename from pg_ls_dir('fwis'));
  
    -- Double defensive programming to check the filename begins with 'fwis-'.  This
    -- doesn't guarantee the file is correct.
    
    if lower(left(flood_warnings_filename, 5)) = 'fwis-' then
    
      -- Remove the previous set of flood warnings.
      delete from u_flood.current_fwis;

      -- Load the new set of flood warnings.
      insert into u_flood.current_fwis
        (fwa_code, fwa_key, description, region, area, tidal, severity, severity_value, warning_key, time_raised, severity_changed, rim_changed, rim)
      select
        (
          xpath
            ('@fwacode',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text fwa_code,
        (
          xpath
            ('@fwakey',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text::int fwa_key,
        (
          xpath
            ('@description',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text description,
        (
          xpath
            ('@region',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text region,  
        (
          xpath
            ('@area',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text area,
        (
          xpath
            ('@tidal',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text tidal,
        (
          xpath
            ('@severity',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text severity,
        (
          xpath
            ('@severityvalue',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text::smallint severity_value,
        (
          xpath
            ('@warningkey',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text::int warning_key,
        to_timestamp((
          xpath
            ('@timeraised',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text, 'DD MM YYYY HH24 MI')::timestamp without time zone time_raised,
        to_timestamp((
          xpath
            ('@severity_changed',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text, 'DD MM YYYY HH24 MI')::timestamp without time zone severity_changed,
        to_timestamp((
          xpath
            ('@rim_changed',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text, 'DD MM YYYY HH24 MI')::timestamp without time zone rim_changed,
        (
          xpath
            ('ns:rim_english/text()',
             fwa,
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']]
            )
        )[1]::text rim
      from
        unnest
          (xpath
            ('/ns:warningreport/ns:warning',
             xmlparse(document convert_from(pg_read_binary_file('fwis/' || flood_warnings_filename), 'UTF8')),
             array[array['ns', 'http://www.kcom.com/eafwis/fwis-internet-4_0.xsd']])) fwa;

      -- Refresh the materialized view of flood warnings.
      refresh materialized view u_flood.current_flood_warning_alert_mview with data;

      -- Update the timestamp that records when flood warnings were transferred from the FWFI hub.
      update u_flood.current_load_timestamp
      set load_timestamp= (select (regexp_split_to_array((select (regexp_split_to_array(flood_warnings_filename, E'.xml'))[1]), E'-'))[2]::int
      where id=1);

    end if;
  end if;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION load_flood_warning_data()
  OWNER TO u_flood;
