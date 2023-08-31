use henry_m3_3;

-- #1
-- Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto y su respectivo precio.
CREATE VIEW ventasporcliente AS (
SELECT DISTINCT Nombre_y_Apellido, IdProducto, Precio
FROM Venta v
JOIN Cliente c
ON v.IdCliente = c.IdCliente);

SELECT *
FROM ventasporcliente;





SELECT DISTINCT Nombre_y_Apellido, IdProducto, Precio
FROM Venta v
LEFT JOIN Cliente c
ON v.IdCliente = c.IdCliente;

SELECT COUNT(DISTINCT IdCliente), COUNT(DISTINCT Nombre_y_Apellido)
FROM cliente;

-- #2
-- Obteber un listado de clientes con la cantidad de productos adquiridos, incluyendo aquellos que nunca compraron algún producto.
SELECT c.IdCliente,
		c.Nombre_y_Apellido,
        SUM(v.Cantidad) AS Q_Productos_Adquiridos,              
        SUM(IFNULL(v.Cantidad,0)) AS Q_Productos_Adquiridos_0
FROM cliente c
LEFT JOIN venta v
ON (v.IdCliente = c.IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido
ORDER BY Q_Productos_Adquiridos;

-- #3
-- Obtener un listado de cual fue el volumen de compra (cantidad) por año de cada cliente. (cuantas compras hizo cada cliente)
SELECT c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha), 
		COUNT(v.IdVenta) AS total_compras
FROM venta v
JOIN cliente c
-- ON (v.IdCliente = c.IdCliente)
USING(IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha)
ORDER BY YEAR(v.Fecha) DESC, total_compras DESC;

-- #4
-- Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto, la cantidad de productos adquiridos y el precio promedio.

SELECT c.IdCliente, c.Nombre_y_Apellido, p.Producto, p.IdProducto,
		SUM(v.Cantidad) AS Cantidad_Producto,
        AVG(v.Precio) AS Precio_Promedio
FROM Venta v
JOIN Producto p
USING(IdProducto)
JOIN Cliente c
USING(IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, p.Producto, p.IdProducto
ORDER BY c.IdCliente;

-- #5
-- Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad, presentar el análisis en un listado con el nombre de cada localidad.

-- Revisamos duplicados
SELECT localidad, COUNT(*)
FROM localidad
GROUP BY localidad
HAVING COUNT(*)>1;

SELECT p.Provincia, l.localidad, l.IdLocalidad,
		SUM(v.Cantidad) AS Cantidad_Productos,
        SUM(v.Precio*v.Cantidad) AS Total_Ventas,
        COUNT(v.IdVenta) AS Volumen_Venta
FROM Venta v
LEFT JOIN cliente c USING(IdCliente)
LEFT JOIN localidad l USING(IdLocalidad)
LEFT JOIN provincia p USING(IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.Provincia, l.localidad, l.IdLocalidad
ORDER BY p.Provincia, l.localidad;


-- #6
SELECT p.Provincia,
		SUM(v.Cantidad) AS Cantidad_Productos,
        SUM(v.Precio * v.Cantidad) AS Total_ventas,
        COUNT(v.IdVenta) AS Volumen_Venta -- Cantidad de ventas indivduales
FROM venta v 
LEFT JOIN cliente c USING(IdCliente)
LEFT JOIN localidad l USING(IdLocalidad)
LEFT JOIN provincia p USING(IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.Provincia
HAVING total_ventas > 100000
ORDER BY p.Provincia;

-- #7
SELECT c.Rango_Etario,	
		SUM(v.Cantidad) AS cantidad_productos,
        ROUND(SUM(v.Precio * v.Cantidad),2) AS total_ventas
FROM venta v
LEFT JOIN cliente c USING(IdCliente)
WHERE v.Outlier = 1
GROUP BY c.Rango_Etario
ORDER BY c.Rango_Etario;

-- #8
-- Obtener la cantidad de clientes por provincia
SELECT p.IdProvincia, p.Provincia, 
		COUNT(c.IdCliente) AS Cantidad_Clientes
FROM Provincia p 
	LEFT JOIN localidad l USING(IdProvincia)
    LEFT JOIN cliente c USING(IdLocalidad)
GROUP BY p.IdProvincia, p.Provincia
ORDER BY p.Provincia DESC;

-- 
