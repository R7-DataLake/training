--
-- PostgreSQL database dump
--

-- Dumped from database version 15.0
-- Dumped by pg_dump version 15.0

-- Started on 2023-02-07 05:39:24

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
-- TOC entry 288 (class 1255 OID 73938)
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
-- TOC entry 229 (class 1259 OID 73996)
-- Name: clinic_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.clinic_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 228 (class 1259 OID 73986)
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
-- TOC entry 226 (class 1259 OID 73960)
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
-- TOC entry 230 (class 1259 OID 74001)
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
-- TOC entry 224 (class 1259 OID 73944)
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
-- TOC entry 227 (class 1259 OID 73981)
-- Name: insurance_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.insurance_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 225 (class 1259 OID 73953)
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
-- TOC entry 232 (class 1259 OID 74028)
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
-- TOC entry 239 (class 1259 OID 82070)
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
-- TOC entry 231 (class 1259 OID 74021)
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
-- TOC entry 236 (class 1259 OID 74054)
-- Name: nation_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.nation_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 235 (class 1259 OID 74047)
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
-- TOC entry 234 (class 1259 OID 74042)
-- Name: occupation_mappings; Type: TABLE; Schema: libs; Owner: -
--

CREATE TABLE libs.occupation_mappings (
    code character varying(10) NOT NULL,
    hospcode character varying(10) NOT NULL,
    f43 character varying(10),
    nhso character varying(10)
);


--
-- TOC entry 233 (class 1259 OID 74035)
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
-- TOC entry 237 (class 1259 OID 74059)
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
-- TOC entry 238 (class 1259 OID 74064)
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
-- TOC entry 240 (class 1259 OID 98426)
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
-- TOC entry 241 (class 1259 OID 98429)
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
-- TOC entry 242 (class 1259 OID 98432)
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
-- TOC entry 243 (class 1259 OID 98435)
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
-- TOC entry 244 (class 1259 OID 98438)
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
-- TOC entry 245 (class 1259 OID 98442)
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
-- TOC entry 246 (class 1259 OID 98445)
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
-- TOC entry 247 (class 1259 OID 98448)
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
-- TOC entry 248 (class 1259 OID 98451)
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
-- TOC entry 249 (class 1259 OID 98456)
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
-- TOC entry 250 (class 1259 OID 98459)
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
-- TOC entry 251 (class 1259 OID 98463)
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
-- TOC entry 276 (class 1259 OID 98679)
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
-- TOC entry 277 (class 1259 OID 98682)
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
-- TOC entry 278 (class 1259 OID 98685)
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
-- TOC entry 279 (class 1259 OID 98688)
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
-- TOC entry 280 (class 1259 OID 98691)
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
-- TOC entry 281 (class 1259 OID 98695)
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
-- TOC entry 282 (class 1259 OID 98698)
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
-- TOC entry 283 (class 1259 OID 98701)
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
-- TOC entry 284 (class 1259 OID 98704)
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
-- TOC entry 285 (class 1259 OID 98709)
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
-- TOC entry 286 (class 1259 OID 98712)
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
-- TOC entry 287 (class 1259 OID 98716)
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
-- TOC entry 252 (class 1259 OID 98508)
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
-- TOC entry 253 (class 1259 OID 98511)
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
-- TOC entry 254 (class 1259 OID 98514)
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
-- TOC entry 255 (class 1259 OID 98517)
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
-- TOC entry 256 (class 1259 OID 98520)
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
-- TOC entry 257 (class 1259 OID 98524)
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
-- TOC entry 258 (class 1259 OID 98527)
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
-- TOC entry 259 (class 1259 OID 98530)
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
-- TOC entry 260 (class 1259 OID 98533)
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
-- TOC entry 261 (class 1259 OID 98538)
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
-- TOC entry 262 (class 1259 OID 98541)
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
-- TOC entry 263 (class 1259 OID 98545)
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
-- TOC entry 264 (class 1259 OID 98593)
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
-- TOC entry 265 (class 1259 OID 98596)
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
-- TOC entry 266 (class 1259 OID 98599)
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
-- TOC entry 267 (class 1259 OID 98602)
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
-- TOC entry 268 (class 1259 OID 98605)
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
-- TOC entry 269 (class 1259 OID 98609)
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
-- TOC entry 270 (class 1259 OID 98612)
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
-- TOC entry 271 (class 1259 OID 98615)
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
-- TOC entry 272 (class 1259 OID 98618)
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
-- TOC entry 273 (class 1259 OID 98623)
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
-- TOC entry 274 (class 1259 OID 98626)
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
-- TOC entry 275 (class 1259 OID 98630)
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
-- TOC entry 221 (class 1259 OID 41108)
-- Name: admin; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.admin (
    id uuid DEFAULT gen_random_uuid(),
    username character varying(10) NOT NULL,
    password character varying(128),
    enabled boolean DEFAULT false
);


--
-- TOC entry 220 (class 1259 OID 41100)
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
-- TOC entry 223 (class 1259 OID 65655)
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
-- TOC entry 219 (class 1259 OID 41088)
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
-- TOC entry 222 (class 1259 OID 49279)
-- Name: zones; Type: TABLE; Schema: users; Owner: -
--

CREATE TABLE users.zones (
    code character(4) NOT NULL,
    name character varying(150),
    ingress_zone character varying(20),
    enabled boolean DEFAULT true
);


--
-- TOC entry 3853 (class 0 OID 73996)
-- Dependencies: 229
-- Data for Name: clinic_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3852 (class 0 OID 73986)
-- Dependencies: 228
-- Data for Name: clinics; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3850 (class 0 OID 73960)
-- Dependencies: 226
-- Data for Name: drug_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drug_mappings VALUES ('101', '200000125', '450000210', '4100014', '11053', '2023-02-01 14:06:20.823', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('102', '2000001257122', '4500002107122', NULL, '11053', '2023-02-04 19:12:28.112', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('1001', '12221', '13333', NULL, '11053', '2023-02-04 19:12:53.432', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drug_mappings VALUES ('1002', '89999', '99999', NULL, '11053', '2023-02-04 19:31:33.251', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3854 (class 0 OID 74001)
-- Dependencies: 230
-- Data for Name: drug_usages; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drug_usages VALUES ('11053', '2121', 'fdsdsfdsfdsfsd', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-05 10:27:03.601125', '2023-02-05 10:27:03.49', 'dsfdsfds', 'dfdsfdsfds');
INSERT INTO libs.drug_usages VALUES ('11053', '1122', 'erwer', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-05 10:58:14.481076', '2023-02-05 11:17:52.295', 'eeeeeeeee', 'sadsdsas');


--
-- TOC entry 3848 (class 0 OID 73944)
-- Dependencies: 224
-- Data for Name: drugs; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.drugs VALUES ('101', 'Paracetamol 500mg', '11053', '2023-02-04 12:46:27.232622', '2023-02-04 18:47:53.46', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('102', 'Amoxyciline2 250mg', '11053', '2023-02-04 07:12:58.571608', '2023-02-04 19:31:40.089', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('1001', 'TA 0.1', '11053', '2023-02-04 19:12:34.710435', '2023-02-05 10:33:00.706', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.drugs VALUES ('1002', 'ยีเรียครีม 0.5', '11053', '2023-02-04 19:12:34.710435', '2023-02-05 10:33:15.598', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3851 (class 0 OID 73981)
-- Dependencies: 227
-- Data for Name: insurance_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3849 (class 0 OID 73953)
-- Dependencies: 225
-- Data for Name: insurances; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3856 (class 0 OID 74028)
-- Dependencies: 232
-- Data for Name: lab_groups; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.lab_groups VALUES ('11053', '5003', 'eeee', '2023-02-06 10:09:54.520265', '2023-02-06 10:10:47.671', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_groups VALUES ('11053', '5001', 'CBC', '2023-02-06 10:11:02.374292', '2023-02-06 10:11:02.374292', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_groups VALUES ('11053', '5002', 'ANC', '2023-02-06 09:50:53.777719', '2023-02-06 10:11:02.374292', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3863 (class 0 OID 82070)
-- Dependencies: 239
-- Data for Name: lab_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.lab_mappings VALUES ('1002', '11053', '2000001257', '4500002107', '2023-02-02 15:00:28.434', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_mappings VALUES ('1001', '11053', '2000001288', '4500002188', '2023-02-06 10:28:24.698', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');
INSERT INTO libs.lab_mappings VALUES ('xxxxx', '11053', '5465464', '556465464', '2023-02-06 10:28:46.596', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f');


--
-- TOC entry 3855 (class 0 OID 74021)
-- Dependencies: 231
-- Data for Name: labs; Type: TABLE DATA; Schema: libs; Owner: -
--

INSERT INTO libs.labs VALUES ('11053', '1001', 'TEST LAB', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-01 14:56:00.604107', '2023-02-06 10:19:51.53', '5002');
INSERT INTO libs.labs VALUES ('11053', '1002', 'FBS', 'c2c58946-2345-4fbd-8f3f-2875deb93c7f', '2023-02-02 15:00:38.807533', '2023-02-06 10:20:01.17', '5001');


--
-- TOC entry 3860 (class 0 OID 74054)
-- Dependencies: 236
-- Data for Name: nation_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3859 (class 0 OID 74047)
-- Dependencies: 235
-- Data for Name: nations; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3858 (class 0 OID 74042)
-- Dependencies: 234
-- Data for Name: occupation_mappings; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3857 (class 0 OID 74035)
-- Dependencies: 233
-- Data for Name: occupations; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3861 (class 0 OID 74059)
-- Dependencies: 237
-- Data for Name: providers; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3862 (class 0 OID 74064)
-- Dependencies: 238
-- Data for Name: wards; Type: TABLE DATA; Schema: libs; Owner: -
--



--
-- TOC entry 3864 (class 0 OID 98426)
-- Dependencies: 240
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3865 (class 0 OID 98429)
-- Dependencies: 241
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3866 (class 0 OID 98432)
-- Dependencies: 242
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3867 (class 0 OID 98435)
-- Dependencies: 243
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3868 (class 0 OID 98438)
-- Dependencies: 244
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3869 (class 0 OID 98442)
-- Dependencies: 245
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3870 (class 0 OID 98445)
-- Dependencies: 246
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3871 (class 0 OID 98448)
-- Dependencies: 247
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3872 (class 0 OID 98451)
-- Dependencies: 248
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3873 (class 0 OID 98456)
-- Dependencies: 249
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3874 (class 0 OID 98459)
-- Dependencies: 250
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3875 (class 0 OID 98463)
-- Dependencies: 251
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_kk; Owner: -
--



--
-- TOC entry 3900 (class 0 OID 98679)
-- Dependencies: 276
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3901 (class 0 OID 98682)
-- Dependencies: 277
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3902 (class 0 OID 98685)
-- Dependencies: 278
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3903 (class 0 OID 98688)
-- Dependencies: 279
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3904 (class 0 OID 98691)
-- Dependencies: 280
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3905 (class 0 OID 98695)
-- Dependencies: 281
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3906 (class 0 OID 98698)
-- Dependencies: 282
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3907 (class 0 OID 98701)
-- Dependencies: 283
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3908 (class 0 OID 98704)
-- Dependencies: 284
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3909 (class 0 OID 98709)
-- Dependencies: 285
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3910 (class 0 OID 98712)
-- Dependencies: 286
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3911 (class 0 OID 98716)
-- Dependencies: 287
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_kls; Owner: -
--



--
-- TOC entry 3876 (class 0 OID 98508)
-- Dependencies: 252
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3877 (class 0 OID 98511)
-- Dependencies: 253
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3878 (class 0 OID 98514)
-- Dependencies: 254
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3879 (class 0 OID 98517)
-- Dependencies: 255
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3880 (class 0 OID 98520)
-- Dependencies: 256
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3881 (class 0 OID 98524)
-- Dependencies: 257
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3882 (class 0 OID 98527)
-- Dependencies: 258
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3883 (class 0 OID 98530)
-- Dependencies: 259
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3884 (class 0 OID 98533)
-- Dependencies: 260
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3885 (class 0 OID 98538)
-- Dependencies: 261
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3886 (class 0 OID 98541)
-- Dependencies: 262
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3887 (class 0 OID 98545)
-- Dependencies: 263
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_msk; Owner: -
--



--
-- TOC entry 3888 (class 0 OID 98593)
-- Dependencies: 264
-- Data for Name: appoint; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3889 (class 0 OID 98596)
-- Dependencies: 265
-- Data for Name: chronic; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3890 (class 0 OID 98599)
-- Dependencies: 266
-- Data for Name: drug; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3891 (class 0 OID 98602)
-- Dependencies: 267
-- Data for Name: drugallergy; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3892 (class 0 OID 98605)
-- Dependencies: 268
-- Data for Name: ipd; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3893 (class 0 OID 98609)
-- Dependencies: 269
-- Data for Name: ipdx; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3894 (class 0 OID 98612)
-- Dependencies: 270
-- Data for Name: ipop; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3895 (class 0 OID 98615)
-- Dependencies: 271
-- Data for Name: lab; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3896 (class 0 OID 98618)
-- Dependencies: 272
-- Data for Name: opd; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3897 (class 0 OID 98623)
-- Dependencies: 273
-- Data for Name: opdx; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3898 (class 0 OID 98626)
-- Dependencies: 274
-- Data for Name: opop; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3899 (class 0 OID 98630)
-- Dependencies: 275
-- Data for Name: person; Type: TABLE DATA; Schema: rawdata_roiet; Owner: -
--



--
-- TOC entry 3845 (class 0 OID 41108)
-- Dependencies: 221
-- Data for Name: admin; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.admin VALUES ('37749a01-8c93-44ee-9051-8ece2401427c', 'admin', '$2b$10$WKhyp0uCK7SvrX.sQJg9IOPEwPKq7gz9PkfmQmWGLJknaAQ0w7wN.', true);


--
-- TOC entry 3844 (class 0 OID 41100)
-- Dependencies: 220
-- Data for Name: hospitals; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.hospitals VALUES ('10707', 'รพท.มหาสารคาม', '4400', true, false);
INSERT INTO users.hospitals VALUES ('11111', 'xxxxxxxxxxxxx', '4000', true, false);
INSERT INTO users.hospitals VALUES ('11053', ' รพช.กันทรวิชัย', '4400', true, false);


--
-- TOC entry 3847 (class 0 OID 65655)
-- Dependencies: 223
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


--
-- TOC entry 3843 (class 0 OID 41088)
-- Dependencies: 219
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
-- TOC entry 3846 (class 0 OID 49279)
-- Dependencies: 222
-- Data for Name: zones; Type: TABLE DATA; Schema: users; Owner: -
--

INSERT INTO users.zones VALUES ('4000', 'ขอนแก่น', 'KHONKAEN', true);
INSERT INTO users.zones VALUES ('4400', 'มหาสารคาม', 'MAHASARAKHAM', true);
INSERT INTO users.zones VALUES ('4500', 'ร้อยเอ็ด', 'ROIET', true);
INSERT INTO users.zones VALUES ('4600', 'กาฬสินธุ์', 'KALASIN', true);


--
-- TOC entry 3514 (class 2606 OID 74000)
-- Name: clinic_mappings clinic_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.clinic_mappings
    ADD CONSTRAINT clinic_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3534 (class 2606 OID 82074)
-- Name: lab_mappings clinic_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.lab_mappings
    ADD CONSTRAINT clinic_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3512 (class 2606 OID 73992)
-- Name: clinics clinics_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.clinics
    ADD CONSTRAINT clinics_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3508 (class 2606 OID 73964)
-- Name: drug_mappings drug_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drug_mappings
    ADD CONSTRAINT drug_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3516 (class 2606 OID 74007)
-- Name: drug_usages drug_usages_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drug_usages
    ADD CONSTRAINT drug_usages_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3504 (class 2606 OID 82051)
-- Name: drugs drugs_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.drugs
    ADD CONSTRAINT drugs_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3510 (class 2606 OID 73985)
-- Name: insurance_mappings insurance_mappings_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.insurance_mappings
    ADD CONSTRAINT insurance_mappings_pk PRIMARY KEY (code, hospcode);


--
-- TOC entry 3506 (class 2606 OID 73976)
-- Name: insurances insurances_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.insurances
    ADD CONSTRAINT insurances_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3520 (class 2606 OID 74034)
-- Name: lab_groups lab_groups_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.lab_groups
    ADD CONSTRAINT lab_groups_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3518 (class 2606 OID 82057)
-- Name: labs lab_items_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.labs
    ADD CONSTRAINT lab_items_pk_1 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3528 (class 2606 OID 74058)
-- Name: nation_mappings nation_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.nation_mappings
    ADD CONSTRAINT nation_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3526 (class 2606 OID 74053)
-- Name: nations nations_pk_3; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.nations
    ADD CONSTRAINT nations_pk_3 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3524 (class 2606 OID 74046)
-- Name: occupation_mappings occupation_mappings_pk_1; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.occupation_mappings
    ADD CONSTRAINT occupation_mappings_pk_1 PRIMARY KEY (code, hospcode);


--
-- TOC entry 3522 (class 2606 OID 74041)
-- Name: occupations occupations_pk_2; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.occupations
    ADD CONSTRAINT occupations_pk_2 PRIMARY KEY (hospcode, code);


--
-- TOC entry 3530 (class 2606 OID 74063)
-- Name: providers providers_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.providers
    ADD CONSTRAINT providers_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3532 (class 2606 OID 74070)
-- Name: wards wards_pk; Type: CONSTRAINT; Schema: libs; Owner: -
--

ALTER TABLE ONLY libs.wards
    ADD CONSTRAINT wards_pk PRIMARY KEY (hospcode, code);


--
-- TOC entry 3537 (class 2606 OID 98467)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3542 (class 2606 OID 98469)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3544 (class 2606 OID 98471)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3548 (class 2606 OID 98473)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3552 (class 2606 OID 98475)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3555 (class 2606 OID 98477)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3558 (class 2606 OID 98479)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3560 (class 2606 OID 98481)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3562 (class 2606 OID 98812)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3564 (class 2606 OID 98485)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3566 (class 2606 OID 98487)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3573 (class 2606 OID 98489)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_kk; Owner: -
--

ALTER TABLE ONLY rawdata_kk.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3660 (class 2606 OID 98720)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3665 (class 2606 OID 98722)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3667 (class 2606 OID 98724)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3671 (class 2606 OID 98726)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3675 (class 2606 OID 98728)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3678 (class 2606 OID 98730)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3681 (class 2606 OID 98732)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3683 (class 2606 OID 98734)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3685 (class 2606 OID 98810)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3687 (class 2606 OID 98738)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3689 (class 2606 OID 98740)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3696 (class 2606 OID 98742)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_kls; Owner: -
--

ALTER TABLE ONLY rawdata_kls.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3578 (class 2606 OID 98549)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3583 (class 2606 OID 98551)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3585 (class 2606 OID 98553)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3589 (class 2606 OID 98555)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3593 (class 2606 OID 98557)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3596 (class 2606 OID 98559)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3599 (class 2606 OID 98561)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3601 (class 2606 OID 98563)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3603 (class 2606 OID 98808)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3605 (class 2606 OID 98567)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3607 (class 2606 OID 98569)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3614 (class 2606 OID 98571)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_msk; Owner: -
--

ALTER TABLE ONLY rawdata_msk.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3619 (class 2606 OID 98634)
-- Name: appoint appoint_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.appoint
    ADD CONSTRAINT appoint_pk PRIMARY KEY (hospcode, hn, appoint_date, clinic);


--
-- TOC entry 3624 (class 2606 OID 98636)
-- Name: chronic chronic_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.chronic
    ADD CONSTRAINT chronic_pk PRIMARY KEY (hospcode, hn, chronic);


--
-- TOC entry 3626 (class 2606 OID 98638)
-- Name: drug drug_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.drug
    ADD CONSTRAINT drug_pk PRIMARY KEY (hospcode, hn, seq, did);


--
-- TOC entry 3630 (class 2606 OID 98640)
-- Name: drugallergy drugallergy_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.drugallergy
    ADD CONSTRAINT drugallergy_pk PRIMARY KEY (hospcode, hn, dname);


--
-- TOC entry 3634 (class 2606 OID 98642)
-- Name: ipd ipd_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipd
    ADD CONSTRAINT ipd_pk PRIMARY KEY (hospcode, hn, an);


--
-- TOC entry 3637 (class 2606 OID 98644)
-- Name: ipdx ipdx_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipdx
    ADD CONSTRAINT ipdx_pk PRIMARY KEY (hospcode, hn, an, diag);


--
-- TOC entry 3640 (class 2606 OID 98646)
-- Name: ipop ipop_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.ipop
    ADD CONSTRAINT ipop_pk PRIMARY KEY (hospcode, hn, an, oper);


--
-- TOC entry 3642 (class 2606 OID 98648)
-- Name: lab lab_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.lab
    ADD CONSTRAINT lab_pk PRIMARY KEY (hospcode, hn, seq, labtest);


--
-- TOC entry 3644 (class 2606 OID 98806)
-- Name: opd opd_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opd
    ADD CONSTRAINT opd_pk PRIMARY KEY (hospcode, hn, date_serv, seq);


--
-- TOC entry 3646 (class 2606 OID 98652)
-- Name: opdx opdx_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opdx
    ADD CONSTRAINT opdx_pk PRIMARY KEY (hospcode, hn, seq, diag);


--
-- TOC entry 3648 (class 2606 OID 98654)
-- Name: opop opop_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.opop
    ADD CONSTRAINT opop_pk PRIMARY KEY (hospcode, hn, seq, oper);


--
-- TOC entry 3655 (class 2606 OID 98656)
-- Name: person person_pk; Type: CONSTRAINT; Schema: rawdata_roiet; Owner: -
--

ALTER TABLE ONLY rawdata_roiet.person
    ADD CONSTRAINT person_pk PRIMARY KEY (hospcode, hn);


--
-- TOC entry 3496 (class 2606 OID 41114)
-- Name: admin admin_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.admin
    ADD CONSTRAINT admin_pk PRIMARY KEY (username);


--
-- TOC entry 3490 (class 2606 OID 107069)
-- Name: hospitals hospitals_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.hospitals
    ADD CONSTRAINT hospitals_pk PRIMARY KEY (hospcode);


--
-- TOC entry 3502 (class 2606 OID 65662)
-- Name: tokens tokens_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.tokens
    ADD CONSTRAINT tokens_pk PRIMARY KEY (user_id, refresh_token);


--
-- TOC entry 3487 (class 2606 OID 107117)
-- Name: users users_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_pk PRIMARY KEY (username);


--
-- TOC entry 3499 (class 2606 OID 49339)
-- Name: zones zones_pk; Type: CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.zones
    ADD CONSTRAINT zones_pk PRIMARY KEY (code);


--
-- TOC entry 3535 (class 1259 OID 98490)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_kk.appoint USING btree (an);


--
-- TOC entry 3538 (class 1259 OID 98491)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_kk.appoint USING btree (seq);


--
-- TOC entry 3539 (class 1259 OID 98492)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_kk.chronic USING btree (hosp_dx);


--
-- TOC entry 3540 (class 1259 OID 98493)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_kk.chronic USING btree (hosp_rx);


--
-- TOC entry 3545 (class 1259 OID 98494)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_kk.drugallergy USING btree (informant);


--
-- TOC entry 3546 (class 1259 OID 98495)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_kk.drugallergy USING btree (informhosp);


--
-- TOC entry 3549 (class 1259 OID 98496)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_kk.drugallergy USING btree (symptom);


--
-- TOC entry 3550 (class 1259 OID 98497)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_kk.ipd USING btree (dateadm);


--
-- TOC entry 3553 (class 1259 OID 98498)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_kk.ipdx USING btree (dxtype);


--
-- TOC entry 3556 (class 1259 OID 98499)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_kk.ipop USING btree (optype);


--
-- TOC entry 3567 (class 1259 OID 98500)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_kk.person USING btree (amphur);


--
-- TOC entry 3568 (class 1259 OID 98501)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_kk.person USING btree (changwat);


--
-- TOC entry 3569 (class 1259 OID 98502)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_kk.person USING btree (cid);


--
-- TOC entry 3570 (class 1259 OID 98503)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_kk.person USING btree (nation);


--
-- TOC entry 3571 (class 1259 OID 98504)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_kk.person USING btree (occupation);


--
-- TOC entry 3574 (class 1259 OID 98505)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_kk.person USING btree (tambol);


--
-- TOC entry 3575 (class 1259 OID 98506)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_kk; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_kk.person USING btree (typearea);


--
-- TOC entry 3658 (class 1259 OID 98743)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_kls.appoint USING btree (an);


--
-- TOC entry 3661 (class 1259 OID 98744)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_kls.appoint USING btree (seq);


--
-- TOC entry 3662 (class 1259 OID 98745)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_kls.chronic USING btree (hosp_dx);


--
-- TOC entry 3663 (class 1259 OID 98746)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_kls.chronic USING btree (hosp_rx);


--
-- TOC entry 3668 (class 1259 OID 98747)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_kls.drugallergy USING btree (informant);


--
-- TOC entry 3669 (class 1259 OID 98748)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_kls.drugallergy USING btree (informhosp);


--
-- TOC entry 3672 (class 1259 OID 98749)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_kls.drugallergy USING btree (symptom);


--
-- TOC entry 3673 (class 1259 OID 98750)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_kls.ipd USING btree (dateadm);


--
-- TOC entry 3676 (class 1259 OID 98751)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_kls.ipdx USING btree (dxtype);


--
-- TOC entry 3679 (class 1259 OID 98752)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_kls.ipop USING btree (optype);


--
-- TOC entry 3690 (class 1259 OID 98753)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_kls.person USING btree (amphur);


--
-- TOC entry 3691 (class 1259 OID 98754)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_kls.person USING btree (changwat);


--
-- TOC entry 3692 (class 1259 OID 98755)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_kls.person USING btree (cid);


--
-- TOC entry 3693 (class 1259 OID 98756)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_kls.person USING btree (nation);


--
-- TOC entry 3694 (class 1259 OID 98757)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_kls.person USING btree (occupation);


--
-- TOC entry 3697 (class 1259 OID 98758)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_kls.person USING btree (tambol);


--
-- TOC entry 3698 (class 1259 OID 98759)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_kls; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_kls.person USING btree (typearea);


--
-- TOC entry 3576 (class 1259 OID 98572)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_msk.appoint USING btree (an);


--
-- TOC entry 3579 (class 1259 OID 98573)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_msk.appoint USING btree (seq);


--
-- TOC entry 3580 (class 1259 OID 98574)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_msk.chronic USING btree (hosp_dx);


--
-- TOC entry 3581 (class 1259 OID 98575)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_msk.chronic USING btree (hosp_rx);


--
-- TOC entry 3586 (class 1259 OID 98576)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_msk.drugallergy USING btree (informant);


--
-- TOC entry 3587 (class 1259 OID 98577)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_msk.drugallergy USING btree (informhosp);


--
-- TOC entry 3590 (class 1259 OID 98578)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_msk.drugallergy USING btree (symptom);


--
-- TOC entry 3591 (class 1259 OID 98579)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_msk.ipd USING btree (dateadm);


--
-- TOC entry 3594 (class 1259 OID 98580)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_msk.ipdx USING btree (dxtype);


--
-- TOC entry 3597 (class 1259 OID 98581)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_msk.ipop USING btree (optype);


--
-- TOC entry 3608 (class 1259 OID 98582)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_msk.person USING btree (amphur);


--
-- TOC entry 3609 (class 1259 OID 98583)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_msk.person USING btree (changwat);


--
-- TOC entry 3610 (class 1259 OID 98584)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_msk.person USING btree (cid);


--
-- TOC entry 3611 (class 1259 OID 98585)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_msk.person USING btree (nation);


--
-- TOC entry 3612 (class 1259 OID 98586)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_msk.person USING btree (occupation);


--
-- TOC entry 3615 (class 1259 OID 98587)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_msk.person USING btree (tambol);


--
-- TOC entry 3616 (class 1259 OID 98588)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_msk; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_msk.person USING btree (typearea);


--
-- TOC entry 3617 (class 1259 OID 98657)
-- Name: appoint_an_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX appoint_an_idx ON rawdata_roiet.appoint USING btree (an);


--
-- TOC entry 3620 (class 1259 OID 98658)
-- Name: appoint_seq_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX appoint_seq_idx ON rawdata_roiet.appoint USING btree (seq);


--
-- TOC entry 3621 (class 1259 OID 98659)
-- Name: chronic_hosp_dx_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX chronic_hosp_dx_idx ON rawdata_roiet.chronic USING btree (hosp_dx);


--
-- TOC entry 3622 (class 1259 OID 98660)
-- Name: chronic_hosp_rx_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX chronic_hosp_rx_idx ON rawdata_roiet.chronic USING btree (hosp_rx);


--
-- TOC entry 3627 (class 1259 OID 98661)
-- Name: drugallergy_informant_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_informant_idx ON rawdata_roiet.drugallergy USING btree (informant);


--
-- TOC entry 3628 (class 1259 OID 98662)
-- Name: drugallergy_informhosp_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_informhosp_idx ON rawdata_roiet.drugallergy USING btree (informhosp);


--
-- TOC entry 3631 (class 1259 OID 98663)
-- Name: drugallergy_symptom_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX drugallergy_symptom_idx ON rawdata_roiet.drugallergy USING btree (symptom);


--
-- TOC entry 3632 (class 1259 OID 98664)
-- Name: ipd_dateadm_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipd_dateadm_idx ON rawdata_roiet.ipd USING btree (dateadm);


--
-- TOC entry 3635 (class 1259 OID 98665)
-- Name: ipdx_dxtype_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipdx_dxtype_idx ON rawdata_roiet.ipdx USING btree (dxtype);


--
-- TOC entry 3638 (class 1259 OID 98666)
-- Name: ipop_optype_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX ipop_optype_idx ON rawdata_roiet.ipop USING btree (optype);


--
-- TOC entry 3649 (class 1259 OID 98667)
-- Name: person_amphur_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_amphur_idx ON rawdata_roiet.person USING btree (amphur);


--
-- TOC entry 3650 (class 1259 OID 98668)
-- Name: person_changwat_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_changwat_idx ON rawdata_roiet.person USING btree (changwat);


--
-- TOC entry 3651 (class 1259 OID 98669)
-- Name: person_cid_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_cid_idx ON rawdata_roiet.person USING btree (cid);


--
-- TOC entry 3652 (class 1259 OID 98670)
-- Name: person_nation_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_nation_idx ON rawdata_roiet.person USING btree (nation);


--
-- TOC entry 3653 (class 1259 OID 98671)
-- Name: person_occupation_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_occupation_idx ON rawdata_roiet.person USING btree (occupation);


--
-- TOC entry 3656 (class 1259 OID 98672)
-- Name: person_tambol_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_tambol_idx ON rawdata_roiet.person USING btree (tambol);


--
-- TOC entry 3657 (class 1259 OID 98673)
-- Name: person_typearea_idx; Type: INDEX; Schema: rawdata_roiet; Owner: -
--

CREATE INDEX person_typearea_idx ON rawdata_roiet.person USING btree (typearea);


--
-- TOC entry 3492 (class 1259 OID 41117)
-- Name: admin_enabled_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX admin_enabled_idx ON users.admin USING btree (enabled);


--
-- TOC entry 3493 (class 1259 OID 41115)
-- Name: admin_id_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE UNIQUE INDEX admin_id_idx ON users.admin USING btree (id);


--
-- TOC entry 3494 (class 1259 OID 41116)
-- Name: admin_password_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX admin_password_idx ON users.admin USING btree (password);


--
-- TOC entry 3488 (class 1259 OID 41132)
-- Name: hospitals_enabled_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX hospitals_enabled_idx ON users.hospitals USING btree (enabled);


--
-- TOC entry 3491 (class 1259 OID 49305)
-- Name: hospitals_province_code_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX hospitals_province_code_idx ON users.hospitals USING btree (zone_code);


--
-- TOC entry 3500 (class 1259 OID 65663)
-- Name: tokens_expires_at_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX tokens_expires_at_idx ON users.tokens USING btree (expires_at);


--
-- TOC entry 3485 (class 1259 OID 107089)
-- Name: users_hospcode_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE INDEX users_hospcode_idx ON users.users USING btree (hospcode);


--
-- TOC entry 3497 (class 1259 OID 49286)
-- Name: zones_ingress_topic_idx; Type: INDEX; Schema: users; Owner: -
--

CREATE UNIQUE INDEX zones_ingress_topic_idx ON users.zones USING btree (ingress_zone);


--
-- TOC entry 3700 (class 2606 OID 49340)
-- Name: hospitals hospitals_fk; Type: FK CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.hospitals
    ADD CONSTRAINT hospitals_fk FOREIGN KEY (zone_code) REFERENCES users.zones(code);


--
-- TOC entry 3699 (class 2606 OID 107090)
-- Name: users users_fk; Type: FK CONSTRAINT; Schema: users; Owner: -
--

ALTER TABLE ONLY users.users
    ADD CONSTRAINT users_fk FOREIGN KEY (hospcode) REFERENCES users.hospitals(hospcode);


-- Completed on 2023-02-07 05:39:24

--
-- PostgreSQL database dump complete
--

