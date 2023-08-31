USE henry;

INSERT INTO carrera (nombre)
	VALUES('Full Stack');

INSERT INTO instructor
VALUES (NULL, '575744', 'Jimena', 'Nada', '1985-04-04', '2021-01-01'),
		(NULL, '657765', 'Alberto', 'Sacardi', '1990-04-04', '2021-06-01');


INSERT INTO cohorte 
VALUES (NULL, 'data01', 1 , 2, '2022-04-25', '2022-10-10'),
		(NULL, 'data02', 1, 1, '2022-10-25', '2022-10-12');


INSERT INTO alumno
VALUES (NULL, '253651', 'Roberto', 'Jimenez', '1998-05-05', CURDATE(), 1),
		(NULL, '245521', 'Ana', 'Diaz', '1999-03-05', CURDATE(), 1),
        (NULL, '160644', 'Pedro', 'Alto', '2005-02-15', CURDATE(), 2);
        
UPDATE instructor
SET fechaNacimiento = '1985-04-05'
WHERE idInstructor = 1;

-- Consultar mi base de datos --
SELECT *
FROM instructor
-- WHERE idInstructor != 1
-- WHERE idInstructor <> 1
WHERE fechaNacimiento > '1980-01-01' ;

SELECT *
FROM alumno
-- WHERE fechaNacimiento BETWEEN '1998-01-01' AND '1999-01-01'
WHERE nombre LIKE '%ber%';

SELECT *
FROM alumno  
WHERE nombre = 'Roberto' OR nombre = 'Pedro';
-- WHERE nombre = 'Roberto' AND fechaIngreso > '2020-01-01';
-- WHERE nombre IN ('Roberto', 'Pedro');

