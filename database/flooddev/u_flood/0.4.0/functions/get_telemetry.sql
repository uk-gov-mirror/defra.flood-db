-- Function: u_flood.get_telemetry(integer, character)

-- DROP FUNCTION u_flood.get_telemetry(integer, character);

-- select * from u_flood.get_telemetry(3421, 'u') limit 1

CREATE OR REPLACE FUNCTION u_flood.get_telemetry(IN _rloi_id integer, IN _qualifier character)
  RETURNS TABLE(ts timestamp with time zone, _ numeric, err boolean, label text) AS
$BODY$
begin
	--works by magic, so that the label for chartjs has the correct timezone.
	--so '2015-05-21T23:00:00.000Z' returns '22 May 2015 12:00am'
	set local time zone 'Europe/London';

	return query
	select 
	v.value_timestamp, 
	v.processed_value, 
	v.error,
	/*Date formatting taken from u_flood.get_telemetry_with_context NOTE first and last datetimes need setting in the code*/
	case when extract('hour' from v.value_timestamp)::integer = 0 and extract('minute' from v.value_timestamp)::integer = 0 
		then to_char(v.value_timestamp, 'DD FMMonth YYYY FMHH12:MIam')
                /* If the hour is divisible by six the time should be displayed. */
             when extract('hour' from v.value_timestamp)::integer % 6 = 0 and extract('minute' from v.value_timestamp)::integer = 0 
                then to_char(v.value_timestamp, 'FMHH12:MIam')
                /* In all other cases nothing should be displayed so the chart is not cluttered. */
             else ''
        end as label
	From u_flood.telemetry_value_parent p
	inner join u_flood.telemetry_value v on v.telemetry_value_parent_id = p.telemetry_value_parent_id
	inner join u_flood.station_split_mview s on p.rloi_id = s.rloi_id and s.qualifier = _qualifier
	where p.rloi_id = _rloi_id
	and (s.status_date is null or v.value_timestamp >= s.status_date)
	and lower(p.parameter) like 'water level' -- Only interested in waterlevel
	and (
		(_qualifier = 'u' and lower(p.qualifier) not like '%downstream%') --if upstream filter out downstream stage
		OR 
		(_qualifier = 'd' and lower(p.qualifier) like '%downstream%') --if downstream, then multistation's downstream stage needed
	    )
	and lower(p.units) not like '%deg%'
	and lower(p.qualifier) not like '%height%'
	--Potentially will need to add a date filter here for when we start showing more than 5 days of data.
	order by v.value_timestamp DESC
;end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION u_flood.get_telemetry(integer, character)
  OWNER TO u_flood;
