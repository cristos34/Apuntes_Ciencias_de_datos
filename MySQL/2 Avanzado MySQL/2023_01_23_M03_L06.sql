USE henry_m2;

SET @anio = 2019;

SELECT @anio;

SELECT *
FROM venta
WHERE YEAR(Fecha) = @anio;

SHOW VARIABLES;
SHOW DATABASES;
SHOW TABLES;

-- Nuestra primera funcion --
SET GLOBAL log_bin_trust_function_creators = 1; -- Seteo variable para que me permita escribir funciones

DELIMITER $$
CREATE FUNCTION antMeses2(fechaIngreso DATE) RETURNS INT
BEGIN
	DECLARE meses INT;
    SET meses = timestampdiff(MONTH, fechaIngreso, CURDATE());
    RETURN meses;
END$$
DELIMITER ;

SELECT antMeses('2020-01-23');


DELIMITER $$
CREATE PROCEDURE getTotalAlumnos()
BEGIN
	DECLARE total_alumnos INT DEFAULT 0;
    SELECT COUNT(*)
    INTO total_alumnos
    FROM alumno;
    SELECT total_alumnos;
END $$
DELIMITER ;

CALL getTotalAlumnos;