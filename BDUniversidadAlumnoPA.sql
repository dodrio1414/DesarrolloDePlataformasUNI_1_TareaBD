--Procediminetos alamacenados
--Yturriaga AGuirre Rodrigo
--8/08/2022

--PA para TAlumno
use BDUniversidad
go

--list a data from a table TAlumno
--TAlumno
if OBJECT_ID('spListarTAlumno') is not null
	drop procedure spListarTAlumno
go

create proc spListarTAlumno
as
begin
	select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela  from TAlumno
end
go

exec spListarTAlumno
go
--
---
-----
--Add data in a PA from a table TAlumno
if OBJECT_ID('spAddTAlumno') is not null
	drop procedure spAddTAlumno
go

create proc spAddTAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), 
@LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)
as
begin
	--CodAlumno no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)		
		--si todo esta validado pasa a ingresar datos
		begin
			insert into TAlumno values(@CodAlumno, @Apellidos, @Nombres, @LugarNac, @FechaNac, @CodEscuela)
			select CodError = 0, Mensaje='Se inserto correctamente alumno'
			select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela  from TAlumno
			where CodAlumno=@CodAlumno
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

exec spAddTAlumno "A0016", "Quispe","Monchi","Arequipa",'2019-06-10',"E02" 
go


--remove in a PA from a table Escuela
if OBJECT_ID('spRemoveTAlumno') is not null
	drop procedure spRemoveTAlumno
go

create proc spRemoveTAlumno
@CodAlumno char(5)
as
begin
	--CodAlumno tiene que existir para eliminar 
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		--si todo esta validado pasa a ingresar datos
		begin
			delete from TAlumno where CodAlumno=@CodAlumno
			select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela  from TAlumno
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

exec spRemoveTAlumno "A0001"
go

exec spRemoveTAlumno "A0100"
go

--
---
----
-----
--Update in a PA from a table TAlumno
if OBJECT_ID('spUpdateTAlumno') is not null
	drop procedure spUpdateTAlumno
go

create proc spUpdateTAlumno
@CodAlumno char(5), @Apellidos varchar(50), @Nombres varchar(50), 
@LugarNac varchar(50), @FechaNac datetime, @CodEscuela char(3)
as
begin
	--CodEscuela no puede ser duplicado
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		
		begin
			update TAlumno set Apellidos=@Apellidos, Nombres= @Nombres, 
								LugarNac=@LugarNac, FechaNac=@FechaNac, CodEscuela=@CodEscuela
			where CodAlumno=@CodAlumno
			select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela  from TAlumno
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela no encontrado'
end
go

exec spUpdateTAlumno "A0002","ASD","ASD","Cusquito",'2019-06-10',"E02"
go


--
---
----
--Search in a PA from a table Escuela
if OBJECT_ID('spSearchTAlumno') is not null
	drop procedure spSearchTAlumno
go

create proc spSearchTAlumno
@CodAlumno char(5)
as
begin
	--CodAlumno no puede ser duplicado
		if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		--si todo esta validado pasa a ingresar datos
			begin
				select CodAlumno, Apellidos, Nombres, LugarNac, FechaNac, CodEscuela  from TAlumno
				where CodAlumno=@CodAlumno
			end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodAlumno no encontrado'
end
go

exec spSearchTAlumno "A0002"
go
exec spSearchTAlumno "A0006"
go