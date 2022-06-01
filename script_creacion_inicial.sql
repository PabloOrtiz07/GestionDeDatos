CREATE PROCEDURE crear_tablas AS
BEGIN
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name='NOCURSOMASLOSSABADOS')
    EXEC ('CREATE SCHEMA NOCURSOMASLOSSABADOS')


----------CREACION DE TABLAS-------------------

CREATE TABLE [NOCURSOMASLOSSABADOS].Pais(
	pais_codigo int NOT NULL,
	pais_descripcion nvarchar(255),
	CONSTRAINT PK_PAIS PRIMARY KEY(pais_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Escuderia(
	escuderia_codigo int NOT NULL,
	escuderia_nombre nvarchar(255),
	escuderia_pais int,
	CONSTRAINT PK_ESCUDERIA PRIMARY KEY(escuderia_codigo),
	CONSTRAINT FK_id_EscuderiaPais FOREIGN KEY(escuderia_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Modelo (
  auto_modelo_codigo int NOT NULL,
  auto_modelo_descripcion nvarchar(255),
  CONSTRAINT PK_AUTO_MODELO PRIMARY KEY(auto_modelo_codigo)
 
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Auto (
  auto_codigo int NOT NULL,
  auto_escuderia int,
  auto_piloto int,
  auto_modelo int,
  auto_numero int,
  CONSTRAINT PK_AUTO PRIMARY KEY(auto_codigo),
  CONSTRAINT FK_id_AutoModelo FOREIGN KEY(auto_modelo) REFERENCES [Auto_Modelo](auto_modelo_codigo),
  CONSTRAINT FK_id_AutoEscuderia FOREIGN KEY(auto_escuderia) REFERENCES [NOCURSOMASLOSSABADOS].[Escuderia](escuderia_codigo)
)



CREATE TABLE [NOCURSOMASLOSSABADOS].Piloto(
	piloto_codigo int NOT NULL,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50),
	piloto_pais int,
	piloto_fecha_nacimiento date
	CONSTRAINT PK_PILOTO PRIMARY KEY(piloto_codigo)
	CONSTRAINT FK_id_PilotoPais FOREIGN KEY(piloto_pais) REFERENCES[NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
)



CREATE TABLE [NOCURSOMASLOSSABADOS].Circuito(
	circuito_codigo int NOT NULL,
	circuito_nombre nvarchar(255),
	circuito_pais int,
	CONSTRAINT PK_CIRCUITO PRIMARY KEY(circuito_codigo),
	CONSTRAINT FK_id_CircuitoPais FOREIGN KEY(circuito_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Carrera(
	carrera_codigo int NOT NULL,
	carrera_circuito int,
	carrera_cantidad_vueltas int,
	carrera_fecha date,
	carrera_clima nvarchar(100),
	CONSTRAINT PK_CARRERA PRIMARY KEY(carrera_codigo),
	CONSTRAINT FK_id_CarreraCircuito FOREIGN KEY(carrera_circuito) REFERENCES [NOCURSOMASLOSSABADOS].[Circuito](circuito_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Carrera(
	auto_carrera_codigo int NOT NULL,
	auto_carrera_auto int,
	auto_carrera_carrera int,
	CONSTRAINT PK_AUTO_CARRERA PRIMARY KEY(auto_carrera_codigo),
	CONSTRAINT FK_id_AUTO FOREIGN KEY(auto_carrera_auto) REFERENCES [NOCURSOMASLOSSABADOS].[Auto](auto_codigo),
	CONSTRAINT FK_id_CARRERA FOREIGN KEY(auto_carrera_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo)
)

C

CREATE TABLE [NOCURSOMASLOSSABADOS].Bandera(
	bandera_codigo int NOT NULL,
	bandera_color nvarchar(255),
	CONSTRAINT PK_BANDERA PRIMARY KEY(bandera_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Sector_Tipo(
	sector_tipo_codigo int NOT NULL,
	sector_tipo_descripcion nvarchar(255),
	CONSTRAINT PK_SECTOR PRIMARY KEY(sector_tipo_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Sector(
	sector_codigo int NOT NULL,
	sector_circuito int,
	sector_distancia decimal(18,2),
	sector_tipo int,
	CONSTRAINT PK_SECTOR PRIMARY KEY(sector_codigo),
	CONSTRAINT FK_id_TIPO_SECTOR FOREIGN KEY(sector_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Sector_Tipo](sector_tipo_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Incidente(
	incidente_tipo_codigo int NOT NULL,
	auto_incidente_auto nvarchar(255),
	CONSTRAINT PK_AUTO_INCIDENTE PRIMARY KEY(auto_incidente_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Auto_Incidente(
	auto_incidente_codigo int NOT NULL,
	auto_incidente_auto int,
	auto_incidente_incidente_codigo int,
	auto_incidente_tipo int,
	auto_incidente_numero_vuelta decimal(18,0),
	CONSTRAINT PK_AUTO_INCIDENTE PRIMARY KEY(auto_incidente_codigo),
	CONSTRAINT FK_id_AUTO FOREIGN KEY(auto_incidente_auto) REFERENCES [NOCURSOMASLOSSABADOS].[Auto](Auto_codigo),
	CONSTRAINT FK_id_INCIDENTE FOREIGN KEY(auto_incidente_incidente_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Incidente](incidente_codigo),
	CONSTRAINT FK_id_INCIDENTE_TIPO FOREIGN KEY(auto_incidente_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Incidente_Tipo](incidente_tipo_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Incidente_Tipo(
	incidente_tipo_codigo int NOT NULL,
	incidente_tipo_descripcion nvarchar(255),
	CONSTRAINT PK_INCIDENTE_TIPO PRIMARY KEY(incidente_tipo_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Incidente(
	incidente_codigo int NOT NULL,
	incidente_sector int,
	incidente_carrera int,
	incidente_tiempo decimal(18,2),
	incidente_bandera int,
	CONSTRAINT PK_INCIDENTE PRIMARY KEY(incidente_codigo),
	CONSTRAINT FK_id_CARRERA FOREIGN KEY(incidente_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo),
	CONSTRAINT FK_id_SECTOR FOREIGN KEY(incidente_sector) REFERENCES [NOCURSOMASLOSSABADOS].[Sector](sector_codigo),
	CONSTRAINT FK_id_BANDERA FOREIGN KEY(incidente_bandera) REFERENCES [NOCURSOMASLOSSABADOS].[Bandera](bandera_codigo)
)



END 
GO
