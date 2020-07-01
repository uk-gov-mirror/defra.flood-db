-- Function: ffoi_get_thresholds(integer)

-- DROP FUNCTION ffoi_get_thresholds(integer);

CREATE OR REPLACE FUNCTION ffoi_get_thresholds(_rloi_id integer)
  RETURNS json AS
$BODY$
declare result json;
begin
	select array_to_json(array_agg(res))
	from
	(
		select t.*, COALESCE(faa.ta_name, fwa.ta_name) as fwa_name,
		CASE
		    WHEN faa.gid is not null THEN 'a'
		    WHEN fwa.gid is not null THEN 'w'
		    ELSE ''
		END AS fwa_type,
		COALESCE(cf.severity_value, -1) as fwa_severity
		from u_flood.ffoi_station s
		inner join u_flood.ffoi_station_threshold t on s.ffoi_station_id = t.ffoi_station_id
		left join u_flood.flood_alert_area faa on faa.fws_tacode = t.fwis_code
		left join u_flood.flood_warning_area fwa on fwa.fws_tacode = t.fwis_code
		left join u_flood.current_fwis cf on fwa_code = t.fwis_code
		where s.rloi_id = _rloi_id
		order by fwa_type,t.value,COALESCE(faa.ta_name, fwa.ta_name)
	) as res into result;
	return result;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION ffoi_get_thresholds(integer)
  OWNER TO u_flood;
