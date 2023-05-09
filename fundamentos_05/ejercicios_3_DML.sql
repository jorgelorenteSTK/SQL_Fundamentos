--Subconsultas

-- Obtener los productos cuyo precio unitario sea mayor al precio promedio de la tabla de productos

SELECT * FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);

-- Obtener los productos cuya cantidad en stock sea menor al promedio de cantidad en stock de toda la tabla de productos.

SELECT * FROM products WHERE units_in_stock < (SELECT AVG(units_in_stock) FROM products);

-- Obtener los productos cuya cantidad en Inventario (UnitsInStock) sea menor a la cantidad mínima del detalle de ordenes (Order Details)

SELECT * FROM products WHERE units_in_stock < (SELECT MIN(quantity) FROM order_details);

--OBTENER LOS PRODUCTOS CUYA CATEGORIA SEA IGUAL A LAS CATEGORIAS DE LOS PRODUCTOS CON PROVEEDOR 1.

SELECT * FROM products WHERE category_id IN (SELECT category_id FROM products WHERE supplier_id = 1);

-- Subconsultas correlacionadas 
--Obtener el número de empleado y el apellido para aquellos empleados que tengan menos de 100 ordenes.

SELECT employee_id, last_name FROM employees AS e WHERE (SELECT COUNT(o.order_id) FROM orders AS o WHERE e.employee_id = o.employee_id) < 100; 

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes

SELECT customer_id, company_name FROM customers AS c WHERE (SELECT COUNT(o.order_id) FROM orders AS o WHERE c.customer_id = o.customer_id) > 20;

--Obtener el productoid, el nombre del producto, el proveedor de la tabla de productos para aquellos productos que se hayan vendido menos de 100 unidades (Consultarlo en la tabla de Orders details).

SELECT product_id, product_name, supplier_id FROM products AS p WHERE (SELECT SUM(od.quantity) FROM order_details AS od WHERE p.product_id = od.product_id) < 100;

--Obtener los datos del empleado IDEmpleado y nombre completo De aquellos que tengan mas de 100 ordenes

SELECT employee_id, CONCAT(first_name, ' ', last_name) AS complete_name FROM employees AS e WHERE (SELECT COUNT(o.order_id) FROM orders AS o WHERE e.employee_id = o.employee_id) > 100;

--Obtener los datos de Producto ProductId, ProductName, UnitsinStock, UnitPrice (Tabla Products) de los productos que la sumatoria de la cantidad (Quantity) de orders details sea mayor a 450

SELECT product_id, product_name, units_in_stock, unit_price FROM products AS p WHERE (SELECT SUM(od.quantity) FROM order_details AS od WHERE p.product_id = od.product_id) > 450;

--Obtener la clave de cliente y el nombre de la empresa para aquellos clientes que tengan más de 20 ordenes.

SELECT customer_id, company_name FROM customers AS c WHERE (SELECT COUNT(o.order_id) FROM orders AS o WHERE c.customer_id = o.customer_id) > 20;


--insert
--Insertar un registro en la tabla de Categorias, únicamente se quiere insertar la información del CategoryName y la descripción los Papelería y papelería escolar

INSERT INTO categories (category_id, category_name, description) VALUES (777, 'Papelería', 'Papelería escolar');

--Dar de alta un producto con Productname, SupplierId, CategoryId, UnitPrice, UnitsInStock Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta

INSERT INTO products (product_id, product_name, supplier_id, category_id, unit_price, units_in_stock, discontinued) VALUES (777, 'GorroCóptero', 1, 1, 99, 1, 1);

--Dar de alta un empleado con LastName, FistName, Title, BrithDate

INSERT INTO employees (employee_id, last_name, first_name, title, birth_date) VALUES (1010, 'Lorente Aguilar', 'Jorge', 'Admin', '23-07-2001');

--Dar de alta una orden, CustomerId, Employeeid, Orderdate, ShipVia Como esta tabla tiene dos clave foraneas hay que ver los datos a dar de alta

INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_via) VALUES (1111, 'ALFKI', 1, '28-02-2019', 1);

--Dar de alta un Order details, con todos los datos

INSERT INTO order_details VALUES (11077, 1, 15, 50, 20);

--update

-- Cambiar el CategoryName a Verduras de la categoria 10

UPDATE categories SET category_name = 'Verduras' WHERE category_id = 10;

-- Actualizar los precios de la tabla de Productos para incrementarlos un 10%

UPDATE products SET unit_price = unit_price + (unit_price * 0.1);

--ACTUALIZAR EL PRODUCTNAME DEL PRODUCTO 80 A ZANAHORIA ECOLOGICA

UPDATE products SET product_name = 'Zanahoria' WHERE product_id = 80;

--ACTUALIZAR EL FIRSTNAME DEL EMPLOYEE 10 A ROSARIO 

UPDATE employees SET first_name = 'Rosario' WHERE employee_id = 10;

--ACTUALIZAR EL ORDERS DETAILS DE LA 11079 PARA QUE SU CANTIDAD SEA 10

UPDATE order_details SET quantity = 10 WHERE order_id = 11079;

--Delete
--diferencia entre delete y truncate
--BORRAR EL EMPLEADO 10

DELETE FROM employees WHERE employee_id = 1010;


