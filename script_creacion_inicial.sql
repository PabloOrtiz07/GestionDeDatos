USE [GD1C2022]
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name='NOCURSOMASLOSSABADOS')
BEGIN
	EXEC ('CREATE SCHEMA NOCURSOMASLOSSABADOS')
END
GO

/************************************/
/*			DROP STORE PROCEDURES	*/
/************************************/
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'crear_tablas')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.crear_tablas;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_pais')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_pais;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_escuderia')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_escuderia;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_auto_modelo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_modelo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_piloto')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_piloto;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_auto')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_circuito')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_circuito;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_carrera')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_carrera;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_auto_carrera')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_carrera;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_bandera')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_bandera;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_sector_tipo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_sector_tipo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_sector')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_sector;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_incidente_tipo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_incidente_tipo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_incidente')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_incidente;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_auto_incidente')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_incidente;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_medicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_medicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_motor_modelo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor_modelo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_motor')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_motor_medicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor_medicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_caja_de_cambio_modelo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_modelo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_caja_de_cambio')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_caja_de_cambio_medicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_medicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_posicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_posicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_freno')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_freno;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_freno_medicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_freno_medicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_neumatico_tipo')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_tipo;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_neumatico')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_neumatico_medicion')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_medicion;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_parada_box')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_parada_box;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_cambio_por_neumatico')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_cambio_por_neumatico;
GO


/************************************/
/*			DROP TABLAS				*/
/************************************/
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Cambio_Por_Neumatico')
		DROP TABLE [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Parada_Box')
		DROP TABLE [NOCURSOMASLOSSABADOS].Parada_Box;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico_Medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Neumatico_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Neumatico_Tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Freno_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Freno_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Freno')
		DROP TABLE [NOCURSOMASLOSSABADOS].Freno;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Posicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Posicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_De_Cambio_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_de_cambio')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_de_cambio;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Caja_De_Cambio_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Modelo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor_Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor_Medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Motor_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Motor_Modelo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].Medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].Incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Incidente_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Incidente_Tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Sector')
		DROP TABLE [NOCURSOMASLOSSABADOS].Sector;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Sector_Tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Sector_Tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Bandera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Bandera;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Carrera;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].Carrera;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Circuito')
		DROP TABLE [NOCURSOMASLOSSABADOS].Circuito;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Piloto')
		DROP TABLE [NOCURSOMASLOSSABADOS].Piloto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Auto_Modelo')
		DROP TABLE [NOCURSOMASLOSSABADOS].Auto_Modelo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Escuderia')
		DROP TABLE [NOCURSOMASLOSSABADOS].Escuderia;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'Pais')
		DROP TABLE [NOCURSOMASLOSSABADOS].Pais;
GO



----------CREACION DE TABLAS-------------------
CREATE PROCEDURE NOCURSOMASLOSSABADOS.crear_tablas AS
BEGIN

	CREATE TABLE [NOCURSOMASLOSSABADOS].Pais(
		pais_codigo int identity(1,1) NOT NULL,
		pais_descripcion nvarchar(255),
		CONSTRAINT PK_PAIS PRIMARY KEY(pais_codigo)
	)

	
	CREATE TABLE [NOCURSOMASLOSSABADOS].Escuderia(
		escuderia_codigo int identity(1,1) NOT NULL,
		escuderia_nombre nvarchar(255),
		escuderia_pais int,
		CONSTRAINT PK_ESCUDERIA PRIMARY KEY(escuderia_codigo),
		CONSTRAINT FK_id_PAIS FOREIGN KEY(escuderia_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)

	
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Modelo (
	  auto_modelo_codigo int identity(1,1) NOT NULL,
	  auto_modelo_descripcion nvarchar(255),
	  CONSTRAINT PK_AUTO_MODELO PRIMARY KEY(auto_modelo_codigo)
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Piloto(
		piloto_codigo int identity(1,1) NOT NULL,
		piloto_nombre nvarchar(50),
		piloto_apellido nvarchar(50),
		piloto_pais int,
		piloto_fecha_nacimiento date
		CONSTRAINT PK_PILOTO PRIMARY KEY(piloto_codigo)
		CONSTRAINT FK_PAIS_codigo FOREIGN KEY(piloto_pais) REFERENCES[NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)
	

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
	

	CREATE TABLE [NOCURSOMASLOSSABADOS].Circuito(
		circuito_codigo int NOT NULL,
		circuito_nombre nvarchar(255),
		circuito_pais int,
		CONSTRAINT PK_CIRCUITO PRIMARY KEY(circuito_codigo),
		CONSTRAINT FK_codigo_PAIS FOREIGN KEY(circuito_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
	)


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

	
	CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Carrera(
		auto_carrera_codigo int identity(1,1) NOT NULL,
		auto_carrera_auto int,
		auto_carrera_carrera int,
		CONSTRAINT PK_AUTO_CARRERA PRIMARY KEY(auto_carrera_codigo),
		CONSTRAINT FK_id_AUTO FOREIGN KEY(auto_carrera_auto) REFERENCES [NOCURSOMASLOSSABADOS].[Auto](auto_codigo),
		CONSTRAINT FK_id_CARRERA FOREIGN KEY(auto_carrera_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo)
	)

	 
	CREATE TABLE [NOCURSOMASLOSSABADOS].Bandera(
		bandera_codigo int identity(1,1) NOT NULL,
		bandera_color nvarchar(255),
		CONSTRAINT PK_BANDERA PRIMARY KEY(bandera_codigo)
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Sector_Tipo(
		sector_tipo_codigo int identity(1,1) NOT NULL,
		sector_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_SECTOR_TIPO PRIMARY KEY(sector_tipo_codigo)
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Sector(
		sector_codigo int NOT NULL,
		sector_circuito int,
		sector_distancia decimal(18,2),
		sector_tipo int,
		CONSTRAINT PK_SECTOR PRIMARY KEY(sector_codigo),
		CONSTRAINT FK_id_SECTOR_CIRCUITO FOREIGN KEY(sector_circuito) REFERENCES [NOCURSOMASLOSSABADOS].[Circuito](circuito_codigo),
		CONSTRAINT FK_id_TIPO_SECTOR FOREIGN KEY(sector_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Sector_Tipo](sector_tipo_codigo)
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Incidente_Tipo(
		incidente_tipo_codigo int identity(1,1) NOT NULL,
		incidente_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_INCIDENTE_TIPO PRIMARY KEY(incidente_tipo_codigo)
	)

	
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


	CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Modelo(
		motor_modelo_codigo int identity(1,1) NOT NULL,
		motor_modelo_descripcion nvarchar(255),
		CONSTRAINT PK_MOTOR PRIMARY KEY(motor_modelo_codigo),
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Motor(
		motor_numero_serie nvarchar(255) NOT NULL,
		motor_modelo int,
		CONSTRAINT PK_MOTOR_nor_serie PRIMARY KEY(motor_numero_serie),
		CONSTRAINT FK_id_MOTOR_MODELO FOREIGN KEY(motor_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Motor_Modelo](motor_modelo_codigo)
	)


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
	

	CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Modelo(
		caja_modelo_codigo int identity(1,1) NOT NULL,
		caja_modelo_descripcion nvarchar(50),
		CONSTRAINT PK_CAJA_CAMBIO PRIMARY KEY(caja_modelo_codigo),
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_de_cambio(
		caja_numero_serie nvarchar(255) NOT NULL,
		caja_modelo int,
		CONSTRAINT PK_CAJA_DE_CAMBIO PRIMARY KEY(caja_numero_serie),
		CONSTRAINT FK_id_CAJA_DE_CAMBIO_MODELO FOREIGN KEY(caja_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Caja_De_Cambio_Modelo](caja_modelo_codigo)	
	)

	
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


	CREATE TABLE [NOCURSOMASLOSSABADOS].Posicion(
		posicion_codigo int identity(1,1) NOT NULL,
		posicion_posicion nvarchar(255),
		CONSTRAINT PK_POSICION PRIMARY KEY(posicion_codigo)	
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Freno(
		freno_numero_serie nvarchar(255) NOT NULL,
		freno_posicion int,
		freno_tamanio_disco decimal(18,2)
		CONSTRAINT PK_FRENO PRIMARY KEY(freno_numero_serie),
		CONSTRAINT FK_id_POSICION FOREIGN KEY(freno_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
	)

	
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


	CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico_Tipo(
		neumatico_tipo_codigo int identity(1,1) NOT NULL,
		neumatico_tipo_descripcion nvarchar(255),
		CONSTRAINT PK_NEUMATICO_TIPO PRIMARY KEY(neumatico_tipo_codigo),
	)


	CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico(
		neumatico_numero_serie nvarchar(255) NOT NULL,
		neumatico_tipo int,
		neumatico_posicion int,
		CONSTRAINT PK_NEUMATICO PRIMARY KEY(neumatico_numero_serie),
		CONSTRAINT FK_id_NEUMATICO_TIPO FOREIGN KEY(neumatico_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico_Tipo](neumatico_tipo_codigo),
		CONSTRAINT FK_id_NEUMATICO_POSICION FOREIGN KEY(neumatico_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
	)


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


	CREATE TABLE [NOCURSOMASLOSSABADOS].Parada_Box(
		parada_codigo int identity(1,1) NOT NULL,
		parada_auto_carrera int,
		parada_numero_vuelta decimal(18,0),
		parada_tiempo decimal(18,2),
		CONSTRAINT PK_PARADA_BOX PRIMARY KEY(parada_codigo),
		CONSTRAINT FK_id_AUTO_CARRERA FOREIGN KEY(parada_auto_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Auto_Carrera](auto_carrera_codigo),
	)
	

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

END 
GO



----------CRECACIÓN DE PROCEDURES PARA MIGRACIÓN DE TABLAS-------------------
	
-- Carga de tabla pais
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_pais
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_escuderia
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_modelo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Auto_Modelo (auto_modelo_descripcion)
	SELECT DISTINCT 
		AUTO_MODELO
	FROM gd_esquema.Maestra
END
GO
	

-- Carga de tabla Piloto
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_piloto
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_circuito
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_carrera
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_carrera
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

	
-- Carga de tabla Bandera
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_bandera
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_sector_tipo
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Sector_Tipo (sector_tipo_descripcion)
	SELECT distinct
		SECTO_TIPO
	FROM gd_esquema.Maestra
END
GO
	
		
-- Carga de tabla Sector
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_sector
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_incidente_tipo
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_incidente
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Incidente (incidente_sector, incidente_carrera, incidente_tiempo, incidente_bandera)
	SELECT
		CODIGO_SECTOR,
		CODIGO_CARRERA,
		INCIDENTE_TIEMPO,
		b.bandera_codigo
	FROM gd_esquema.Maestra m
	JOIN [NOCURSOMASLOSSABADOS].[Bandera] b ON b.bandera_color = m.INCIDENTE_BANDERA
	group by CODIGO_SECTOR, CODIGO_CARRERA,	INCIDENTE_TIEMPO, b.bandera_codigo, m.INCIDENTE_TIPO
END
GO


-- Carga de tabla Auto_incidente
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_auto_incidente
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


-- Carga de tabla Medicion
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_medicion
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
	

-- Carga de tabla Motor_Modelo
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor_modelo
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor
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


-- Carga de tabla motor_medicion
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_motor_medicion
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_modelo
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_medicion
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_posicion
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_freno
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
END
GO


-- Carga de tabla Freno_medicion
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_freno_medicion
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

	
-- Carga de tabla Neumatico_Tipo
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_tipo
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
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Neumatico (neumatico_numero_serie, neumatico_tipo, neumatico_posicion) 

		(select TELE_NEUMATICO1_NRO_SERIE, t.neumatico_tipo_codigo, p.posicion_codigo
		from gd_esquema.Maestra m
		JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t ON t.neumatico_tipo_descripcion = m.NEUMATICO1_TIPO_VIEJO
		JOIN [NOCURSOMASLOSSABADOS].[Posicion] p ON p.posicion_posicion = m.TELE_NEUMATICO1_POSICION
		where m.TELE_NEUMATICO1_NRO_SERIE is not null
		)
	union
		(select TELE_NEUMATICO2_NRO_SERIE, t.neumatico_tipo_codigo, p.posicion_codigo
			from gd_esquema.Maestra m
			JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t ON t.neumatico_tipo_descripcion = m.NEUMATICO2_TIPO_VIEJO
			JOIN [NOCURSOMASLOSSABADOS].[Posicion] p ON p.posicion_posicion = m.TELE_NEUMATICO2_POSICION
			where m.TELE_NEUMATICO2_NRO_SERIE is not null
		)
	union
		(select TELE_NEUMATICO3_NRO_SERIE, t.neumatico_tipo_codigo, p.posicion_codigo
			from gd_esquema.Maestra m
			JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t ON t.neumatico_tipo_descripcion = m.NEUMATICO3_TIPO_VIEJO
			JOIN [NOCURSOMASLOSSABADOS].[Posicion] p ON p.posicion_posicion = m.TELE_NEUMATICO3_POSICION
			where m.TELE_NEUMATICO3_NRO_SERIE is not null
		)
	union
		(select TELE_NEUMATICO4_NRO_SERIE, t.neumatico_tipo_codigo, p.posicion_codigo
			from gd_esquema.Maestra m
			JOIN [NOCURSOMASLOSSABADOS].[Neumatico_Tipo] t ON t.neumatico_tipo_descripcion = m.NEUMATICO4_TIPO_VIEJO
			JOIN [NOCURSOMASLOSSABADOS].[Posicion] p ON p.posicion_posicion = m.TELE_NEUMATICO4_POSICION
			where m.TELE_NEUMATICO4_NRO_SERIE is not null
		)			
END
GO


-- Carga de tabla Neumatico_Medicion
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_medicion
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

	
-- Carga de tabla Parada_Box
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_parada_box
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


-- Carga de tabla Cambio_Por_Neumatico
CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_cambio_por_neumatico
AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico
		(cambio_parada_box_codigo, cambio_por_neumatico_nuevo_codigo, cambio_por_neumatico_viejo_codigo)
	SELECT DISTINCT
		pb.parada_codigo,
		n1.neumatico_numero_serie,
		n2.neumatico_numero_serie
	FROM gd_esquema.Maestra M
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Modelo] am ON am.auto_modelo_descripcion = m.AUTO_MODELO
	JOIN [NOCURSOMASLOSSABADOS].[Auto] a ON a.auto_modelo = am.auto_modelo_codigo AND a.auto_numero = m.AUTO_NUMERO
	JOIN [NOCURSOMASLOSSABADOS].[Auto_Carrera] ac ON ac.auto_carrera_auto = a.auto_codigo AND ac.auto_carrera_carrera = m.CODIGO_CARRERA
	JOIN [NOCURSOMASLOSSABADOS].[Parada_Box] pb ON pb.parada_auto_carrera = ac.auto_carrera_codigo 
												AND pb.parada_numero_vuelta = m.PARADA_BOX_VUELTA
												AND pb.parada_tiempo = m.PARADA_BOX_TIEMPO
	JOIN [NOCURSOMASLOSSABADOS].[Neumatico] n1 ON n1.neumatico_numero_serie = m.NEUMATICO1_NRO_SERIE_NUEVO
	JOIN [NOCURSOMASLOSSABADOS].[Neumatico] n2 ON n2.neumatico_numero_serie = m.NEUMATICO1_NRO_SERIE_VIEJO
	WHERE m.PARADA_BOX_TIEMPO IS NOT NULL
END	
GO


----------EJECUCIÓN DE PROCEDURE PARA CREAR TABLAS-------------------
EXEC NOCURSOMASLOSSABADOS.crear_tablas

----------EJECUCIÓN DE PROCEDURES PARA MIGRACIÓN DE TABLAS-------------------
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_pais
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_escuderia
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_auto_modelo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_piloto
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_auto
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_circuito
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_carrera
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_auto_carrera
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_bandera
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_sector_tipo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_sector
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_incidente_tipo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_incidente
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_auto_incidente
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_medicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_motor_modelo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_motor
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_motor_medicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_modelo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_caja_de_cambio_medicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_posicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_freno
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_freno_medicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_tipo
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_neumatico
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_neumatico_medicion
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_parada_box
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_cambio_por_neumatico
