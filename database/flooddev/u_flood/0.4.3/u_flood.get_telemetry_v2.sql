-- Function: u_flood.get_telemetry(integer, character)

-- DROP FUNCTION u_flood.get_telemetry(integer, character);

-- select u_flood.get_telemetry(1021, 'u') 

-- History
-- Release	Ticket		Author		Notes
-- 0.4.1			Tedd Mason	Original creation of function
-- 0.4.3	FLO-1017	Tedd Mason	Removing label field due to front end refactor; altering function to return json object.
-- 0.4.3	FLO-1208	Tedd Mason	Returning rolling back google charts and implementing chartjs again.

--Changing return type so need to drop first.
DROP FUNCTION u_flood.get_telemetry(integer, character);

CREATE OR REPLACE FUNCTION u_flood.get_telemetry(IN _rloi_id integer, IN _qualifier character)
  RETURNS json AS
$BODY$

declare result json;

begin
	-- NOTE: returning this time zone set for google chart rollback, remove once returned!!
	--works by magic, so that the label for chartjs has the correct timezone.
	--so '2015-05-21T23:00:00.000Z' returns '22 May 2015 12:00am'
	set local time zone 'Europe/London';

	select array_to_json(array_agg(res))
	from
	(
		select 
		v.value_timestamp as ts,
		-- commenting out for googlechart rollback!
		--to_char(v.value_timestamp, 'YYYY-MM-DD"T"HH24:MIZ') as ts, --ISO8601 timestamp consumable by date.parse
		v.processed_value as _, 
		v.error as err,
		-- returning below label field for googlechart rollback!
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
		and lower(p.qualifier) != 'crest tapping'
		--Potentially will need to add a date filter here for when we start showing more than 5 days of data.
		order by v.value_timestamp DESC
	) as res into result;
	return result;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.get_telemetry(integer, character)
  OWNER TO u_flood;
