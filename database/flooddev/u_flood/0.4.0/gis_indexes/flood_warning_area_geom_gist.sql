-- Index: u_flood.flood_warning_area_geom_gist

-- DROP INDEX u_flood.flood_warning_area_geom_gist;

CREATE INDEX flood_warning_area_geom_gist
  ON u_flood.flood_warning_area
  USING gist
  (geom)
TABLESPACE flood_indexes;
