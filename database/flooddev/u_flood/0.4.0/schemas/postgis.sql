-- Schema: postgis

-- DROP SCHEMA postgis;

CREATE SCHEMA postgis
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA postgis TO rds_superuser;
GRANT ALL ON SCHEMA postgis TO u_flood;
