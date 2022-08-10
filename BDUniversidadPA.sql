--Procediminetos alamacenados
--Yturriaga AGuirre
--8/08/2022

--PA para TEscuela
use BDUniversidad
go

--list a data from a table 
if OBJECT_ID('spListarEscuela') is not null
	drop procedure spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go


--Add data in a PA from a table Escuela
if OBJECT_ID('spAgregarEscuela') is not null
	drop procedure spAgregarEscuela
go

create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	--CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--Escuela no puede ser duplicado
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			--si todo esta validado pasa a ingresar datos
			begin
				insert into TEscuela values(@CodEscuela, @Escuela, @Facultad)
				select CodError = 0, Mensaje='Se inserto correctamente escuela'
				select CodEscuela, Escuela, Facultad from TEscuela
			end
		--Si esta todo invalido pasara a dar el mensaje de error
		else select codError = 1, Mensaje = 'Error: Escuela duplicada'
	else select codError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go

exec spAgregarEscuela "E06","Derecho","Derecho" 
go

--remove in a PA from a table Escuela
if OBJECT_ID('spRemoveEscuela') is not null
	drop procedure spRemoveEscuela
go

create proc spRemoveEscuela
@CodEscuela char(3)
as
begin
	--CodEscuela no puede ser duplicado
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--Escuela no puede ser duplicado
		--si todo esta validado pasa a ingresar datos
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodEscuela, Escuela, Facultad from TEscuela
			select codError = 1, Mensaje = 'Error: La escuela fue borrada correctamente'
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go


exec spRemoveEscuela "E06"
go

--Update in a PA from a table Escuela
if OBJECT_ID('spUpdateEscuela') is not null
	drop procedure spUpdateEscuela
go

create proc spUpdateEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	--CodEscuela tiene que existir para hacer los cambios
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--si todo esta validado pasa a ingresar datos
		begin
			update TEscuela set Escuela = @Escuela, Facultad=@Facultad
			where CodEscuela=@CodEscuela
			select CodEscuela, Escuela, Facultad from TEscuela
			where CodEscuela=@CodEscuela
			
		end
		--Si esta todo invalido pasara a dar el mensaje de error
	else select codError = 1, Mensaje = 'Error: CodEscuela no encontrado'
end
go

exec spUpdateEscuela "E01", "ahora si", "pipipipi"  
go

exec spUpdateEscuela "E10", "ahora si", "pipipipi"  
go


--Search in a PA from a table Escuela
if OBJECT_ID('spSearchEscuela') is not null
	drop procedure spSearchEscuela
go

create proc spSearchEscuela
@CodEscuela char(3)
as
begin
	--CodEscuela tiene que existir para hacer la busqueda
		if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		--si todo esta validado pasa a ingresar datos
			begin
				select CodEscuela, Escuela, Facultad from TEscuela
				where CodEscuela=@CodEscuela
			end
		--Si esta todo invalido pasara a dar el mensaje de error
		else select codError = 1, Mensaje = 'Error: CodEscuela no encontrado'
end
go

exec spSearchEscuela "E05"
go

exec spSearchEscuela "E10"
go

