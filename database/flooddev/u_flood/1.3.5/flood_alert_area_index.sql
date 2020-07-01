-- Index: flood_alert_area_geom_gist

-- DROP INDEX flood_alert_area_geom_gist;

CREATE INDEX flood_alert_area_geom_gist
  ON flood_alert_area
  USING gist
  (geom)
TABLESPACE flood_indexes;
