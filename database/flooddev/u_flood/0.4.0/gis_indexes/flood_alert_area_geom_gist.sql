-- Index: u_flood.flood_alert_area_geom_gist

-- DROP INDEX u_flood.flood_alert_area_geom_gist;

CREATE INDEX flood_alert_area_geom_gist
  ON u_flood.flood_alert_area
  USING gist
  (geom)
TABLESPACE flood_indexes;
