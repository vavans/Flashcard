--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Card; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Card" (
    idcard integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    iddeck integer NOT NULL
);


ALTER TABLE "Card" OWNER TO postgres;

--
-- Name: Card_idcard_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Card_idcard_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Card_idcard_seq" OWNER TO postgres;

--
-- Name: Card_idcard_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Card_idcard_seq" OWNED BY "Card".idcard;


--
-- Name: Deck; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "Deck" (
    iddeck integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE "Deck" OWNER TO postgres;

--
-- Name: Deck_iddeck_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Deck_iddeck_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Deck_iddeck_seq" OWNER TO postgres;

--
-- Name: Deck_iddeck_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Deck_iddeck_seq" OWNED BY "Deck".iddeck;


--
-- Name: idcard; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Card" ALTER COLUMN idcard SET DEFAULT nextval('"Card_idcard_seq"'::regclass);


--
-- Name: iddeck; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Deck" ALTER COLUMN iddeck SET DEFAULT nextval('"Deck_iddeck_seq"'::regclass);


--
-- Name: idcardkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Card"
    ADD CONSTRAINT idcardkey PRIMARY KEY (idcard);


--
-- Name: iddeck; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "Deck"
    ADD CONSTRAINT iddeck PRIMARY KEY (iddeck);


--
-- Name: Card_idcard_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Card_idcard_idx" ON "Card" USING btree (idcard);


--
-- Name: Deck_iddeck_idx; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX "Deck_iddeck_idx" ON "Deck" USING btree (iddeck);


--
-- Name: fki_iddeckkey; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_iddeckkey ON "Card" USING btree (iddeck);


--
-- Name: iddeckkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Card"
    ADD CONSTRAINT iddeckkey FOREIGN KEY (iddeck) REFERENCES "Deck"(iddeck);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT USAGE ON SCHEMA public TO read;


--
-- Name: Card; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "Card" FROM PUBLIC;
REVOKE ALL ON TABLE "Card" FROM postgres;
GRANT ALL ON TABLE "Card" TO postgres;
GRANT ALL ON TABLE "Card" TO read WITH GRANT OPTION;


--
-- Name: Card_idcard_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "Card_idcard_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "Card_idcard_seq" FROM postgres;
GRANT ALL ON SEQUENCE "Card_idcard_seq" TO postgres;
GRANT ALL ON SEQUENCE "Card_idcard_seq" TO read WITH GRANT OPTION;


--
-- Name: Deck; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE "Deck" FROM PUBLIC;
REVOKE ALL ON TABLE "Deck" FROM postgres;
GRANT ALL ON TABLE "Deck" TO postgres;
GRANT ALL ON TABLE "Deck" TO read WITH GRANT OPTION;


--
-- Name: Deck_iddeck_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE "Deck_iddeck_seq" FROM PUBLIC;
REVOKE ALL ON SEQUENCE "Deck_iddeck_seq" FROM postgres;
GRANT ALL ON SEQUENCE "Deck_iddeck_seq" TO postgres;
GRANT ALL ON SEQUENCE "Deck_iddeck_seq" TO read WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES  TO read;


--
-- PostgreSQL database dump complete
--

