--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2024-11-05 18:59:53

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
-- TOC entry 216 (class 1259 OID 174004)
-- Name: timovi_json; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.timovi_json (
    tim_id integer NOT NULL,
    podaci jsonb
);


ALTER TABLE public.timovi_json OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 174011)
-- Name: igraci_razdvojeni; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.igraci_razdvojeni AS
 SELECT t.tim_id,
    (t.podaci ->> 'Naziv'::text) AS naziv,
    (t.podaci ->> 'Skracenica'::text) AS skracenica,
    (t.podaci ->> 'Godina_osnutka'::text) AS godina_osnutka,
    (t.podaci ->> 'Esport'::text) AS esport,
    (t.podaci ->> 'Broj_trofeja'::text) AS broj_trofeja,
    (t.podaci ->> 'Drzava'::text) AS drzava,
    (t.podaci ->> 'Pobjede2023'::text) AS pobjede2023,
    (t.podaci ->> 'Porazi2023'::text) AS porazi2023,
    (t.podaci ->> 'Regija'::text) AS regija,
    (t.podaci ->> 'Ukupna_zarada'::text) AS ukupna_zarada,
    (jsonb_igrac.value ->> 'Ime'::text) AS ime,
    (jsonb_igrac.value ->> 'Prezime'::text) AS prezime,
    (jsonb_igrac.value ->> 'Nickname'::text) AS nickname,
    (jsonb_igrac.value ->> 'Pozicija'::text) AS pozicija,
    (jsonb_igrac.value ->> 'Godina_prikljucenja'::text) AS godina_prikljucenja
   FROM public.timovi_json t,
    LATERAL jsonb_array_elements((t.podaci -> 'Igraci'::text)) jsonb_igrac(value);


ALTER TABLE public.igraci_razdvojeni OWNER TO postgres;

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
-- TOC entry 3335 (class 0 OID 165921)
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
-- TOC entry 3334 (class 0 OID 165914)
-- Dependencies: 214
-- Data for Name: tim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tim (tim_id, naziv, skracenica, godina_osnutka, esport, broj_trofeja, drzava, pobjede2023, porazi2023, regija, ukupna_zarada) FROM stdin;
1	T1	T1	2003	League of Legends	10	Južna Koreja	96	56	LCK	9418521.00
2	JD Gaming	JDG	2017	League of Legends	5	Kina	95	30	LPL	2341588.00
3	Gen.G	GEN	2017	League of Legends	3	Južna Koreja	95	38	LCK	1943449.00
4	Bilibili Gaming	BLG	2017	League of Legends	2	Kina	100	60	LPL	1442683.00
5	G2 Esports	G2	2014	League of Legends	9	Europa	68	32	LEC	3603017.00
6	Fnatic	FNC	2004	League of Legends	7	Europa	37	38	LEC	3480526.00
7	FlyQuest	FLY	2017	League of Legends	1	SAD	25	23	LCS	497450.00
8	Cloud9	C9	2013	League of Legends	6	SAD	50	25	LCS	2662341.00
9	Sentinels	SEN	2020	Valorant	3	SAD	37	30	NA	2500000.00
10	Moist Esports	MOIST	2021	Rocket League	2	SAD	16	14	EU	440880.00
11	Natus Vincere	NaVi	2009	CS:GO	11	Ukrajina	74	56	EU	9483067.00
\.


--
-- TOC entry 3336 (class 0 OID 174004)
-- Dependencies: 216
-- Data for Name: timovi_json; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timovi_json (tim_id, podaci) FROM stdin;
1	{"Naziv": "T1", "Drzava": "Južna Koreja", "Esport": "League of Legends", "Igraci": [{"Ime": "Lee", "Prezime": "Sang-hyeok", "Nickname": "Faker", "Pozicija": "Mid", "Godina_prikljucenja": 2013}, {"Ime": "Ryu", "Prezime": "Min-seok", "Nickname": "Zeus", "Pozicija": "Top", "Godina_prikljucenja": 2021}, {"Ime": "Moon", "Prezime": "Hyeon-jun", "Nickname": "Oner", "Pozicija": "Jungle", "Godina_prikljucenja": 2021}, {"Ime": "Lee", "Prezime": "Min-hyung", "Nickname": "Gumayusi", "Pozicija": "ADC", "Godina_prikljucenja": 2020}, {"Ime": "Ryu", "Prezime": "Min-seong", "Nickname": "Keria", "Pozicija": "Support", "Godina_prikljucenja": 2020}], "Regija": "LCK", "Porazi2023": 56, "Skracenica": "T1", "Pobjede2023": 96, "Broj_trofeja": 10, "Ukupna_zarada": 9418521.00, "Godina_osnutka": 2003}
2	{"Naziv": "JD Gaming", "Drzava": "Kina", "Esport": "League of Legends", "Igraci": [{"Ime": "Seo", "Prezime": "Jin-hyeok", "Nickname": "Kanavi", "Pozicija": "Jungle", "Godina_prikljucenja": 2020}, {"Ime": "Zhuo", "Prezime": "Ding", "Nickname": "Knight", "Pozicija": "Mid", "Godina_prikljucenja": 2023}, {"Ime": "Park", "Prezime": "Jae-hyuk", "Nickname": "Ruler", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Bai", "Prezime": "Jiahao", "Nickname": "369", "Pozicija": "Top", "Godina_prikljucenja": 2021}, {"Ime": "Lou", "Prezime": "Yunfeng", "Nickname": "Missing", "Pozicija": "Support", "Godina_prikljucenja": 2023}], "Regija": "LPL", "Porazi2023": 30, "Skracenica": "JDG", "Pobjede2023": 95, "Broj_trofeja": 5, "Ukupna_zarada": 2341588.00, "Godina_osnutka": 2017}
3	{"Naziv": "Gen.G", "Drzava": "Južna Koreja", "Esport": "League of Legends", "Igraci": [{"Ime": "Han", "Prezime": "Wang-ho", "Nickname": "Peanut", "Pozicija": "Jungle", "Godina_prikljucenja": 2020}, {"Ime": "Jeong", "Prezime": "Ji-hoon", "Nickname": "Chovy", "Pozicija": "Mid", "Godina_prikljucenja": 2021}, {"Ime": "Park", "Prezime": "Joon-young", "Nickname": "Doran", "Pozicija": "Top", "Godina_prikljucenja": 2021}, {"Ime": "Kim", "Prezime": "Tae-min", "Nickname": "Peyz", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Yoo", "Prezime": "Min-seok", "Nickname": "Delight", "Pozicija": "Support", "Godina_prikljucenja": 2023}], "Regija": "LCK", "Porazi2023": 38, "Skracenica": "GEN", "Pobjede2023": 95, "Broj_trofeja": 3, "Ukupna_zarada": 1943449.00, "Godina_osnutka": 2017}
4	{"Naziv": "Bilibili Gaming", "Drzava": "Kina", "Esport": "League of Legends", "Igraci": [{"Ime": "Chen", "Prezime": "Ze-Bin", "Nickname": "Bin", "Pozicija": "Top", "Godina_prikljucenja": 2023}, {"Ime": "Peng", "Prezime": "Zhen-Ming", "Nickname": "Xun", "Pozicija": "Jungle", "Godina_prikljucenja": 2021}, {"Ime": "Zeng", "Prezime": "Qi", "Nickname": "Yagao", "Pozicija": "Mid", "Godina_prikljucenja": 2021}, {"Ime": "Elk", "Prezime": "", "Nickname": "Elk", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Liu", "Prezime": "Shi-Yu", "Nickname": "On", "Pozicija": "Support", "Godina_prikljucenja": 2021}], "Regija": "LPL", "Porazi2023": 60, "Skracenica": "BLG", "Pobjede2023": 100, "Broj_trofeja": 2, "Ukupna_zarada": 1442683.00, "Godina_osnutka": 2017}
5	{"Naziv": "G2 Esports", "Drzava": "Europa", "Esport": "League of Legends", "Igraci": [{"Ime": "Sergen", "Prezime": "Çelik", "Nickname": "BrokenBlade", "Pozicija": "Top", "Godina_prikljucenja": 2021}, {"Ime": "Martin", "Prezime": "Hansen", "Nickname": "Yike", "Pozicija": "Jungle", "Godina_prikljucenja": 2023}, {"Ime": "Rasmus", "Prezime": "Winther", "Nickname": "Caps", "Pozicija": "Mid", "Godina_prikljucenja": 2018}, {"Ime": "Steven", "Prezime": "Liv", "Nickname": "Hans sama", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Mihael", "Prezime": "Mehle", "Nickname": "Mikyx", "Pozicija": "Support", "Godina_prikljucenja": 2023}], "Regija": "LEC", "Porazi2023": 32, "Skracenica": "G2", "Pobjede2023": 68, "Broj_trofeja": 9, "Ukupna_zarada": 3603017.00, "Godina_osnutka": 2014}
6	{"Naziv": "Fnatic", "Drzava": "Europa", "Esport": "League of Legends", "Igraci": [{"Ime": "Óscar", "Prezime": "Muñoz", "Nickname": "Oscarinin", "Pozicija": "Top", "Godina_prikljucenja": 2023}, {"Ime": "Iván", "Prezime": "Martín", "Nickname": "Razork", "Pozicija": "Jungle", "Godina_prikljucenja": 2022}, {"Ime": "Marek", "Prezime": "Brázda", "Nickname": "Humanoid", "Pozicija": "Mid", "Godina_prikljucenja": 2022}, {"Ime": "Carl", "Prezime": "Martin", "Nickname": "Rekkles", "Pozicija": "ADC", "Godina_prikljucenja": 2015}, {"Ime": "Adrian", "Prezime": "Trybus", "Nickname": "Trymbi", "Pozicija": "Support", "Godina_prikljucenja": 2023}], "Regija": "LEC", "Porazi2023": 38, "Skracenica": "FNC", "Pobjede2023": 37, "Broj_trofeja": 7, "Ukupna_zarada": 3480526.00, "Godina_osnutka": 2004}
7	{"Naziv": "FlyQuest", "Drzava": "SAD", "Esport": "League of Legends", "Igraci": [{"Ime": "Jeong", "Prezime": "Ho-bin", "Nickname": "Impact", "Pozicija": "Top", "Godina_prikljucenja": 2023}, {"Ime": "Lucas", "Prezime": "Tao", "Nickname": "Santorin", "Pozicija": "Jungle", "Godina_prikljucenja": 2023}, {"Ime": "Loïc", "Prezime": "Dubois", "Nickname": "Toucouille", "Pozicija": "Mid", "Godina_prikljucenja": 2022}, {"Ime": "Bae", "Prezime": "Ho-min", "Nickname": "Prince", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Kim", "Prezime": "Dong-wook", "Nickname": "Winsome", "Pozicija": "Support", "Godina_prikljucenja": 2023}], "Regija": "LCS", "Porazi2023": 23, "Skracenica": "FLY", "Pobjede2023": 25, "Broj_trofeja": 1, "Ukupna_zarada": 497450.00, "Godina_osnutka": 2017}
8	{"Naziv": "Cloud9", "Drzava": "SAD", "Esport": "League of Legends", "Igraci": [{"Ime": "Ibrahim", "Prezime": "Allami", "Nickname": "Fudge", "Pozicija": "Top", "Godina_prikljucenja": 2021}, {"Ime": "Robert", "Prezime": "Huang", "Nickname": "Blaber", "Pozicija": "Jungle", "Godina_prikljucenja": 2020}, {"Ime": "Jiang", "Prezime": "Tao", "Nickname": "Diplex", "Pozicija": "Mid", "Godina_prikljucenja": 2023}, {"Ime": "Kim", "Prezime": "Min-cheol", "Nickname": "Berserker", "Pozicija": "ADC", "Godina_prikljucenja": 2023}, {"Ime": "Jesper", "Prezime": "Svenningsen", "Nickname": "Zven", "Pozicija": "Support", "Godina_prikljucenja": 2022}], "Regija": "LCS", "Porazi2023": 25, "Skracenica": "C9", "Pobjede2023": 50, "Broj_trofeja": 6, "Ukupna_zarada": 2662341.00, "Godina_osnutka": 2013}
9	{"Naziv": "Sentinels", "Drzava": "SAD", "Esport": "Valorant", "Igraci": [{"Ime": "Hunter", "Prezime": "Mims", "Nickname": "SicK", "Pozicija": "Flex", "Godina_prikljucenja": 2020}, {"Ime": "Jared", "Prezime": "Gitlin", "Nickname": "zombs", "Pozicija": "Controller", "Godina_prikljucenja": 2020}, {"Ime": "Shahzeeb", "Prezime": "Khan", "Nickname": "ShahZaM", "Pozicija": "In-game Leader", "Godina_prikljucenja": 2020}, {"Ime": "Tyson", "Prezime": "Ngo", "Nickname": "TenZ", "Pozicija": "Duelist", "Godina_prikljucenja": 2021}, {"Ime": "Michael", "Prezime": "Grzesiek", "Nickname": "shroud", "Pozicija": "Flex", "Godina_prikljucenja": 2022}], "Regija": "NA", "Porazi2023": 30, "Skracenica": "SEN", "Pobjede2023": 37, "Broj_trofeja": 3, "Ukupna_zarada": 2500000.00, "Godina_osnutka": 2020}
10	{"Naziv": "Moist Esports", "Drzava": "SAD", "Esport": "Rocket League", "Igraci": [{"Ime": "Joris", "Prezime": "Robben", "Nickname": "Joyo", "Pozicija": "Striker", "Godina_prikljucenja": 2022}, {"Ime": "Finlay", "Prezime": "Ferguson", "Nickname": "Rise", "Pozicija": "Midfielder", "Godina_prikljucenja": 2022}, {"Ime": "Axel", "Prezime": "Lopez", "Nickname": "Astro", "Pozicija": "Defender", "Godina_prikljucenja": 2023}], "Regija": "EU", "Porazi2023": 14, "Skracenica": "MOIST", "Pobjede2023": 16, "Broj_trofeja": 2, "Ukupna_zarada": 440880.00, "Godina_osnutka": 2021}
11	{"Naziv": "Natus Vincere", "Drzava": "Ukrajina", "Esport": "CS:GO", "Igraci": [{"Ime": "Oleksandr", "Prezime": "Kostyliev", "Nickname": "s1mple", "Pozicija": "AWPer", "Godina_prikljucenja": 2016}, {"Ime": "Denis", "Prezime": "Sharipov", "Nickname": "electroNic", "Pozicija": "Rifler", "Godina_prikljucenja": 2017}, {"Ime": "Ilya", "Prezime": "Zalutskiy", "Nickname": "Perfecto", "Pozicija": "Support", "Godina_prikljucenja": 2020}, {"Ime": "Andrii", "Prezime": "Kukharskyi", "Nickname": "npl", "Pozicija": "Entry Fragger", "Godina_prikljucenja": 2023}, {"Ime": "Valerii", "Prezime": "Vakhovskyi", "Nickname": "b1t", "Pozicija": "Rifler", "Godina_prikljucenja": 2021}], "Regija": "EU", "Porazi2023": 56, "Skracenica": "NaVi", "Pobjede2023": 74, "Broj_trofeja": 11, "Ukupna_zarada": 9483067.00, "Godina_osnutka": 2009}
\.


--
-- TOC entry 3187 (class 2606 OID 165925)
-- Name: igraci igraci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.igraci
    ADD CONSTRAINT igraci_pkey PRIMARY KEY (igrac_id);


--
-- TOC entry 3185 (class 2606 OID 165920)
-- Name: tim tim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tim
    ADD CONSTRAINT tim_pkey PRIMARY KEY (tim_id);


--
-- TOC entry 3189 (class 2606 OID 174010)
-- Name: timovi_json timovi_json_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.timovi_json
    ADD CONSTRAINT timovi_json_pkey PRIMARY KEY (tim_id);


--
-- TOC entry 3190 (class 2606 OID 165926)
-- Name: igraci igraci_tim_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.igraci
    ADD CONSTRAINT igraci_tim_id_fkey FOREIGN KEY (tim_id) REFERENCES public.tim(tim_id);


-- Completed on 2024-11-05 18:59:54

--
-- PostgreSQL database dump complete
--

