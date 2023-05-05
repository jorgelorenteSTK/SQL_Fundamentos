CREATE SEQUENCE id_zoo_count;
CREATE TABLE IF NOT EXISTS zoo(
	id_zoo integer NOT NULL DEFAULT nextval('id_zoo_count'),
	tamano varchar(50) NOT NULL,
	presupuesto_anual integer NOT NULL,
	nombre varchar(50) NOT NULL,
	ciudad varchar(50) NOT NULL,
	pais varchar(50) NOT NULL,
	CONSTRAINT PK_zoo PRIMARY KEY(id_zoo)
);

CREATE SEQUENCE id_especie_count;
CREATE TABLE IF NOT EXISTS especie(
	id_especie integer NOT NULL DEFAULT nextval('id_especie_count'),
	nombre_vulgar varchar(50) NOT NULL,
	nombre_cientifico varchar(50) NOT NULL,
	familia varchar(50) NOT NULL,
	peligro_extincion boolean NOT NULL,
	CONSTRAINT PK_especie PRIMARY KEY(id_especie)
);

CREATE SEQUENCE id_animal_count;
CREATE TABLE IF NOT EXISTS animal(
	id_animal integer NOT NULL DEFAULT nextval('id_animal_count'),
	id_zoo integer NOT NULL,
	id_especie integer NOT NULL,
	ano_nacimiento date NOT NULL,
	continente varchar(50) NOT NULL,
	sexo character(1) NOT NULL,
	pais_origen varchar(50) NOT NULL,
	CONSTRAINT PK_animal PRIMARY KEY(id_animal),
	CONSTRAINT FK_animal_zoo FOREIGN KEY(id_zoo)
		REFERENCES zoo(id_zoo)
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_animal_especie FOREIGN KEY(id_especie)
		REFERENCES especie(id_especie)
		ON UPDATE CASCADE ON DELETE CASCADE
);




