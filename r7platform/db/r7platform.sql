--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-02-22 20:37:14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 32818)
-- Name: libs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA libs;


--
-- TOC entry 12 (class 2615 OID 107156)
-- Name: logs; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA logs;


--
-- TOC entry 11 (class 2615 OID 107139)
-- Name: metadata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA metadata;


--
-- TOC entry 7 (class 2615 OID 98425)
-- Name: rawdata_kk; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA rawdata_kk;


--
-- TOC entry 10 (class 2615 OID 98678)
-- Name: rawdata_kls; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA rawdata_kls;


--
-- TOC entry 8 (class 2615 OID 98507)
-- Name: rawdata_msk; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA rawdata_msk;


--
-- TOC entry 9 (class 2615 OID 98592)
-- Name: rawdata_roiet; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA rawdata_roiet;


--
-- TOC entry 5 (class 2615 OID 41079)
-- Name: users; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA users;


--
-- TOC entry 296 (class 1255 OID 73938)
-- Name: hash_password(character varying); Type: FUNCTION; Schema: users; Owner: -
--

CREATE FUNCTION users.hash_password(plain_text character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN crypt(plain_text, gen_salt('bf', 10));
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 73996)
-- Name: clinic_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.clinic_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 230 (class 1259 OID 73986)
-- Name: clinics; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.clinics (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(200),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 228 (class 1259 OID 73960)
-- Name: drug_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.drug_mappings (
    code character varying(10) NOT NULL,
    f43 character varying(50),
    tmt character varying(50),
    nhso character varying(50),
    hospcode character varying(10) NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    user_id uuid
);


--
-- TOC entry 232 (class 1259 OID 74001)
-- Name: drug_usages; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.drug_usages (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    usage1 character varying(255),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    usage2 character varying(255),
    usage3 character varying(255)
);


--
-- TOC entry 226 (class 1259 OID 73944)
-- Name: drugs; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.drugs (
    code character varying(50) NOT NULL,
    name character varying(255),
    hospcode character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    user_id uuid
);


--
-- TOC entry 229 (class 1259 OID 73981)
-- Name: insurance_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.insurance_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 227 (class 1259 OID 73953)
-- Name: insurances; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.insurances (
    hospcode character varying(10) NOT NULL,
    code character varying(6) NOT NULL,
    name character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    user_id uuid
);


--
-- TOC entry 234 (class 1259 OID 74028)
-- Name: lab_groups; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.lab_groups (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(200),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    user_id uuid
);


--
-- TOC entry 241 (class 1259 OID 82070)
-- Name: lab_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.lab_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    loinc character varying(50),
    updated_at timestamp without time zone,
    user_id uuid
);


--
-- TOC entry 233 (class 1259 OID 74021)
-- Name: labs; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.labs (
    hospcode character varying(10) NOT NULL,
    code character varying(50) NOT NULL,
    name character varying(200),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    lab_group_code character varying(50)
);


--
-- TOC entry 238 (class 1259 OID 74054)
-- Name: nation_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.nation_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 237 (class 1259 OID 74047)
-- Name: nations; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.nations (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(200),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 236 (class 1259 OID 74042)
-- Name: occupation_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.occupation_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 235 (class 1259 OID 74035)
-- Name: occupations; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.occupations (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(200),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 239 (class 1259 OID 74059)
-- Name: providers; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.providers (
    hospcode character varying(10) NOT NULL,
    code character varying(50) NOT NULL,
    fname character varying(100),
    lname character varying(100),
    sex character(1),
    birth date,
    provider_type character varying(15),
    start_date date,
    end_date date,
    cid character varying(13),
    register_no character varying(50),
    council character varying(2),
    prename character varying(50)
);


--
-- TOC entry 240 (class 1259 OID 74064)
-- Name: wards; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.wards (
    hospcode character varying(10) NOT NULL,
    code character varying(10) NOT NULL,
    name character varying(200),
    user_id uuid,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- TOC entry 292 (class 1259 OID 107157)
-- Name: transactions; Type: TABLE; Schema: logs; Owner: -
--

CREATE TABLE logs.transactions (
    trx_id uuid NOT NULL,
    hospcode character varying(10) NOT NULL,
    user_id uuid NOT NULL,
    ingress_zone character varying(100) NOT NULL,
    file_name character varying(50),
    total_records numeric DEFAULT 0,
    status character varying,
    created_at timestamp without time zone,
    error text
);


--
-- TOC entry 293 (class 1259 OID 107181)
-- Name: ipd; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE metadata.ipd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(50) NOT NULL,
    dischs character(1) NOT NULL,
    discht character(1) NOT NULL,
    dateadm date NOT NULL,
    timeadm time without time zone NOT NULL,
    datedsc date NOT NULL,
    timedsc time without time zone NOT NULL,
    d_update timestamp without time zone NOT NULL,
    ingress_zone character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone
);


--
-- TOC entry 291 (class 1259 OID 107150)
-- Name: opd; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE metadata.opd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(50) NOT NULL,
    date_serv date NOT NULL,
    time_serv time without time zone NOT NULL,
    diag_text character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    d_update timestamp without time zone,
    chiefcomp character varying(255),
    ingress_zone character varying(50) NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 290 (class 1259 OID 107140)
-- Name: person; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE metadata.person (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    cid character varying(13) NOT NULL,
    fname character varying(150) NOT NULL,
    lname character varying(150) NOT NULL,
    birth date NOT NULL,
    sex character(1) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    d_update timestamp without time zone,
    ingress_zone character varying(100) NOT NULL,
    updated_at timestamp without time zone
);


--
-- TOC entry 242 (class 1259 OID 98426)
-- Name: appoint; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.appoint (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15),
    seq character varying(15),
    appoint_date date NOT NULL,
    appoint_time time without time zone,
    clinic character varying(100) NOT NULL,
    remark character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 243 (class 1259 OID 98429)
-- Name: chronic; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.chronic (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    date_diag date,
    chronic character varying(6) NOT NULL,
    hosp_dx character varying(5),
    hosp_rx character varying(5),
    date_disch date,
    d_update timestamp without time zone
);


--
-- TOC entry 244 (class 1259 OID 98432)
-- Name: drug; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.drug (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    seq character varying(15) NOT NULL,
    did character varying(30) NOT NULL,
    amount numeric(6,0),
    drugprice numeric(7,2),
    drugcost numeric(7,2),
    unit character varying(50),
    unit_pack character varying(20),
    sigcode character varying(50),
    provider character varying(15),
    d_update timestamp without time zone
);


--
-- TOC entry 245 (class 1259 OID 98435)
-- Name: drugallergy; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.drugallergy (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    daterecord timestamp without time zone,
    dname character varying(255) NOT NULL,
    typedx character(1),
    alevel character(1),
    symptom character(2),
    informant character(1),
    informhosp character(5),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 246 (class 1259 OID 98438)
-- Name: ipd; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.ipd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    dateadm date,
    timeadm time without time zone,
    datedsc date,
    timedsc time without time zone,
    dischs character(1),
    discht character(1),
    dept character varying(6),
    warddsc character varying(6),
    adm_w numeric(5,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 247 (class 1259 OID 98442)
-- Name: ipdx; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.ipdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 248 (class 1259 OID 98445)
-- Name: ipop; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.ipop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    oper character varying(7) NOT NULL,
    optype character(1),
    provider character varying(6),
    datein date,
    timein time without time zone,
    dateout date,
    timeout time without time zone,
    d_update timestamp without time zone
);


--
-- TOC entry 249 (class 1259 OID 98448)
-- Name: lab; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.lab (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    an character varying(15),
    labtest character varying(30) NOT NULL,
    labresult character varying(100),
    d_update timestamp without time zone
);


--
-- TOC entry 250 (class 1259 OID 98451)
-- Name: opd; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.opd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    clinic character varying(10),
    date_serv date NOT NULL,
    time_serv time without time zone,
    seq character varying(15) NOT NULL,
    chiefcomp character varying,
    btemp numeric(3,1),
    sbp numeric(3,0),
    dbp numeric(3,0),
    pr numeric(3,0),
    rr numeric(3,0),
    typein character(1),
    typeout character(1),
    ins_type character varying(10),
    ins_number character varying(15),
    ins_hospmain character varying(10),
    ins_hospsub character varying(10),
    diag_text character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 251 (class 1259 OID 98456)
-- Name: opdx; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.opdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    datedx date,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 252 (class 1259 OID 98459)
-- Name: opop; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.opop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    dateop date,
    oper character varying(7) NOT NULL,
    provider character varying(6),
    servprice numeric(7,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 253 (class 1259 OID 98463)
-- Name: person; Type: TABLE; Schema: rawdata_kk; Owner: -
--

CREATE TABLE rawdata_kk.person (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    cid character varying(13),
    title character varying(30),
    fname character varying(100),
    lname character varying(100),
    birth date,
    sex character(1),
    marriage character(1),
    occupation character varying(10),
    nation character varying(10),
    idtype character(1),
    changwat character(2),
    amphur character(2),
    tambol character(2),
    moo character varying(3),
    typearea character(1),
    d_update timestamp without time zone
);


--
-- TOC entry 278 (class 1259 OID 98679)
-- Name: appoint; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.appoint (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15),
    seq character varying(15),
    appoint_date date NOT NULL,
    appoint_time time without time zone,
    clinic character varying(100) NOT NULL,
    remark character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 279 (class 1259 OID 98682)
-- Name: chronic; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.chronic (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    date_diag date,
    chronic character varying(6) NOT NULL,
    hosp_dx character varying(5),
    hosp_rx character varying(5),
    date_disch date,
    d_update timestamp without time zone
);


--
-- TOC entry 280 (class 1259 OID 98685)
-- Name: drug; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.drug (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    seq character varying(15) NOT NULL,
    did character varying(30) NOT NULL,
    amount numeric(6,0),
    drugprice numeric(7,2),
    drugcost numeric(7,2),
    unit character varying(50),
    unit_pack character varying(20),
    sigcode character varying(50),
    provider character varying(15),
    d_update timestamp without time zone
);


--
-- TOC entry 281 (class 1259 OID 98688)
-- Name: drugallergy; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.drugallergy (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    daterecord timestamp without time zone,
    dname character varying(255) NOT NULL,
    typedx character(1),
    alevel character(1),
    symptom character(2),
    informant character(1),
    informhosp character(5),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 282 (class 1259 OID 98691)
-- Name: ipd; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.ipd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    dateadm date,
    timeadm time without time zone,
    datedsc date,
    timedsc time without time zone,
    dischs character(1),
    discht character(1),
    dept character varying(6),
    warddsc character varying(6),
    adm_w numeric(5,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 283 (class 1259 OID 98695)
-- Name: ipdx; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.ipdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 284 (class 1259 OID 98698)
-- Name: ipop; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.ipop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    oper character varying(7) NOT NULL,
    optype character(1),
    provider character varying(6),
    datein date,
    timein time without time zone,
    dateout date,
    timeout time without time zone,
    d_update timestamp without time zone
);


--
-- TOC entry 285 (class 1259 OID 98701)
-- Name: lab; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.lab (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    an character varying(15),
    labtest character varying(30) NOT NULL,
    labresult character varying(100),
    d_update timestamp without time zone
);


--
-- TOC entry 286 (class 1259 OID 98704)
-- Name: opd; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.opd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    clinic character varying(10),
    date_serv date NOT NULL,
    time_serv time without time zone,
    seq character varying(15) NOT NULL,
    chiefcomp character varying,
    btemp numeric(3,1),
    sbp numeric(3,0),
    dbp numeric(3,0),
    pr numeric(3,0),
    rr numeric(3,0),
    typein character(1),
    typeout character(1),
    ins_type character varying(10),
    ins_number character varying(15),
    ins_hospmain character varying(10),
    ins_hospsub character varying(10),
    diag_text character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 287 (class 1259 OID 98709)
-- Name: opdx; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.opdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    datedx date,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 288 (class 1259 OID 98712)
-- Name: opop; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.opop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    dateop date,
    oper character varying(7) NOT NULL,
    provider character varying(6),
    servprice numeric(7,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 289 (class 1259 OID 98716)
-- Name: person; Type: TABLE; Schema: rawdata_kls; Owner: -
--

CREATE TABLE rawdata_kls.person (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    cid character varying(13),
    title character varying(30),
    fname character varying(100),
    lname character varying(100),
    birth date,
    sex character(1),
    marriage character(1),
    occupation character varying(10),
    nation character varying(10),
    idtype character(1),
    changwat character(2),
    amphur character(2),
    tambol character(2),
    moo character varying(3),
    typearea character(1),
    d_update timestamp without time zone
);


--
-- TOC entry 254 (class 1259 OID 98508)
-- Name: appoint; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.appoint (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15),
    seq character varying(15),
    appoint_date date NOT NULL,
    appoint_time time without time zone,
    clinic character varying(100) NOT NULL,
    remark character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 255 (class 1259 OID 98511)
-- Name: chronic; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.chronic (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    date_diag date,
    chronic character varying(6) NOT NULL,
    hosp_dx character varying(5),
    hosp_rx character varying(5),
    date_disch date,
    d_update timestamp without time zone
);


--
-- TOC entry 256 (class 1259 OID 98514)
-- Name: drug; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.drug (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    seq character varying(15) NOT NULL,
    did character varying(30) NOT NULL,
    amount numeric(6,0),
    drugprice numeric(7,2),
    drugcost numeric(7,2),
    unit character varying(50),
    unit_pack character varying(20),
    sigcode character varying(50),
    provider character varying(15),
    d_update timestamp without time zone
);


--
-- TOC entry 257 (class 1259 OID 98517)
-- Name: drugallergy; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.drugallergy (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    daterecord timestamp without time zone,
    dname character varying(255) NOT NULL,
    typedx character(1),
    alevel character(1),
    symptom character(2),
    informant character(1),
    informhosp character(5),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 258 (class 1259 OID 98520)
-- Name: ipd; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.ipd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    dateadm date,
    timeadm time without time zone,
    datedsc date,
    timedsc time without time zone,
    dischs character(1),
    discht character(1),
    dept character varying(6),
    warddsc character varying(6),
    adm_w numeric(5,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 259 (class 1259 OID 98524)
-- Name: ipdx; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.ipdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 260 (class 1259 OID 98527)
-- Name: ipop; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.ipop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    oper character varying(7) NOT NULL,
    optype character(1),
    provider character varying(6),
    datein date,
    timein time without time zone,
    dateout date,
    timeout time without time zone,
    d_update timestamp without time zone
);


--
-- TOC entry 261 (class 1259 OID 98530)
-- Name: lab; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.lab (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    an character varying(15),
    labtest character varying(30) NOT NULL,
    labresult character varying(100),
    d_update timestamp without time zone
);


--
-- TOC entry 262 (class 1259 OID 98533)
-- Name: opd; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.opd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    clinic character varying(10),
    date_serv date NOT NULL,
    time_serv time without time zone,
    seq character varying(15) NOT NULL,
    chiefcomp character varying,
    btemp numeric(3,1),
    sbp numeric(3,0),
    dbp numeric(3,0),
    pr numeric(3,0),
    rr numeric(3,0),
    typein character(1),
    typeout character(1),
    ins_type character varying(10),
    ins_number character varying(15),
    ins_hospmain character varying(10),
    ins_hospsub character varying(10),
    diag_text character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 263 (class 1259 OID 98538)
-- Name: opdx; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.opdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    datedx date,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 264 (class 1259 OID 98541)
-- Name: opop; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.opop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    dateop date,
    oper character varying(7) NOT NULL,
    provider character varying(6),
    servprice numeric(7,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 265 (class 1259 OID 98545)
-- Name: person; Type: TABLE; Schema: rawdata_msk; Owner: -
--

CREATE TABLE rawdata_msk.person (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    cid character varying(13),
    title character varying(30),
    fname character varying(100),
    lname character varying(100),
    birth date,
    sex character(1),
    marriage character(1),
    occupation character varying(10),
    nation character varying(10),
    idtype character(1),
    changwat character(2),
    amphur character(2),
    tambol character(2),
    moo character varying(3),
    typearea character(1),
    d_update timestamp without time zone
);


--
-- TOC entry 266 (class 1259 OID 98593)
-- Name: appoint; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.appoint (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15),
    seq character varying(15),
    appoint_date date NOT NULL,
    appoint_time time without time zone,
    clinic character varying(100) NOT NULL,
    remark character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 267 (class 1259 OID 98596)
-- Name: chronic; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.chronic (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    date_diag date,
    chronic character varying(6) NOT NULL,
    hosp_dx character varying(5),
    hosp_rx character varying(5),
    date_disch date,
    d_update timestamp without time zone
);


--
-- TOC entry 268 (class 1259 OID 98599)
-- Name: drug; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.drug (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    seq character varying(15) NOT NULL,
    did character varying(30) NOT NULL,
    amount numeric(6,0),
    drugprice numeric(7,2),
    drugcost numeric(7,2),
    unit character varying(50),
    unit_pack character varying(20),
    sigcode character varying(50),
    provider character varying(15),
    d_update timestamp without time zone
);


--
-- TOC entry 269 (class 1259 OID 98602)
-- Name: drugallergy; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.drugallergy (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    daterecord timestamp without time zone,
    dname character varying(255) NOT NULL,
    typedx character(1),
    alevel character(1),
    symptom character(2),
    informant character(1),
    informhosp character(5),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 270 (class 1259 OID 98605)
-- Name: ipd; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.ipd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    dateadm date,
    timeadm time without time zone,
    datedsc date,
    timedsc time without time zone,
    dischs character(1),
    discht character(1),
    dept character varying(6),
    warddsc character varying(6),
    adm_w numeric(5,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 271 (class 1259 OID 98609)
-- Name: ipdx; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.ipdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 272 (class 1259 OID 98612)
-- Name: ipop; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.ipop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    an character varying(15) NOT NULL,
    oper character varying(7) NOT NULL,
    optype character(1),
    provider character varying(6),
    datein date,
    timein time without time zone,
    dateout date,
    timeout time without time zone,
    d_update timestamp without time zone
);


--
-- TOC entry 273 (class 1259 OID 98615)
-- Name: lab; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.lab (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    an character varying(15),
    labtest character varying(30) NOT NULL,
    labresult character varying(100),
    d_update timestamp without time zone
);


--
-- TOC entry 274 (class 1259 OID 98618)
-- Name: opd; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.opd (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    clinic character varying(10),
    date_serv date NOT NULL,
    time_serv time without time zone,
    seq character varying(15) NOT NULL,
    chiefcomp character varying,
    btemp numeric(3,1),
    sbp numeric(3,0),
    dbp numeric(3,0),
    pr numeric(3,0),
    rr numeric(3,0),
    typein character(1),
    typeout character(1),
    ins_type character varying(10),
    ins_number character varying(15),
    ins_hospmain character varying(10),
    ins_hospsub character varying(10),
    diag_text character varying(255),
    d_update timestamp without time zone
);


--
-- TOC entry 275 (class 1259 OID 98623)
-- Name: opdx; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.opdx (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    datedx date,
    diag character varying(7) NOT NULL,
    dxtype character(1),
    provider character varying(6),
    d_update timestamp without time zone
);


--
-- TOC entry 276 (class 1259 OID 98626)
-- Name: opop; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.opop (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    seq character varying(15) NOT NULL,
    dateop date,
    oper character varying(7) NOT NULL,
    provider character varying(6),
    servprice numeric(7,2) DEFAULT 0,
    d_update timestamp without time zone
);


--
-- TOC entry 277 (class 1259 OID 98630)
-- Name: person; Type: TABLE; Schema: rawdata_roiet; Owner: -
--

CREATE TABLE rawdata_roiet.person (
    hospcode character varying(10) NOT NULL,
    hn character varying(50) NOT NULL,
    cid character varying(13),
    title character varying(30),
    fname character varying(100),
    lname character varying(100),
    birth date,
    sex character(1),
    marriage character(1),
    occupation character varying(10),
    nation character varying(10),
    idtype character(1),
    changwat character(2),
    amphur character(2),
    tambol character(2),
    moo character varying(3),
    typearea character(1),
    d_update timestamp without time zone
);


--
-- TOC entry 223 (class 1259 OID 41108)
-- Name: admin; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.admin (
    id uuid DEFAULT gen_random_uuid(),
    username character varying(10) NOT NULL,
    password character varying(128),
    enabled boolean DEFAULT false
);


--
-- TOC entry 222 (class 1259 OID 41100)
-- Name: hospitals; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.hospitals (
    hospcode character varying(10) NOT NULL,
    hospname character varying(255),
    zone_code character(4),
    enabled boolean DEFAULT true,
    is_deleted boolean DEFAULT false
);


--
-- TOC entry 295 (class 1259 OID 115205)
-- Name: platforms; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.platforms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    platform_name character varying(255),
    login_endpoint character varying(255),
    refresh_endpoint character varying(255),
    description character varying(255)
);


--
-- TOC entry 225 (class 1259 OID 65655)
-- Name: tokens; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.tokens (
    user_id uuid NOT NULL,
    refresh_token character varying NOT NULL,
    expires_at timestamp without time zone,
    created_at timestamp with time zone DEFAULT now(),
    ingress_zone character varying,
    hospcode character varying
);


--
-- TOC entry 294 (class 1259 OID 115189)
-- Name: user_platforms; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.user_platforms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(150) NOT NULL,
    api_key character varying(250),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone,
    platform_id uuid NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 41088)
-- Name: users; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    first_name character varying(150),
    last_name character varying(150),
    hospcode character varying(10),
    username character varying(50) NOT NULL,
    password character varying(150),
    enabled boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    email character varying(50),
    last_login timestamp without time zone
);


--
-- TOC entry 224 (class 1259 OID 49279)
-- Name: zones; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.zones (
    code character(4) NOT NULL,
    name character varying(150),
    ingress_zone character varying(20),
    enabled boolean DEFAULT true
);


--
-- TOC entry 3905 (class 0 OID 73996)
-- Dependencies: 231
-- Data for Name: clinic_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3904 (class 0 OID 73986)
-- Dependencies: 230
-- Data for Name: clinics; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3902 (class 0 OID 73960)
-- Dependencies: 228
-- Data for Name: drug_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drug_mappings VALUES ('101', '200000125', '450000210', '4100014', '11053', '2023-02-01 14:06:20.823', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('102', '2000001257122', '4500002107122', NULL, '11053', '2023-02-04 19:12:28.112', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('1001', '12221', '13333', NULL, '11053', '2023-02-04 19:12:53.432', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('1002', '89999', '99999', NULL, '11053', '2023-02-04 19:31:33.251', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3906 (class 0 OID 74001)
-- Dependencies: 232
-- Data for Name: drug_usages; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drug_usages VALUES ('11053', '2121', 'fdsdsfdsfdsfsd', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-05 10:27:03.601125', '2023-02-05 10:27:03.49', 'dsfdsfds', 'dfdsfdsfds');
INSERT INTO libs.drug_usages VALUES ('11053', '1122', 'erwer', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-05 10:58:14.481076', '2023-02-05 11:17:52.295', 'eeeeeeeee', 'sadsdsas');


--
-- TOC entry 3900 (class 0 OID 73944)
-- Dependencies: 226
-- Data for Name: drugs; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drugs VALUES ('101', 'Paracetamol 500mg', '11053', '2023-02-04 12:46:27.232622', '2023-02-04 18:47:53.46', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('102', 'Amoxyciline2 250mg', '11053', '2023-02-04 07:12:58.571608', '2023-02-04 19:31:40.089', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('1001', 'TA 0.1', '11053', '2023-02-04 19:12:34.710435', '2023-02-05 10:33:00.706', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('1002', 'ยีเรียครีม 0.5', '11053', '2023-02-04 19:12:34.710435', '2023-02-05 10:33:15.598', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3903 (class 0 OID 73981)
-- Dependencies: 229
-- Data for Name: insurance_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3901 (class 0 OID 73953)
-- Dependencies: 227
-- Data for Name: insurances; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3908 (class 0 OID 74028)
-- Dependencies: 234
-- Data for Name: lab_groups; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.lab_groups VALUES ('11053', '5003', 'eeee', '2023-02-06 10:09:54.520265', '2023-02-06 10:10:47.671', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_groups VALUES ('11053', '5001', 'CBC', '2023-02-06 10:11:02.374292', '2023-02-06 10:11:02.374292', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_groups VALUES ('11053', '5002', 'ANC', '2023-02-06 09:50:53.777719', '2023-02-06 10:11:02.374292', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3915 (class 0 OID 82070)
-- Dependencies: 241
-- Data for Name: lab_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.lab_mappings VALUES ('1002', '11053', '2000001257', '4500002107', '2023-02-02 15:00:28.434', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_mappings VALUES ('1001', '11053', '2000001288', '4500002188', '2023-02-06 10:28:24.698', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_mappings VALUES ('xxxxx', '11053', '5465464', '556465464', '2023-02-06 10:28:46.596', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3907 (class 0 OID 74021)
-- Dependencies: 233
-- Data for Name: labs; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.labs VALUES ('11053', '1001', 'TEST LAB', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-01 14:56:00.604107', '2023-02-06 10:19:51.53', '5002');
INSERT INTO libs.labs VALUES ('11053', '1002', 'FBS', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-02 15:00:38.807533', '2023-02-06 10:20:01.17', '5001');


--
-- TOC entry 3912 (class 0 OID 74054)
-- Dependencies: 238
-- Data for Name: nation_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3911 (class 0 OID 74047)
-- Dependencies: 237
-- Data for Name: nations; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3910 (class 0 OID 74042)
-- Dependencies: 236
-- Data for Name: occupation_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3909 (class 0 OID 74035)
-- Dependencies: 235
-- Data for Name: occupations; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3913 (class 0 OID 74059)
-- Dependencies: 239
-- Data for Name: providers; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3914 (class 0 OID 74064)
-- Dependencies: 240
-- Data for Name: wards; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3966 (class 0 OID 107157)
-- Dependencies: 292
-- Data for Name: transactions; Type: TABLE DATA; Schema: logs; Owner: -
--



--
-- TOC entry 3967 (class 0 OID 107181)
-- Dependencies: 293
-- Data for Name: ipd; Type: TABLE DATA; Schema: metadata; Owner: -
--



--
-- TOC entry 3965 (class 0 OID 107150)
-- Dependencies: 291
-- Data for Name: opd; Type: TABLE DATA; Schema: metadata; Owner: -
--



--
-- TOC entry 3964 (class 0 OID 107140)
-- Dependencies: 290
-- Data for Name: person; Type: TABLE DATA; Schema: metadata; Owner: -
--



--
-- TOC entry 3916 (class 0 OID 98426)
-- Dependencies: 242
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3917 (class 0 OID 98429)
-- Dependencies: 243
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3918 (class 0 OID 98432)
-- Dependencies: 244
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3919 (class 0 OID 98435)
-- Dependencies: 245
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3920 (class 0 OID 98438)
-- Dependencies: 246
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3921 (class 0 OID 98442)
-- Dependencies: 247
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3922 (class 0 OID 98445)
-- Dependencies: 248
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3923 (class 0 OID 98448)
-- Dependencies: 249
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3924 (class 0 OID 98451)
-- Dependencies: 250
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3925 (class 0 OID 98456)
-- Dependencies: 251
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3926 (class 0 OID 98459)
-- Dependencies: 252
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3927 (class 0 OID 98463)
-- Dependencies: 253
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3952 (class 0 OID 98679)
-- Dependencies: 278
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3953 (class 0 OID 98682)
-- Dependencies: 279
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3954 (class 0 OID 98685)
-- Dependencies: 280
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3955 (class 0 OID 98688)
-- Dependencies: 281
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3956 (class 0 OID 98691)
-- Dependencies: 282
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3957 (class 0 OID 98695)
-- Dependencies: 283
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3958 (class 0 OID 98698)
-- Dependencies: 284
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3959 (class 0 OID 98701)
-- Dependencies: 285
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3960 (class 0 OID 98704)
-- Dependencies: 286
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3961 (class 0 OID 98709)
-- Dependencies: 287
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3962 (class 0 OID 98712)
-- Dependencies: 288
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3963 (class 0 OID 98716)
-- Dependencies: 289
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3928 (class 0 OID 98508)
-- Dependencies: 254
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3929 (class 0 OID 98511)
-- Dependencies: 255
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3930 (class 0 OID 98514)
-- Dependencies: 256
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3931 (class 0 OID 98517)
-- Dependencies: 257
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3932 (class 0 OID 98520)
-- Dependencies: 258
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3933 (class 0 OID 98524)
-- Dependencies: 259
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3934 (class 0 OID 98527)
-- Dependencies: 260
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3935 (class 0 OID 98530)
-- Dependencies: 261
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3936 (class 0 OID 98533)
-- Dependencies: 262
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3937 (class 0 OID 98538)
-- Dependencies: 263
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3938 (class 0 OID 98541)
-- Dependencies: 264
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3939 (class 0 OID 98545)
-- Dependencies: 265
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3940 (class 0 OID 98593)
-- Dependencies: 266
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3941 (class 0 OID 98596)
-- Dependencies: 267
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3942 (class 0 OID 98599)
-- Dependencies: 268
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3943 (class 0 OID 98602)
-- Dependencies: 269
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3944 (class 0 OID 98605)
-- Dependencies: 270
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3945 (class 0 OID 98609)
-- Dependencies: 271
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3946 (class 0 OID 98612)
-- Dependencies: 272
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3947 (class 0 OID 98615)
-- Dependencies: 273
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3948 (class 0 OID 98618)
-- Dependencies: 274
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3949 (class 0 OID 98623)
-- Dependencies: 275
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3950 (class 0 OID 98626)
-- Dependencies: 276
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3951 (class 0 OID 98630)
-- Dependencies: 277
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3897 (class 0 OID 41108)
-- Dependencies: 223
-- Data for Name: admin; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.admin VALUES ('37749a01-8c93-44ee-9051-8ece2401427c', 'admin', '$2b$10$2NmnJDrUYza5xBRgF7CR/.Oi8xJe3eZyO1seQFrE1460zg58qvjyO', true);


--
-- TOC entry 3896 (class 0 OID 41100)
-- Dependencies: 222
-- Data for Name: hospitals; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.hospitals VALUES ('10707', 'รพท.มหาสารคาม', '4400', true, false);
INSERT INTO users.hospitals VALUES ('11053', ' รพช.กันทรวิชัย', '4400', true, false);
INSERT INTO users.hospitals VALUES ('11111', 'xxxxxxxxxxxxx', '4000', true, false);
INSERT INTO users.hospitals VALUES ('11054', 'รพช.เชียงยืน', '4400', true, false);


--
-- TOC entry 3969 (class 0 OID 115205)
-- Dependencies: 295
-- Data for Name: platforms; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.platforms VALUES ('137e6fe0-cc02-4594-9491-c2d023df5456', 'R7 Platform', 'http://localhost:3001/login', 'http://localhost:3001/refresh_token', 'แพลตฟอร์มกลางเขตสุขภาพที่ 7');
INSERT INTO users.platforms VALUES ('b2cd329a-c636-4b1f-a368-253a40a41912', 'N-Refer', 'http://localhost:3001/login', 'http://localhost:3001/refresh_token', 'ระบบ N Refer');


--
-- TOC entry 3899 (class 0 OID 65655)
-- Dependencies: 225
-- Data for Name: tokens; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3tgbLhBlvwd899fMLq7DRf3HMhZaq0r83flAMbzzGJyE9liCSdKA21cisqrlCFCZ', '2023-02-24 20:01:52.263869', '2023-01-25 20:01:52.263869+07', NULL, NULL);
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '9kYtvzQ1n9dRBkAW8RbCbuSoJiTvb9mbpyf8v2oEhGh9AsLjgjyetgDpchaOAWjR', '2023-02-24 20:02:34.55461', '2023-01-25 20:02:34.55461+07', NULL, NULL);
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'epYo8mAhEvcNrdulJsX0mFQippUEZVh96Qdz5h3un4CdmsU5s1AUGvd3KHdbhxcM', '2023-02-24 20:03:53.775554', '2023-01-25 20:03:53.775554+07', NULL, NULL);
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ur1anjnQZTuRI4L3Ao3u0VoLLo2LHksrQY7PWRGiFrIqGg8bgXGcBeBhiDxn8ROD', '2023-02-24 20:12:19.997672', '2023-01-25 20:12:19.997672+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ojukv3igcJN5F77dFpRWsBoaE9vidUjLMINzxG2D8MplFmP40aFpgnui4Qi2sVe2', '2023-02-27 17:16:08.336627', '2023-01-28 17:16:08.336627+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'wuBd9ZssYTu8fcwJ4JzOd3corXMM7Rj4Vtv3ZM6wtBEEHRQ66cxOPdIhkh8aGZQh', '2023-02-27 17:26:30.484463', '2023-01-28 17:26:30.484463+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'kImc5o8LtIvw5DsbCNhUJ00rKPioN7jCHsN7Bkdqt8hj2T07279hc0230i8jr1gz', '2023-02-27 17:31:56.416906', '2023-01-28 17:31:56.416906+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '4DjXplK58ndshqJimUJS0u9AhJFv4hAvm5eDyBHnMLEwLSPPAX5KS61v4NpQpMmD', '2023-02-27 17:48:00.736508', '2023-01-28 17:48:00.736508+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jJL1gvTJn4efRqzsGrPm1WSEIIVuAgilPA51RCK6F9xYkhyAfY0RxnKPFmOmgPGA', '2023-02-27 18:08:14.751007', '2023-01-28 18:08:14.751007+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jonuKxidE46RfqvMn60iLhUPCdfW1XWnGsv1mlkqH2Z3giQ0CZGSu7AMOpjPeVSO', '2023-02-27 18:21:04.553007', '2023-01-28 18:21:04.553007+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'qSjr4UO2mA5YSyYPzAf8t45ccbNC4J4Cruvj4O8WKXZVxDAcHNsh0onShMjaaO3D', '2023-02-28 18:27:23.02166', '2023-01-29 18:27:23.02166+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3jQagLqrtuQctuN9Pykgc6wlMCIU3qP3Wd0GsBtJb3h3sMA5NkGbHPPXQwzZBs12', '2023-02-28 18:27:43.998462', '2023-01-29 18:27:43.998462+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'R49WpvKmPh8maUPMe1hwyHFlsfFR3uOfcRkkNu9ADY4yuD47QpTBmg2dFqrSSxen', '2023-03-03 12:12:35.480659', '2023-02-01 12:12:35.480659+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'g7BBvjwY4gaEvsqAJxqmTgb7sGVsJeQiidwdNINN59jniOIzk0LoGw6tSKNqhSXd', '2023-03-03 12:14:50.923114', '2023-02-01 12:14:50.923114+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'wze35OoxghXxIOcdRXlFMi8aOccCKwQizYr2OTbOnfH9bbA7MXMcc0mRsyppDwJO', '2023-03-03 12:15:27.837371', '2023-02-01 12:15:27.837371+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'dtBHaSuZrAUGNSs3i11SuHM834Wo4RWcPhGHCMlakN2fMkzk7h6lb3bZmT6adpSx', '2023-03-03 12:16:09.063738', '2023-02-01 12:16:09.063738+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'guUzbhaIwOdigotWlJpLfoB4W7bxT9XzF31cbYJsNIeAF7XhbSSEIlTNkE9yjMMg', '2023-03-03 12:17:13.264224', '2023-02-01 12:17:13.264224+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'nFcXBrsmV53E9oFWZ0sZO6co75A93tl9CqXYpRiz0poLiln3k7vxlDOWv9qA7T5c', '2023-03-03 12:17:46.060826', '2023-02-01 12:17:46.060826+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '4muilXEiQ5LotmHtrUCMY3WQuTWPvmfDeRb8aUz04zywtPcsfgGnqpFuuDgiQaLE', '2023-03-03 12:19:32.80883', '2023-02-01 12:19:32.80883+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3karjAM5Bsr4qzicMzY8m8qOQKxdEN6cJPH0SIghFcX3THv9Ze2b0lFVMK38IImd', '2023-03-03 12:19:44.179109', '2023-02-01 12:19:44.179109+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'z7rAfjGPShDKct4AY2LKWT3ZxRxwv2J2yrKCwvVxHxaKkYicPARL6Z1HOCEMM88z', '2023-03-03 12:20:22.951547', '2023-02-01 12:20:22.951547+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jPO9WUpa2AzMMZ0r7wr8QhyJa9bLmgEoHwdBqCBPZuDehhRETQwtaUliwpfXyQvY', '2023-03-03 12:26:28.307558', '2023-02-01 12:26:28.307558+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Nar2ZNiM3TmFcUNTtEGRnbq5yHkZUv6ycxyMFUe3It0MUejgjx0R6UvTfl7XPmKV', '2023-03-03 14:04:41.956851', '2023-02-01 14:04:41.956851+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Cdetw2t27mbg3ZTFH6gvMMyz1hNHiWOczVw6keRrsZ1s8jcFeXLWF0ozonXJXZCH', '2023-03-03 16:11:51.439037', '2023-02-01 16:11:51.439037+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'hnl5c08WI34JGVt01SIWeJN07erDouThQzJwVqiYbTIoGh5fnHAQ2wPCRgLRTJcK', '2023-03-03 16:12:02.994154', '2023-02-01 16:12:02.994154+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jdWTwhcaqGjLKbb63jAKZBQTeNwD8J7AOxgQ5eV65FLCqH2k0hP2SXqUsm2oKZnB', '2023-03-03 16:13:57.516101', '2023-02-01 16:13:57.516101+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'YUHhwdJ4qEJJQqiGK1LkROdmZvj2t5JEhwyHnyIisNVHVtuVitmDsn0OsV0WckFX', '2023-03-03 19:38:52.742963', '2023-02-01 19:38:52.742963+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '0Q8MEIrMHvWSXH6NDraFEWtNuHWBzd0ztpFLTif18HcG8RLHGPY7ftoSMkATbpiZ', '2023-03-04 10:07:21.781784', '2023-02-02 10:07:21.781784+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jHlZGyWYvT7bky8L4FisqYFx6We99tN51Xrce9l0jIFKu6Gm5iKbu2PDsqxfjW7p', '2023-03-04 10:09:20.286015', '2023-02-02 10:09:20.286015+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'y668ONzTAfXqOrTn3kvdOUV3hT5GyzH1albsohvytAjQ34h7PrS5SARaaZDbO4hN', '2023-03-04 10:10:46.440606', '2023-02-02 10:10:46.440606+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'e9qoQ5NwSaC03aSHP1M2kRqyOfkHEGPDdPF7GZZJssX06v9GcHM2YdbgZdZrda0q', '2023-03-04 10:11:23.101233', '2023-02-02 10:11:23.101233+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2DEguab9otIJCkFXjGsAHVdK5m1asZ1UbqZmhJ1DbEWFbvWzREPHgB0VR2MxePcn', '2023-03-04 10:11:48.780355', '2023-02-02 10:11:48.780355+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '465WqyatidUuNAvqdF66MEwdxtTT0qSdLDvlwTBln530aQ92LPrSHGr32wcTSJoq', '2023-03-04 10:16:15.092767', '2023-02-02 10:16:15.092767+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'z1nEDCkA8Kv1NfHDmG1epP8fUCft2pWNRKA1VQIooMm01nSWeCphiGkhy2Wb2tDh', '2023-03-04 14:59:45.639147', '2023-02-02 14:59:45.639147+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'c2caUv0Ef9X81lzFMSSEBiAtJuK2yNi1x2BuEviCojfiNrNJVh2HnCSW4Eu0GWqC', '2023-03-04 15:33:37.72334', '2023-02-02 15:33:37.72334+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'LHIbc6590UHOy6rNoFMAxYO8woSEgEgMEjaDE2FXSajKnkRIrtHfq32zLDiipI8C', '2023-03-04 19:38:34.507047', '2023-02-02 19:38:34.507047+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '5DntwBF9vxSbbs85SUTk50zeRNtiZvpsY7RmkOxssLQfTBDVQCxMInopjOfHGbi7', '2023-03-04 19:39:27.388874', '2023-02-02 19:39:27.388874+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'WsrEu4VUGllVbTm5OsI6Usq9ut7oyXyDTuamdkwe7MQ0Dtu8YrxzobH9TzBvJxus', '2023-03-04 19:55:10.955929', '2023-02-02 19:55:10.955929+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'SuIUWqmcTJWvunHKAciKLoMDinpB4zOcZfTnXzVSh4XQieYZwyvcvgS4rVTf2wk4', '2023-03-04 20:27:58.038128', '2023-02-02 20:27:58.038128+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'fvW4AouDMKvOKo473THTyMrFFHjqLjhsyOwczWXRNUZ7axnM5pu4Qk7yqI2htZ8l', '2023-03-04 20:27:58.828986', '2023-02-02 20:27:58.828986+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '0zSSxQ4FgnqmwElPf5m6zRb4106jl3bdoxoMUvEesZ3fnXxaoHVDEq5SQzCeBiFa', '2023-03-04 20:27:59.73536', '2023-02-02 20:27:59.73536+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'R3KsbXPtMhZZBbsH5bTof7BFA7mrp8AJio63UFwWEFP6QfulZdDnIb5qBEzdDWEI', '2023-03-04 20:28:00.55955', '2023-02-02 20:28:00.55955+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '8Gx7imBJYeQj9KjNjo9SaH9MMxlMujzN9iU6pbd1APyCLI59Ug3l5Y08nu9G8YyC', '2023-03-04 20:28:01.389663', '2023-02-02 20:28:01.389663+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '0CjLyGQdRqjkEpLjPw4vY5i4s583d4HljwcJ8pyZup0heeyLsiQSXlndElKwplZq', '2023-03-04 20:28:02.248871', '2023-02-02 20:28:02.248871+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'wwXbi8VEXFSdRhkJr0KhXwhVjxiPY5QQ8exSTnKG5j1xmdsSY2I5M2Fk85sBs9rw', '2023-03-04 20:28:02.918346', '2023-02-02 20:28:02.918346+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Lfq2zdGxGg1sydD0ga15mi7OatQqTLP5e7r8WAdUI2CoyAWGDo0D8q5XfYvBXf4W', '2023-03-04 20:28:03.583595', '2023-02-02 20:28:03.583595+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '5dWBpbyc3DW81e9xTAviHF6NcAgBkWqIJjRWfDhUaaVKETIpBQqGtnHWKiLsTjH6', '2023-03-04 20:28:04.288569', '2023-02-02 20:28:04.288569+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'tmF11c7FsDMh389Gtfneg9YjAyb71z8QQcBZme9onV8wbZKiR2VvzcAjhJs436p2', '2023-03-04 20:28:05.097398', '2023-02-02 20:28:05.097398+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'DXRA4CDo5m8m3Hib27ULthMaPeYRBuN8KxA6Zd2Aj7DhGRKPErafznRwlDwvUIMd', '2023-03-04 20:29:23.149689', '2023-02-02 20:29:23.149689+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'nDOyIUrYiqAlSx34tOfmbNZvdcuki1UnQw8mDPBXWCyYoU3haHXQQXTLuqSDHRus', '2023-03-04 20:36:17.716018', '2023-02-02 20:36:17.716018+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'lQ9YjKjkhhz1G4WPmHxjnUAetp2KJWJzmbZrZxhJu5bO5HxUeF0y4aQUQnFuZAqO', '2023-03-04 20:36:26.565984', '2023-02-02 20:36:26.565984+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ZF9HBUY541cR848bMwCsWrVd6vlLSqpSa2PDGbzZmpngNvcZn3iLW6kdx74mU6kr', '2023-03-05 20:40:39.633453', '2023-02-03 20:40:39.633453+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'pmdmmyzjX4LvbdRos1KYmQsSqQhKhPRCK4sNnYyKinBcHo5ocIom5CZsZKx4vYVJ', '2023-03-05 20:42:38.954618', '2023-02-03 20:42:38.954618+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'd7CdUurkw06VI0ojpZ1LMXz2GI5BzFwLjNUoR5KwdY7K1lzePKRr7iPfcxzSegJY', '2023-03-05 20:55:10.460308', '2023-02-03 20:55:10.460308+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'VvWtlL6zUoAzvQ09UzR6f63oBkwudKakFlExwjjD3P7IAWQh72OJL0AvhnOXrRLQ', '2023-03-05 22:16:06.88973', '2023-02-03 22:16:06.88973+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'fvoCe7k62j7woPsnxsTJjeCLtBmuHVkDbZxqP4NNSOi0YaqndvOuLvbOizF9BuT8', '2023-03-06 06:09:57.143396', '2023-02-04 06:09:57.143396+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '5xpiE8ci6Umx61ksRpHSe0ucFZJpad9qHoUJ05aLREAcqHFE1u8vKb8cvX1PI5NA', '2023-03-06 06:17:44.417775', '2023-02-04 06:17:44.417775+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'xmwycJdzEJb0fzKavpNktjmY7QrChHZOz2XqXHXUOwj5gqa569wtddBVShmFc9Cd', '2023-03-06 18:47:47.40862', '2023-02-04 18:47:47.40862+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'D5eUfB60o5HirgyXsTUfzPROOf6cUhKcSWn9mnQ4HKnkKFgct9vZO42M0n85xu7O', '2023-03-07 09:33:26.632193', '2023-02-05 09:33:26.632193+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '8zeFq2NS2sdWtcpxi1uNwrySzsSmSImQz4eLR0h4j8DxmUwHVNlRzsc8nICCTYyU', '2023-03-07 10:13:39.986349', '2023-02-05 10:13:39.986349+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Ecu0Hl4XSXaTa8kVRfqdhfF0km5giN3ysJ3TN77C118NYj46SwDKhx1lD6endp0B', '2023-03-08 09:46:05.207835', '2023-02-06 09:46:05.207835+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'hEhu6nX4s0yZbSkJd4PdByGZT1Yyu7wedkUASbTK8AS8Awa0QExcwR5wACBKIQnM', '2023-03-10 09:36:18.927129', '2023-02-08 09:36:18.927129+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '6LkEbUw7YMBpfjJ2zBMtJ2FrRNNw76lbXS8WtDY83cfWoSk3XjLO917Xo5j7223l', '2023-03-10 09:51:59.556501', '2023-02-08 09:51:59.556501+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'vrhK1sfic4Xue8C4pBtev7GFWQygiwMUMsu77WHWBIwhNkD4slyNyOBv5win0Jsb', '2023-03-10 18:01:51.124602', '2023-02-08 18:01:51.124602+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'meUknkMHFtsdEJzMws1LnaZ79prLdcNvLGgftFG2aD6lj7vSvMB4oaqZA6rZqVVJ', '2023-03-10 18:19:55.678436', '2023-02-08 18:19:55.678436+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'PRxWU5fDQQcbCzoQDHKfzJwZtp0RmoEDM1rxliaNyYrl5WcvPshmkagR5nr08opr', '2023-03-10 19:02:05.862966', '2023-02-08 19:02:05.862966+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'da2D92FuJQRvhBtEbY5lwM27QKJV4tiMb0BpRaz5je8XG5nr3delyMHF1ugrAAfy', '2023-03-10 19:10:24.703164', '2023-02-08 19:10:24.703164+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2UZlx10exZAWVimNAs7MuAWmPv2zNkL68CpuOKTWxRk7uzmqMJIdRwBDJYxLZtPe', '2023-03-10 19:18:21.097182', '2023-02-08 19:18:21.097182+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'AXTFQgH371P0jdShC8uUr9r5VvMdUMZyiAZY4Ch2oI63h464BnxZtTUrWVCruKLR', '2023-03-10 19:45:13.894152', '2023-02-08 19:45:13.894152+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'XlTvin0QNI7vz6knsYWl5kYc55G0U6nCxFA6XeggwEHz7i71hUFIES4cs3ncc26M', '2023-03-10 21:34:14.874338', '2023-02-08 21:34:14.874338+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jMCVeMfS2txHpD9LW6PKDNyOt1ZFl2toNzdlOIK1DMNx4yaO0LAtumFLuEqv8C3Y', '2023-03-10 21:39:38.824985', '2023-02-08 21:39:38.824985+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '35AFBug5vhAcC8dwmvY1cEgYtoUUKn1ulRE8nnCBPry64XUUfTqJqX5TzaeN9vY1', '2023-03-10 21:57:46.994826', '2023-02-08 21:57:46.994826+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '9DsLeYQVXugFWq8GosgorZWBGUlkilWXRUDpB9zU2hQy7dYBPP94XXxXEm9xnT7t', '2023-03-10 22:21:49.913697', '2023-02-08 22:21:49.913697+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'GjXdpPOb9kVT0VAEr5i7si3tLnhREIwsKm61knnUKZX47VwdCNVF665rp11DqqG7', '2023-03-10 22:23:56.196991', '2023-02-08 22:23:56.196991+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'axcYwhqXg9i0XOKO4yqkqwrv3jg90Ukq8MKwnvnf0ZddJEnKezOPqw2b3fwvT8NR', '2023-03-10 22:28:54.490993', '2023-02-08 22:28:54.490993+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '7i2xO3ADmWeTOpd6Wyj335vgWHg7mldYsA44bsG6osBHeMXSRFvP6HlQurulcHm0', '2023-03-10 22:33:21.123192', '2023-02-08 22:33:21.123192+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'P8WhLdiZp0Raf4aJB1AlMGFffxszZygrhAsf7RXVwRqG8Tnnr2v7J5F0rba4FybU', '2023-03-10 22:36:52.004861', '2023-02-08 22:36:52.004861+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'TQHeAb713HzbR6ETjACEa3cNJOAHL8ZA42nlgf10beeP4aL6FWVddaSlOMmgSnlV', '2023-03-10 22:57:26.980464', '2023-02-08 22:57:26.980464+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'zPnHn2el2qgUebUnCezK3dcTZQuhw6ZsGZZi4sFWdhDY1QAGtngWdpNNvGm66r7n', '2023-03-10 22:59:27.828367', '2023-02-08 22:59:27.828367+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '60kErTrElBtH44iS7KDP555R403I3mEskmtiyGYqiaStsodmCXCAD0jChOoWP1WO', '2023-03-11 10:44:12.206492', '2023-02-09 10:44:12.206492+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'lAxRItbVHGaloXWxFO5IvbfFwgeR1mbM1DjqkX43xtlDBEtqiKT5PdOsfifxAOYf', '2023-03-11 12:09:51.798135', '2023-02-09 12:09:51.798135+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'hBgCQFgMXXHQz7kOqKVLa4gKj0cntrZGLrMy4EasV20Ki6uebrB6RNm2htoZQNXf', '2023-03-11 15:28:03.716278', '2023-02-09 15:28:03.716278+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'SQtbOX7ueLbUMNULjnWa5Yc3vmH57yL2l87b3fJ0atOef4NREMVV71FlejcJiwc5', '2023-03-11 19:32:15.105181', '2023-02-09 19:32:15.105181+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'dO2sZqhOjIsVRC9fltZKuEwvuVMm9Lp3yIDzd2tGpPKlf8maIdlPJtCJn8RHLguA', '2023-03-12 09:23:46.260482', '2023-02-10 09:23:46.260482+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'U4oZ5jNLB6yWTdus37e2Zx9AbwLbWN8hcDqZiqaW9geqUSGX5hJSnsmVO76G10rA', '2023-03-12 20:02:12.826556', '2023-02-10 20:02:12.826556+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'zh1m5RsaNNg7YlWczPtzhlk0HQRMELBFL5PVYl85QmfmoA6y3Qx2HBYwglEOsNlq', '2023-03-13 08:02:04.280327', '2023-02-11 08:02:04.280327+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'vL7U3HHsFcUGYCqlFeZefQOlipVff17wxUu1X0CJ3ZSAH4tg8YXNLx89bhnIBhsO', '2023-03-13 15:56:51.321492', '2023-02-11 15:56:51.321492+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'xbHoIpiOjOmZJqmiq7yJzLzUk6GMN5RVy5msTU9ubLAyUuYzQYXbzu2yNzCX4NZN', '2023-03-13 18:46:52.187493', '2023-02-11 18:46:52.187493+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'JdKJKIth74qpE0F12wdevNIdkptshQ8jIBqdvvgzzIjCTEjBdTupRs9XIAKDgC0T', '2023-03-13 18:48:42.699888', '2023-02-11 18:48:42.699888+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '9WcEtbe3f8ckManXtx1rd44g764A0pK3Vp0q3y4xUU08UnDIpu9OPPff6zHRnWvW', '2023-03-14 10:09:08.944785', '2023-02-12 10:09:08.944785+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'a7fcgISgno0VQwGPxEVSfvD6SwpMnDSHbOhdPzThOlLoJ5CAwBl9hbCv78Ts2sfE', '2023-03-14 10:32:22.60076', '2023-02-12 10:32:22.60076+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'WUFc3pFe4mNrCwVzxsNj6i071MtyrXt4rBJQTvNEjz28STzYSKmRZdHWNraDFQkD', '2023-03-14 21:21:51.481676', '2023-02-12 21:21:51.481676+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'nLeaUEqlID2qCU4vkkLqIF1AlUi6Gk2KJrGroRsrWpTyvcgYKUxQzQhq4o4aKguh', '2023-03-15 09:07:38.932544', '2023-02-13 09:07:38.932544+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'dPzUHE0hcdbHeproZtEptgdBruzJEt0ArfUIH7888D1yCdOlvQe3RZbexb2UimQp', '2023-03-15 09:32:35.984349', '2023-02-13 09:32:35.984349+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'kK9QkibClpHBz7psCCi0oxFYwY6yi5rxPwL0R89W8ez6WemXcTbxmjsUYoquOkYc', '2023-03-15 13:18:55.527399', '2023-02-13 13:18:55.527399+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'V9o48a6wAXzFjSfxePBsy1mQKp1YGwDGhByMA2YIfMwGn0Xdb0NaWkuBZTgnrSUp', '2023-03-15 13:49:28.700314', '2023-02-13 13:49:28.700314+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ZdJNPfP22KwEj2aM6DEZXAMx7oNtTIGbxvZ0kE2kNpoYMpEGSRaRX9pll1kC3DJi', '2023-03-15 14:15:12.454121', '2023-02-13 14:15:12.454121+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2rQVwBOoDLG9kAU1eGNuepOadjasdFISxRUDlTQsRhm7pToF0MZfgtlJ3GAK3RDu', '2023-03-15 14:19:53.323028', '2023-02-13 14:19:53.323028+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'x1fuwQmr3pOYhKgIyl8p8pUDVnECE5muFUjQqhAQ2Fd4ylTg17thI6fNY57SUcnH', '2023-03-15 16:01:46.185778', '2023-02-13 16:01:46.185778+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'zudfgvvA1h91nN1zgVY4dDzfKgXbu2urzwQAyI8DheCY23ZP7j7bUM6F3DFZxkbm', '2023-03-15 16:11:20.232089', '2023-02-13 16:11:20.232089+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '6olbe6isuxroPKmXm4wgWiVQqrYjXSpjT27s8bfrJULQypVsrmXhdaDtKMKbmdCk', '2023-03-15 16:17:37.505278', '2023-02-13 16:17:37.505278+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'yyw8cXAGdyDIhPF5gYmqmVHw1JmZEEy5dLUwy5CaN6wZlXylhpa8WNpg7ChhLN5Y', '2023-03-15 16:22:08.886399', '2023-02-13 16:22:08.886399+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'S2k3kD5HXlvCppjNIAuudQlGNgv6ZBjiZDoaWgn5f2NOppk4xwf2LVTmpdSO1ILu', '2023-03-15 16:26:03.853616', '2023-02-13 16:26:03.853616+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '4tiFKnVf7rx16zQyq6sfy6uz2oEHGfTBKAV78ic4i4Mtkb6LCuKvhHCffKWDUbmm', '2023-03-15 16:28:47.182501', '2023-02-13 16:28:47.182501+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'f3YfNOZQI99ER7c6yNEwnOpHP1VTd0bgZGknpBDTrWNN93CtJqcF85PgvSUuowPL', '2023-03-15 16:32:43.654318', '2023-02-13 16:32:43.654318+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'tZ7SQ635OKuTG6RSMhd2JnHhuAlpwMXxnG0Zjgd4tTHjsOEJpDDymcKmewuvpqiu', '2023-03-15 16:34:58.07172', '2023-02-13 16:34:58.07172+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'oRRvjF8NiXPxc4c5UXdNrFJTl5e1fgJrnk2Wofrj5LWemiW9IqAhKBivdgEeGnEF', '2023-03-15 16:36:15.250914', '2023-02-13 16:36:15.250914+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'SmgcQBmJkAreoTfetsg9QeO55n1BpNJt0qLK7NoGgICBwx324mIqVw3lCQ81FEdP', '2023-03-15 20:23:25.651055', '2023-02-13 20:23:25.651055+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'PRgQdRilmrrBERY0JPlZxr1AvjKf3Yb058omoC5NElca5zg47L32o67U6r1oApgz', '2023-03-15 20:24:51.414258', '2023-02-13 20:24:51.414258+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'uCAv3tuXOI5VB8chADbQVSz1aPHaADd0FRgpFEmGmcGQGHgbn84ttsZar90gs4DL', '2023-03-15 20:29:16.213174', '2023-02-13 20:29:16.213174+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'voTpa4DecZLqiEMpsmm1qbfmKdcudzXgSmcDJDTU467Ud5AK9PfelU6OWzVjs76h', '2023-03-16 06:07:08.29263', '2023-02-14 06:07:08.29263+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'y7eUDkELlnfsgir77cSCcrR8jiBnnsm331fk4dbSa0EU7EclJE29K6VGjuI631cZ', '2023-03-16 08:32:12.950573', '2023-02-14 08:32:12.950573+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'oZ3gUZo2RRBsdYPZYcjWxAoJnFZz2R1g35iBLwJLptr8xNu3ZmR4wobBUlFa2vt6', '2023-03-16 08:52:44.447144', '2023-02-14 08:52:44.447144+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Fnn2YV4WLSPJnba464Rus7lJrPCGM9OZ5rivN46saRpQmbnvkWasmGWvdqbZiqjM', '2023-03-16 08:54:07.717972', '2023-02-14 08:54:07.717972+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 's3fli1N1sK0gT2PXHGitMtJ5H0PopY9ZFPMu10UTcLKiox0rSJ3vUHDcDbHYU1tv', '2023-03-16 09:02:44.774738', '2023-02-14 09:02:44.774738+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'aZmKFaJ4sFVW2CINHfvoof6wgKss4qlQu1qr2r5BvYhJxwrGrQ326eaYqV4FheUO', '2023-03-16 09:27:04.687212', '2023-02-14 09:27:04.687212+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'PvopdCtiVxhFRKqAa2hkXxXgrElvWjV2T6X0DIBP1HGkrEJODijaxCDZQ4owuEFX', '2023-03-16 09:28:08.942569', '2023-02-14 09:28:08.942569+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'koBKYvuk3sLyumOt2jndJfp5N919vjmgeyk9bX0PTvQnsQKndPM6Lf9VUBwEd30f', '2023-03-16 10:19:20.895057', '2023-02-14 10:19:20.895057+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '6p3OZLOBOC5gwjeXQjRTMUCLMRfdPea1utiSnfak77dl62PPTuJFrtGBwSohwCYT', '2023-03-16 10:31:07.394182', '2023-02-14 10:31:07.394182+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 't6EhXcLP885o1z0JBv4crYTDtm2r1bca02nsQPf1URmef7OfHgkzAOJDNcL4RmzA', '2023-03-16 10:34:36.380451', '2023-02-14 10:34:36.380451+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'uaUxfthTx5AXZ7U8kRmyLEV0xCTKwNlVnP4zcGvCrZlNSCPM1LLII5bWljUiLQ0o', '2023-03-16 15:05:58.773473', '2023-02-14 15:05:58.773473+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'OcV7FvDA9KzSjixV3vu6TpUg7lRUB2wjeLdNzytlBtlx4RkA9xKkFOU35a7Ntl8W', '2023-03-16 15:22:16.493916', '2023-02-14 15:22:16.493916+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '8BnaQaDkAOESIDkXfpJWxC4pbLfleLDV7MWM77VP3fdwuCaubK9GagGl349JwUzS', '2023-03-17 06:02:14.865657', '2023-02-15 06:02:14.865657+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'E7aEANfpHNKjoWv1qloZwiJfWL5dObtfvOxC7XBb8mJurBBvbFAYDLW35MepUOUl', '2023-03-17 12:38:50.236511', '2023-02-15 12:38:50.236511+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'FyiQI1B1HD6GS7OSpLw4RmwVBFyJqBB9nBlzdpk5A9IsAi3FRosbzil5NLXG9aqg', '2023-03-17 13:38:59.201484', '2023-02-15 13:38:59.201484+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'fQNO0u9QWJkTAieXxoCTlla2sdK1QJSP8Mo0KDKkbfCjBlb06KCKIktlgvsvuJzK', '2023-03-17 14:03:41.678036', '2023-02-15 14:03:41.678036+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'RIyVq3zgqWSXQwhvwbdzWL3bwlxTmW0AiUCMwLuQApATWSA4gVytIFpjjnDrIiQO', '2023-03-17 16:09:07.512021', '2023-02-15 16:09:07.512021+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '1Nh3C4l5TsLj2V1Qr5jUq4QAeyyeghkYQtsfRhAnxf1Vp0oTxe6p7m61XACcHW9H', '2023-03-17 16:10:02.980336', '2023-02-15 16:10:02.980336+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '5EfZyn5h88K9fNBtb1LYaottjvAsLUaxeUKZJX4E5tHzyqmO0DokRYPPpD2ckbzT', '2023-03-17 16:11:52.101821', '2023-02-15 16:11:52.101821+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'y3q6oUs2idwvnXvnr7tEWSIdhqhwh8bRHdt3uzjm7HZblift72cpIiKVK2HSW8Nh', '2023-03-17 16:24:53.01717', '2023-02-15 16:24:53.01717+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'vhVTCbOHqSmdHFK7QHu4dNIMZjj6RpJVCSJTqZQcu8yDchKUyVFqYzgDbCAp7wJV', '2023-03-17 17:58:54.998453', '2023-02-15 17:58:54.998453+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'MmFB8PoBcqVXFNvDY5uCVVmxN9t4ML480QNcM21y8hsAi5caqMEpT58pbdS6JnXp', '2023-03-17 18:50:29.500864', '2023-02-15 18:50:29.500864+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'JeEwUX9FcwoRU6grnKQBA2rdkl7j6VslbkgF0Oaf8TYD11kIfcWvyeU9AEJTLgJg', '2023-03-17 18:57:11.714148', '2023-02-15 18:57:11.714148+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'M72K5DCcSVr30nNxfSvVBR6KwGX5kNZaSnbrKO2LaKrbWkiqq3S6MiEYsCro6AHe', '2023-03-17 20:48:32.593477', '2023-02-15 20:48:32.593477+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3Hb0MKSAmVsYhychMP1Cdax8w0LwNZy0hmKc9Cp4cdKUaR5vhWlZoPbkY4m9YLWS', '2023-03-17 21:19:25.552894', '2023-02-15 21:19:25.552894+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'F09dnOMAqZsByK2QqQD8DkDSnAGqJSRUnKAnQoq2AyHOhgoZVu37lAEfVvQVI9Ld', '2023-03-18 10:37:31.675327', '2023-02-16 10:37:31.675327+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'b1IEcFTbrrWhBHaFKfmvq2XH2XyPndRSqiuhoFz8Wf42UihIbskziYnF3WGIqIHz', '2023-03-18 12:33:24.147868', '2023-02-16 12:33:24.147868+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 't5psTAecKlm0cKELxPfK0LJtBJaOKhOYlCZIupYGbJJEhJzNgDO1OY26BpfRBrV5', '2023-03-18 15:58:39.540387', '2023-02-16 15:58:39.540387+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'xLpCwADbAWIYNUeUajXkBs7szJQ1IvJA1u8dAq0eCpamdljMaf1gGF3oOm8k6fsJ', '2023-03-18 20:53:12.829073', '2023-02-16 20:53:12.829073+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'jgcH8rBmXNVRjDTWO0xgubw95EKSUhIEcvUEh0aSJzaeuzjV9LiLX3rb4n2SRNtL', '2023-03-19 11:33:53.069954', '2023-02-17 11:33:53.069954+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'aPnp2iWAe5qNVNB1ds0MdgAGqZLW54jCVfkVUj2YyEFT889zj2KPVtBUK8jHrPcz', '2023-03-19 19:46:10.540925', '2023-02-17 19:46:10.540925+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'hsjUhK6LGYp3CQISnQsIydxnouEdJdx4cUQ4sMRY7CuRhvB4W73QFSjsySYcn9do', '2023-03-20 07:30:57.108201', '2023-02-18 07:30:57.108201+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3k69IEDSM8sss7s5pATWN1nTagNdVfVmTPqkSJGedRi3xIiMXSl3uS2nodRwEfqp', '2023-03-20 22:04:54.098655', '2023-02-18 22:04:54.098655+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'mTDQEeobpWJBGKOsIaOSbZomieQwjrcldPAka82UjIWH3ORNR3g6DSyXxSj2ul9V', '2023-03-21 09:25:38.861994', '2023-02-19 09:25:38.861994+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '9lbpcoTLPw7Lul8nAbMQuAOdVXSeF2ULK8C2NIf1q3YjcPuZLczifa5du8w2vaOz', '2023-03-21 20:20:13.839361', '2023-02-19 20:20:13.839361+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '9yYAxtyUmlXh9e5H6nBQi4NpDymyek5jR9RQdws2nFA2ZT6MQUDFNQwiepiyDqfX', '2023-03-22 06:14:01.093441', '2023-02-20 06:14:01.093441+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'zAdcovD2agzXwKhEp9g78zrSXNUdX4X6MhJxEHYxKVp5UPxXXteCSvjftk1DiDYt', '2023-03-22 09:18:49.469613', '2023-02-20 09:18:49.469613+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'LvZfXDMLxHuHJBEHVtkZhjgWI4pWI2ncoySnpxyL1IxJIbFbjwenfPZ5L9e622z1', '2023-03-22 13:10:30.765887', '2023-02-20 13:10:30.765887+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '7sqUg51ArdSTPHPzkf5SxNqZAgOeLmDke4la91UL87rGAfRmN6JK9aNEKldEHxi0', '2023-03-22 13:21:40.437709', '2023-02-20 13:21:40.437709+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'nWPc3oCZd4WtH2WJXG0HfJaKfJ5sJmzSeRoAfVhwSF46Z2PJtgKpTGHRRe5dypnw', '2023-03-22 14:41:14.905108', '2023-02-20 14:41:14.905108+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'UCkKQECLtBiuzAnu1QzyOOAAVnOkscCIEiZaz5kArBvB0NPfy0kKiyY0bW2TP3tj', '2023-03-22 15:01:04.062711', '2023-02-20 15:01:04.062711+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'QD8ftZLc45veUaf4F9JnTfNobyoBv04sR7G5sDBzFO7y72LKpvjqjTmqKiOoLOXX', '2023-03-22 15:14:13.614324', '2023-02-20 15:14:13.614324+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'O6zcSGBA6LFvz96x2UQkozUaMiLXWgaSI5X5RLFutLT9iaxaVkKzCgugQ9JElOGI', '2023-03-22 15:17:19.498203', '2023-02-20 15:17:19.498203+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'TwSA4Fkb1cWfK9yV5m9ez6iBze3uuJqMIVsEyCD53PYExYdu6c20W3180HqAkyRo', '2023-03-22 15:39:23.566887', '2023-02-20 15:39:23.566887+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'oTJ3y45SCfLtnFreaLhpISY9QUZXah55e96zCcM0Zt2EHfvPE35mE5et05FmDNul', '2023-03-22 16:13:27.515147', '2023-02-20 16:13:27.515147+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Mux8Pg8tjNFSFQ94HOLpXWCw1VkxiEv7Imcy2Uo53tPyefpxIykkrcl97xfs2eUP', '2023-03-22 16:21:18.958616', '2023-02-20 16:21:18.958616+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'bjzUFjR15kUNXxrCINGnDussYslmFbQhWsyQYBaBZafFfHyi25I7O72El6N0chzq', '2023-03-22 18:18:04.420081', '2023-02-20 18:18:04.420081+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'WGK6GQ2tF2ZLg5h0vveWx3ZdzZ7D7CWI5kkKIE2WY89KZnC2jAWCrRs4EipnXdk5', '2023-03-22 19:38:30.718145', '2023-02-20 19:38:30.718145+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '3KZP3mQir0RpCHra3BhB0TqUygC7GkXQ6Qkf2KJlWbttXRNRwpa0kpTfYR3FKacn', '2023-03-23 05:53:28.00465', '2023-02-21 05:53:28.00465+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'lmZAEkm2l0Moikf7iInsIrndEwfp4eRfZYbMuI0XihTatXLh3IXFIlZgreBZlDfm', '2023-03-23 08:59:58.655939', '2023-02-21 08:59:58.655939+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'KQjR2o3K2e45wAU4s16mpmRakkttJ3RCYC56yCx4SrVoYkS2rQqYnkKWKG75AB47', '2023-03-23 13:35:49.464142', '2023-02-21 13:35:49.464142+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2xdjCCCvFTWmSr4YeA4PuOrFhV3ogwfVQyPSxQZD04MwcS1Jklu750m5deRRUr9j', '2023-03-23 14:44:01.470038', '2023-02-21 14:44:01.470038+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Rhx6P9dVqks7Vu5IOOwagIuPJIGyOFySacVUCjTMWjFNGrqGSZJ7S9Bt8S5Ui8In', '2023-03-23 14:59:03.095983', '2023-02-21 14:59:03.095983+07', 'MAHASARAKHAM', '11053');
INSERT INTO users.tokens VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'pag6wbH5dddfGy4XHkKPmzf8Ap2sUSGzgasGK5dxVKSiF1TrFKDHebggBQNXo271', '2023-03-23 15:47:14.185883', '2023-02-21 15:47:14.185883+07', 'MAHASARAKHAM', '11053');


--
-- TOC entry 3968 (class 0 OID 115189)
-- Dependencies: 294
-- Data for Name: user_platforms; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.user_platforms VALUES ('3f4530c8-c1b6-4078-b75a-3878cb03d63d', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ข้อมูลมาตรฐาน เขตสุขภาพที่ 7', '0000000000000', '2023-02-15 19:00:02.42291', '2023-02-15 19:30:33.842859', '137e6fe0-cc02-4594-9491-c2d023df5456');
INSERT INTO users.user_platforms VALUES ('9656188b-812c-49b4-b3c1-3c2e9129dfc8', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'ข้อมูลส่งต่อ (Refer) เขตสุขภาพที่ 7', '1212111111111', '2023-02-15 21:19:39.102943', NULL, '137e6fe0-cc02-4594-9491-c2d023df5456');


--
-- TOC entry 3895 (class 0 OID 41088)
-- Dependencies: 221
-- Data for Name: users; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.users VALUES ('901d56f9-c64e-466e-a67f-910089339c61', 'xxxxx', 'xxxxxx', '11111', 'xxxxxxxxxxx', '$2b$10$bSUMf5dzObpptEfGnfjNlOCoOwkoeh2.XGBfGuMgBrPIMGGVpBHJG', false, false, NULL, '2023-01-11 04:05:06');
INSERT INTO users.users VALUES ('fef71b90-94e8-40c3-8f91-97a46361989e', 'xxxxxxxx', 'xxxxx', '11053', 'xxxxxx', '$2b$10$ySiUldLkg0y1jB2QYgFNxOprLAEDuaP8oHT03cbl1y4OK3PI2yfXm', false, false, 'test@test.com', NULL);
INSERT INTO users.users VALUES ('a5626ec2-b630-4da5-b6aa-8ccba2b892c7', 'กกกก', 'กกกกก', '10707', 'rtretertret', '$2b$10$NOLTCf5lKGD.49iN.ztDCOvS5H6GGFOl1hWAUBcQ8BIEj1TrGK2/m', false, false, 'rianpit@gmail.com', NULL);
INSERT INTO users.users VALUES ('6d084780-b006-4273-82ac-8f7aa47319d5', 'fsdfdsf', 'sfdsfdsfs', '11111', '22222', '$2b$10$eQjkxkpA7VizvgqCnCqrIOZOSrAes31ugl6V6KGivTbUoogLy457a', true, false, 'test@testssss.com', NULL);
INSERT INTO users.users VALUES ('96ca0da3-8977-4794-ac42-935fb8879b4c', 'xxxxxxxx', 'xxxxx', '10707', '1111111', '$2b$10$027Z98RqAA5xRPM0Cx2nzOsDl3dq1UOpADAOXODlrcHAi8U8ct6K.', true, true, 'test@test.com', '1999-01-08 04:05:06');
INSERT INTO users.users VALUES ('1fe87a3b-5594-4faa-9570-801015116f92', '33333', '33333', '11053', '333333', '$2b$10$mv/9xRkSLIyEqPN9pgWvAuk.yMTSEtfZushfdKc5oX32ZaWUe9OD6', true, false, '3333@ddd.com', NULL);
INSERT INTO users.users VALUES ('c2c58946-2345-4fbd-8f3f-2875deb93c7f', 'Satit', 'Rianpit', '11053', '11053', '$2b$10$ekq/ga2SsnB0mZQGavSVsubJe3/Hsbp.ZJiUPUsATPWTDkekrI.Wi', true, false, 'rianpit@gmail.com', '2023-01-18 04:05:06');


--
-- TOC entry 3898 (class 0 OID 49279)
-- Dependencies: 224
-- Data for Name: zones; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.zones VALUES ('4000', 'ขอนแก่น', 'KHONKAEN', true);
INSERT INTO users.zones VALUES ('4400', 'มหาสารคาม', 'MAHASARAKHAM', true);
INSERT INTO users.zones VALUES ('4500', 'ร้อยเอ็ด', 'ROIET', true);
INSERT INTO users.zones VALUES ('4600', 'กาฬสินธุ์', 'KALASIN', true);


--
-- TOC entry 3547 (class 2606 OID 74000)
-- Name: clinic_mappings clinic_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.clinic_mappings
    ADD CONSTRAINT clinic_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3567 (class 2606 OID 82074)
-- Name: lab_mappings clinic_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.lab_mappings
    ADD CONSTRAINT clinic_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3545 (class 2606 OID 73992)
-- Name: clinics clinics_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.clinics
    ADD CONSTRAINT clinics_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3541 (class 2606 OID 73964)
-- Name: drug_mappings drug_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drug_mappings
    ADD CONSTRAINT drug_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3549 (class 2606 OID 74007)
-- Name: drug_usages drug_usages_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drug_usages
    ADD CONSTRAINT drug_usages_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3537 (class 2606 OID 82051)
-- Name: drugs drugs_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drugs
    ADD CONSTRAINT drugs_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3543 (class 2606 OID 73985)
-- Name: insurance_mappings insurance_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.insurance_mappings
    ADD CONSTRAINT insurance_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3539 (class 2606 OID 73976)
-- Name: insurances insurances_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.insurances
    ADD CONSTRAINT insurances_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3553 (class 2606 OID 74034)
-- Name: lab_groups lab_groups_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.lab_groups
    ADD CONSTRAINT lab_groups_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3551 (class 2606 OID 82057)
-- Name: labs lab_items_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.labs
    ADD CONSTRAINT lab_items_pk_1 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3561 (class 2606 OID 74058)
-- Name: nation_mappings nation_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.nation_mappings
    ADD CONSTRAINT nation_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3559 (class 2606 OID 74053)
-- Name: nations nations_pk_3; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.nations
    ADD CONSTRAINT nations_pk_3 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3557 (class 2606 OID 74046)
-- Name: occupation_mappings occupation_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.occupation_mappings
    ADD CONSTRAINT occupation_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3555 (class 2606 OID 74041)
-- Name: occupations occupations_pk_2; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.occupations
    ADD CONSTRAINT occupations_pk_2 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3563 (class 2606 OID 74063)
-- Name: providers providers_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.providers
    ADD CONSTRAINT providers_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3565 (class 2606 OID 74070)
-- Name: wards wards_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.wards
    ADD CONSTRAINT wards_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3741 (class 2606 OID 107189)
-- Name: transactions transactions_pk; Type: CONSTRAINT; Schema: logs; Owner: -
--

ALTER TABLE ONLY logs.transactions
    ADD CONSTRAINT transactions_pk PRIMARY KEY (trx_id);


--
-- TOC entry 3745 (class 2606 OID 107186)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY metadata.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an, ingress_zone);


--
-- TOC entry 3736 (class 2606 OID 107180)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY metadata.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, seq, date_serv, ingress_zone);


--
-- TOC entry 3734 (class 2606 OID 107175)
-- Name: person person_pk; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY metadata.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn, ingress_zone);


--
-- TOC entry 3570 (class 2606 OID 98467)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3575 (class 2606 OID 98469)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3577 (class 2606 OID 98471)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3581 (class 2606 OID 98473)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3585 (class 2606 OID 98475)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3588 (class 2606 OID 98477)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3591 (class 2606 OID 98479)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3593 (class 2606 OID 98481)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3595 (class 2606 OID 98812)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3597 (class 2606 OID 98485)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3599 (class 2606 OID 98487)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3606 (class 2606 OID 98489)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3693 (class 2606 OID 98720)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3698 (class 2606 OID 98722)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3700 (class 2606 OID 98724)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3704 (class 2606 OID 98726)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3708 (class 2606 OID 98728)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3711 (class 2606 OID 98730)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3714 (class 2606 OID 98732)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3716 (class 2606 OID 98734)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3718 (class 2606 OID 98810)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3720 (class 2606 OID 98738)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3722 (class 2606 OID 98740)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3729 (class 2606 OID 98742)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3611 (class 2606 OID 98549)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3616 (class 2606 OID 98551)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3618 (class 2606 OID 98553)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3622 (class 2606 OID 98555)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3626 (class 2606 OID 98557)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3629 (class 2606 OID 98559)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3632 (class 2606 OID 98561)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3634 (class 2606 OID 98563)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3636 (class 2606 OID 98808)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3638 (class 2606 OID 98567)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3640 (class 2606 OID 98569)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3647 (class 2606 OID 98571)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3652 (class 2606 OID 98634)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3657 (class 2606 OID 98636)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3659 (class 2606 OID 98638)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3663 (class 2606 OID 98640)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3667 (class 2606 OID 98642)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3670 (class 2606 OID 98644)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3673 (class 2606 OID 98646)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3675 (class 2606 OID 98648)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3677 (class 2606 OID 98806)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3679 (class 2606 OID 98652)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3681 (class 2606 OID 98654)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3688 (class 2606 OID 98656)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3529 (class 2606 OID 41114)
-- Name: admin admin_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.admin
    ADD CONSTRAINT admin_pk PRIMARY KEY (username);


--
-- TOC entry 3523 (class 2606 OID 107069)
-- Name: hospitals hospitals_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.hospitals
    ADD CONSTRAINT hospitals_pk PRIMARY KEY (hospcode);


--
-- TOC entry 3750 (class 2606 OID 115212)
-- Name: platforms platforms_main_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.platforms
    ADD CONSTRAINT platforms_main_pk PRIMARY KEY (id);


--
-- TOC entry 3535 (class 2606 OID 65662)
-- Name: tokens tokens_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.tokens
    ADD CONSTRAINT tokens_pk PRIMARY KEY (user_id, refresh_token);


--
-- TOC entry 3748 (class 2606 OID 115216)
-- Name: user_platforms user_platforms_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.user_platforms
    ADD CONSTRAINT user_platforms_pk PRIMARY KEY (user_id, name, platform_id);


--
-- TOC entry 3520 (class 2606 OID 107117)
-- Name: users users_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_pk PRIMARY KEY (username);


--
-- TOC entry 3532 (class 2606 OID 49339)
-- Name: zones zones_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.zones
    ADD CONSTRAINT zones_pk PRIMARY KEY (code);


--
-- TOC entry 3737 (class 1259 OID 107173)
-- Name: transactions_file_name_idx; Type: INDEX; Schema: logs; Owner: -
--

CREATE INDEX transactions_file_name_idx ON logs.transactions USING btree (file_name);


--
-- TOC entry 3738 (class 1259 OID 107169)
-- Name: transactions_hospcode_idx; Type: INDEX; Schema: logs; Owner: -
--

CREATE INDEX transactions_hospcode_idx ON logs.transactions USING btree (hospcode);


--
-- TOC entry 3739 (class 1259 OID 107172)
-- Name: transactions_ingress_zone_idx; Type: INDEX; Schema: logs; Owner: -
--

CREATE INDEX transactions_ingress_zone_idx ON logs.transactions USING btree (ingress_zone);


--
-- TOC entry 3742 (class 1259 OID 107187)
-- Name: transactions_status_idx; Type: INDEX; Schema: logs; Owner: -
--

CREATE INDEX transactions_status_idx ON logs.transactions USING btree (status);


--
-- TOC entry 3743 (class 1259 OID 107170)
-- Name: transactions_user_id_idx; Type: INDEX; Schema: logs; Owner: -
--

CREATE INDEX transactions_user_id_idx ON logs.transactions USING btree (user_id);


--
-- TOC entry 3732 (class 1259 OID 107176)
-- Name: person_cid_idx; Type: INDEX; Schema: metadata; Owner: -
--

CREATE INDEX person_cid_idx ON metadata.person USING btree (cid);


--
-- TOC entry 3568 (class 1259 OID 98490)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_kk.appoint USING btree (an);


--
-- TOC entry 3571 (class 1259 OID 98491)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_kk.appoint USING btree (seq);


--
-- TOC entry 3572 (class 1259 OID 98492)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_kk.chronic USING btree (hosp_dx);


--
-- TOC entry 3573 (class 1259 OID 98493)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_kk.chronic USING btree (hosp_rx);


--
-- TOC entry 3578 (class 1259 OID 98494)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_kk.drugallergy USING btree (informant);


--
-- TOC entry 3579 (class 1259 OID 98495)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_kk.drugallergy USING btree (informhosp);


--
-- TOC entry 3582 (class 1259 OID 98496)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_kk.drugallergy USING btree (symptom);


--
-- TOC entry 3583 (class 1259 OID 98497)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_kk.ipd USING btree (dateadm);


--
-- TOC entry 3586 (class 1259 OID 98498)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_kk.ipdx USING btree (dxtype);


--
-- TOC entry 3589 (class 1259 OID 98499)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_kk.ipop USING btree (optype);


--
-- TOC entry 3600 (class 1259 OID 98500)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_kk.person USING btree (amphur);


--
-- TOC entry 3601 (class 1259 OID 98501)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_kk.person USING btree (changwat);


--
-- TOC entry 3602 (class 1259 OID 98502)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_kk.person USING btree (cid);


--
-- TOC entry 3603 (class 1259 OID 98503)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_kk.person USING btree (nation);


--
-- TOC entry 3604 (class 1259 OID 98504)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_kk.person USING btree (occupation);


--
-- TOC entry 3607 (class 1259 OID 98505)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_kk.person USING btree (tambol);


--
-- TOC entry 3608 (class 1259 OID 98506)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_kk.person USING btree (typearea);


--
-- TOC entry 3691 (class 1259 OID 98743)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_kls.appoint USING btree (an);


--
-- TOC entry 3694 (class 1259 OID 98744)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_kls.appoint USING btree (seq);


--
-- TOC entry 3695 (class 1259 OID 98745)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_kls.chronic USING btree (hosp_dx);


--
-- TOC entry 3696 (class 1259 OID 98746)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_kls.chronic USING btree (hosp_rx);


--
-- TOC entry 3701 (class 1259 OID 98747)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_kls.drugallergy USING btree (informant);


--
-- TOC entry 3702 (class 1259 OID 98748)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_kls.drugallergy USING btree (informhosp);


--
-- TOC entry 3705 (class 1259 OID 98749)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_kls.drugallergy USING btree (symptom);


--
-- TOC entry 3706 (class 1259 OID 98750)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_kls.ipd USING btree (dateadm);


--
-- TOC entry 3709 (class 1259 OID 98751)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_kls.ipdx USING btree (dxtype);


--
-- TOC entry 3712 (class 1259 OID 98752)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_kls.ipop USING btree (optype);


--
-- TOC entry 3723 (class 1259 OID 98753)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_kls.person USING btree (amphur);


--
-- TOC entry 3724 (class 1259 OID 98754)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_kls.person USING btree (changwat);


--
-- TOC entry 3725 (class 1259 OID 98755)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_kls.person USING btree (cid);


--
-- TOC entry 3726 (class 1259 OID 98756)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_kls.person USING btree (nation);


--
-- TOC entry 3727 (class 1259 OID 98757)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_kls.person USING btree (occupation);


--
-- TOC entry 3730 (class 1259 OID 98758)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_kls.person USING btree (tambol);


--
-- TOC entry 3731 (class 1259 OID 98759)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_kls.person USING btree (typearea);


--
-- TOC entry 3609 (class 1259 OID 98572)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_msk.appoint USING btree (an);


--
-- TOC entry 3612 (class 1259 OID 98573)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_msk.appoint USING btree (seq);


--
-- TOC entry 3613 (class 1259 OID 98574)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_msk.chronic USING btree (hosp_dx);


--
-- TOC entry 3614 (class 1259 OID 98575)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_msk.chronic USING btree (hosp_rx);


--
-- TOC entry 3619 (class 1259 OID 98576)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_msk.drugallergy USING btree (informant);


--
-- TOC entry 3620 (class 1259 OID 98577)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_msk.drugallergy USING btree (informhosp);


--
-- TOC entry 3623 (class 1259 OID 98578)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_msk.drugallergy USING btree (symptom);


--
-- TOC entry 3624 (class 1259 OID 98579)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_msk.ipd USING btree (dateadm);


--
-- TOC entry 3627 (class 1259 OID 98580)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_msk.ipdx USING btree (dxtype);


--
-- TOC entry 3630 (class 1259 OID 98581)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_msk.ipop USING btree (optype);


--
-- TOC entry 3641 (class 1259 OID 98582)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_msk.person USING btree (amphur);


--
-- TOC entry 3642 (class 1259 OID 98583)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_msk.person USING btree (changwat);


--
-- TOC entry 3643 (class 1259 OID 98584)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_msk.person USING btree (cid);


--
-- TOC entry 3644 (class 1259 OID 98585)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_msk.person USING btree (nation);


--
-- TOC entry 3645 (class 1259 OID 98586)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_msk.person USING btree (occupation);


--
-- TOC entry 3648 (class 1259 OID 98587)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_msk.person USING btree (tambol);


--
-- TOC entry 3649 (class 1259 OID 98588)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_msk.person USING btree (typearea);


--
-- TOC entry 3650 (class 1259 OID 98657)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_roiet.appoint USING btree (an);


--
-- TOC entry 3653 (class 1259 OID 98658)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_roiet.appoint USING btree (seq);


--
-- TOC entry 3654 (class 1259 OID 98659)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_roiet.chronic USING btree (hosp_dx);


--
-- TOC entry 3655 (class 1259 OID 98660)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_roiet.chronic USING btree (hosp_rx);


--
-- TOC entry 3660 (class 1259 OID 98661)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_roiet.drugallergy USING btree (informant);


--
-- TOC entry 3661 (class 1259 OID 98662)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_roiet.drugallergy USING btree (informhosp);


--
-- TOC entry 3664 (class 1259 OID 98663)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_roiet.drugallergy USING btree (symptom);


--
-- TOC entry 3665 (class 1259 OID 98664)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_roiet.ipd USING btree (dateadm);


--
-- TOC entry 3668 (class 1259 OID 98665)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_roiet.ipdx USING btree (dxtype);


--
-- TOC entry 3671 (class 1259 OID 98666)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_roiet.ipop USING btree (optype);


--
-- TOC entry 3682 (class 1259 OID 98667)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_roiet.person USING btree (amphur);


--
-- TOC entry 3683 (class 1259 OID 98668)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_roiet.person USING btree (changwat);


--
-- TOC entry 3684 (class 1259 OID 98669)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_roiet.person USING btree (cid);


--
-- TOC entry 3685 (class 1259 OID 98670)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_roiet.person USING btree (nation);


--
-- TOC entry 3686 (class 1259 OID 98671)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_roiet.person USING btree (occupation);


--
-- TOC entry 3689 (class 1259 OID 98672)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_roiet.person USING btree (tambol);


--
-- TOC entry 3690 (class 1259 OID 98673)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_roiet.person USING btree (typearea);


--
-- TOC entry 3525 (class 1259 OID 41117)
-- Name: admin_enabled_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX admin_enabled_idx ON users.admin USING btree (enabled);


--
-- TOC entry 3526 (class 1259 OID 41115)
-- Name: admin_id_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE UNIQUE INDEX admin_id_idx ON users.admin USING btree (id);


--
-- TOC entry 3527 (class 1259 OID 41116)
-- Name: admin_password_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX admin_password_idx ON users.admin USING btree (password);


--
-- TOC entry 3521 (class 1259 OID 41132)
-- Name: hospitals_enabled_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX hospitals_enabled_idx ON users.hospitals USING btree (enabled);


--
-- TOC entry 3524 (class 1259 OID 49305)
-- Name: hospitals_province_code_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX hospitals_province_code_idx ON users.hospitals USING btree (zone_code);


--
-- TOC entry 3746 (class 1259 OID 115198)
-- Name: platforms_id_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE UNIQUE INDEX platforms_id_idx ON users.user_platforms USING btree (id);


--
-- TOC entry 3533 (class 1259 OID 65663)
-- Name: tokens_expires_at_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX tokens_expires_at_idx ON users.tokens USING btree (expires_at);


--
-- TOC entry 3518 (class 1259 OID 107089)
-- Name: users_hospcode_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX users_hospcode_idx ON users.users USING btree (hospcode);


--
-- TOC entry 3530 (class 1259 OID 49286)
-- Name: zones_ingress_topic_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE UNIQUE INDEX zones_ingress_topic_idx ON users.zones USING btree (ingress_zone);


--
-- TOC entry 3752 (class 2606 OID 49340)
-- Name: hospitals hospitals_fk; Type: FK CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.hospitals
    ADD CONSTRAINT hospitals_fk FOREIGN KEY (zone_code) REFERENCES users.zones(code);


--
-- TOC entry 3751 (class 2606 OID 107090)
-- Name: users users_fk; Type: FK CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_fk FOREIGN KEY (hospcode) REFERENCES users.hospitals(hospcode);


-- Completed on 2023-02-22 20:37:14

--
-- PostgreSQL database dump complete
--

