
-- select u_flood.ffoi_process_file('ANFSANTS20170117093138419.XML');



	
select pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml;


-- working
select xpath('/ns:EATimeSeriesDataExchangeFormat/ns:Station', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']])

select unnest(xpath('/ns:EATimeSeriesDataExchangeFormat/ns:Station', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))

-- select unnest(xpath('/ns:EATimeSeriesDataExchangeFormat/ns:Station', pg_read_file('ffoi/ANFSANTS20170117001608916.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']]))


	-- ensure xml document is a variable already read in.
	set session time zone 'utc';
	select 
	to_timestamp(
		(xpath('/ns:EATimeSeriesDataExchangeFormat/md:Date/text()', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat'], array['md', 'http://www.environment-agency.gov.uk/XMLSchemas/EAMetadataFormat']]))[1] 
		|| ' ' || 
		(xpath('/ns:EATimeSeriesDataExchangeFormat/md:Time/text()', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat'], array['md', 'http://www.environment-agency.gov.uk/XMLSchemas/EAMetadataFormat']]))[1], 
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
	from unnest(xpath('/ns:EATimeSeriesDataExchangeFormat/ns:Station', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat']])) ffoi;

	
	
	select forecastdate[1]::text
	from xpath('/ns:EATimeSeriesDataExchangeFormat/md:Date/text()', pg_read_file('ffoi/ANFSANTS20170117093138419.XML', 0, 100000000)::xml, array[array['ns', 'http://www.environment-agency.gov.uk/XMLSchemas/EATimeSeriesDataExchangeFormat'], array['md', 'http://www.environment-agency.gov.uk/XMLSchemas/EAMetadataFormat']]) forecastdate
	
	-- to_timestamp(ttv.value_date || ' ' || ttv.value_time, 'YYYY-MM-DD HH24:MI:SS') as value_timestamp
        select * from u_flood.ffoi_forecast

        select * from u_flood.telemetry_value limit 1