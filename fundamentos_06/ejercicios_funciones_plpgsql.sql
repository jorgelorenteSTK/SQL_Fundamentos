-- EJERCICIOS
/*
1 --Función sin parámetro de entrada para devolver el precio máximo
*/

CREATE OR REPLACE FUNCTION max_price()
RETURNS numeric
AS $$
DECLARE
	max_price numeric;
BEGIN
	SELECT MAX(unit_price) INTO max_price FROM products;
	RETURN max_price;
END;
$$ LANGUAGE 'plpgsql';

SELECT max_price();

/*
2 --parametro de entrada
  --Obtener el numero de ordenes por empleado
*/

CREATE OR REPLACE FUNCTION number_orders(e_id integer)
RETURNS integer
AS $$
DECLARE
	count_orders integer;
BEGIN
	SELECT COUNT(order_id) INTO count_orders FROM orders WHERE employee_id = e_id;
	RETURN count_orders;
END;
$$ LANGUAGE 'plpgsql';

SELECT number_orders(1);

/*
3 -Obtener las ventas de un empleado con un determinado producto
*/

CREATE OR REPLACE FUNCTION total_sales(p_id integer, e_id integer)
RETURNS numeric
AS $$
DECLARE
	sales numeric;
BEGIN
	SELECT SUM(quantity) INTO sales FROM order_details AS od INNER JOIN orders AS o ON od.order_id = o.order_id AND od.product_id = p_id AND o.employee_id = e_id;
	RETURN sales;
END;
$$ LANGUAGE 'plpgsql';

SELECT total_sales(e_id => 4, p_id => 1);

/*
4 -Crear una funcion para devolver una tabla con producto_id, nombre, precio y unidades en strock, debe obtener los productos terminados en n
*/

CREATE OR REPLACE FUNCTION table_products_n()
RETURNS TABLE (productId smallint, productName varchar, unitPrice real, unitsInStock smallint)
AS $$
BEGIN
	RETURN QUERY
		SELECT product_id, product_name, unit_price, units_in_stock FROM products WHERE product_name LIKE '%n';
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM table_products_n();

/*
5 --Creamos la función contador_ordenes_anio()
  --QUE CUENTE LAS ORDENES POR AÑO devuelve una tabla con año y contador
*/

CREATE OR REPLACE FUNCTION contador_ordenes_anio()
RETURNS TABLE (anio numeric, cont bigint)
AS $$
BEGIN
	RETURN QUERY
		SELECT EXTRACT(YEAR FROM order_date), COUNT(order_id) FROM orders GROUP BY EXTRACT(YEAR FROM order_date);
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM contador_ordenes_anio();

/*
6 --Lo mismo que el ejemplo anterior pero con un parametro de entrada que sea el año
*/

CREATE OR REPLACE FUNCTION contador_ordenes_anio_param(year_number numeric)
RETURNS TABLE (anio numeric, cont bigint)
AS $$
BEGIN
	RETURN QUERY
		SELECT EXTRACT(YEAR FROM order_date), COUNT(order_id) FROM orders WHERE EXTRACT(YEAR FROM order_date) = year_number GROUP BY EXTRACT(YEAR FROM order_date);
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM contador_ordenes_anio_param(1996);

/*
7 --PROCEDIMIENTO ALMACENADO PARA OBTENER PRECIO PROMEDIO Y SUMA DE 
  --UNIDADES EN STOCK POR CATEGORIA
*/

CREATE OR REPLACE FUNCTION price_stock(categoryId integer)
RETURNS TABLE (avg_price double precision, sum_stock bigint)
AS $$
BEGIN
	RETURN QUERY
		SELECT AVG(unit_price), SUM(units_in_stock) FROM products WHERE category_id = categoryId;
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM price_stock(2);