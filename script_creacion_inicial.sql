USE [GD1C2022]
GO

CREATE PROCEDURE crear_esquema AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name='NOCURSOMASLOSSABADOS')
		EXEC ('CREATE SCHEMA NOCURSOMASLOSSABADOS')
END
GO

----------CREACION DE TABLAS-------------------
CREATE PROCEDURE crear_tablas AS
BEGIN

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Pais')
		DROP TABLE [NOCURSOMASLOSSABADOS].Pais;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Pais(
		pais_codigo int identity(1,1) NOT NULL,
		pais_descripcion nvarchar(255),
		CONSTRAINT PK_PAIS PRIMARY KEY(pais_codigo)
	)
	GO

	
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Escuderia')
		DROP TABLE [NOCURSOMASLOSSABADOS].Escuderia;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Escuderia(
		escuderia_codigo int identity(1,1) NOT NULL,
		escuderia_nombre nvarchar(255),
		escuderia_pais int,
		CONSTRAINT PK_ESCUDERIA PRIMARY KEY(escuderia_codigo),
		CONSTRAINT FK_id_PAIS FOREIGN KEY(escuderia_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)
	GO

	
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Modelo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Modelo (
	  auto_modelo_codigo int identity(1,1) NOT NULL,
	  auto_modelo_descripcion nvarchar(255),
	  CONSTRAINT PK_AUTO_MODELO PRIMARY KEY(auto_modelo_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Piloto')
		DROP TABLE [NOCURSOMASLOSSABADOS].Piloto;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Piloto(
		piloto_codigo int identity(1,1) NOT NULL,
		piloto_nombre nvarchar(50),
		piloto_apellido nvarchar(50),
		piloto_pais int,
		piloto_fecha_nacimiento date
		CONSTRAINT PK_PILOTO PRIMARY KEY(piloto_codigo)
		CONSTRAINT FK_PAIS_codigo FOREIGN KEY(piloto_pais) REFERENCES[NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)
	GO
	

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto (
	  auto_codigo int identity(1,1) NOT NULL,
	  auto_escuderia int,
	  auto_piloto int,
	  auto_modelo int,
	  auto_numero int,
	  CONSTRAINT PK_AUTO PRIMARY KEY(auto_codigo),
	  CONSTRAINT FK_id_AUTO_ESCUDERIA FOREIGN KEY(auto_escuderia) REFERENCES [NOCURSOMASLOSSABADOS].[Escuderia] (escuderia_codigo),
	  CONSTRAINT FK_id_AUTO_PILOTO FOREIGN KEY(auto_piloto) REFERENCES [NOCURSOMASLOSSABADOS].[Piloto] (piloto_codigo),
	  CONSTRAINT FK_id_AUTO_MODELO FOREIGN KEY(auto_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Auto_Modelo] (auto_modelo_codigo)
	)
	GO
	

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Circuito')
		DROP TABLE [NOCURSOMASLOSSABADOS].Circuito;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Circuito(
		circuito_codigo int NOT NULL,
		circuito_nombre nvarchar(255),
		circuito_pais int,
		CONSTRAINT PK_CIRCUITO PRIMARY KEY(circuito_codigo),
		CONSTRAINT FK_codigo_PAIS FOREIGN KEY(circuito_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Carrera;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Carrera(
		carrera_codigo int NOT NULL,
		carrera_circuito int,
		carrera_cantidad_vueltas int,
		carrera_fecha date,
		carrera_clima nvarchar(100),
		carrera_total_carrera decimal(18,2)
		CONSTRAINT PK_CARRERA PRIMARY KEY(carrera_codigo),
		CONSTRAINT FK_id_CIRCUITO FOREIGN KEY(carrera_circuito) REFERENCES [NOCURSOMASLOSSABADOS].[Circuito](circuito_codigo)
	)
	GO

	
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Carrera;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Carrera(
		auto_carrera_codigo int identity(1,1) NOT NULL,
		auto_carrera_auto int,
		auto_carrera_carrera int,
		CONSTRAINT PK_AUTO_CARRERA PRIMARY KEY(auto_carrera_codigo),
		CONSTRAINT FK_id_AUTO FOREIGN KEY(auto_carrera_auto) REFERENCES [NOCURSOMASLOSSABADOS].[Auto](auto_codigo),
		CONSTRAINT FK_id_CARRERA FOREIGN KEY(auto_carrera_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo)
	)
	GO

	 
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Bandera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Bandera;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Bandera(
		bandera_codigo int identity(1,1) NOT NULL,
		bandera_color nvarchar(255),
		CONSTRAINT PK_BANDERA PRIMARY KEY(bandera_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Sector_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Sector_Tipo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Sector_Tipo(
		sector_tipo_codigo int identity(1,1) NOT NULL,
		sector_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_SECTOR_TIPO PRIMARY KEY(sector_tipo_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Sector')
		DROP TABLE [NOCURSOMASLOSSABADOS].Sector;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Sector(
		sector_codigo int NOT NULL,
		sector_circuito int,
		sector_distancia decimal(18,2),
		sector_tipo int,
		CONSTRAINT PK_SECTOR PRIMARY KEY(sector_codigo),
		CONSTRAINT FK_id_SECTOR_CIRCUITO FOREIGN KEY(sector_circuito) REFERENCES [NOCURSOMASLOSSABADOS].[Circuito](circuito_codigo),
		CONSTRAINT FK_id_TIPO_SECTOR FOREIGN KEY(sector_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Sector_Tipo](sector_tipo_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Incidente_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Incidente_Tipo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Incidente_Tipo(
		incidente_tipo_codigo int identity(1,1) NOT NULL,
		incidente_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_INCIDENTE_TIPO PRIMARY KEY(incidente_tipo_codigo)
	)
	GO
	

	
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].Incidente;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Incidente(
		incidente_codigo int identity(1,1) NOT NULL,
		incidente_sector int,
		incidente_carrera int,
		incidente_tiempo decimal(18,2),
		incidente_bandera int,
		CONSTRAINT PK_INCIDENTE PRIMARY KEY(incidente_codigo),
		CONSTRAINT FK_id_INCIDENTE_CARRERA FOREIGN KEY(incidente_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo),
		CONSTRAINT FK_id_INCIDENTE_SECTOR FOREIGN KEY(incidente_sector) REFERENCES [NOCURSOMASLOSSABADOS].[Sector](sector_codigo),
		CONSTRAINT FK_id_BANDERA FOREIGN KEY(incidente_bandera) REFERENCES [NOCURSOMASLOSSABADOS].[Bandera](bandera_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Incidente;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Incidente(
		auto_incidente_codigo int identity(1,1) NOT NULL,
		auto_incidente_auto int,
		auto_incidente_incidente_codigo int,
		auto_incidente_tipo int,
		auto_incidente_numero_vuelta decimal(18,0),
		CONSTRAINT PK_AUTO_INCIDENTE PRIMARY KEY(auto_incidente_codigo),
		CONSTRAINT FK_id_INCIDENTE_AUTO FOREIGN KEY(auto_incidente_auto) REFERENCES [NOCURSOMASLOSSABADOS].[Auto](Auto_codigo),
		CONSTRAINT FK_id_INCIDENTE FOREIGN KEY(auto_incidente_incidente_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Incidente](incidente_codigo),
		CONSTRAINT FK_id_INCIDENTE_TIPO FOREIGN KEY(auto_incidente_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Incidente_Tipo](incidente_tipo_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Medicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Medicion(
	medicion_codigo decimal(18,0) NOT NULL,
	medicion_auto_carrera int,
	medicion_sector int,
	medicion_numero_vuelta decimal(18,0),
	medicion_distancia_carrera decimal(18,6),
	medicion_distancia_vuelta decimal(18,2),
	medicion_tiempo_vuelta decimal(18,10),
	medicion_posicion decimal(18,0),
	medicion_velocidad decimal(18,2),
	medicion_combustible decimal(18,2),
	CONSTRAINT PK_MEDICION PRIMARY KEY(medicion_codigo),
	CONSTRAINT FK_id_medicion_AUTO_CARRERA FOREIGN KEY(medicion_auto_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Auto_Carrera](auto_carrera_codigo),
	CONSTRAINT FK_id_medicion_SECTOR FOREIGN KEY(medicion_sector) REFERENCES [NOCURSOMASLOSSABADOS].[Sector](sector_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor_Modelo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Modelo(
		motor_modelo_codigo int identity(1,1) NOT NULL,
		motor_modelo_descripcion nvarchar(255),
		CONSTRAINT PK_MOTOR PRIMARY KEY(motor_modelo_codigo),
	)
	GO



	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Motor(
		motor_numero_serie nvarchar(255) NOT NULL,
		motor_modelo int,
		CONSTRAINT PK_MOTOR_nor_serie PRIMARY KEY(motor_numero_serie),
		CONSTRAINT FK_id_MOTOR_MODELO FOREIGN KEY(motor_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Motor_Modelo](motor_modelo_codigo)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor_Medicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Medicion(
		motor_medicion_codigo int identity(1,1) NOT NULL,
		motor_medicion_medicion decimal(18,0),
		motor_medicion_motor_numero_serie nvarchar(255),
		motor_medicion_potencia decimal(18,6),
		motor_medicion_temperatura_aceite decimal(18,6),
		motor_medicion_temperatura_agua decimal(18,6),
		motor_medicion_rpm decimal(18,6),
		CONSTRAINT PK_MOTOR_MEDICION PRIMARY KEY(motor_medicion_codigo),
		CONSTRAINT FK_id_MEDICION FOREIGN KEY(motor_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
		CONSTRAINT FK_id_MOTOR FOREIGN KEY(motor_medicion_motor_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Motor](motor_numero_serie)
	)
	GO
	

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_De_Cambio_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Modelo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Modelo(
		caja_modelo_codigo int identity(1,1) NOT NULL,
		caja_modelo_descripcion nvarchar(50),
		CONSTRAINT PK_CAJA_CAMBIO PRIMARY KEY(caja_modelo_codigo),
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_de_cambio')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_de_cambio;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_de_cambio(
		caja_numero_serie nvarchar(255) NOT NULL,
		caja_modelo int,
		CONSTRAINT PK_CAJA_DE_CAMBIO PRIMARY KEY(caja_numero_serie),
		CONSTRAINT FK_id_CAJA_DE_CAMBIO_MODELO FOREIGN KEY(caja_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Caja_De_Cambio_Modelo](caja_modelo_codigo)	
	)
	GO

	
	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_De_Cambio_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion(
		caja_medicion_codigo int identity(1,1) NOT NULL,
		caja_medicion_medicion decimal(18,0),
		caja_medicion_caja_numero_serie nvarchar(255),
		caja_medicion_temperatura_aceite decimal(18,2),
		caja_medicion_rpm decimal(18,2),
		caja_medicion_desgaste decimal(18,2),
		CONSTRAINT PK_CAJA_DE_CAMBIO_MEDICION PRIMARY KEY(caja_medicion_codigo),
		CONSTRAINT FK_id_CAJA_MEDICION FOREIGN KEY(caja_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
		CONSTRAINT FK_id_CAJA_DE_CAMBIO FOREIGN KEY(caja_medicion_caja_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Caja_De_Cambio](caja_numero_serie)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Posicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Posicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Posicion(
		posicion_codigo int identity(1,1) NOT NULL,
		posicion_posicion nvarchar(255),
		CONSTRAINT PK_POSICION PRIMARY KEY(posicion_codigo)	
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Freno')
		DROP TABLE [NOCURSOMASLOSSABADOS].Freno;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Freno(
		freno_numero_serie nvarchar(255) NOT NULL,
		freno_posicion int,
		freno_tamanio_disco decimal(18,2)
		CONSTRAINT PK_FRENO PRIMARY KEY(freno_numero_serie),
		CONSTRAINT FK_id_POSICION FOREIGN KEY(freno_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
	)
	GO

	

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Freno_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Freno_medicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Freno_medicion(
		freno_medicion_codigo int identity(1,1) NOT NULL,
		freno_medicion_medicion decimal(18,0),
		freno_medicion_freno_numero_serie nvarchar(255),
		freno_medicion_grosor decimal(18,2),
		freno_medicion_temperatura decimal(18,2),
		CONSTRAINT PK_FRENO_MEDICION PRIMARY KEY(freno_medicion_codigo),
		CONSTRAINT FK_id_FRENO_MEDICION FOREIGN KEY(freno_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
		CONSTRAINT FK_id_FRENO FOREIGN KEY(freno_medicion_freno_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Freno](freno_numero_serie)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico_Tipo;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico_Tipo(
		neumatico_tipo_codigo int identity(1,1) NOT NULL,
		neumatico_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_NEUMATICO_TIPO PRIMARY KEY(neumatico_tipo_codigo),
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico(
		neumatico_numero_serie nvarchar(255) NOT NULL,
		neumatico_tipo int,
		neumatico_posicion int,
		CONSTRAINT PK_NEUMATICO PRIMARY KEY(neumatico_numero_serie),
		CONSTRAINT FK_id_NEUMATICO_TIPO FOREIGN KEY(neumatico_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico_Tipo](neumatico_tipo_codigo),
		CONSTRAINT FK_id_NEUMATICO_POSICION FOREIGN KEY(neumatico_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico_Medicion;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico_Medicion(
		neumatico_medicion_codigo int identity(1,1) NOT NULL,
		neumatico_medicion_medicion decimal(18,0),
		neumatico_medicion_neumatico_numero_serie nvarchar(255),
		neumatico_medicion_profundidad decimal(18,6),
		neumatico_medicion_presion decimal(18,6),
		neumatico_medicion_temperatura decimal(18,6),
		CONSTRAINT PK_NEUMATICO_MEDICION PRIMARY KEY(neumatico_medicion_codigo),
		CONSTRAINT FK_id_NEUMATICO_MEDICION FOREIGN KEY(neumatico_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
		CONSTRAINT FK_id_NEUMATICO FOREIGN KEY(neumatico_medicion_neumatico_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie)
	)
	GO


	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Parada_Box')
		DROP TABLE [NOCURSOMASLOSSABADOS].Parada_Box;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Parada_Box(
		parada_codigo int identity(1,1) NOT NULL,
		parada_auto_carrera int,
		parada_numero_vuelta decimal(18,0),
		parada_tiempo decimal(18,2),
		CONSTRAINT PK_PARADA_BOX PRIMARY KEY(parada_codigo),
		CONSTRAINT FK_id_AUTO_CARRERA FOREIGN KEY(parada_auto_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Auto_Carrera](auto_carrera_codigo),
	)
	GO
	

	IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Cambio_Por_Neumatico')
		DROP TABLE [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico;
	CREATE TABLE [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico(
		cambio_por_neumatico_codigo int identity(1,1) NOT NULL,
		cambio_parada_box_codigo int,
		cambio_por_neumatico_nuevo_codigo nvarchar(255),
		cambio_por_neumatico_viejo_codigo nvarchar(255),
		CONSTRAINT PK_CAMBIO_POR_NEUMATICO PRIMARY KEY(cambio_por_neumatico_codigo),
		CONSTRAINT FK_id_PARADA_BOX FOREIGN KEY(cambio_parada_box_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Parada_Box](parada_codigo),
		CONSTRAINT FK_id_NEUMATICO_NUEVO FOREIGN KEY(cambio_por_neumatico_nuevo_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie),
		CONSTRAINT FK_id_NEUMATICO_VIEJO FOREIGN KEY(cambio_por_neumatico_viejo_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie)
	)
	GO

END 
GO



	--SELECT AC.auto_carrera_codigo, AM.auto_modelo_descripcion, CIR.circuito_nombre, ESCU.escuderia_nombre  
	--FROM NOCURSOMASLOSSABADOS.Auto_Carrera as AC 
	--INNER JOIN NOCURSOMASLOSSABADOS.Auto as A ON AC.auto_carrera_auto = A.auto_codigo 
	--INNER JOIN NOCURSOMASLOSSABADOS.Auto_Modelo as AM ON A.auto_codigo = AM.auto_modelo_codigo 
	--INNER JOIN NOCURSOMASLOSSABADOS.Carrera as C ON C.carrera_codigo = AC.auto_carrera_carrera 
	--INNER JOIN NOCURSOMASLOSSABADOS.Circuito as CIR ON CIR.circuito_codigo = C.carrera_codigo 
	--INNER JOIN NOCURSOMASLOSSABADOS.Escuderia as ESCU ON ESCU.escuderia_codigo = A.auto_codigo

---------------------------------------------------------------------------------------------------------------------------------------------


----------CRECACIÓN DE PROCEDURES PARA MIGRACIÓN DE TABLAS-------------------
	
-- Carga de tabla pais
CREATE PROCEDURE cargar_tabla_pais
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Pais (pais_descripcion)
		(select distinct CIRCUITO_PAIS
		from gd_esquema.Maestra	)
		union
		(select distinct ESCUDERIA_NACIONALIDAD
		from gd_esquema.Maestra	)
		union
		(select distinct PILOTO_NACIONALIDAD
		from gd_esquema.Maestra	)
END
GO


-- Carga de tabla escuderia
CREATE PROCEDURE cargar_tabla_escuderia
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Escuderia (escuderia_nombre, escuderia_pais)
	SELECT DISTINCT 
		ESCUDERIA_NOMBRE,
		pais_codigo
	FROM gd_esquema.Maestra
	JOIN [NOCURSOMASLOSSABADOS].Pais ON ESCUDERIA_NACIONALIDAD = pais_descripcion
END
GO
	

-- Carga de tabla Auto_modelo
CREATE PROCEDURE cargar_tabla_auto_modelo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Auto_Modelo (auto_modelo_descripcion)
	SELECT DISTINCT 
		AUTO_MODELO
	FROM gd_esquema.Maestra
END
GO
	


-- Carga de tabla Piloto
CREATE PROCEDURE cargar_tabla_piloto
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Piloto (piloto_nombre, piloto_apellido, piloto_pais, piloto_fecha_nacimiento)
	SELECT DISTINCT 
		PILOTO_NOMBRE, 
		PILOTO_APELLIDO,
		pais_codigo,
		PILOTO_FECHA_NACIMIENTO
	FROM gd_esquema.Maestra
	JOIN [NOCURSOMASLOSSABADOS].Pais ON pais_descripcion = PILOTO_NACIONALIDAD
END
GO


-- Carga de tabla Auto
CREATE PROCEDURE cargar_tabla_auto
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Auto (auto_escuderia, auto_piloto, auto_modelo, auto_numero)
	SELECT DISTINCT 
		e.escuderia_codigo,
		p.piloto_codigo,
		a.auto_modelo_codigo,
		AUTO_NUMERO
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Escuderia] e ON e.escuderia_nombre = m.ESCUDERIA_NOMBRE
	JOIN [NOCURSOMASLOSSABADOS].[Piloto] p ON p.piloto_nombre = m.PILOTO_NOMBRE AND p.piloto_apellido = m.PILOTO_APELLIDO
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] a ON a.auto_modelo_descripcion = m.AUTO_MODELO
END
GO
	


-- Carga de tabla Circuito
CREATE PROCEDURE cargar_tabla_circuito
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Circuito (circuito_codigo, circuito_nombre, circuito_pais)
	SELECT DISTINCT 
		CIRCUITO_CODIGO,
		CIRCUITO_NOMBRE,
		p.pais_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Pais] p ON p.pais_descripcion = m.CIRCUITO_PAIS
END
GO

	
-- Carga de tabla Carrera
CREATE PROCEDURE cargar_tabla_carrera
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Carrera 
		(carrera_codigo, carrera_circuito, carrera_cantidad_vueltas, carrera_fecha, carrera_clima, carrera_total_carrera)
	SELECT DISTINCT 
		CODIGO_CARRERA,
		CIRCUITO_CODIGO,
		CARRERA_CANT_VUELTAS,
		CARRERA_FECHA,
		CARRERA_CLIMA,
		CARRERA_TOTAL_CARRERA
	FROM gd_esquema.Maestra
END
GO

	
	
-- Carga de tabla Auto_Carrera
--VER SI ESTÁ BIEN CARGADA ESTA TABLA
CREATE PROCEDURE cargar_tabla_auto_carrera
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Auto_Carrera (auto_carrera_auto, auto_carrera_carrera)
	SELECT distinct
		a.auto_codigo,
		CODIGO_CARRERA
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Auto] a ON a.auto_numero = m.AUTO_NUMERO
	--JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] am ON am.auto_modelo_descripcion = m.AUTO_MODELO
	order by CODIGO_CARRERA
END
GO

		
--select * from [NOCURSOMASLOSSABADOS].auto_carrera 
--select * from [NOCURSOMASLOSSABADOS].Auto_Modelo
--select * from [NOCURSOMASLOSSABADOS].Carrera
	
--am 6 (FW28) -   carr 1  -  tiene al auto_numero 1 y 2    -- son los auto codigo 10 y 8

--select distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA FROM gd_esquema.Maestra m where CODIGO_CARRERA = 1 order by AUTO_MODELO
	
	 
	
-- Carga de tabla Bandera
CREATE PROCEDURE cargar_tabla_bandera
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Bandera (bandera_color)
	SELECT distinct
		INCIDENTE_BANDERA
	FROM gd_esquema.Maestra
	WHERE INCIDENTE_BANDERA IS NOT NULL
END
GO



-- Carga de tabla Sector_tipo
CREATE PROCEDURE cargar_tabla_sector_tipo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Sector_Tipo (sector_tipo_descripcion)
	SELECT distinct
		SECTO_TIPO
	FROM gd_esquema.Maestra
END
GO
	
		
-- Carga de tabla Sector
CREATE PROCEDURE cargar_tabla_sector
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Sector (sector_codigo, sector_circuito, sector_distancia, sector_tipo)
	SELECT distinct
		CODIGO_SECTOR,
		CIRCUITO_CODIGO,
		SECTOR_DISTANCIA,
		st.sector_tipo_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Sector_Tipo] st ON st.sector_tipo_descripcion = m.SECTO_TIPO
	ORDER BY CODIGO_SECTOR
END
GO
	

-- Carga de tabla Incidente_tipo
CREATE PROCEDURE cargar_tabla_incidente_tipo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Incidente_Tipo (incidente_tipo_descripcion)
	SELECT distinct
		INCIDENTE_TIPO
	FROM gd_esquema.Maestra
	WHERE INCIDENTE_TIPO IS NOT NULL
END
GO


-- Carga de tabla Incidente
--OJO QUE EN EL CODIGO_SECTOR 36 HAY DOS INCIDENTES TIEMPO IGUALES. VER SI EST'A BIEN O NO QUE ESTA TABLA SOLO SE CARGUE UNA VEZ CON ESE DATO O QUE
CREATE PROCEDURE cargar_tabla_incidente
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Incidente (incidente_sector, incidente_carrera, incidente_tiempo, incidente_bandera)
	SELECT distinct
		CODIGO_SECTOR,
		CODIGO_CARRERA,
		INCIDENTE_TIEMPO,
		b.bandera_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Bandera] b ON b.bandera_color = m.INCIDENTE_BANDERA
END
GO


-- Carga de tabla Auto_incidente
--CHEQUEAR ESTE. tiene que devolver 60 filas creo. chequear pq puede estar mal tranquilamente
CREATE PROCEDURE cargar_tabla_auto_incidente
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Auto_Incidente 
		(auto_incidente_auto, auto_incidente_incidente_codigo, auto_incidente_tipo, auto_incidente_numero_vuelta)
	SELECT distinct
		a.auto_codigo,
		i.incidente_codigo,
		it.incidente_tipo_codigo,
		m.INCIDENTE_NUMERO_VUELTA
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] am ON am.auto_modelo_descripcion = m.AUTO_MODELO
	JOIN [NOCURSOMASLOSSABADOS].[Auto] a ON a.auto_modelo = am.auto_modelo_codigo AND a.auto_numero = m.AUTO_NUMERO
	JOIN [NOCURSOMASLOSSABADOS].[Incidente] i ON 
							i.incidente_sector = m.CODIGO_SECTOR
							AND i.incidente_carrera = m.CODIGO_CARRERA
							AND i.incidente_tiempo = m.INCIDENTE_TIEMPO
	JOIN [NOCURSOMASLOSSABADOS].[Incidente_Tipo] it ON it.incidente_tipo_descripcion = m.INCIDENTE_TIPO
	WHERE INCIDENTE_NUMERO_VUELTA IS NOT NULL
END
GO

--SELECT * FROM gd_esquema.Maestra WHERE INCIDENTE_TIEMPO IS NOT NULL AND AUTO_MODELO = 'RA106'
--select * from [NOCURSOMASLOSSABADOS].[Incidente]
--select * from [NOCURSOMASLOSSABADOS].[Incidente_Tipo]
--select * from [NOCURSOMASLOSSABADOS].[Auto_Modelo] --'RA106' es auto_modelo_codigo 3
--select * from [NOCURSOMASLOSSABADOS].[Auto] --q lo tienen auto 11 O 18




-- Carga de tabla Medicion
---creo que tiene que dar 218641 filas
--CHEQUEAR que es importamte y dificil.
CREATE PROCEDURE cargar_tabla_medicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Medicion 
		(medicion_codigo, medicion_auto_carrera, medicion_sector, medicion_numero_vuelta, medicion_distancia_carrera, 
		medicion_distancia_vuelta, medicion_tiempo_vuelta, medicion_posicion, medicion_velocidad, medicion_combustible)
	SELECT distinct
		m.TELE_AUTO_CODIGO,
		ac.auto_carrera_codigo,
		m.CODIGO_SECTOR,
		m.TELE_AUTO_NUMERO_VUELTA,
		m.TELE_AUTO_DISTANCIA_CARRERA,
		m.TELE_AUTO_DISTANCIA_VUELTA,
		m.TELE_AUTO_TIEMPO_VUELTA,
		m.TELE_AUTO_POSICION,
		m.TELE_AUTO_VELOCIDAD,
		m.TELE_AUTO_COMBUSTIBLE
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] am ON am.auto_modelo_descripcion = m.AUTO_MODELO
	JOIN [NOCURSOMASLOSSABADOS].[Auto] a ON a.auto_modelo = am.auto_modelo_codigo AND a.auto_numero = m.AUTO_NUMERO
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Carrera] ac ON ac.auto_carrera_auto = a.auto_codigo AND ac.auto_carrera_carrera = m.CODIGO_CARRERA
	WHERE TELE_AUTO_CODIGO IS NOT NULL
END
GO
	
select * from [NOCURSOMASLOSSABADOS].Medicion 

--el tele_auto_codigo 1 es del modelo 248 F1   auto_numero 1  . es el autocarrera 17. que es auto 12   carrera 1. auto modelo =2
--el tele_auto_codigo 120830 es del modelo SA05   auto_numero 1  . el autocarrera 63. que es auto 7   carrera 4. auto modelo =8
--select * from [NOCURSOMASLOSSABADOS].Auto_Carrera
--select * from [NOCURSOMASLOSSABADOS].Auto
--select * from [NOCURSOMASLOSSABADOS].Auto_Modelo



-- Carga de tabla Motor_Modelo
CREATE PROCEDURE cargar_tabla_motor_modelo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Motor_Modelo (motor_modelo_descripcion)
	SELECT distinct
		TELE_MOTOR_MODELO
	FROM gd_esquema.Maestra
	WHERE TELE_MOTOR_MODELO IS NOT NULL
END
GO


-- Carga de tabla Motor
--NO SE CARGA EN ORDEN NOSE PORQUE
CREATE PROCEDURE cargar_tabla_motor
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Motor (motor_numero_serie, motor_modelo)
	SELECT distinct
		TELE_MOTOR_NRO_SERIE,
		mm.motor_modelo_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Motor_Modelo] mm ON mm.motor_modelo_descripcion = m.TELE_MOTOR_MODELO
	WHERE TELE_MOTOR_NRO_SERIE IS NOT NULL
	ORDER BY mm.motor_modelo_codigo
END
GO

--select * from NOCURSOMASLOSSABADOS.Motor 


-- Carga de tabla motor_medicion
--chequear. devuelve el mismo numero que la tabla Medicion. estará bien eso?
CREATE PROCEDURE cargar_tabla_motor_medicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Motor_Medicion 
		(motor_medicion_medicion, motor_medicion_motor_numero_serie, motor_medicion_potencia,
		motor_medicion_temperatura_aceite, motor_medicion_temperatura_agua, motor_medicion_rpm)
	SELECT distinct
		med.medicion_codigo,
		m.TELE_MOTOR_NRO_SERIE,
		m.TELE_MOTOR_POTENCIA, 
		m.TELE_MOTOR_TEMP_ACEITE,
		m.TELE_MOTOR_TEMP_AGUA,
		m.TELE_MOTOR_RPM
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m.TELE_AUTO_CODIGO
END
GO
	

-- Carga de tabla Caja_De_Cambio_Modelo
CREATE PROCEDURE cargar_tabla_caja_de_cambio_modelo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Modelo (caja_modelo_descripcion)
	SELECT distinct
		TELE_CAJA_MODELO
	FROM gd_esquema.Maestra
	WHERE TELE_CAJA_MODELO IS NOT NULL
END
GO


-- Carga de tabla Caja_De_Cambio
--NO SE CARGA EN ORDEN NOSE PORQUE
CREATE PROCEDURE cargar_tabla_caja_de_cambio
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Caja_De_Cambio (caja_numero_serie, caja_modelo)
	SELECT distinct
		m.TELE_CAJA_NRO_SERIE,
		ccm.caja_modelo_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Caja_De_Cambio_Modelo] ccm ON ccm.caja_modelo_descripcion = m.TELE_CAJA_MODELO
	WHERE M.TELE_CAJA_NRO_SERIE IS NOT NULL
	ORDER BY CCM.caja_modelo_codigo
END
GO


-- Carga de tabla Caja_De_Cambio_medicion
--igual que el motor_medicion
CREATE PROCEDURE cargar_tabla_caja_de_cambio_medicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion 
		(caja_medicion_medicion, caja_medicion_caja_numero_serie, caja_medicion_temperatura_aceite, caja_medicion_rpm, caja_medicion_desgaste)
	SELECT distinct
		med.medicion_codigo,
		m.TELE_CAJA_NRO_SERIE,
		m.TELE_CAJA_TEMP_ACEITE,
		m.TELE_CAJA_RPM,
		m.TELE_CAJA_DESGASTE
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m.TELE_AUTO_CODIGO
END
GO


-- Carga de tabla Posicion
--SUPONGO QUE NO TIENE QUE HABER NULL NO?
--ver si hay manera mejor de hacerlo
CREATE PROCEDURE cargar_tabla_posicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Posicion (posicion_posicion)
		(select NEUMATICO1_POSICION_NUEVO from gd_esquema.Maestra where NEUMATICO1_POSICION_NUEVO is not null) union
		(select NEUMATICO1_POSICION_VIEJO from gd_esquema.Maestra where NEUMATICO1_POSICION_VIEJO is not null) union
		(select NEUMATICO2_POSICION_NUEVO from gd_esquema.Maestra where NEUMATICO2_POSICION_NUEVO is not null) union
		(select NEUMATICO2_POSICION_VIEJO from gd_esquema.Maestra where NEUMATICO2_POSICION_VIEJO is not null) union
		(select NEUMATICO3_POSICION_NUEVO from gd_esquema.Maestra where NEUMATICO3_POSICION_NUEVO is not null) union
		(select NEUMATICO3_POSICION_VIEJO from gd_esquema.Maestra where NEUMATICO3_POSICION_VIEJO is not null) union
		(select NEUMATICO4_POSICION_NUEVO from gd_esquema.Maestra where NEUMATICO4_POSICION_NUEVO is not null) union
		(select NEUMATICO4_POSICION_VIEJO from gd_esquema.Maestra where NEUMATICO4_POSICION_VIEJO is not null) union
		(select TELE_NEUMATICO1_POSICION from gd_esquema.Maestra where TELE_NEUMATICO1_POSICION is not null) union
		(select TELE_NEUMATICO2_POSICION from gd_esquema.Maestra where TELE_NEUMATICO2_POSICION is not null) union
		(select TELE_NEUMATICO3_POSICION from gd_esquema.Maestra where TELE_NEUMATICO3_POSICION is not null) union
		(select TELE_NEUMATICO4_POSICION from gd_esquema.Maestra where TELE_NEUMATICO4_POSICION is not null) union
		(select TELE_FRENO1_POSICION from gd_esquema.Maestra where TELE_FRENO1_POSICION is not null) union
		(select TELE_FRENO2_POSICION from gd_esquema.Maestra where TELE_FRENO2_POSICION is not null) union
		(select TELE_FRENO3_POSICION from gd_esquema.Maestra where TELE_FRENO3_POSICION is not null) union
		(select TELE_FRENO4_POSICION from gd_esquema.Maestra where TELE_FRENO4_POSICION is not null)
END
GO


-- Carga de tabla Freno
--no se carga ordenado
CREATE PROCEDURE cargar_tabla_freno
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Freno (freno_numero_serie, freno_posicion, freno_tamanio_disco)
		(select TELE_FRENO1_NRO_SERIE, p.posicion_codigo, TELE_FRENO1_TAMANIO_DISCO
		from gd_esquema.Maestra m
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p ON p.posicion_posicion = m.TELE_FRENO1_POSICION
		where TELE_FRENO1_NRO_SERIE is not null
		) 
	union
		(select TELE_FRENO2_NRO_SERIE, p1.posicion_codigo, TELE_FRENO2_TAMANIO_DISCO
		from gd_esquema.Maestra m2
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p1 ON p1.posicion_posicion = m2.TELE_FRENO2_POSICION
		where TELE_FRENO2_NRO_SERIE is not null
		) 
	union
		(select TELE_FRENO3_NRO_SERIE, p2.posicion_codigo, TELE_FRENO3_TAMANIO_DISCO
		from gd_esquema.Maestra m3
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p2 ON p2.posicion_posicion = m3.TELE_FRENO3_POSICION
		where TELE_FRENO3_NRO_SERIE is not null
		) 
	union
		(select TELE_FRENO4_NRO_SERIE, p3.posicion_codigo, TELE_FRENO4_TAMANIO_DISCO
		from gd_esquema.Maestra m4
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p3 ON p3.posicion_posicion = m4.TELE_FRENO4_POSICION
		where TELE_FRENO4_NRO_SERIE is not null)
	order by 2
END
GO
	


-- Carga de tabla Freno_medicion
--CHEQUEAR, PERO PARECE QUE ANDA BIEN.
CREATE PROCEDURE cargar_tabla_freno_medicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Freno_medicion 
		(freno_medicion_medicion, freno_medicion_freno_numero_serie, freno_medicion_grosor, freno_medicion_temperatura)
	
		(select med.medicion_codigo, TELE_FRENO1_NRO_SERIE, TELE_FRENO1_GROSOR_PASTILLA, TELE_FRENO1_TEMPERATURA
		from gd_esquema.Maestra m0
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m0.TELE_AUTO_CODIGO
		where TELE_FRENO1_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_FRENO2_NRO_SERIE, TELE_FRENO2_GROSOR_PASTILLA, TELE_FRENO2_TEMPERATURA
		from gd_esquema.Maestra m2
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m2.TELE_AUTO_CODIGO
		where TELE_FRENO2_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_FRENO3_NRO_SERIE, TELE_FRENO3_GROSOR_PASTILLA, TELE_FRENO3_TEMPERATURA
		from gd_esquema.Maestra m3
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m3.TELE_AUTO_CODIGO
		where TELE_FRENO3_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_FRENO4_NRO_SERIE, TELE_FRENO4_GROSOR_PASTILLA, TELE_FRENO4_TEMPERATURA
		from gd_esquema.Maestra m4
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m4.TELE_AUTO_CODIGO
		where TELE_FRENO4_NRO_SERIE is not null)
END
GO

--select * from [NOCURSOMASLOSSABADOS].Freno_medicion where freno_medicion_medicion = 81837
--select * from gd_esquema.Maestra where TELE_AUTO_CODIGO = 81837
--select * from [NOCURSOMASLOSSABADOS].Freno where freno_numero_serie = 'UQX921036' --trans izq


	
-- Carga de tabla Neumatico_Tipo
CREATE PROCEDURE cargar_tabla_neumatico_tipo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Neumatico_Tipo (neumatico_tipo_descripcion)
		(select NEUMATICO1_TIPO_NUEVO from gd_esquema.Maestra where NEUMATICO1_TIPO_NUEVO is not null) union
		(select NEUMATICO1_TIPO_VIEJO from gd_esquema.Maestra where NEUMATICO1_TIPO_VIEJO is not null) union
		(select NEUMATICO2_TIPO_NUEVO from gd_esquema.Maestra where NEUMATICO2_TIPO_NUEVO is not null) union
		(select NEUMATICO2_TIPO_VIEJO from gd_esquema.Maestra where NEUMATICO2_TIPO_VIEJO is not null) union
		(select NEUMATICO3_TIPO_NUEVO from gd_esquema.Maestra where NEUMATICO3_TIPO_NUEVO is not null) union
		(select NEUMATICO3_TIPO_VIEJO from gd_esquema.Maestra where NEUMATICO3_TIPO_VIEJO is not null) union
		(select NEUMATICO4_TIPO_NUEVO from gd_esquema.Maestra where NEUMATICO4_TIPO_NUEVO is not null) union
		(select NEUMATICO4_TIPO_VIEJO from gd_esquema.Maestra where NEUMATICO4_TIPO_VIEJO is not null)
END
GO
	

-- Carga de tabla Neumatico
--nose si tengo que seleccionar de NEUMATICO y TELE_NEUMATICO ??????? pensar
--SEGURO SE OPDIA HACER ALGUNA FUNCION PARA TODO ESTO
--cheqeuar que puede estar re mal

--select distinct NEUMATICO1_NRO_SERIE_viejo from gd_esquema.Maestra where NEUMATICO1_NRO_SERIE_viejo = 'XQQ633778'
--and NEUMATICO1_NRO_SERIE_NUEVO in(
--select TELE_NEUMATICO1_NRO_SERIE from gd_esquema.Maestra
--)

--708
--(select TELE_NEUMATICO1_NRO_SERIE from gd_esquema.Maestra) union
--(select TELE_NEUMATICO2_NRO_SERIE from gd_esquema.Maestra) union
--(select TELE_NEUMATICO3_NRO_SERIE from gd_esquema.Maestra) union
--(select TELE_NEUMATICO4_NRO_SERIE from gd_esquema.Maestra) union
--(select NEUMATICO1_NRO_SERIE_NUEVO from gd_esquema.Maestra) union
--(select NEUMATICO1_NRO_SERIE_VIEJO from gd_esquema.Maestra) union
--(select NEUMATICO2_NRO_SERIE_NUEVO from gd_esquema.Maestra) union
--(select NEUMATICO2_NRO_SERIE_VIEJO from gd_esquema.Maestra) union
--(select NEUMATICO3_NRO_SERIE_NUEVO from gd_esquema.Maestra) union
--(select NEUMATICO3_NRO_SERIE_VIEJO from gd_esquema.Maestra) union
--(select NEUMATICO4_NRO_SERIE_NUEVO from gd_esquema.Maestra) union
--(select NEUMATICO4_NRO_SERIE_VIEJO from gd_esquema.Maestra)
--order by 1

--(select m0.NEUMATICO1_NRO_SERIE_NUEVO
--	from gd_esquema.Maestra m0
--	where m0.NEUMATICO1_NRO_SERIE_NUEVO is not null
--	) 
--union
--	(select m1.NEUMATICO1_NRO_SERIE_VIEJO
--	from gd_esquema.Maestra m1
--	where m1.NEUMATICO1_NRO_SERIE_VIEJO is not null
--	) 

CREATE PROCEDURE cargar_tabla_neumatico
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Neumatico (neumatico_numero_serie, neumatico_tipo, neumatico_posicion) --380 filas
		(select m0.NEUMATICO1_NRO_SERIE_NUEVO, t0.neumatico_tipo_codigo, p0.posicion_codigo 
		from gd_esquema.Maestra m0
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p0 ON p0.posicion_posicion = m0.NEUMATICO1_POSICION_NUEVO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t0 ON t0.neumatico_tipo_descripcion = m0.NEUMATICO1_TIPO_NUEVO
		where m0.NEUMATICO1_NRO_SERIE_NUEVO is not null
		) 
	union
		(select m1.NEUMATICO1_NRO_SERIE_VIEJO, t1.neumatico_tipo_codigo, p1.posicion_codigo
		from gd_esquema.Maestra m1
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p1 ON p1.posicion_posicion = m1.NEUMATICO1_POSICION_VIEJO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t1 ON t1.neumatico_tipo_descripcion = m1.NEUMATICO1_TIPO_VIEJO
		where m1.NEUMATICO1_NRO_SERIE_VIEJO is not null
		) 
	union
		(select m2.NEUMATICO2_NRO_SERIE_NUEVO, t2.neumatico_tipo_codigo, p2.posicion_codigo
		from gd_esquema.Maestra m2
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p2 ON p2.posicion_posicion = m2.NEUMATICO2_POSICION_NUEVO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t2 ON t2.neumatico_tipo_descripcion = m2.NEUMATICO2_TIPO_NUEVO
		where m2.NEUMATICO2_NRO_SERIE_NUEVO is not null
		) 
	union
		(select m3.NEUMATICO2_NRO_SERIE_VIEJO, t3.neumatico_tipo_codigo, p3.posicion_codigo
		from gd_esquema.Maestra m3
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p3 ON p3.posicion_posicion = m3.NEUMATICO2_POSICION_VIEJO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t3 ON t3.neumatico_tipo_descripcion = m3.NEUMATICO2_TIPO_VIEJO
		where m3.NEUMATICO2_NRO_SERIE_VIEJO is not null
		) 
	union
		(select m4.NEUMATICO3_NRO_SERIE_NUEVO, t4.neumatico_tipo_codigo, p4.posicion_codigo
		from gd_esquema.Maestra m4
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p4 ON p4.posicion_posicion = m4.NEUMATICO3_POSICION_NUEVO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t4 ON t4.neumatico_tipo_descripcion = m4.NEUMATICO3_TIPO_NUEVO
		where m4.NEUMATICO3_NRO_SERIE_NUEVO is not null
		) 
	union
		(select m5.NEUMATICO3_NRO_SERIE_VIEJO, t5.neumatico_tipo_codigo, p5.posicion_codigo
		from gd_esquema.Maestra m5
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p5 ON p5.posicion_posicion = m5.NEUMATICO3_POSICION_VIEJO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t5 ON t5.neumatico_tipo_descripcion = m5.NEUMATICO3_TIPO_VIEJO
		where m5.NEUMATICO3_NRO_SERIE_VIEJO is not null
		) 
	union
		(select m6.NEUMATICO4_NRO_SERIE_NUEVO, t6.neumatico_tipo_codigo, p6.posicion_codigo
		from gd_esquema.Maestra m6
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p6 ON p6.posicion_posicion = m6.NEUMATICO4_POSICION_NUEVO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t6 ON t6.neumatico_tipo_descripcion = m6.NEUMATICO4_TIPO_NUEVO
		where m6.NEUMATICO4_NRO_SERIE_NUEVO is not null
		) 
	union
		(select m7.NEUMATICO4_NRO_SERIE_VIEJO, t7.neumatico_tipo_codigo, p7.posicion_codigo
		from gd_esquema.Maestra m7
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p7 ON p7.posicion_posicion = m7.NEUMATICO4_POSICION_VIEJO
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t7 ON t7.neumatico_tipo_descripcion = m7.NEUMATICO4_TIPO_VIEJO
		where m7.NEUMATICO4_NRO_SERIE_VIEJO is not null
		) 			
END
GO

--select * from [NOCURSOMASLOSSABADOS].Neumatico_Tipo
--select * from [NOCURSOMASLOSSABADOS].Posicion
--ABC229817  tipo 2 DURO    posic 4  del der
--select * from gd_esquema.Maestra where TELE_NEUMATICO1_NRO_SERIE = 'ABC229817'
--select * from gd_esquema.Maestra where NEUMATICO1_NRO_SERIE_VIEJO = 'ABC229817'
--select * from gd_esquema.Maestra where NEUMATICO1_NRO_SERIE_NUEVO = 'ABC229817'



-- Carga de tabla Neumatico_Medicion
--SEGURO SE OPDIA HACER ALGUNA FUNCION PARA TODO ESTO
--chequear. ni me fije si esta bien.
--NO FUNCIONA. 
CREATE PROCEDURE cargar_tabla_neumatico_medicion
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Neumatico_Medicion 
		(neumatico_medicion_medicion, neumatico_medicion_neumatico_numero_serie, neumatico_medicion_profundidad, 
		neumatico_medicion_presion, neumatico_medicion_temperatura)
			
		(select med.medicion_codigo, TELE_NEUMATICO1_NRO_SERIE, TELE_NEUMATICO1_PROFUNDIDAD, TELE_NEUMATICO1_PRESION, TELE_NEUMATICO1_TEMPERATURA
		from gd_esquema.Maestra m0
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m0.TELE_AUTO_CODIGO
		where TELE_NEUMATICO1_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_NEUMATICO2_NRO_SERIE, TELE_NEUMATICO2_PROFUNDIDAD, TELE_NEUMATICO2_PRESION, TELE_NEUMATICO2_TEMPERATURA
		from gd_esquema.Maestra m1
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m1.TELE_AUTO_CODIGO
		where TELE_NEUMATICO2_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_NEUMATICO3_NRO_SERIE, TELE_NEUMATICO3_PROFUNDIDAD, TELE_NEUMATICO3_PRESION, TELE_NEUMATICO3_TEMPERATURA
		from gd_esquema.Maestra m3
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m3.TELE_AUTO_CODIGO
		where TELE_NEUMATICO3_NRO_SERIE is not null
		) 
	union
		(select med.medicion_codigo, TELE_NEUMATICO4_NRO_SERIE, TELE_NEUMATICO4_PROFUNDIDAD, TELE_NEUMATICO4_PRESION, TELE_NEUMATICO4_TEMPERATURA
		from gd_esquema.Maestra m4
		JOIN [NOCURSOMASLOSSABADOS].[Medicion] med ON med.medicion_codigo = m4.TELE_AUTO_CODIGO
		where TELE_NEUMATICO4_NRO_SERIE is not null
		) 
END
GO

--exec cargar_tabla_neumatico_medicion --no anda
--select * from [NOCURSOMASLOSSABADOS].Neumatico_Medicion 

--select * from [NOCURSOMASLOSSABADOS].Neumatico

	
-- Carga de tabla Parada_Box
CREATE PROCEDURE cargar_tabla_parada_box
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Parada_Box (parada_auto_carrera, parada_numero_vuelta, parada_tiempo)
	SELECT DISTINCT
		ac.auto_carrera_codigo,
		m.PARADA_BOX_VUELTA,
		m.PARADA_BOX_TIEMPO
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] am ON am.auto_modelo_descripcion = m.AUTO_MODELO
	JOIN [NOCURSOMASLOSSABADOS].[Auto] a ON a.auto_modelo = am.auto_modelo_codigo AND a.auto_numero = m.AUTO_NUMERO
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Carrera] ac ON ac.auto_carrera_auto = a.auto_codigo AND ac.auto_carrera_carrera = m.CODIGO_CARRERA
	WHERE m.PARADA_BOX_TIEMPO IS NOT NULL
	order by ac.auto_carrera_codigo
END  
GO

--select * from [NOCURSOMASLOSSABADOS].Parada_Box

--ac 13
--select * from [NOCURSOMASLOSSABADOS].[Auto_Carrera] --ac 13    auto 7    carrera 1
--select * from gd_esquema.Maestra m where CODIGO_CARRERA = 1 and AUTO_MODELO = 'SA05' AND AUTO_NUMERO = 1 AND PARADA_BOX_VUELTA IS NOT NULL
--select * from [NOCURSOMASLOSSABADOS].[Auto] --modelo 8  numero 1
--select * from [NOCURSOMASLOSSABADOS].Auto_Modelo --modelo 8 = SA05



-- Carga de tabla Cambio_Por_Neumatico
CREATE PROCEDURE cargar_tabla_cambio_por_neumatico
AS
BEGIN
INSERT INTO [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico
	(cambio_parada_box_codigo, cambio_por_neumatico_nuevo_codigo, cambio_por_neumatico_viejo_codigo)
SELECT DISTINCT
	p.parada_box_codigo,
(SELECT N.neumatico_numero_serie FROM  [NOCURSOMASLOSSABADOS].Neumatico N WHERE N.neumatico_numero_serie = M.NEUMATICO1_NRO_SERIE_VIEJO)
FROM gd_esquema.Maestra M
WHERE M.NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL AND M.NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
	

--create procedure cargar_tabla_cambio_por_neumatico
--AS
--BEGIN
--INSERT INTO [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico(
--	cambio_parada_box_codigo,
--	cambio_por_neumatico_nuevo_codigo,
--	cambio_por_neumatico_viejo_codigo
--)
--SELECT DISTINCT
--	p.parada_box_codigo,
--(SELECT N.neumatico_numero_serie FROM  [NOCURSOMASLOSSABADOS].Neumatico N WHERE N.neumatico_numero_serie = M.NEUMATICO1_NRO_SERIE_VIEJO)
--FROM gd_esquema.Maestra M
--WHERE M.NEUMATICO1_NRO_SERIE_VIEJO IS NOT NULL AND M.NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL

END 
GO



----------EJECUCIÓN DE PROCEDURE PARA CREAR ESQUEMA-------------------
EXEC crear_esquema

----------EJECUCIÓN DE PROCEDURE PARA CREAR TABLAS-------------------
EXEC crear_tablas

----------EJECUCIÓN DE PROCEDURES PARA MIGRACIÓN DE TABLAS-------------------
EXEC cargar_tabla_pais
EXEC cargar_tabla_escuderia
EXEC cargar_tabla_auto_modelo
EXEC cargar_tabla_piloto
EXEC cargar_tabla_auto
EXEC cargar_tabla_circuito
EXEC cargar_tabla_carrera
EXEC cargar_tabla_auto_carrera
EXEC cargar_tabla_bandera
EXEC cargar_tabla_sector_tipo
EXEC cargar_tabla_sector
EXEC cargar_tabla_incidente_tipo
EXEC cargar_tabla_incidente
EXEC cargar_tabla_auto_incidente
EXEC cargar_tabla_medicion
EXEC cargar_tabla_motor_modelo
EXEC cargar_tabla_motor
EXEC cargar_tabla_motor_medicion
EXEC cargar_tabla_caja_de_cambio_modelo
EXEC cargar_tabla_caja_de_cambio
EXEC cargar_tabla_caja_de_cambio_medicion
EXEC cargar_tabla_posicion
EXEC cargar_tabla_freno
EXEC cargar_tabla_freno_medicion
EXEC cargar_tabla_neumatico_tipo
EXEC cargar_tabla_neumatico
EXEC cargar_tabla_neumatico_medicion
EXEC cargar_tabla_parada_box
EXEC cargar_tabla_cambio_por_neumatico


