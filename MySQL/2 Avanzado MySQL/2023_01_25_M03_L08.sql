-- Modulo 3:
-- Lecture 8

USE henry_m2;

SELECT idAlumno, fechaIngreso
FROM alumno
WHERE fechaIngreso = (SELECT MIN(fechaIngreso) AS fecha
						FROM alumno);

SELECT MIN(fechaIngreso) AS fecha
FROM alumno;

-- otro ejemplo con subquery de distinta tabla y trayendo una lista

SELECT MIN(fechaInicio) as fecha_inicio
FROM cohorte;

SELECT idCohorte
FROM cohorte
WHERE fechaInicio =  (SELECT MIN(fechaInicio) as fecha_inicio
					FROM cohorte);

SELECT idAlumno, nombre, apellido
FROM alumno
WHERE idCohorte IN (SELECT idCohorte
					FROM cohorte
					WHERE fechaInicio =  (SELECT MAX(fechaInicio) as fecha_inicio
											FROM cohorte));
---
SELECT idCohorte
FROM cohorte
WHERE fechaInicio =  (SELECT MAX(fechaInicio) as fecha_inicio
						FROM cohorte);


-- VISTAS
CREATE VIEW ultimosAlumnos AS (
								SELECT idAlumno, fechaIngreso
								FROM alumno
								WHERE fechaIngreso = (SELECT MAX(fechaIngreso) AS fecha
														FROM alumno));

SELECT *
FROM ultimosalumnos;