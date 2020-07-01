-- Materialized View: u_flood.stations_overview_mview
-- DROP MATERIALIZED VIEW u_flood.stations_overview_mview;
-- select * from u_flood.stations_overview_mview;
-- History
-- Release	Ticket		Author		Notes
-- 0.4.3	FLO-1018	TJMason		New mview for an overview of stations and some meta data

CREATE MATERIALIZED VIEW u_flood.stations_overview_mview AS 
	select  s.rloi_id, 
	s.telemetry_id,
	s.qualifier as direction, 
	s.station_type, 
	s.agency_name, 
	s.area, 
	s.catchment, 
	s.status, 
	latest.parameter, 
	latest.qualifier, 
	latest.units, 
	latest.value, 
	latest.processed_value, 
	latest.value_timestamp, 
	latest.error, current_timestamp - latest.value_timestamp as age, 
	rb.rloi_id is not null as por_max_breached,
	CASE WHEN (not latest.error and latest.processed_value != 'NaN' and coalesce(latest.processed_value, 0) >= s.percentile_5) THEN true
	ELSE false
	END as at_risk 
	FROM u_flood.station_split_mview s
	left join
		(
		Select *
		FROM
			(
				select p.rloi_id, p.parameter, p.qualifier, p.units,v_rank.*, rank() OVER (PARTITION BY rloi_id, qualifier ORDER by v_rank.value_timestamp desc, v_rank.telemetry_value_id desc) as parent_rank 
				FROM
					(
						select *, rank() OVER (PARTITION BY telemetry_value_parent_id ORDER BY value_timestamp desc) as value_rank
						from u_flood.telemetry_value
					) as v_rank
				inner join u_flood.telemetry_value_parent p on v_rank.telemetry_value_parent_id = p.telemetry_value_parent_id
				where v_rank.value_rank = 1
				and lower(parameter) = 'water level'
				and lower(units) not like '%deg%'
				and lower(qualifier) not like '%height%'
				and lower(qualifier) != 'crest tapping'
				
			) p_rank
		where  p_rank.parent_rank = 1
		) as latest
	on s.rloi_id = latest.rloi_id 
	and ((s.qualifier = 'u' and lower(latest.qualifier) not like '%downstream%') 
	OR (s.qualifier = 'd' and lower(latest.qualifier) like '%downstream%'))
	left join (
		select s.rloi_id, s.qualifier
		From u_flood.station_split_mview s
		inner join u_flood.telemetry_value_parent p 
			on s.rloi_id = p.rloi_id and ((s.qualifier = 'u' and lower(p.qualifier) not like '%downstream%') 
				OR (s.qualifier = 'd' and lower(p.qualifier) like '%downstream%'))
		inner join u_flood.telemetry_value v on p.telemetry_value_parent_id = v.telemetry_value_parent_id
		where 
		not v.error
		and v.processed_value != 'NaN'
		and coalesce(v.processed_value, 0) > s.por_max_value
		and lower(p.parameter) = 'water level'
		and lower(p.units) not like '%deg%'
		and lower(p.qualifier) not like '%height%'
		and lower(p.qualifier) != 'crest tapping'
		group by s.rloi_id, s.qualifier
	) rb on rb.rloi_id = s.rloi_id and rb.qualifier = s.qualifier
WITH DATA;

ALTER TABLE u_flood.stations_overview_mview
  OWNER TO u_flood;
