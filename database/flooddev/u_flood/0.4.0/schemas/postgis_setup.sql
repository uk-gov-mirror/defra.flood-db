DROP EXTENSION IF EXISTS postgis cascade;
CREATE EXTENSION postgis;
ALTER DATABASE flooddev SET search_path = "$user", public, postgis, topology;
UPDATE pg_extension 
  SET extrelocatable = TRUE 
    WHERE extname = 'postgis';
 
ALTER EXTENSION postgis 
  SET SCHEMA postgis;
 
ALTER EXTENSION postgis 
  UPDATE TO "2.3.3next";
 
ALTER EXTENSION postgis 
  UPDATE TO "2.3.3";
