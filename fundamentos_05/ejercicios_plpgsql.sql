-- EJERCICIOS
/*
1 - Escriba un bloque de codigo PL/pgSQL que reciba una nota como parametro
    y notifique en la consola de mensaje las letras A,B,C,D,E o F segun el valor de la nota
*/

DO $$
DECLARE num int := 1;

BEGIN
	CASE num
		WHEN 10 THEN
			RAISE NOTICE 'A';

		WHEN 9 THEN
			RAISE NOTICE 'B';

		WHEN 8 THEN
			RAISE NOTICE 'C';

		WHEN 7 THEN
			RAISE NOTICE 'D';

		WHEN 6 THEN
			RAISE NOTICE 'E';

		ELSE
			RAISE NOTICE 'F';

		END CASE;
END;
$$
LANGUAGE 'plpgsql';

/*
2 - Escriba un bloque de codigo PL/pgSQL que reciba un numero como parametro
    y muestre la tabla de multiplicar de ese numero.
*/

DO $$
DECLARE num int := 5;

BEGIN
	FOR cont IN 1..10 LOOP
		RAISE NOTICE '% * % = %', num, cont, num*cont;
	END LOOP;
END;
$$
LANGUAGE 'plpgsql';

/*
3 - Escriba una funcion PL/pgSQL que convierta de dolares a moneda nacional.
    La funcion debe recibir dos parametros, cantidad de dolares y tasa de cambio.
    Al final debe retornar el monto convertido a moneda nacional.
*/

DO $$
DECLARE cantidad decimal := 25.89;
DECLARE tasa decimal := 0.91;

BEGIN
	RAISE NOTICE '% dólares son al cambio % euros', cantidad, cantidad*tasa;
END;
$$
LANGUAGE 'plpgsql';

/*
4 - Escriba una funcion PL/pgSQL que reciba como parametro el monto de un prestamo,
    su duracion en meses y la tasa de interes, retornando el monto de la cuota a pagar.
    Aplicar el metodo de amortizacion frances.
*/

DO $$
DECLARE monto decimal := 1500;
DECLARE duracion decimal := 2;
DECLARE interes decimal := 0.02 / 12;

BEGIN
	RAISE NOTICE 'El monto de un préstamo de valor % en una cantidad de % meses con un interés de % es de %',monto, duracion, interes, monto*(interes / (1 - (1 + interes)^(-1 * duracion)));
END;
$$
LANGUAGE 'plpgsql';