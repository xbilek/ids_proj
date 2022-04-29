DROP TABLE  "kniha_rezervace";
DROP TABLE  "kniha_vypujcka";
DROP TABLE  "rezervace";
DROP TABLE  "vypujcka";
DROP TABLE  "kniha";
DROP TABLE  "titul";
DROP TABLE "zamestnanec";
DROP TABLE "ctenar";
DROP SEQUENCE "kniha_sekvence";

CREATE TABLE "titul"
(
    "id" INT PRIMARY KEY,
    "nazev" VARCHAR(255) NOT NULL ,
    "autor" VARCHAR(255) NOT NULL ,
    "ilustrator" VARCHAR(255) NOT NULL ,
    "nakladatelstvi" VARCHAR(255) NOT NULL ,
    "rok_vydani" VARCHAR(255) NOT NULL ,
    "zanr" VARCHAR(255) NOT NULL ,
    "druh" VARCHAR(255) NOT NULL
);

CREATE TABLE "zamestnanec"
(
    "id" INT PRIMARY KEY,
    "jmeno" VARCHAR(255) NOT NULL ,
    "prijmeni" VARCHAR(255) NOT NULL ,
    "datum_narozeni" DATE NOT NULL ,
    "email" VARCHAR(255) NOT NULL
		CHECK(REGEXP_LIKE(
			"email", '^[a-z]+[a-z0-9\.]*@[a-z0-9\.-]+\.[a-z]{2,}$', 'i'
		)),
    "telefon" INT NOT NULL ,
    "datum_nastupu"  DATE NOT NULL ,
    "datum_vypovedi" DATE DEFAULT NULL ,
    "pojistovna"     VARCHAR(255) NOT NULL ,
    "platebni udaje" VARCHAR(255) NOT NULL
);

CREATE TABLE "ctenar"
(
    "id" INT PRIMARY KEY,
    "jmeno" VARCHAR(255) NOT NULL ,
    "prijmeni" VARCHAR(255) NOT NULL ,
    "datum_narozeni" DATE NOT NULL ,
    "email" VARCHAR(255) NOT NULL
		CHECK(REGEXP_LIKE(
			"email", '^[a-z]+[a-z0-9\.]*@[a-z0-9\.-]+\.[a-z]{2,}$', 'i'
		)),
    "telefon" INT NOT NULL ,
    "datum_registrace" DATE NOT NULL ,
    "platnost_prukazu_do" DATE NOT NULL
);

CREATE TABLE "rezervace"
(
    "id" INT PRIMARY KEY,
    "datum_vytvoreni" DATE,
    "datum_platnosti_od" DATE,
    "datum_platnosti_do" DATE,
    "zamestnanec_id" INT DEFAULT NULL,
    "ctenar_id" INT DEFAULT NULL,
    CONSTRAINT "rezervace_zamestnanec_id_fk"
		FOREIGN KEY ("zamestnanec_id") REFERENCES "zamestnanec" ("id"),
    CONSTRAINT "rezervace_ctenar_id_fk"
		FOREIGN KEY ("ctenar_id") REFERENCES "ctenar" ("id")
            ON DELETE CASCADE
);

CREATE TABLE "vypujcka"
(
    "id" INT PRIMARY KEY,
    "datum_vypujceni" DATE,
    "vratit_do" DATE,
    "datum_vraceni" DATE,
    "zamestnanec_id" INT DEFAULT NULL,
    "ctenar_id" INT DEFAULT NULL,
    CONSTRAINT "vypujcka_zamestnanec_id_fk"
		FOREIGN KEY ("zamestnanec_id") REFERENCES "zamestnanec" ("id"),
    CONSTRAINT "vypujcka_ctenar_id_fk"
		FOREIGN KEY ("ctenar_id") REFERENCES "ctenar" ("id")
);


CREATE TABLE "kniha"
(
    "id" INT PRIMARY KEY,
    "stav" VARCHAR(255),
    "datum_porizeni" DATE,
    "cena" INT,
    "titul_id" INT DEFAULT NULL,
    CONSTRAINT "kniha_titul_id_fk"
        FOREIGN KEY ("titul_id") REFERENCES "titul" ("id")
);



CREATE TABLE "kniha_rezervace"
(
    "kniha_id"     INT NOT NULL,
    "rezervace_id" INT NOT NULL,
    CONSTRAINT "kniha_rezervace_pk"
        PRIMARY KEY ("kniha_id", "rezervace_id"),
    CONSTRAINT "kniha_rezervace_kniha_id_fk"
        FOREIGN KEY ("kniha_id") REFERENCES "kniha" ("id"),
    CONSTRAINT "kniha_rezervace_rezervace_id_fk"
        FOREIGN KEY ("rezervace_id") REFERENCES "rezervace" ("id")
);

CREATE TABLE "kniha_vypujcka" (
	"kniha_id" INT NOT NULL,
	"vypujcka_id" INT NOT NULL,
	CONSTRAINT "kniha_vypujcka_pk"
		PRIMARY KEY ("kniha_id", "vypujcka_id"),
	CONSTRAINT "kniha_vypujcka_kniha_id_fk"
		FOREIGN KEY ("kniha_id") REFERENCES "kniha" ("id"),
	CONSTRAINT "kniha_vypujcka_vypujcka_id_fk"
		FOREIGN KEY ("vypujcka_id") REFERENCES "vypujcka" ("id")
);

CREATE SEQUENCE "kniha_sekvence" START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE OR REPLACE TRIGGER kniha_sekvence_trigger
    BEFORE INSERT ON "kniha"
    FOR EACH ROW
        WHEN (new."id" is NULL)
    BEGIN
        :new."id" := "kniha_sekvence".nextval;
    END;



INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0001','Alex','Syrovy',TO_DATE('1972-07-30', 'yyyy/mm/dd'),'xmarek75@vutbr.cz','123456789',TO_DATE('1992-07-30', 'yyyy/mm/dd'),TO_DATE('2022-04-03', 'yyyy/mm/dd'),'vzp','6595 8596 7485 9658');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0002','Pavel','Marek',TO_DATE('1973-08-30', 'yyyy/mm/dd'),'ahoj75@seznam.cz','159878236',TO_DATE('1999-01-01', 'yyyy/mm/dd'),NULL,'vzp','6500 8986 1111 2222');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0003','Jan','Novak',TO_DATE('1974-01-30', 'yyyy/mm/dd'),'jannovak@seznam.cz','123489126',TO_DATE('1985-03-09', 'yyyy/mm/dd'),NULL,'vzp','5565 3695 3333 1478');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0004','Peter','Brown',TO_DATE('1975-11-12', 'yyyy/mm/dd'),'peterzav@inacseznam.cz','852963741',TO_DATE('1995-02-14', 'yyyy/mm/dd'),TO_DATE('1995-05-01', 'yyyy/mm/dd'),'uzp','3691 1254 1234 1414');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0005','Jenda','Janega',TO_DATE('1976-11-12', 'yyyy/mm/dd'),'jenda@inacseznam.cz','952963741',TO_DATE('1995-02-10', 'yyyy/mm/dd'),TO_DATE('2000-05-01', 'yyyy/mm/dd'),'uzp','1691 1252 1234 1414');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0006','Rick','Sanchez',TO_DATE('1950-11-12', 'yyyy/mm/dd'),'citadela@inacseznam.cz','952963551',TO_DATE('2000-02-10', 'yyyy/mm/dd'), NULL,'alianz','1691 1250 1734 1415');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0007','Elon','Tusk',TO_DATE('1970-11-12', 'yyyy/mm/dd'),'tusk@twitter.com','952113551',TO_DATE('2010-02-10', 'yyyy/mm/dd'), NULL, 'zpmv','9691 1251 1434 1415');
INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0008','Ales','Bejr',TO_DATE('1975-10-12', 'yyyy/mm/dd'),'silenec@bejr.com','912313551',TO_DATE('2011-02-10', 'yyyy/mm/dd'), NULL, 'nepojistitelny','9691 1250 1434 4415');


INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1111','Harry Potter 1','J. K. Rowling','Alfonz Mucha','Albatros','2001','fantasy','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1112','My deti ze stanice ZOO','CH. V. Felscherinow','Adolf Schnitzel','IDontKnow','2005','thriller','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1113','Maly princ',' Antoine de Saint-Exupéry','Petr Svestka','IDontKnow','2000','filozoficka pohadka','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1114','Farma zvirat','George Orwell','Honza Tresnicka','WhoKnows','2010','autopicky roman','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1115','1948','George Orwell','Honza Tresnicka','WhoKnows','1999','roman','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1116','Staré pověsti české','Alois Jirásek','Věnceslav Černý','Albatros','2003','povesti','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1117','Oliver Twist','Charles Dickens','Milan Jaroš','Odeon','1966','roman','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1118','Kytice','Karel Jaromír Erben','Jiří Arbe Miňovský','Omega','2014','povesti','epika');
INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1119','Hamlet','William Shakespeare','Josef Šíma','Československý spisovatel','1981','Divadelni hry','epika');

INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES (9999,'poskozeny obal',TO_DATE('2015-10-03', 'yyyy/mm/dd'),'199','1111');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9990','perfektni',TO_DATE('2020-08-05', 'yyyy/mm/dd'),'499','1112');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9991','obal je mirne osoupany',TO_DATE('2010-11-11', 'yyyy/mm/dd'),'159','1113');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9992' ,'pokrcene rohy stranek',TO_DATE('2014-05-01', 'yyyy/mm/dd'),'259','1114');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES (NULL ,'super',TO_DATE('2013-05-01', 'yyyy/mm/dd'),'259','1114');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES (NULL ,'nic moc',TO_DATE('2013-05-01', 'yyyy/mm/dd'),'259','1114');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9993' ,'8/10',TO_DATE('2020-05-05', 'yyyy/mm/dd'),'239','1114');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9994','10/10',TO_DATE('2022-03-03', 'yyyy/mm/dd'),'269','1114');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9995' ,'9/10',TO_DATE('2021-04-01', 'yyyy/mm/dd'),'329','1115');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9996','8/10',TO_DATE('2020-03-18', 'yyyy/mm/dd'),'309','1115');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9997' ,'5/10',TO_DATE('2018-01-01', 'yyyy/mm/dd'),'309','1116');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('9998','7/10',TO_DATE('2019-02-10', 'yyyy/mm/dd'),'359','1116');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10005' ,'8/10',TO_DATE('2020-10-01', 'yyyy/mm/dd'),'300','1117');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10000','8/10',TO_DATE('2020-10-01', 'yyyy/mm/dd'),'300','1117');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10001' ,'9/10',TO_DATE('2022-02-01', 'yyyy/mm/dd'),'380','1118');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10002','10/10',TO_DATE('2022-02-01', 'yyyy/mm/dd'),'410','1118');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10003' ,'9/10',TO_DATE('2010-02-01', 'yyyy/mm/dd'),'589','1119');
INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena", "titul_id")
VALUES ('10004','10/10',TO_DATE('2010-08-01', 'yyyy/mm/dd'),'649','1119');


INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2222','Jan','Novotny',TO_DATE('2000-07-30', 'yyyy/mm/dd'),'nic@seznam.cz','123123123',TO_DATE('2015-10-03', 'yyyy/mm/dd'),TO_DATE('2022-09-30', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2223','Ondrej','Maly',TO_DATE('2001-08-30', 'yyyy/mm/dd'),'neco@seznam.cz','123456456',TO_DATE('2015-08-03', 'yyyy/mm/dd'),TO_DATE('2022-10-15', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2224','Pavel','Velky',TO_DATE('2002-09-15', 'yyyy/mm/dd'),'hodneneco@seznam.cz','123789789',TO_DATE('2012-09-05', 'yyyy/mm/dd'),TO_DATE('2022-05-09', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2225','Josef','Siroky',TO_DATE('2003-10-12', 'yyyy/mm/dd'),'nicneco@seznam.cz','123159159',TO_DATE('2016-11-02', 'yyyy/mm/dd'),TO_DATE('2022-02-02', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2226','Morty','Smith',TO_DATE('2001-10-12', 'yyyy/mm/dd'),'morty@ohjeez.cz','125559159',TO_DATE('2016-11-05', 'yyyy/mm/dd'),TO_DATE('2022-02-03', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2227','Adam','Novak',TO_DATE('2001-01-01', 'yyyy/mm/dd'),'adam@seznam.cz','123153339',TO_DATE('2016-05-02', 'yyyy/mm/dd'),TO_DATE('2022-01-02', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2228','Josef','Uzky',TO_DATE('2003-10-12', 'yyyy/mm/dd'),'pepik@seznam.cz','121159159',TO_DATE('2017-11-02', 'yyyy/mm/dd'),TO_DATE('2023-02-02', 'yyyy/mm/dd'));
INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2229','Josef','Lada',TO_DATE('1920-10-12', 'yyyy/mm/dd'),'bajky@seznam.cz','723159159',TO_DATE('2018-11-02', 'yyyy/mm/dd'),TO_DATE('2023-01-01', 'yyyy/mm/dd'));


INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1234',TO_DATE('2020-07-30', 'yyyy/mm/dd'),TO_DATE('2020-10-30', 'yyyy/mm/dd'),TO_DATE('2020-09-30', 'yyyy/mm/dd'),'0001','2222');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1235',TO_DATE('2020-08-03', 'yyyy/mm/dd'),TO_DATE('2020-10-03', 'yyyy/mm/dd'),TO_DATE('2020-10-02', 'yyyy/mm/dd'),'0002','2223');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1236',TO_DATE('2020-02-15', 'yyyy/mm/dd'),TO_DATE('2020-04-15', 'yyyy/mm/dd'),TO_DATE('2020-03-15', 'yyyy/mm/dd'),'0003','2224');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1237',TO_DATE('2020-02-20', 'yyyy/mm/dd'),TO_DATE('2020-04-16', 'yyyy/mm/dd'),TO_DATE('2020-03-15', 'yyyy/mm/dd'),'0001','2224');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1238',TO_DATE('2019-02-20', 'yyyy/mm/dd'),TO_DATE('2022-04-16', 'yyyy/mm/dd'),TO_DATE('2021-03-15', 'yyyy/mm/dd'),'0005','2229');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1239',TO_DATE('2020-02-21', 'yyyy/mm/dd'),TO_DATE('2020-04-17', 'yyyy/mm/dd'),TO_DATE('2020-03-15', 'yyyy/mm/dd'),'0004','2227');
INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1240',TO_DATE('2015-02-20', 'yyyy/mm/dd'),TO_DATE('2020-04-16', 'yyyy/mm/dd'),TO_DATE('2020-03-25', 'yyyy/mm/dd'),'0001','2225');

INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('9999','1234');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('9990','1235');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('9991','1236');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('10000','1237');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('10001','1238');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('10002','1239');
INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('10005','1240');

INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8001',TO_DATE('2022-01-15', 'yyyy/mm/dd'),TO_DATE('2022-01-29', 'yyyy/mm/dd'),TO_DATE('2020-02-13', 'yyyy/mm/dd'),'0001','2225') ;
INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8002',TO_DATE('2020-02-10', 'yyyy/mm/dd'),TO_DATE('2020-02-10', 'yyyy/mm/dd'),TO_DATE('2020-04-10', 'yyyy/mm/dd'),'0002','2222') ;
INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8003',TO_DATE('2020-04-09', 'yyyy/mm/dd'),TO_DATE('2020-04-15', 'yyyy/mm/dd'),TO_DATE('2020-06-15', 'yyyy/mm/dd'),'0003','2223') ;
INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8004',TO_DATE('2020-05-08', 'yyyy/mm/dd'),TO_DATE('2020-05-30', 'yyyy/mm/dd'),TO_DATE('2020-07-30', 'yyyy/mm/dd'),'0004','2224') ;
INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8005',TO_DATE('2020-05-10', 'yyyy/mm/dd'),TO_DATE('2020-05-30', 'yyyy/mm/dd'),TO_DATE('2020-07-30', 'yyyy/mm/dd'),'0004','2224') ;
INSERT INTO "rezervace" ("id", "datum_vytvoreni", "datum_platnosti_od", "datum_platnosti_do", "zamestnanec_id", "ctenar_id")
VALUES ('8006',TO_DATE('2020-05-10', 'yyyy/mm/dd'),TO_DATE('2020-05-30', 'yyyy/mm/dd'),TO_DATE('2020-07-30', 'yyyy/mm/dd'),'0004','2225') ;

INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('9999','8001');
INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('9998','8002');
INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('9997','8003');
INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('9996','8004');
INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('9999','8005');
INSERT INTO "kniha_rezervace" ("kniha_id", "rezervace_id")
VALUES ('10000','8006');


SELECT * FROM "titul";
SELECT * FROM "kniha";
SELECT * FROM "titul" JOIN "kniha" ON "titul"."id" = "kniha"."titul_id";


