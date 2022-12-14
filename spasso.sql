CREATE DATABASE spasso;
USE spasso;
CREATE TABLE report_sale(
nome_locale nvarchar(100),
capienza int,
provincia nvarchar(50),
comune nvarchar(50),
genere_locale nvarchar(50),
CAP nvarchar(5),
numero_civico nvarchar(20),
toponimo nvarchar(15),
ingressi int,
giornate_solari int,
indirizzo nvarchar(50)
);
CREATE TABLE report_comuni(
codice_regione nvarchar(2), -- Codice di due caratteri alfanumerici, con validità nel
--range 01-20
codice_unita_territoriale nvarchar(3), -- Codice di tre caratteri alfanumerici, con
--validità nei range 001-111 per le province e 081-089 per i liberi consorzi subentrati
--alle omonime ex province. Il codice delle città metropolitane è, invece, creato
--sommando &#39;200&#39; al codice della provincia corrispondente. Ai soli fini statistici,
--permangono i codici delle soppresse province del Friuli-Venezia Giulia, cessate secondo
--le modalità espresse con Legge regionale 20 dicembre 2016, n. 20 (Suppl. ord. n. 55 al
--B.U.R n. 50 del 14 dicembre 2016).
codice_provincia nvarchar(3), -- Codice di tre caratteri alfanumerici, con validità nel
--range 001-111. A partire dal 1/1/2015 con l&#39;entrata in vigore delle città metropolitane
--i codici delle province corrispondenti permangono al solo scopo di costituire il codice
--del comune, che non subisce variazioni. Allo stesso scopo, e ai soli fini statistici,
--permangono i codici delle soppresse province del Friuli-Venezia Giulia, cessate secondo
--le modalità espresse con Legge regionale 20 dicembre 2016, n. 20 (Suppl. ord. n. 55 al
--B.U.R n. 50 del 14 dicembre 2016).
progressivo_comune nvarchar(3), -- E&#39; un numero progressivo che parte da &#39;001&#39;
--all&#39;interno di ogni provincia
codice_comune_formato_alfanumerico nvarchar(6), -- Si ottiene dalla concatenazione del Codice Provincia con il Progressivo del comune
denominazione_comune_italana_straniera nvarchar(100), --Denominazione del Comune in lingua italiana e straniera. Per le denominazioni bilingue è previsto l&#39;uso del simbolo separatore: &quot;/&quot; per i comuni della provincia di Bolzano/Bozen, e &quot;-&quot; per tutti gli altri.
denominazione_comune_italiano nvarchar(50), -- Denominazione solo in lingua italiana del Comune
denominazione_comune_altra_lingua nvarchar(50), -- Denominazione del Comune in lingua diversa dall&#39;italiano
codice_ripartizione_geografica nvarchar(1), --Codice Istat della Ripartizione
--geografica secondo la suddivisione del territorio nazionale in: 1) Nord-ovest, 2) Nord-
--est, 3) Centro, 4) Sud e 5) Isole.
ripartizione_geografica nvarchar(30), -- Codice Istat della Ripartizione geografica
--secondo la suddivisione del territorio nazionale in: 1) Nord-ovest, 2) Nord-est, 3)
--Centro, 4) Sud e 5) Isole.
denominazione_regione nvarchar(50),
denominazione_unita_territoriale_sovracomunale nvarchar(50), -- nome del capoluogo di provincia
tipologia_unita_territoriale_sovracomunale nvarchar(1), -- 1=Provincia; 2=Provincia
--autonoma; 3=Città metropolitana; 4=Libero consorzio di comuni; 5=Unità non
--amministrativa (ex- province del Friuli-Venezia Giulia)
flag_comune_capoluogo_di_provincia_metropolitana_consorzio nvarchar(1), -- 1=Comune
--capoluogo; 0=Comune non è capoluogo.
sigla_automobilistica nvarchar(2),
codice_comune_formato_numerico int, -- Si ottiene dalla concatenazione del Codice
--Provincia (110 province) con Progressivo del comune.
codice_comune_numerico_con_110_province_2010_2016 int,
codice_comune_numerico_con_107_province_2006_2009 int,
codice_comune_numerico_con_103_province_1995_2005 int,
codice_catastale_comune nvarchar(4), 
-- E&#39; un codice composto da quattro caratteri, il
--primo dei quali alfabetico e gli altri tre numerici. Il codice è stato assegnato
--inizialmente seguendo l&#39;ordinamento alfabetico crescente dell&#39;elenco di tutti i comuni
--di Italia, indipedentemente dalla Provincia di appartenenza. Per i comuni di nuova
--istituzione viene assegnato il primo codice alfanumerico disponibile.
codice_NUTS1_2010 nvarchar(5),
codice_NUTS2_2010 nvarchar(5),
codice_NUTS3_2010 nvarchar(5),
codice_NUTS1_2021 nvarchar(5),
codice_NUTS2_2021 nvarchar(5),
codice_NUTS3_2021 nvarchar(5)
);

CREATE TABLE geographic_ripartition (
	ripartition_code NVARCHAR(1) PRIMARY KEY,
	ripartition NVARCHAR(30) NOT NULL,
);

INSERT INTO geographic_ripartition (ripartition_code, ripartition)
SELECT DISTINCT codice_ripartizione_geografica, ripartizione_geografica
FROM report_comuni;

CREATE TABLE country (
	country_code NVARCHAR(2) PRIMARY KEY,
	country_denomination NVARCHAR(50) NOT NULL,
	ripartition_code NVARCHAR(1) FOREIGN KEY REFERENCES geographic_ripartition(ripartition_code),
);

INSERT INTO country (country_code, country_denomination, ripartition_code)
SELECT DISTINCT codice_regione, denominazione_regione, codice_ripartizione_geografica
FROM report_comuni;

CREATE TABLE province (
	province_code NVARCHAR(3) PRIMARY KEY,
	city_name NVARCHAR(50) NOT NULL,
	country_code NVARCHAR(2) FOREIGN KEY REFERENCES country(country_code),
	city_type NVARCHAR(1) NOT NULL,
	automotive
);


CREATE TABLE municipality (
	municipality_code INT PRIMARY KEY,
	municipality_progressive NOT NULL,
	country_code NVARCHAR(2) FOREIGN KEY REFERENCES country(country_code),
	municipality_name_ita_for NVARCHAR(100) NOT NULL,
	municipality_name_ita NVARCHAR(50) NOT NULL,
	munucipality_name_for NVARCHAR(50),
	municipality_flag NVARCHAR(1) NOT NULL, 
	catastal_code NVARCHAR(4) NOT NULL,
)




