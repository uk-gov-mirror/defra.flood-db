-- Non-rainfall sls_telemetry_value readings, partitioned monthly, retained for 3 years.
CREATE TABLE IF NOT EXISTS u_flood.sls_telemetry_value_history
(
    value_timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    rloi_id INTEGER NOT NULL,
    processed_value NUMERIC NOT NULL,
    parameter TEXT NOT NULL,
    qualifier TEXT NOT NULL,
    CONSTRAINT pk_sls_telemetry_value_history PRIMARY KEY (rloi_id, parameter, qualifier, value_timestamp)
) PARTITION BY RANGE (value_timestamp);

ALTER TABLE u_flood.sls_telemetry_value_history
    OWNER TO u_flood;

-- Copies any live telemetry not already in history, then removes history older than 3 years.
-- Safe to re-run; must run at least once within the 5 day live retention window.
CREATE OR REPLACE FUNCTION u_flood.update_telemetry_history()
    RETURNS BIGINT
    LANGUAGE plpgsql
AS $BODY$
DECLARE
    _retain_from TIMESTAMP WITH TIME ZONE := now() - INTERVAL '3 years';
    _min TIMESTAMP;
    _max TIMESTAMP;
    _month TIMESTAMP;
    _partition TEXT;
    _inserted BIGINT;
BEGIN
    SELECT min(v.value_timestamp) AT TIME ZONE 'utc', max(v.value_timestamp) AT TIME ZONE 'utc'
    INTO _min, _max
    FROM u_flood.sls_telemetry_value_parent p
    JOIN u_flood.sls_telemetry_value v ON v.telemetry_value_parent_id = p.telemetry_value_parent_id
    WHERE v.value_timestamp >= _retain_from
    AND p.parameter <> 'Rainfall';

    IF _min IS NOT NULL THEN
        FOR _month IN SELECT generate_series(date_trunc('month', _min), date_trunc('month', _max), INTERVAL '1 month') LOOP
            EXECUTE format(
                'CREATE TABLE IF NOT EXISTS u_flood.%I PARTITION OF u_flood.sls_telemetry_value_history FOR VALUES FROM (%L) TO (%L)',
                'sls_telemetry_value_history_' || to_char(_month, 'YYYY_MM'),
                _month AT TIME ZONE 'utc',
                (_month + INTERVAL '1 month') AT TIME ZONE 'utc'
            );
        END LOOP;
    END IF;

    -- Overlapping live files repeat readings, so duplicates are skipped.
    INSERT INTO u_flood.sls_telemetry_value_history (value_timestamp, rloi_id, processed_value, parameter, qualifier)
    SELECT v.value_timestamp, p.rloi_id, v.processed_value, p.parameter, COALESCE(p.qualifier, '')
    FROM u_flood.sls_telemetry_value_parent p
    JOIN u_flood.sls_telemetry_value v ON v.telemetry_value_parent_id = p.telemetry_value_parent_id
    WHERE v.value_timestamp >= _retain_from
    AND p.parameter <> 'Rainfall'
    AND NOT v.error
    AND v.processed_value IS NOT NULL
    ON CONFLICT DO NOTHING;

    GET DIAGNOSTICS _inserted = ROW_COUNT;

    FOR _partition IN
        SELECT c.relname
        FROM pg_inherits i
        JOIN pg_class c ON c.oid = i.inhrelid
        WHERE i.inhparent = 'u_flood.sls_telemetry_value_history'::regclass
        AND (to_date(right(c.relname, 7), 'YYYY_MM') + INTERVAL '1 month') AT TIME ZONE 'utc' <= _retain_from
    LOOP
        EXECUTE format('DROP TABLE u_flood.%I', _partition);
    END LOOP;

    -- Trims the part of the oldest remaining month that has passed 3 years.
    DELETE FROM u_flood.sls_telemetry_value_history
    WHERE value_timestamp < _retain_from;

    RETURN _inserted;
END
$BODY$;

ALTER FUNCTION u_flood.update_telemetry_history()
    OWNER TO u_flood;

-- Backfill from the live tables.
SELECT u_flood.update_telemetry_history();
