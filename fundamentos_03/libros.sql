CREATE SEQUENCE IF NOT EXISTS id_socio_count;
CREATE TABLE IF NOT EXISTS public."socio"(
	id_socio integer NOT NULL DEFAULT nextval('id_socio_count'),
	tlf char(9) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellidos varchar(50) NOT NULL,
	dni char(9) NOT NULL,
	id_poblacion integer NOT NULL,
	avalista integer NOT NULL,
	CONSTRAINT PK_socio PRIMARY KEY(id_socio)
);

CREATE SEQUENCE IF NOT EXISTS id_pedido_count;
CREATE TABLE IF NOT EXISTS public."pedido"(
	id_pedido integer NOT NULL DEFAULT nextval('id_pedido_count'),
	forma_pago varchar(50) NOT NULL,
	forma_envio varchar(50) NOT NULL,
	id_socio integer NOT NULL,
	CONSTRAINT PK_pedido PRIMARY KEY(id_pedido, id_socio)
);

CREATE SEQUENCE IF NOT EXISTS id_detalle_count;
CREATE TABLE IF NOT EXISTS public."detalle"(
	id_detalle integer NOT NULL DEFAULT nextval('id_detalle_count'),
	cantidad integer NOT NULL,
	isbn char(13) NOT NULL,
	id_pedido integer NOT NULL,
	id_socio integer NOT NULL,
	CONSTRAINT PK_detalle PRIMARY KEY(id_pedido)
);

CREATE TABLE IF NOT EXISTS public."libro"(
	isbn char(13) NOT NULL,
	titulo varchar(50) NOT NULL,
	autor varchar(50) NOT NULL,
	editorial varchar(50) NOT NULL,
	id_coleccion integer NOT NULL,
	CONSTRAINT PK_libro PRIMARY KEY(isbn)
);

CREATE SEQUENCE IF NOT EXISTS id_coleccion_count;
CREATE TABLE IF NOT EXISTS public."coleccion"(
	id_coleccion integer NOT NULL DEFAULT nextval('id_coleccion_count'),
	volumenes integer NOT NULL,
	CONSTRAINT PK_coleccion PRIMARY KEY(id_coleccion)
);

CREATE TABLE IF NOT EXISTS public."libro_almacen"(
	id_almacen integer NOT NULL,
	isbn char(13) NOT NULL,
	cantidad integer NOT NULL,
	CONSTRAINT PK_libro_almacen PRIMARY KEY(id_almacen, isbn)
);

CREATE SEQUENCE IF NOT EXISTS id_almacen_count;
CREATE TABLE IF NOT EXISTS public."almacen"(
	id_almacen integer NOT NULL DEFAULT nextval('id_almacen_count'),
	fecha date NOT NULL,
	direccion varchar(50) NOT NULL, 
	id_provincia integer NOT NULL,
	CONSTRAINT PK_almacen PRIMARY KEY(id_almacen)
);

CREATE SEQUENCE IF NOT EXISTS id_provincia_count;
CREATE TABLE IF NOT EXISTS public."provincia"(
	id_provincia integer NOT NULL DEFAULT nextval('id_provincia_count'),
	nombre varchar(50) NOT NULL,
	_extension integer NOT NULL, 
	id_almacen integer NOT NULL,
	CONSTRAINT PK_provincia PRIMARY KEY(id_provincia)
);

CREATE SEQUENCE IF NOT EXISTS id_poblacion_count;
CREATE TABLE IF NOT EXISTS public."poblacion"(
	id_poblacion integer NOT NULL DEFAULT nextval('id_poblacion_count'),
	nombre varchar(50) NOT NULL,
	habitantes varchar(50) NOT NULL, 
	id_provincia integer NOT NULL,
	CONSTRAINT PK_poblacion PRIMARY KEY(id_poblacion)
);

ALTER TABLE IF EXISTS public."socio"
    ADD CONSTRAINT FK_socio_poblacion FOREIGN KEY (id_poblacion)
    REFERENCES public."poblacion" (id_poblacion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID,
	
	ADD CONSTRAINT FK_socio_socio FOREIGN KEY (avalista)
    REFERENCES public."socio" (id_socio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public."pedido"
    ADD CONSTRAINT FK_pedido_socio FOREIGN KEY (id_socio)
    REFERENCES public."socio" (id_socio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public."detalle"
    ADD CONSTRAINT FK_detalle_pedido FOREIGN KEY (id_pedido, id_socio)
    REFERENCES public."pedido" (id_pedido, id_socio) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID,
	
	ADD CONSTRAINT FK_detalle_libro FOREIGN KEY (isbn)
    REFERENCES public."libro" (isbn) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public."libro"
    ADD CONSTRAINT FK_libro_coleccion FOREIGN KEY (id_coleccion)
    REFERENCES public."coleccion" (id_coleccion) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."libro_almacen"
    ADD CONSTRAINT FK_libro_almacen_libro FOREIGN KEY (isbn)
    REFERENCES public."libro" (isbn) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID,
	
	ADD CONSTRAINT FK_libro_almacen_almacen FOREIGN KEY (id_almacen)
    REFERENCES public."almacen" (id_almacen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public."almacen"
    ADD CONSTRAINT FK_almacen_provincia FOREIGN KEY (id_provincia)
    REFERENCES public."provincia" (id_provincia) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
	
ALTER TABLE IF EXISTS public."provincia"
    ADD CONSTRAINT FK_provincia_almacen FOREIGN KEY (id_almacen)
    REFERENCES public."almacen" (id_almacen) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;