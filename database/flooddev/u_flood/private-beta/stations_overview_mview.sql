-- View: u_flood.stations_overview_mview

DROP MATERIALIZED VIEW u_flood.stations_overview_mview cascade;

CREATE MATERIALIZED VIEW u_flood.stations_overview_mview
TABLESPACE pg_default
AS
 SELECT s.rloi_id,
    s.telemetry_id,
    s.wiski_id,
    s.qualifier AS direction,
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
    latest.error,
    now() - latest.value_timestamp AS age,
    rb.rloi_id IS NOT NULL AS por_max_breached,
        CASE
            WHEN NOT latest.error AND latest.processed_value <> 'NaN'::numeric AND COALESCE(latest.processed_value, 0::numeric) >= s.percentile_5 THEN true
            ELSE false
        END AS at_risk,
    fs.rloi_id IS NOT NULL AS forecast,
        CASE
            WHEN s.station_type = 'C'::bpchar THEN ''::text
            WHEN latest.processed_value < s.percentile_95 THEN 'low'::text
            WHEN latest.processed_value >= s.percentile_5 THEN 'high'::text
            ELSE 'normal'::text
        END AS level,
    s.percentile_5,
    s.percentile_95
   FROM station_split_mview s
     LEFT JOIN ( SELECT p_rank.rloi_id,
            p_rank.parameter,
            p_rank.qualifier,
            p_rank.units,
            p_rank.telemetry_value_id,
            p_rank.telemetry_value_parent_id,
            p_rank.value,
            p_rank.processed_value,
            p_rank.value_timestamp,
            p_rank.error,
            p_rank.value_rank,
            p_rank.parent_rank
           FROM ( SELECT p.rloi_id,
                    p.parameter,
                    p.qualifier,
                    p.units,
                    v_rank.telemetry_value_id,
                    v_rank.telemetry_value_parent_id,
                    v_rank.value,
                    v_rank.processed_value,
                    v_rank.value_timestamp,
                    v_rank.error,
                    v_rank.value_rank,
                    rank() OVER (PARTITION BY p.rloi_id, p.qualifier ORDER BY v_rank.value_timestamp DESC, v_rank.telemetry_value_id DESC) AS parent_rank
                   FROM ( SELECT sls_telemetry_value.telemetry_value_id,
                            sls_telemetry_value.telemetry_value_parent_id,
                            sls_telemetry_value.value,
                            sls_telemetry_value.processed_value,
                            sls_telemetry_value.value_timestamp,
                            sls_telemetry_value.error,
                            rank() OVER (PARTITION BY sls_telemetry_value.telemetry_value_parent_id ORDER BY sls_telemetry_value.value_timestamp DESC) AS value_rank
                           FROM sls_telemetry_value) v_rank
                     JOIN sls_telemetry_value_parent p ON v_rank.telemetry_value_parent_id = p.telemetry_value_parent_id
                  WHERE v_rank.value_rank = 1 AND lower(p.parameter) = 'water level'::text AND lower(p.units) !~~ '%deg%'::text AND lower(p.qualifier) !~~ '%height%'::text AND lower(p.qualifier) <> 'crest tapping'::text) p_rank
          WHERE p_rank.parent_rank = 1) latest ON s.rloi_id = latest.rloi_id AND (s.qualifier = 'u'::text AND lower(latest.qualifier) !~~ '%downstream%'::text OR s.qualifier = 'd'::text AND lower(latest.qualifier) ~~ '%downstream%'::text)
     LEFT JOIN ( SELECT s_1.rloi_id,
            s_1.qualifier
           FROM station_split_mview s_1
             JOIN sls_telemetry_value_parent p ON s_1.rloi_id = p.rloi_id AND (s_1.qualifier = 'u'::text AND lower(p.qualifier) !~~ '%downstream%'::text OR s_1.qualifier = 'd'::text AND lower(p.qualifier) ~~ '%downstream%'::text)
             JOIN sls_telemetry_value v ON p.telemetry_value_parent_id = v.telemetry_value_parent_id
          WHERE NOT v.error AND v.processed_value <> 'NaN'::numeric AND COALESCE(v.processed_value, 0::numeric) > s_1.por_max_value AND lower(p.parameter) = 'water level'::text AND lower(p.units) !~~ '%deg%'::text AND lower(p.qualifier) !~~ '%height%'::text AND lower(p.qualifier) <> 'crest tapping'::text
          GROUP BY s_1.rloi_id, s_1.qualifier) rb ON rb.rloi_id = s.rloi_id AND rb.qualifier = s.qualifier
     LEFT JOIN ffoi_station fs ON fs.rloi_id = s.rloi_id
WITH DATA;

ALTER TABLE u_flood.stations_overview_mview
    OWNER TO u_flood;
