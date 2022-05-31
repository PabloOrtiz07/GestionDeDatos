USE [GD1C2022]
GO
IF NOT EXISTS (select * from sys.schemas where name='NOCURSOMASLOSSABADOS')
BEGIN
    EXEC ('CREATE SCHEMA NOCURSOMASLOSSABADOS')
END 
GO
--DROPEO DE OBJETOS
IF EXISTS (SELECT * FROM sys.objects where object_id=object_id(N'[NOCURSOMASLOSSABADOS].MITABLA')AND type ='U')
    DROP TABLE[NOCURSOMASLOSSABADOS].MITABLA
GO

----------CREACION DE TABLAS-------------------

CREATE TABLE Pais(
	pais_codigo int NOT NULL,
	pais_descripcion nvarchar(255),
	CONSTRAINT PK_PAIS PRIMARY KEY(pais_codigo)
)

CREATE TABLE Escuderia(
	escuderia_codigo int NOT NULL,
	escuderia_nombre nvarchar(255),
	escuderia_pais int,
	CONSTRAINT PK_ESCUDERIA PRIMARY KEY(escuderia_codigo),
	CONSTRAINT FK_id_EscuderiaPais FOREIGN KEY(escuderia_pais) REFERENCES [Pais](pais_codigo)
)

CREATE TABLE Auto_Modelo (
  auto_modelo_codigo int NOT NULL,
  auto_modelo_descripcion nvarchar(255),
  CONSTRAINT PK_AUTO_MODELO PRIMARY KEY(auto_modelo_codigo)
 
)

CREATE TABLE Auto (
  auto_codigo int NOT NULL,
  auto_escuderia int,
  auto_piloto int,
  auto_modelo int,
  auto_numero int,
  CONSTRAINT PK_AUTO PRIMARY KEY(auto_codigo),
  CONSTRAINT FK_id_AutoModelo FOREIGN KEY(auto_modelo) REFERENCES [Auto_Modelo](auto_modelo_codigo),
  CONSTRAINT FK_id_AutoEscuderia FOREIGN KEY(auto_escuderia) REFERENCES [Escuderia](escuderia_codigo)
)



CREATE TABLE Piloto(
	piloto_codigo int NOT NULL,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50),
	piloto_pais int,
	piloto_fecha_nacimiento date
	CONSTRAINT PK_PILOTO PRIMARY KEY(piloto_codigo)
	CONSTRAINT FK_id_PilotoPais FOREIGN KEY(piloto_pais) REFERENCES [Pais](pais_codigo)
)



CREATE TABLE Circuito(
	circuito_codigo int NOT NULL,
	circuito_nombre nvarchar(255),
	circuito_pais int,
	CONSTRAINT PK_CIRCUITO PRIMARY KEY(circuito_codigo),
	CONSTRAINT FK_id_CircuitoPais FOREIGN KEY(circuito_pais) REFERENCES [Pais](pais_codigo)
)

CREATE TABLE Carrera(
	carrera_codigo int NOT NULL,
	carrera_circuito int,
	carrera_cantidad_vueltas int,
	carrera_fecha date,
	carrera_clima nvarchar(100),
	CONSTRAINT PK_CARRERA PRIMARY KEY(carrera_codigo),
	CONSTRAINT FK_id_CarreraCircuito FOREIGN KEY(carrera_circuito) REFERENCES [Circuito](circuito_codigo)
)

CREATE TABLE Auto_Carrera(
	auto_carrera_codigo int NOT NULL,
	auto_carrera_auto int,
	auto_carrera_carrera int,
	CONSTRAINT PK_AUTO_CARRERA PRIMARY KEY(auto_carrera_codigo),
	CONSTRAINT FK_id_AUTO FOREIGN KEY(auto_carrera_auto) REFERENCES [Auto](auto_codigo),
	CONSTRAINT FK_id_CARRERA FOREIGN KEY(auto_carrera_carrera) REFERENCES [Carrera](carrera_codigo)
)


--CREACION DE INDICES
--CREACION DE VISTAS
--CREACION DE FUNCIONES
--CREACION DE SP
--CREACION DE TRIGGERS
--LLENADO DE TABLAS/EXEC DE SP
insert into NOCURSOMASLOSSABADOS.parametros(CLAVE,VALOR)
SELECT DISTINCT dato1,dato2 from gd_esquema.Maestra
WHERE dato1 IS NOT NULL
--CREACION DE INDICES
GO

-- -----------------------------------------------------
-- Carrera
-- -----------------------------------------------------
IF OBJECT_ID('NOCURSOMASLOSSABADOS.carrera', 'U') IS NOT NULL DROP TABLE NOCURSOMASLOSSABADOS.carrera;
IF OBJECT_ID('NOCURSOMASLOSSABADOS.carrera', 'U') IS NULL CREATE TABLE NOCURSOMASLOSSABADOS.carrera (
  carrera_codigo int primary key,
  carrera_circuito int,
  carrera_cant_vueltas int,
  carrera_fecha date,
  carrera_clima nvarchar(100),
  carrera_total_carrera decimal(18,2)
  --FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
)
GO

---- -----------------------------------------------------
---- Auto
---- -----------------------------------------------------
--IF OBJECT_ID('NOCURSOMASLOSSABADOS.auto', 'U') IS NOT NULL DROP TABLE NOCURSOMASLOSSABADOS.auto;
--IF OBJECT_ID('NOCURSOMASLOSSABADOS.auto', 'U') IS NULL CREATE TABLE NOCURSOMASLOSSABADOS.auto (
--  auto_codigo int primary key,
--  auto_escuderia int,
--  auto_piloto int,
--  auto_modelo int,
--  auto_numero int
--  FOREIGN KEY (auto_modelo) REFERENCES sales.stores (store_id)
--)
--GO

---- -----------------------------------------------------
---- Auto_modelo
---- -----------------------------------------------------
--IF OBJECT_ID('NOCURSOMASLOSSABADOS.auto_modelo', 'U') IS NOT NULL DROP TABLE NOCURSOMASLOSSABADOS.auto_modelo;
--IF OBJECT_ID('NOCURSOMASLOSSABADOS.auto_modelo', 'U') IS NULL CREATE TABLE NOCURSOMASLOSSABADOS.auto_modelo (
--  auto_modelo_codigo int primary key,
--  auto_modelo_descripcion nvarchar(255)
--)
--GO

--ALTER TABLE cuentas  
--ADD CONSTRAINT fk_cuentas_clie FOREIGN KEY
--(clie_id)
--REFERENCES clientes (clie_id)
--GO


-- -----------------------------------------------------
-- Auto
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Auto_modelo
-- -----------------------------------------------------
CREATE TABLE auto_modelo (
  auto_modelo_codigo int primary key identity(1,1),
  auto_modelo_descripcion nvarchar(255)
)
GO

--ALTER TABLE cuentas  
--ADD CONSTRAINT fk_cuentas_clie FOREIGN KEY
--(clie_id)
--REFERENCES clientes (clie_id)
--GO

-- -----------------------------------------------------
-- Carga de tabla Auto_modelo
-- -----------------------------------------------------
CREATE PROCEDURE cargar_tabla_auto_modeloASBEGIN	INSERT INTO auto_modelo (auto_modelo_descripcion)	select		auto_modelo	FROM [GD1C2022].[gd_esquema].[Maestra]	group by auto_modeloEND--en el medio de esta transaccion para no cagarla por las dudasBEGIN TRANSACTION 	exec cargar_tabla_auto_modeloROLLBACK
select * from auto_modelo
