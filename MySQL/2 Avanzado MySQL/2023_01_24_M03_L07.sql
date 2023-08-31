-- Modulo 3
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
