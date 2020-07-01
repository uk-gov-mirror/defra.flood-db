--Strip out FFOI tables and functions as moving to serverless
DROP FUNCTION IF EXISTS u_flood.ffoi_import();
DROP FUNCTION IF EXISTS u_flood.ffoi_process();
DROP FUNCTION IF EXISTS u_flood.ffoi_process_file(bigint,text);
DROP FUNCTION IF EXISTS u_flood.ffoi_cleanup_by_seconds(bigint);
DROP FUNCTION IF EXISTS u_flood.ffoi_process_trigger() CASCADE;

DROP TABLE IF EXISTS u_flood.ffoi_file CASCADE;
DROP TABLE IF EXISTS u_flood.ffoi_forecast CASCADE;
