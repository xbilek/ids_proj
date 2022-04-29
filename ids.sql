-------------------------------- DROP ------------------------------------------


DROP TABLE "ticket_bug";
DROP TABLE "ticket";
DROP TABLE "module_bug";
DROP TABLE "module";
DROP TABLE "user_language";
DROP TABLE "language";
DROP TABLE "bug";
DROP TABLE "patch";
DROP TABLE "user";
DROP TABLE "programmer";
--------------------------------------------------
DROP TABLE  "kniha_rezervace";
DROP TABLE  "kniha_vypujcka";
DROP TABLE  "rezervace";
DROP TABLE  "vypujcka";
DROP TABLE  "kniha";
DROP TABLE  "titul";
DROP TABLE "zamestnanec";
DROP TABLE "ctenar";


-------------------------------- CREATE ----------------------------------------



CREATE TABLE "zamestnanec"
(
    "id" INT PRIMARY KEY,
    "jmeno" VARCHAR(255),
    "prijmeni" VARCHAR(255),
    "datum_narozeni" DATE,
    "email" VARCHAR(255),
    "telefon" INT,
    "datum_nastupu"  DATE,
    "datum_vypovedi" DATE,
    "pojistovna"     VARCHAR(255),
    "platebni udaje" VARCHAR(255)
);
CREATE TABLE "ctenar"
(
    "id" INT PRIMARY KEY,
    "jmeno" VARCHAR(255),
    "prijmeni" VARCHAR(255),
    "datum_narozeni" DATE,
    "email" VARCHAR(255),
    "telefon" INT,
    "datum_registrace" DATE,
    "platnost_prukazu_do" DATE
);
CREATE TABLE "titul"
(
    "id" INT PRIMARY KEY,
    "nazev" VARCHAR(255),
    "autor" VARCHAR(255),
    "ilustrator" VARCHAR(255),
    "nakladatelstvi" VARCHAR(255),
    "rok_vydani" VARCHAR(255),
    "zanr" VARCHAR(255),
    "druh" VARCHAR(255)
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
		FOREIGN KEY ("zamestnanec_id") REFERENCES "zamestnanec" ("id")
            ON DELETE CASCADE,
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
		FOREIGN KEY ("zamestnanec_id") REFERENCES "zamestnanec" ("id")
            ON DELETE SET NULL,
    CONSTRAINT "vypujcka_ctenar_id_fk"
		FOREIGN KEY ("ctenar_id") REFERENCES "ctenar" ("id")
            ON DELETE SET NULL
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
            ON DELETE SET NULL
);

CREATE TABLE "kniha_rezervace" (
	"kniha_id" INT NOT NULL,
	"rezervace_id" INT NOT NULL,
	CONSTRAINT "kniha_rezervace_pk"
		PRIMARY KEY ("kniha_id", "rezervace_id"),
	CONSTRAINT "kniha_rezervace_kniha_id_fk"
		FOREIGN KEY ("kniha_id") REFERENCES "kniha" ("id")
            ON DELETE CASCADE,
	CONSTRAINT "kniha_rezervace_rezervace_id_fk"
		FOREIGN KEY ("rezervace_id") REFERENCES "rezervace" ("id")
            ON DELETE CASCADE
);
CREATE TABLE "kniha_vypujcka" (
	"kniha_id" INT NOT NULL,
	"vypujcka_id" INT NOT NULL,
	CONSTRAINT "kniha_vypujcka_pk"
		PRIMARY KEY ("kniha_id", "vypujcka_id"),
	CONSTRAINT "kniha_vypujcka_kniha_id_fk"
		FOREIGN KEY ("kniha_id") REFERENCES "kniha" ("id")
            ON DELETE CASCADE,
	CONSTRAINT "kniha_vypujcka_vypujcka_id_fk"
		FOREIGN KEY ("vypujcka_id") REFERENCES "vypujcka" ("id")
            ON DELETE CASCADE
);


-------------------------------- INSERT ----------------------------------------

INSERT INTO "zamestnanec" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_nastupu", "datum_vypovedi", "pojistovna", "platebni udaje")
VALUES ('0001','Alex','Syrovy',TO_DATE('1972-07-30', 'yyyy/mm/dd'),'xmarek75@vutbr.cz','123456789',TO_DATE('1992-07-30', 'yyyy/mm/dd'),TO_DATE('1997-07-30', 'yyyy/mm/dd'),'vzp','6595 8596 7485 9658');

INSERT INTO "titul" ("id", "nazev", "autor", "ilustrator", "nakladatelstvi", "rok_vydani", "zanr", "druh")
VALUES ('1111','Harry Potter 1','J. K. Rowling','Alfonz Mucha','Albatros','2001','fantasy','beletrie');

INSERT INTO "kniha" ("id", "stav", "datum_porizeni", "cena")
VALUES ('9999','poskozeny obal',TO_DATE('2002-10-03', 'yyyy/mm/dd'),'199');

INSERT INTO "ctenar" ("id", "jmeno", "prijmeni", "datum_narozeni", "email", "telefon", "datum_registrace", "platnost_prukazu_do")
VALUES ('2222','Jan','Novotny',TO_DATE('2000-07-30', 'yyyy/mm/dd'),'nic@seznam.cz','123',TO_DATE('2015-10-03', 'yyyy/mm/dd'),TO_DATE('2022-09-30', 'yyyy/mm/dd'));

INSERT INTO "vypujcka" ("id", "datum_vypujceni", "vratit_do", "datum_vraceni", "zamestnanec_id", "ctenar_id")
VALUES ('1234',TO_DATE('2020-07-30', 'yyyy/mm/dd'),TO_DATE('2020-10-30', 'yyyy/mm/dd'),TO_DATE('2020-09-30', 'yyyy/mm/dd'),'0001','2222');

INSERT INTO "kniha_vypujcka" ("kniha_id", "vypujcka_id")
VALUES ('9999','1234');



