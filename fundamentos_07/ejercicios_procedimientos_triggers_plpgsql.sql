CREATE TABLE IF NOT EXISTS cuentas (
	cuenta serial, 
	saldo numeric,
	CONSTRAINT PK_cuentas PRIMARY KEY(cuenta)
);

CREATE TABLE IF NOT EXISTS movimientos (
	id_mov serial, 
	cuenta integer,
	tipo_movimiento varchar, 
	monto numeric,
	CONSTRAINT PK_movimientos PRIMARY KEY(id_mov)
);

INSERT INTO cuentas (saldo) VALUES (1000.0);
INSERT INTO cuentas (saldo) VALUES (500.0);
INSERT INTO cuentas (saldo) VALUES (2000.0);

-- Procedimientos almacenados.

CREATE OR REPLACE PROCEDURE realizar_transferencia(
	cuenta_transferencia integer,
	monto numeric
) 
AS $$
BEGIN
	IF monto > 0 THEN
		INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (cuenta_transferencia, 'Ingresar', monto);
		UPDATE cuentas SET saldo = saldo + monto WHERE cuenta = cuenta_transferencia;
		
	ELSIF monto < 0 THEN
		INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (cuenta_transferencia, 'Retirar', monto);
		UPDATE cuentas SET saldo = saldo + monto WHERE cuenta = cuenta_transferencia;
		
		IF (SELECT saldo FROM cuentas WHERE cuenta = cuenta_transferencia) < 0 THEN
			RAISE SQLSTATE '22012';
			
		END IF;
	ELSE
		RAISE SQLSTATE '22013';
		
	END IF;
	
	EXCEPTION
   		WHEN SQLSTATE '22012' THEN 
			RAISE NOTICE 'No tienes saldo suficiente!';
      		ROLLBACK;
			
		WHEN SQLSTATE '22013' THEN 
			RAISE NOTICE 'Introduce alguna cantidad!';
      		ROLLBACK;
			
		WHEN OTHERS THEN
			RAISE NOTICE 'ERROR!';
			ROLLBACK;
		
	COMMIT;
END;
$$ LANGUAGE 'plpgsql';

CALL realizar_transferencia(1, 100.0);
CALL realizar_transferencia(2, -100.0);
CALL realizar_transferencia(3, -5000000.0);
CALL realizar_transferencia(1, 0.0);

-- Triggers

CREATE OR REPLACE FUNCTION insert_movement()
RETURNS TRIGGER
AS $$
BEGIN
	UPDATE cuentas SET saldo = saldo + new.monto WHERE cuenta = new.cuenta;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER tr_insert_movement
BEFORE INSERT
ON movimientos
FOR EACH ROW
EXECUTE PROCEDURE insert_movement();

INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (1, 'Ingresar', 150.0);
INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (2, 'Retirar', -150.0);

--SELECT * FROM cuentas;
--SELECT * FROM movimientos;

CREATE OR REPLACE FUNCTION update_account()
RETURNS TRIGGER
AS $$
DECLARE
	dinero numeric;
BEGIN
	dinero = new.saldo - old.saldo;
	IF dinero > 0 THEN
		INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (new.cuenta, 'Ingresar', dinero);
	ELSE
		INSERT INTO movimientos (cuenta, tipo_movimiento, monto) VALUES (new.cuenta, 'Retirar', dinero);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER tr_update_account
AFTER UPDATE
ON cuentas
FOR EACH ROW
EXECUTE PROCEDURE update_account();

UPDATE cuentas SET saldo = saldo + 150 WHERE cuenta = 1;

--SELECT * FROM cuentas;
--SELECT * FROM movimientos;