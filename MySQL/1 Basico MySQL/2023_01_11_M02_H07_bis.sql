USE henry_m2;

# 1. ¿Cuantas carreas tiene Henry?
SELECT COUNT(idCarrera) "cantidad de carreras"
FROM carrera;

# 2. ¿Cuantos alumnos hay en total?
SELECT COUNT(idAlumno)
FROM alumno;

# 3. ¿Cuantos alumnos tiene cada cohorte?
-- SELECT idCohorte, COUNT(idAlumno)
SELECT idCohorte, COUNT(*)
FROM alumno
GROUP BY idCohorte;

/* 4. Confecciona un listado de los alumnos ordenado por los últimos 
alumnos que ingresaron, con nombre y apellido en un solo campo. */

SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		fechaIngreso
FROM alumno
ORDER BY 2 DESC
LIMIT 10;

# 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido"
FROM alumno
ORDER BY fechaIngreso
LIMIT 1;

# 6. ¿En que fecha ingreso?
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		fechaIngreso
FROM alumno
ORDER BY 2
LIMIT 1;

# 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC
LIMIT 1;

# 8. ¿Cuantos alumnos ingresaron por año?
SELECT YEAR(fechaIngreso) "Año Ingreso",
		COUNT(*) AS cantidad
FROM alumno
GROUP BY 1
ORDER BY 1;

# 9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año.
SELECT YEAR(fechaIngreso) "Año Ingreso",
		WEEKOFYEAR(fechaIngreso) "Semana",
        COUNT(*) AS cantidad
FROM alumno
GROUP BY 1,2
ORDER BY 1,2;

# 10. En que años ingreasaron más de 20 alumnos?
SELECT YEAR(fechaIngreso) "Año Ingreso",
		COUNT(*) AS cantidad
FROM alumno
GROUP BY 1
HAVING cantidad>20;

# 11. ¿Cual es la edad de los instructores?
SELECT CONCAT(nombre, " ", apellido)  "Nombre y Apellido",
		TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) "Edad"
FROM instructor;
		
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())  "Edad",
        fechaNacimiento,
        -- DATE_ADD(fechaNacimiento, INTERVAL(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())) YEAR) "Verificacion" 
		DATE_ADD(fechaNacimiento, INTERVAL TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) YEAR) "Verificacion" 
FROM instructor;
      
# 12.
/* 
- La edad de cada alumno.
- La edad promedio de los alumnos de henry.
- La edad promedio de los alumnos de cada cohorte.
*/
SELECT idAlumno, 
		CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())  "Edad",
        fechaNacimiento
FROM alumno
ORDER BY 3 DESC;

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()))) "Promedio Edad"
FROM alumno;

UPDATE alumno
SET fechaNacimiento = '2002-01-02'
WHERE idAlumno = 127;

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()))) "Promedio Edad"
FROM alumno;

-- La edad promedio de los alumnos de cada cohorte.
SELECT idCohorte,
		ROUND(AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()))) "Promedio Edad"
FROM alumno
GROUP BY 1
ORDER BY 2;

# 13. Elabora un listado de los alumnos que superan la edad promedio de Henry.
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())  "Edad"
FROM alumno
WHERE TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) > 22;

-- Subqueries
SELECT CONCAT(nombre, " ", apellido) "Nombre y Apellido",
		TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())  "Edad"
FROM alumno
WHERE TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) > (SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE())))
															FROM alumno);



SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()))) "Promedio Edad"
FROM alumno;