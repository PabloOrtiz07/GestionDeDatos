/*Cree el/los objetos de base de datos necesarios para corregir la tabla empleado
en caso que sea necesario. Se sabe que debería existir un único gerente general
(debería ser el único empleado sin jefe). Si detecta que hay más de un empleado
sin jefe deberá elegir entre ellos el gerente general, el cual será seleccionado por
mayor salario. Si hay más de uno se seleccionara el de mayor antigüedad en la
empresa. Al finalizar la ejecución del objeto la tabla deberá cumplir con la regla
de un único empleado sin jefe (el gerente general) y deberá retornar la cantidad
de empleados que había sin jefe antes de la ejecución.*/

IF OBJECT_ID('FX_JEFE') IS NOT NULL
	DROP FUNCTION FX_JEFE
CREATE PROCEDURE FX_JEFE (@CANTIDAD INT OUTPUT)
AS 
BEGIN
	DECLARE @GERENTE INT
	SET @CANTIDAD = (
		SELECT 
		SUM(empl_codigo)
		from Empleado 
		where empl_jefe is null)

if @cantidad > 1
	BEGIN
	SET @GERENTE=(
		SELECT TOP 1 
		empl_codigo
		from Empleado
		where empl_jefe is null
		order by empl_salario desc, empl_ingreso asc
	)

	update Empleado
	set empl_jefe=@GERENTE



	 
