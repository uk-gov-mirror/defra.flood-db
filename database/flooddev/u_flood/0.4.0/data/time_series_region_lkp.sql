--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = u_flood, pg_catalog;

--
-- Data for Name: time_series_region_lkp; Type: TABLE DATA; Schema: u_flood; Owner: u_flood
--

INSERT INTO time_series_region_lkp VALUES (1, 'Anglian', 'Anglian');
INSERT INTO time_series_region_lkp VALUES (2, 'Midland', 'Midlands');
INSERT INTO time_series_region_lkp VALUES (3, 'North East', 'North East');
INSERT INTO time_series_region_lkp VALUES (4, 'North West', 'North West');
INSERT INTO time_series_region_lkp VALUES (5, 'South West', 'South West');
INSERT INTO time_series_region_lkp VALUES (6, 'Southern', 'Southern');
INSERT INTO time_series_region_lkp VALUES (7, 'Thames', 'Thames');
INSERT INTO time_series_region_lkp VALUES (8, 'EA Wales', 'Wales');
INSERT INTO time_series_region_lkp VALUES (9, 'EA South East', 'South East');


--
-- Name: time_series_region_lkp_time_series_lkp_id_seq; Type: SEQUENCE SET; Schema: u_flood; Owner: u_flood
--

SELECT pg_catalog.setval('time_series_region_lkp_time_series_lkp_id_seq', 9, true);


--
-- PostgreSQL database dump complete
--

