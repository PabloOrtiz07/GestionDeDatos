USE [GD1C2022]
GO


/************************************/
/*			SCHEMA  BI				*/
/************************************/


CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_fecha
(
	fecha_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	anio integer,
	cuatrimestre integer
)


CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_incidente
(
	incidente_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	incidente_sector integer,
	incidente_carrera integer,
	incidente_tiempo decimal(18,2),
	incidente_bandera integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_neumatico_tipo
(
	neumatico_tipo_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	neumatico_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_sector_tipo
(
	sector_tipo_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	sector_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_incidente_tipo
(
	incidente_tipo_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	incidente_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_sector
(
	sector_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	sector_circuito integer,
	sector_distancia decimal(18,2),
	sector_tipo integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_escuderia
(
	escuderia_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	escuderia_nombre nvarchar(255),
	escuderia_pais integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_circuito
(
	circuito_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	circuitio_nombre nvarchar(255),
	circuito_pais integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_auto
(
	auto_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	auto_escuderia integer,
	auto_piloto integer,
	auto_modelo integer,
	auto_numero integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_piloto
(
	piloto_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50),
	piloto_pais integer,
	piloto_fecha_nacimiento date
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_freno_medicion
(
	freno_medicion_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	freno_medicion_medicion decimal(18,0),
	freno_medicion_freno_numero_serie nvarchar(255),
	freno_medicion_grosor decimal(18,2),
	freno_medicion_temperatura decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_auto_carrera
(
	auto_carrera_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	auto_carrera_auto integer,
	auto_carrera_carrera integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_medicion
(
	medicion_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	medicion_auto_carrera integer,
	medicion_sector integer,
	medicion_numero_vuelta decimal(18,2),
	medicion_distancia_carrera decimal(18,2),
	medicion_distancia_vuelta decimal(18,2),
	medicion_tiempo_vuelta decimal(18,2),
	medicion_posicion decimal(18,2),
	medicion_velocidad decimal(18,2),
	medicion_combustible decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_neumatico_medicion
(
	neumatico_medicion_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	neumatico_medicion_medicion decimal (18,0),
	neumatico_medicion_neumatico_numero_serie nvarchar(255),
	neumatico_medicion_profundidad decimal(18,6),
	neumatico_medicion_presion decimal(18,6),
	neumatico_medicion_temperatura decimal(18,6)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_caja_de_cambio_medicion
(
	caja_medicion_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	caja_medicion_medicion decimal (18,0),
	caja_medicion_caja_numero_serie nvarchar(255),
	caja_medicion_temperatura_aceite decimal(18,2),
	caja_medicion_rpm decimal(18,2),
	caja_medicion_desgaste decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_motor_medicion
(
	motor_medicion_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	motor_medicion_medicion decimal (18,0),
	motor_medicion_motor_numero_serie nvarchar(255),
	motor_medicion_potencia decimal(18,6),
	motor_medicion_temperatura_aceite decimal(18,6),
	motor_medicion_temperatura_agua decimal(18,6),
	motor_medicion_rpm decimal(18,6)
)




CREATE TABLE  [NOCURSOMASLOSSABADOS].dim_parada_box
(
	parada_codigo INTEGER IDENTITY(1,1) PRIMARY KEY,
	parada_auto_carrera integer,
	parada_numero_vuelta decimal(18,0),
	parada_tiempo decimal(18,2),
)



/************************************/
/*			CARGA  BI				*/
/************************************/




INSERT INTO [NOCURSOMASLOSSABADOS].dim_sector_tipo
(
	sector_tipo_codigo,
	sector_tipo_descripcion
)
SELECT 
	sector_tipo_codigo,
	sector_tipo_descripcion 
FROM [NOCURSOMASLOSSABADOS].Sector_Tipo


INSERT INTO [NOCURSOMASLOSSABADOS].dim_sector
(
	sector_codigo,
	sector_circuito,
	sector_distancia,
	sector_tipo
)
SELECT 
	sector_codigo,
	sector_circuito,
	sector_distancia,
	sector_tipo
FROM [NOCURSOMASLOSSABADOS].Sector


INSERT INTO [NOCURSOMASLOSSABADOS].dim_incidente
(
	incidente_codigo,
	incidente_sector,
	incidente_carrera,
	incidente_tiempo,
	incidente_bandera
)
SELECT 
	incidente_codigo,
	incidente_sector,
	incidente_carrera,
	incidente_tiempo,
	incidente_bandera
FROM [NOCURSOMASLOSSABADOS].Incidente

INSERT INTO [NOCURSOMASLOSSABADOS].dim_incidente_tipo
(
	incidente_tipo_codigo,
	incidente_tipo_descripcion
)
SELECT 
	incidente_tipo_codigo,
	incidente_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Incidente_Tipo

INSERT INTO [NOCURSOMASLOSSABADOS].dim_circuito
(
	circuito_codigo,
	circuitio_nombre,
	circuito_pais
)
SELECT 
	circuito_codigo,
	circuito_nombre,
	circuito_pais
FROM [NOCURSOMASLOSSABADOS].Circuito


INSERT INTO [NOCURSOMASLOSSABADOS].dim_neumatico_tipo
(
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
)
SELECT 
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Neumatico_Tipo

INSERT INTO [NOCURSOMASLOSSABADOS].dim_sector_tipo
(
	sector_tipo_codigo,
	sector_tipo_descripcion
)
SELECT 
	sector_tipo_codigo,
	sector_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].sector_Tipo

INSERT INTO [NOCURSOMASLOSSABADOS].dim_auto
(
	auto_codigo,
	auto_escuderia,
	auto_piloto,
	auto_modelo,
	auto_numero
)
SELECT 
	auto_codigo,
	auto_escuderia,
	auto_piloto,
	auto_modelo,
	auto_numero
FROM [NOCURSOMASLOSSABADOS].Auto

INSERT INTO [NOCURSOMASLOSSABADOS].dim_piloto
(
	piloto_codigo,
	piloto_nombre,
	piloto_apellido,
	piloto_pais,
	piloto_fecha_nacimiento
)
SELECT 
	piloto_codigo,
	piloto_nombre,
	piloto_apellido,
	piloto_pais,
	piloto_fecha_nacimiento
FROM [NOCURSOMASLOSSABADOS].Piloto

INSERT INTO [NOCURSOMASLOSSABADOS].dim_freno_medicion
(
	freno_medicion_codigo,
	freno_medicion_medicion,
	freno_medicion_freno_numero_serie,
	freno_medicion_grosor,
	freno_medicion_temperatura
)
SELECT 
	freno_medicion_codigo,
	freno_medicion_medicion,
	freno_medicion_freno_numero_serie,
	freno_medicion_grosor,
	freno_medicion_temperatura
FROM [NOCURSOMASLOSSABADOS].Freno_medicion

INSERT INTO [NOCURSOMASLOSSABADOS].dim_neumatico_medicion
(
	neumatico_medicion_codigo,
	neumatico_medicion_medicion,
	neumatico_medicion_neumatico_numero_serie,
	neumatico_medicion_profundidad,
	neumatico_medicion_temperatura
)
SELECT 
	neumatico_medicion_codigo,
	neumatico_medicion_medicion,
	neumatico_medicion_neumatico_numero_serie,
	neumatico_medicion_profundidad,
	neumatico_medicion_temperatura
FROM [NOCURSOMASLOSSABADOS].Neumatico_medicion


INSERT INTO [NOCURSOMASLOSSABADOS].dim_auto_carrera
(
	auto_carrera_codigo,
	auto_carrera_auto,
	auto_carrera_carrera
)
SELECT 
	auto_carrera_codigo,
	auto_carrera_auto,
	auto_carrera_carrera
FROM [NOCURSOMASLOSSABADOS].Auto_Carrera

INSERT INTO [NOCURSOMASLOSSABADOS].dim_medicion
(
	medicion_codigo,
	medicion_auto_carrera,
	medicion_sector,
	medicion_numero_vuelta,
	medicion_distancia_carrera,
	medicion_distancia_vuelta,
	medicion_posicion,
	medicion_velocidad,
	medicion_combustible
)
SELECT 
	medicion_codigo,
	medicion_auto_carrera,
	medicion_sector,
	medicion_numero_vuelta,
	medicion_distancia_carrera,
	medicion_distancia_vuelta,
	medicion_posicion,
	medicion_velocidad,
	medicion_combustible
FROM [NOCURSOMASLOSSABADOS].Medicion

INSERT INTO [NOCURSOMASLOSSABADOS].dim_caja_de_cambio_medicion
(
	caja_medicion_codigo,
	caja_medicion_medicion,
	caja_medicion_caja_numero_serie,
	caja_medicion_temperatura_aceite,
	caja_medicion_desgaste
)
SELECT 
	caja_medicion_codigo,
	caja_medicion_medicion,
	caja_medicion_caja_numero_serie,
	caja_medicion_temperatura_aceite,
	caja_medicion_desgaste
FROM [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion

INSERT INTO [NOCURSOMASLOSSABADOS].dim_motor_medicion
(
	motor_medicion_codigo,
	motor_medicion_medicion,
	motor_medicion_motor_numero_serie,
	motor_medicion_potencia,
	motor_medicion_temperatura_aceite,
	motor_medicion_temperatura_agua,
	motor_medicion_rpm
)
SELECT 
	motor_medicion_codigo,
	motor_medicion_medicion,
	motor_medicion_motor_numero_serie,
	motor_medicion_potencia,
	motor_medicion_temperatura_aceite,
	motor_medicion_temperatura_agua,
	motor_medicion_rpm
FROM [NOCURSOMASLOSSABADOS].Motor_Medicion


INSERT INTO [NOCURSOMASLOSSABADOS].dim_parada_box
(
	parada_codigo,
	parada_auto_carrera,
	parada_numero_vuelta,
	parada_tiempo
)
SELECT 
	parada_codigo,
	parada_auto_carrera,
	parada_numero_vuelta,
	parada_tiempo
FROM [NOCURSOMASLOSSABADOS].Parada_Box











