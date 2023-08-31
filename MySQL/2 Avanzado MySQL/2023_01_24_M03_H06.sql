-- Modulo 3
-- Homework CLase 6

USE henry_m3;
-- 1
-- Crear un procedimiento que recibe como parametro una fecha y muestre el listado de productos que se vendieron en esa fecha.
/*
SELECT DISTINCT p.Producto
FROM venta v
JOIN producto p
ON (v.IdProducto = p.IdProducto AND v.Fecha = '2018-03-09');
*/

DROP PROCEDURE listaProductos;

DELIMITER $$
CREATE PROCEDURE listaProductos (IN fechaventa DATE)
BEGIN 
	SELECT DISTINCT p.Producto
	FROM venta v
	JOIN producto p
	ON (v.IdProducto = p.IdProducto AND v.Fecha = fechaventa);
END $$
DELIMITER ;

CALL listaProductos('2018-03-09');

-- 2
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,2), margen DECIMAL(8,2)) RETURNS DECIMAL(15,2)
BEGIN
	DECLARE margenBruto DECIMAL(15,2);
    SET margenBruto = precio*margen; -- margenBruto = precio + precio*margen --> podemos utilizar 0.20
    RETURN margenBruto;
END $$
DELIMITER ;

SELECT margenBruto(100, 1.50);
-- Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos
SELECT c.Fecha,
		pr.Nombre, 
        c.Precio AS precio_compra,
        p.producto,
        margenBruto(c.Precio, 1.2) AS precio_con_margen
FROM compra c
JOIN producto p ON (p.IdProducto = c.IdProducto)
JOIN proveedor pr ON(pr.IdProveedor = c.IdProveedor);

-- 3
-- Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un margen bruto del 20% de cada uno de los productos.

SELECT p.IdProducto,
	p.Producto,
    p.Precio,
    margenBruto(p.Precio, 1.20) AS precio_con_margen
FROM producto p
JOIN tipo_producto tp
    ON (p.IdTipoProducto = tp.IdTipoProducto AND TipoProducto = 'Limpieza');

-- 4
DROP PROCEDURE listaProductosCategoria;

DELIMITER $$
CREATE PROCEDURE listaProductosCategoria (categoria VARCHAR(40))
BEGIN
	SELECT v.*, p.Producto
    FROM venta v
    JOIN producto p ON(p.IdProducto = v.IdProducto) 
    JOIN tipo_producto tp ON(tp.IdTipoProducto = p.IdTipoProducto AND TipoProducto COLLATE utf8mb4_spanish_ci = categoria);
END $$
DELIMITER ;

CALL listaProductosCategoria('Gaming');

-- 5
DROP PROCEDURE cargaFact_venta;
DELIMITER $$
CREATE PROCEDURE cargaFact_venta()
BEGIN
	INSERT INTO fact_venta
    SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
    FROM venta
    WHERE Outlier = 1
    LIMIT 30;
END $$
DELIMITER ;

TRUNCATE TABLE fact_venta;

CALL cargaFact_venta();

-- 6
SELECT 	c.Rango_Etario, 
		sum(v.Precio*v.Cantidad) AS Total_Ventas
FROM venta v
INNER JOIN cliente c
	ON (v.IdCliente = c.IdCliente
	AND c.Rango_Etario COLLATE utf8mb4_spanish_ci = '2_De 31 a 40 años')
GROUP BY c.Rango_Etario;
    
DROP PROCEDURE ventasGrupoEtario; 
DELIMITER $$
CREATE PROCEDURE ventasGrupoEtario(grupo VARCHAR(25))
BEGIN
	SELECT 	c.Rango_Etario, 
		sum(v.Precio*v.Cantidad) AS Total_Ventas
	FROM venta v
	INNER JOIN cliente c
		ON (v.IdCliente = c.IdCliente
		AND c.Rango_Etario collate utf8mb4_spanish_ci LIKE Concat('%', grupo, '%'))
	GROUP BY c.Rango_Etario;
END $$
DELIMITER ;

CALL ventasGrupoEtario('51%60');

-- 7
SET @grupo_etario = '2_De 31 a 40 años';

SELECT *
FROM cliente
WHERE Rango_Etario COLLATE utf8mb4_spanish_ci = @grupo_etario;



-- Lecture clase 7
USE henry_m2;
SELECT *
FROM instructor i
INNER JOIN cohorte c ON(c.IdInstructor = i.idInstructor);
-- LEFT JOIN cohorte c ON(c.IdInstructor = i.idInstructor);
-- RIGHT JOIN cohorte c ON(c.IdInstructor = i.idInstructor);
-- CROSS JOIN cohorte c ON(c.IdInstructor = i.idInstructor);


USE henry_m3;
-- 47082;
-- Todos los clientes y monto de compra en la tabla venta (de los que compraron)
SELECT v.Fecha, 
		c.Nombre_y_Apellido, 
        (v.Precio*v.Cantidad) AS Venta
FROM cliente c
LEFT JOIN venta v 
	ON (c.IdCliente = v.IdCliente);
    
-- Solamente los clientes que realizaron compras
-- 46645
SELECT v.Fecha, 
		c.Nombre_y_Apellido, 
        (v.Precio*v.Cantidad) AS Venta
FROM cliente c
INNER JOIN venta v 
	ON (c.IdCliente = v.IdCliente);
    
-- Clientes que no hicieron compras:
-- 437 
SELECT v.Fecha, 
		c.Nombre_y_Apellido, 
        (v.Precio*v.Cantidad) AS Venta
FROM cliente c
LEFT JOIN venta v 
	ON (c.IdCliente = v.IdCliente)
WHERE v.IdVenta IS NULL;















