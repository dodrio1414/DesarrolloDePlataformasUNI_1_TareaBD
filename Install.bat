echo Instalador de la base de datos Universidad
echo Autor: Yturriaga Aguirre Rodrigo
echo 8 de Agosto 2022
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
sqlcmd -S. -E -i BDUniversidadAlumnoPA.sql
echo Se ejecuto correctamente la base de datos
pause