-- Create postgis schema
CREATE SCHEMA IF NOT EXISTS postgis
  AUTHORIZATION u_flood;

GRANT ALL ON SCHEMA postgis TO u_flood;

-- Ensure the database and u_flood role search_ path is set to install extension in the postgis schema
ALTER DATABASE flooddev SET search_path = postgis, public;
ALTER ROLE u_flood SET search_path = postgis, public;

-- Install postgis and postgis_topology extensions
DROP EXTENSION IF EXISTS postgis_topology cascade;
DROP EXTENSION IF EXISTS postgis cascade;

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;

ALTER EXTENSION postgis
  UPDATE TO "2.3.7next";

ALTER EXTENSION postgis
  UPDATE TO "2.3.7";

-- Set the schema owner to the builtin rds_superuser group
ALTER SCHEMA postgis owner to rds_superuser;
ALTER SCHEMA topology owner to rds_superuser;

-- Create and execute function to transfer owner ship of postgis/topology scema objects to rds_superuser group.
CREATE FUNCTION exec(text) returns text language plpgsql volatile AS $f$ BEGIN EXECUTE $1; RETURN $1; END; $f$;

SELECT exec('ALTER TABLE ' || quote_ident(s.nspname) || '.' || quote_ident(s.relname) || ' OWNER TO rds_superuser;')
  FROM (
    SELECT nspname, relname
    FROM pg_class c JOIN pg_namespace n ON (c.relnamespace = n.oid)
    WHERE nspname in ('postgis','topology') AND
    relkind IN ('r','S','v') ORDER BY relkind = 'S')
s;

-- Create the main u_flood schema
CREATE SCHEMA IF NOT EXISTS u_flood
  AUTHORIZATION u_flood;

COMMENT ON SCHEMA u_flood
  IS 'Flood schema';

-- Create tablespaces for flood_indexes and flood_tables
CREATE TABLESPACE flood_indexes OWNER u_flood LOCATION '/srv/postgres/data/wiyby/wiyby_indexes';
CREATE TABLESPACE flood_tables OWNER u_flood LOCATION '/srv/postgres/data/wiyby/wiyby_tables';

-- Ensure the database and u_flood role search path is correctly set
ALTER DATABASE flooddev SET search_path = "$user", postgis, topology, public;
ALTER ROLE u_flood SET search_path = u_flood, postgis, topology, public;

