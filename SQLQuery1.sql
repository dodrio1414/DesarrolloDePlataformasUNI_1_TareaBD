--BASE de datos Ejemplo
--Yturriaga Rodrigo
--8/8/2022

use master
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
go

use BDUniversidad
go

--crear tablas de la DB

--TABLA 1
if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go
create table TEscuela
(
	CodEscuela char(3) primary Key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

--TABLA 2
if OBJECT_ID('TAlumno') is not null
	drop table TAlumno
go
create table TAlumno
(
	CodAlumno char(5) primary Key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac date,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela,
)
go

--Isercion de datos
--insert into TEscuela (CodEscuela, Escuela, Facultad)
--values
--(
	--'E01','Sistemas','Ingenieria',
	--'E02','Civil','Ingenieria',
	--'E03','Industrial','Ingenieria',
	--'E04','Ambiental','Ingenieria',
	--'E05','Arquitectura','Ingenieria'
--)
--go

-- Inserción de datos
--TEscuela
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go

-- Inserción de datos
--TAlumno
insert into TAlumno values('A0001','Yturriaga','Rodrigo','Cusco',29-12-1998,'E01')
insert into TAlumno values('A0002','Yturriaga','Diego','Cusco',29-12-1998,'E01')



select * from TEscuela
go

select * from TAlumno
go

