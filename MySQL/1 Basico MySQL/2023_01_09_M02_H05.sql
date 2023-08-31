DROP DATABASE henry;
CREATE DATABASE henry;

-- 
/*
jdjasdjasjdas
jdaskdjaskd
*/

USE henry;
CREATE TABLE carrera (
	IdCarrera INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (IdCarrera)
);

CREATE TABLE instructor (
	idInstructor INT NOT NULL AUTO_INCREMENT,
    cedlulaIdentidad VARCHAR(30) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fechaIncorporacion DATE,
    PRIMARY KEY (idInstructor)
    );
    
CREATE TABLE cohorte (
	idcohorte INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(30) NOT NULL,
    idCarrera INT NOT NULL,
    idInstructor INT NOT NULL,
    fechaInicio DATE,
    fechaFinalizacion DATE,
    PRIMARY KEY (idCohorte),
    FOREIGN KEY (idCarrera) REFERENCES carrera(IdCarrera),
    FOREIGN KEY (idInstructor) REFERENCES instructor(idInstructor)
    );
    
CREATE TABLE alumno (
	idAlumno INT NOT NULL AUTO_INCREMENT,
    cedulaIdentidad VARCHAR(30) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    fechaIngreso DATE,
    idCohorte INT,
    PRIMARY KEY (idAlumno),
    FOREIGN KEY (idCohorte) REFERENCES cohorte(idCohorte)
);