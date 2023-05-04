--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-03 16:59:24

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16511)
-- Name: Libro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Libro" (
    id_libro integer NOT NULL,
    titulo character varying NOT NULL,
    autor character varying NOT NULL,
    ejemplares integer NOT NULL,
    id_tema integer NOT NULL
);


ALTER TABLE public."Libro" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16510)
-- Name: Libro_id_libro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Libro_id_libro_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Libro_id_libro_seq" OWNER TO postgres;

--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 214
-- Name: Libro_id_libro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Libro_id_libro_seq" OWNED BY public."Libro".id_libro;


--
-- TOC entry 217 (class 1259 OID 16520)
-- Name: Reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Reserva" (
    id_reserva integer NOT NULL,
    "Libro_id_libro" integer NOT NULL,
    "Socio_id_socio" integer NOT NULL,
    fecha_prestamo date NOT NULL,
    fecha_devolucion date NOT NULL
);


ALTER TABLE public."Reserva" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16519)
-- Name: Reserva_id_reserva_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Reserva_id_reserva_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Reserva_id_reserva_seq" OWNER TO postgres;

--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 216
-- Name: Reserva_id_reserva_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Reserva_id_reserva_seq" OWNED BY public."Reserva".id_reserva;


--
-- TOC entry 219 (class 1259 OID 16527)
-- Name: Socio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Socio" (
    id_socio integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE public."Socio" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16526)
-- Name: Socio_id_socio_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Socio_id_socio_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Socio_id_socio_seq" OWNER TO postgres;

--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 218
-- Name: Socio_id_socio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Socio_id_socio_seq" OWNED BY public."Socio".id_socio;


--
-- TOC entry 221 (class 1259 OID 16536)
-- Name: Tema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tema" (
    id_tema integer NOT NULL,
    tipo character varying NOT NULL
);


ALTER TABLE public."Tema" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16535)
-- Name: Tema_id_tema_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Tema_id_tema_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Tema_id_tema_seq" OWNER TO postgres;

--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tema_id_tema_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Tema_id_tema_seq" OWNED BY public."Tema".id_tema;


--
-- TOC entry 3188 (class 2604 OID 16514)
-- Name: Libro id_libro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Libro" ALTER COLUMN id_libro SET DEFAULT nextval('public."Libro_id_libro_seq"'::regclass);


--
-- TOC entry 3189 (class 2604 OID 16523)
-- Name: Reserva id_reserva; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reserva" ALTER COLUMN id_reserva SET DEFAULT nextval('public."Reserva_id_reserva_seq"'::regclass);


--
-- TOC entry 3190 (class 2604 OID 16530)
-- Name: Socio id_socio; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Socio" ALTER COLUMN id_socio SET DEFAULT nextval('public."Socio_id_socio_seq"'::regclass);


--
-- TOC entry 3191 (class 2604 OID 16539)
-- Name: Tema id_tema; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema" ALTER COLUMN id_tema SET DEFAULT nextval('public."Tema_id_tema_seq"'::regclass);


--
-- TOC entry 3346 (class 0 OID 16511)
-- Dependencies: 215
-- Data for Name: Libro; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Libro" (id_libro, titulo, autor, ejemplares, id_tema) VALUES (1, 'Cien Años de Soledad', 'Gabriel García Márquez', 4, 1);
INSERT INTO public."Libro" (id_libro, titulo, autor, ejemplares, id_tema) VALUES (2, 'Cuentos Completos', 'Edgar Allan Poe', 12, 2);


--
-- TOC entry 3348 (class 0 OID 16520)
-- Dependencies: 217
-- Data for Name: Reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Reserva" (id_reserva, "Libro_id_libro", "Socio_id_socio", fecha_prestamo, fecha_devolucion) VALUES (1, 1, 1, '2023-05-03', '2023-05-10');
INSERT INTO public."Reserva" (id_reserva, "Libro_id_libro", "Socio_id_socio", fecha_prestamo, fecha_devolucion) VALUES (2, 2, 2, '2023-04-20', '2023-05-03');


--
-- TOC entry 3350 (class 0 OID 16527)
-- Dependencies: 219
-- Data for Name: Socio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Socio" (id_socio, nombre) VALUES (1, 'Pepe');
INSERT INTO public."Socio" (id_socio, nombre) VALUES (2, 'María');


--
-- TOC entry 3352 (class 0 OID 16536)
-- Dependencies: 221
-- Data for Name: Tema; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tema" (id_tema, tipo) VALUES (1, 'Ficción');
INSERT INTO public."Tema" (id_tema, tipo) VALUES (2, 'Misterio');


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 214
-- Name: Libro_id_libro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Libro_id_libro_seq"', 2, true);


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 216
-- Name: Reserva_id_reserva_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Reserva_id_reserva_seq"', 2, true);


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 218
-- Name: Socio_id_socio_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Socio_id_socio_seq"', 2, true);


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 220
-- Name: Tema_id_tema_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Tema_id_tema_seq"', 2, true);


--
-- TOC entry 3193 (class 2606 OID 16518)
-- Name: Libro Libro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Libro"
    ADD CONSTRAINT "Libro_pkey" PRIMARY KEY (id_libro);


--
-- TOC entry 3195 (class 2606 OID 16525)
-- Name: Reserva Reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT "Reserva_pkey" PRIMARY KEY (id_reserva);


--
-- TOC entry 3197 (class 2606 OID 16534)
-- Name: Socio Socio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Socio"
    ADD CONSTRAINT "Socio_pkey" PRIMARY KEY (id_socio);


--
-- TOC entry 3199 (class 2606 OID 16543)
-- Name: Tema Tema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tema"
    ADD CONSTRAINT "Tema_pkey" PRIMARY KEY (id_tema);


--
-- TOC entry 3200 (class 2606 OID 16544)
-- Name: Libro fk_id_tema; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Libro"
    ADD CONSTRAINT fk_id_tema FOREIGN KEY (id_tema) REFERENCES public."Tema"(id_tema) NOT VALID;


--
-- TOC entry 3201 (class 2606 OID 16549)
-- Name: Reserva fk_libro_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT fk_libro_id FOREIGN KEY ("Libro_id_libro") REFERENCES public."Libro"(id_libro) NOT VALID;


--
-- TOC entry 3202 (class 2606 OID 16554)
-- Name: Reserva fk_socio_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Reserva"
    ADD CONSTRAINT fk_socio_id FOREIGN KEY ("Socio_id_socio") REFERENCES public."Socio"(id_socio) NOT VALID;


-- Completed on 2023-05-03 16:59:24

--
-- PostgreSQL database dump complete
--

