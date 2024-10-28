--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2024-10-28 01:10:06

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
-- TOC entry 215 (class 1259 OID 165921)
-- Name: igraci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.igraci (
    igrac_id integer NOT NULL,
    puno_ime character varying(255) NOT NULL,
    nickname character varying(100),
    pozicija character varying(100),
    godina_prikljucenja integer,
    tim_id integer
);


ALTER TABLE public.igraci OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 165914)
-- Name: tim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tim (
    tim_id integer NOT NULL,
    naziv character varying(255) NOT NULL,
    skracenica character varying(50),
    godina_osnutka integer,
    esport character varying(100),
    broj_trofeja integer,
    drzava character varying(100),
    pobjede2023 integer,
    porazi2023 integer,
    regija character varying(50),
    ukupna_zarada numeric(15,2)
);


ALTER TABLE public.tim OWNER TO postgres;

--
-- TOC entry 3324 (class 0 OID 165921)
-- Dependencies: 215
-- Data for Name: igraci; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.igraci (igrac_id, puno_ime, nickname, pozicija, godina_prikljucenja, tim_id) FROM stdin;
1	Lee Sang-hyeok	Faker	Mid	2013	1
2	Ryu Min-seok	Zeus	Top	2021	1
3	Moon Hyeon-jun	Oner	Jungle	2021	1
4	Lee Min-hyung	Gumayusi	ADC	2020	1
5	Ryu Min-seong	Keria	Support	2020	1
6	Seo Jin-hyeok	Kanavi	Jungle	2020	2
7	Zhuo Ding	Knight	Mid	2023	2
8	Park Jae-hyuk	Ruler	ADC	2023	2
9	Bai Jiahao	369	Top	2021	2
10	Lou Yunfeng	Missing	Support	2023	2
11	Han Wang-ho	Peanut	Jungle	2020	3
12	Jeong Ji-hoon	Chovy	Mid	2021	3
13	Park Joon-young	Doran	Top	2021	3
14	Kim Tae-min	Peyz	ADC	2023	3
15	Yoo Min-seok	Delight	Support	2023	3
16	Chen Ze-Bin	Bin	Top	2023	4
17	Peng Zhen-Ming	Xun	Jungle	2021	4
18	Zeng Qi	Yagao	Mid	2021	4
19	Elk	Elk	ADC	2023	4
20	Liu Shi-Yu	On	Support	2021	4
21	Sergen Çelik	BrokenBlade	Top	2021	5
22	Martin Hansen	Yike	Jungle	2023	5
23	Rasmus Winther	Caps	Mid	2018	5
24	Steven Liv	Hans sama	ADC	2023	5
25	Mihael Mehle	Mikyx	Support	2023	5
26	Óscar Muñoz	Oscarinin	Top	2023	6
27	Iván Martín	Razork	Jungle	2022	6
28	Marek Brázda	Humanoid	Mid	2022	6
29	Carl Martin Erik Larsson	Rekkles	ADC	2015	6
30	Adrian Trybus	Trymbi	Support	2023	6
31	Jeong Ho-bin	Impact	Top	2023	7
32	Lucas Tao Kilmer Larsen	Santorin	Jungle	2023	7
33	Loïc Dubois	Toucouille	Mid	2022	7
34	Bae Ho-min	Prince	ADC	2023	7
35	Kim Dong-wook	Winsome	Support	2023	7
36	Ibrahim Allami	Fudge	Top	2021	8
37	Robert Huang	Blaber	Jungle	2020	8
38	Jiang Tao	Diplex	Mid	2023	8
39	Kim Min-cheol	Berserker	ADC	2023	8
40	Jesper Svenningsen	Zven	Support	2022	8
41	Hunter Mims	SicK	Flex	2020	9
42	Jared Gitlin	zombs	Controller	2020	9
43	Shahzeeb Khan	ShahZaM	In-game Leader	2020	9
44	Tyson Ngo	TenZ	Duelist	2021	9
45	Michael Grzesiek	shroud	Flex	2022	9
46	Joris Robben	Joyo	Striker	2022	10
47	Finlay Ferguson	Rise	Midfielder	2022	10
48	Axel Lopez	Astro	Defender	2023	10
49	Oleksandr Kostyliev	s1mple	AWPer	2016	11
50	Denis Sharipov	electroNic	Rifler	2017	11
51	Ilya Zalutskiy	Perfecto	Support	2020	11
52	Andrii Kukharskyi	npl	Entry Fragger	2023	11
53	Valerii Vakhovskyi	b1t	Rifler	2021	11
\.


--
-- TOC entry 3323 (class 0 OID 165914)
-- Dependencies: 214
-- Data for Name: tim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tim (tim_id, naziv, skracenica, godina_osnutka, esport, broj_trofeja, drzava, pobjede2023, porazi2023, regija, ukupna_zarada) FROM stdin;
1	T1	T1	2003	League of Legends	17	Južna Koreja	96	56	LCK	9418521.00
2	JD Gaming	JDG	2017	League of Legends	5	Kina	95	30	LPL	2341588.00
3	Gen.G	GEN	2017	League of Legends	5	Južna Koreja	95	38	LCK	1943449.00
4	Bilibili Gaming	BLG	2017	League of Legends	3	Kina	100	60	LPL	1442683.00
5	G2 Esports	G2	2014	League of Legends	18	Europa	68	32	LEC	3603017.00
6	Fnatic	FNC	2004	League of Legends	10	Europa	37	38	LEC	3480526.00
7	FlyQuest	FLY	2017	League of Legends	1	SAD	25	23	LCS	497450.00
8	Cloud9	C9	2013	League of Legends	6	SAD	50	25	LCS	2662341.00
9	Sentinels	SEN	2020	Valorant	3	SAD	37	30	NA	2500000.00
10	Moist Esports	MOIST	2021	Rocket League	2	SAD	16	14	EU	440880.00
11	Natus Vincere	NaVi	2009	CS:GO	11	Ukrajina	74	56	EU	9483067.00
\.


--
-- TOC entry 3179 (class 2606 OID 165925)
-- Name: igraci igraci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.igraci
    ADD CONSTRAINT igraci_pkey PRIMARY KEY (igrac_id);


--
-- TOC entry 3177 (class 2606 OID 165920)
-- Name: tim tim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tim
    ADD CONSTRAINT tim_pkey PRIMARY KEY (tim_id);


--
-- TOC entry 3180 (class 2606 OID 165926)
-- Name: igraci igraci_tim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.igraci
    ADD CONSTRAINT igraci_tim_id_fkey FOREIGN KEY (tim_id) REFERENCES public.tim(tim_id);


-- Completed on 2024-10-28 01:10:06

--
-- PostgreSQL database dump complete
--

