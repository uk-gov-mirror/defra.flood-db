--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.19
-- Dumped by pg_dump version 10.0

-- Started on 2018-02-02 13:34:33 GMT
--
-- TOC entry 225 (class 1259 OID 19129)
-- Name: flood_warning_area; Type: TABLE; Schema: u_flood; Owner: u_flood
--

CREATE TABLE flood_warning_area (
    gid integer NOT NULL,
    area character varying(100),
    fws_tacode character varying(50),
    ta_name character varying(100),
    descrip character varying(254),
    la_name character varying(254),
    parent character varying(50),
    qdial character varying(50),
    river_sea character varying(254),
    geom geometry(MultiPolygon,4326)
);


ALTER TABLE flood_warning_area OWNER TO u_flood;

--
-- TOC entry 226 (class 1259 OID 19135)
-- Name: flood_warning_area_gid_seq; Type: SEQUENCE; Schema: u_flood; Owner: u_flood
--

CREATE SEQUENCE IF NOT EXISTS flood_warning_area_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE flood_warning_area_gid_seq OWNER TO u_flood;

--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 226
-- Name: flood_warning_area_gid_seq; Type: SEQUENCE OWNED BY; Schema: u_flood; Owner: u_flood
--

ALTER SEQUENCE flood_warning_area_gid_seq OWNED BY flood_warning_area.gid;


--
-- TOC entry 3338 (class 2604 OID 19340)
-- Name: flood_warning_area gid; Type: DEFAULT; Schema: u_flood; Owner: u_flood
--

ALTER TABLE ONLY flood_warning_area ALTER COLUMN gid SET DEFAULT nextval('flood_warning_area_gid_seq'::regclass);


--
-- TOC entry 3340 (class 2606 OID 19384)
-- Name: flood_warning_area flood_warning_area_pkey; Type: CONSTRAINT; Schema: u_flood; Owner: u_flood
--

ALTER TABLE ONLY flood_warning_area
    ADD CONSTRAINT flood_warning_area_pkey PRIMARY KEY (gid);


-- Completed on 2018-02-02 13:34:33 GMT

--
-- PostgreSQL database dump complete
--

