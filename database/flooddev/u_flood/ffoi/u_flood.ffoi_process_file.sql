-- Function: u_flood.ffoi_process_file()

-- DROP FUNCTION u_flood.ffoi_process_file(bigint, text);

-- select u_flood.ffoi_process_file(xx, 'ANFSANTS20170117093138419.XML');
-- select u_flood.ffoi_process_file(xx, 'NEFSNETS20170117095320811.XML');

CREATE OR REPLACE FUNCTION u_flood.ffoi_process_file(ffoi_file_id bigint, filename text)
  RETURNS void AS
$BODY$
declare
    ffoi_xml xml;
begin
	-- All timestamps in the source data are in GMT.
	set session time zone 'utc';

	-- read in our file
	ffoi_xml := pg_read_file('ffoi/' || filename, 0, 100000000)::xml;
	
	create temp table temp_ffoi_forecast AS SELECT * FROM u_flood.ffoi_forecast where 1 = 0;

	--probably not needed but get of unused columns in case non nullable
	ALTER TABLE temp_ffoi_forecast DROP ffoi_forecast_id;
	ALTER TABLE temp_ffoi_forecast DROP ffoi_file_id;
	ALTER TABLE temp_ffoi_forecast DROP rloi_id;

	-- Store file values in temp table
	INSERT INTO temp_ffoi_forecast (forecast_date, station_reference, station_name, parameter, qualifier, units, start_timestamp, end_timestamp, values)
	SELECT 
	to_timestamp(
		(xpath('/ns:EATimeSeriesDataExchangeFormat/md:Date/text()', ffoi_xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat'], array['md', 'http://www.environment-agency.gov.uk/XMLSchemas/EAMetadataFormat']]))[1] 
		|| ' ' || 
		(xpath('/ns:EATimeSeriesDataExchangeFormat/md:Time/text()', ffoi_xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat'], array['md', 'http://www.environment-agency.gov.uk/XMLSchemas/EAMetadataFormat']]))[1], 
		'YYYY-MM-DD HH24:MI:SS'
		) forecast_date,
	(xpath('@stationReference', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::text station_reference,
	(xpath('@stationName', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::text station_name,
	(xpath('ns:SetofValues/@parameter', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::text parameter,
	(xpath('ns:SetofValues/@qualifier', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::text qualifier,
	(xpath('ns:SetofValues/@units', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::text units,
	to_timestamp((xpath('ns:SetofValues/@startDate', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1] || ' ' || (xpath('ns:SetofValues/@startTime', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1], 'YYYY-MM-DD HH24:MI:SS') start_timestamp,
	to_timestamp((xpath('ns:SetofValues/@endDate', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1] || ' ' || (xpath('ns:SetofValues/@endTime', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1], 'YYYY-MM-DD HH24:MI:SS') end_timestamp,
	(xpath('ns:SetofValues', ffoi, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))[1]::xml as values
	from unnest(xpath('/ns:EATimeSeriesDataExchangeFormat/ns:Station', ffoi_xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']])) ffoi;

	-- Join temp table with station data to only insert matched forecasts
	INSERT INTO u_flood.ffoi_forecast (ffoi_file_id, forecast_date, station_reference, station_name, rloi_id, parameter, qualifier, units, start_timestamp, end_timestamp, values)
	SELECT 
	ffoi_file_id,
	f.forecast_date,
	f.station_reference,
	f.station_name,
	tc.rloi_id,
	f.parameter,
	f.qualifier,
	f.units,
	f.start_timestamp,
	f.end_timestamp,
	f.values
	FROM temp_ffoi_forecast f 
	INNER JOIN u_flood.telemetry_context tc ON tc.wiski_id = f.station_reference
	WHERE f.parameter = 'Water Level';
	
	drop table temp_ffoi_forecast;

end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION u_flood.ffoi_process_file(bigint, text)
  OWNER TO u_flood;
