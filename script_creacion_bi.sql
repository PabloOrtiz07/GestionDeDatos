USE [GD1C2022]
GO

/************************************/
/*			DROP TABLAS BI				*/
/************************************/
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_auto_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_auto_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_fecha')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_fecha;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_sector_tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_sector')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_sector;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_incidente_tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_incidente_tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_circuito')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_circuito;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_neumatico_tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_neumatico_tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_auto')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_auto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_auto_carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_auto_carrera;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_piloto')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_piloto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_freno_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_freno_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_neumatico_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_neumatico_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_caja_de_cambio_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_caja_de_cambio_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_motor_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_motor_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_parada_box')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_parada_box;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_escuderia')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_escuderia;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_dim_carrera')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_dim_carrera;

-------------- DROP TABLA HECHO ------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_hecho_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_hecho_medicion_v2;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_hecho_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_hecho_incidente_v2;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'bi_hecho_parada')
		DROP TABLE [NOCURSOMASLOSSABADOS].bi_hecho_parada_v2;
		

/************************************/
/*			CREACION DIMENSIONES  BI				*/
/************************************/

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_auto_incidente
(
	auto_incidente_codigo INTEGER IDENTITY PRIMARY KEY,
	auto_incidente_auto integer,
	auto_incidente_incidente_codigo integer,
	auto_incidente_tipo integer,
	auto_incidente_numero_vuelta decimal(18,0),
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_fecha
(
	fecha_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	fecha_anio integer,
	fecha_cuatrimestre integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo
(
	sector_tipo_codigo INTEGER PRIMARY KEY,
	sector_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_sector
(
	sector_codigo INTEGER PRIMARY KEY,
	sector_circuito integer,
	sector_distancia decimal(18,2),
	sector_tipo integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_incidente
(
	incidente_codigo INTEGER PRIMARY KEY,
	incidente_sector integer,
	incidente_carrera integer,
	incidente_tiempo decimal(18,2),
	incidente_bandera integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_incidente_tipo
(
	incidente_tipo_codigo INTEGER PRIMARY KEY,
	incidente_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_circuito
(
	circuito_codigo INTEGER PRIMARY KEY,
	circuitio_nombre nvarchar(255),
	circuito_pais integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_neumatico_tipo
(
	neumatico_tipo_codigo INTEGER PRIMARY KEY,
	neumatico_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_auto
(
	auto_codigo INTEGER PRIMARY KEY,
	auto_escuderia integer,
	auto_piloto integer,
	auto_modelo integer,
	auto_numero integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_auto_carrera
(
	auto_carrera_codigo INTEGER PRIMARY KEY,
	auto_carrera_auto integer,
	auto_carrera_carrera integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_piloto
(
	piloto_codigo INTEGER PRIMARY KEY,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50),
	piloto_pais integer,
	piloto_fecha_nacimiento date
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_freno_medicion
(
	freno_medicion_codigo INTEGER PRIMARY KEY,
	freno_medicion_medicion decimal(18,0),
	freno_medicion_freno_numero_serie nvarchar(255),
	freno_medicion_grosor decimal(18,2),
	freno_medicion_temperatura decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_neumatico_medicion
(
	neumatico_medicion_codigo INTEGER PRIMARY KEY,
	neumatico_medicion_medicion decimal (18,0),
	neumatico_medicion_neumatico_numero_serie nvarchar(255),
	neumatico_medicion_profundidad decimal(18,6),
	neumatico_medicion_presion decimal(18,6),
	neumatico_medicion_temperatura decimal(18,6)
)


CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_caja_de_cambio_medicion
(
	caja_medicion_codigo INTEGER PRIMARY KEY,
	caja_medicion_medicion decimal (18,0),
	caja_medicion_caja_numero_serie nvarchar(255),
	caja_medicion_temperatura_aceite decimal(18,2),
	caja_medicion_rpm decimal(18,2),
	caja_medicion_desgaste decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_motor_medicion
(
	motor_medicion_codigo INTEGER PRIMARY KEY,
	motor_medicion_medicion decimal (18,0),
	motor_medicion_motor_numero_serie nvarchar(255),
	motor_medicion_potencia decimal(18,6),
	motor_medicion_temperatura_aceite decimal(18,6),
	motor_medicion_temperatura_agua decimal(18,6),
	motor_medicion_rpm decimal(18,6)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_medicion
(
	medicion_codigo decimal(18,0) PRIMARY KEY,
	medicion_auto_carrera integer,
	medicion_sector integer,
	medicion_numero_vuelta decimal(18,2),
	medicion_distancia_carrera decimal(18,2),
	medicion_distancia_vuelta decimal(18,2),
	medicion_tiempo_vuelta decimal(18,10),
	medicion_posicion decimal(18,2),
	medicion_velocidad decimal(18,2),
	medicion_combustible decimal(18,2)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_parada_box
(
	parada_codigo INTEGER PRIMARY KEY,
	parada_auto_carrera integer,
	parada_numero_vuelta decimal(18,0),
	parada_tiempo decimal(18,2),
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_dim_escuderia
(
	escuderia_codigo INTEGER PRIMARY KEY,
	escuderia_nombre nvarchar(255),
	escuderia_pais integer
)

CREATE TABLE [NOCURSOMASLOSSABADOS].bi_dim_carrera
(
		carrera_codigo INTEGER PRIMARY KEY,
		carrera_circuito int,
		carrera_cantidad_vueltas int,
		carrera_fecha date,
		carrera_clima nvarchar(100),
		carrera_total_carrera decimal(18,2)
)


/************************************/
/*			CARGA DIMENSIONES BI				*/
/************************************/


INSERT INTO  [NOCURSOMASLOSSABADOS].bi_dim_auto_incidente
(
	auto_incidente_codigo,
	auto_incidente_auto,
	auto_incidente_incidente_codigo,
	auto_incidente_tipo ,
	auto_incidente_numero_vuelta,
)
SELECT
	auto_incidente_codigo,
	auto_incidente_auto,
	auto_incidente_codigo,
	auto_incidente_tipo,
	auto_incidente_numero_vuelta
FROM [NOCURSOMASLOSSABADOS].Auto_Incidente


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_fecha
(
	fecha_anio,
	fecha_cuatrimestre
)
SELECT distinct
	year(carrera_fecha),
	DATEPART(QUARTER, carrera_fecha)
FROM [NOCURSOMASLOSSABADOS].Carrera


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo
(
	sector_tipo_codigo,
	sector_tipo_descripcion
)
SELECT 
	sector_tipo_codigo,
	sector_tipo_descripcion 
FROM [NOCURSOMASLOSSABADOS].Sector_Tipo


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_sector
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_incidente
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

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_incidente_tipo
(
	incidente_tipo_codigo,
	incidente_tipo_descripcion
)
SELECT 
	incidente_tipo_codigo,
	incidente_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Incidente_Tipo

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_circuito
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_neumatico_tipo
(
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
)
SELECT 
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Neumatico_Tipo


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_auto
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

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_auto_carrera
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

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_piloto
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

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_freno_medicion
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

INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_neumatico_medicion
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_caja_de_cambio_medicion
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_motor_medicion
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_medicion
(
	medicion_codigo,
	medicion_auto_carrera,
	medicion_sector,
	medicion_numero_vuelta,
	medicion_distancia_carrera,
	medicion_distancia_vuelta,
	medicion_tiempo_vuelta,
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
	medicion_tiempo_vuelta,
	medicion_posicion,
	medicion_velocidad,
	medicion_combustible
FROM [NOCURSOMASLOSSABADOS].Medicion


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_parada_box
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


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_escuderia
(
	escuderia_codigo,
	escuderia_nombre,
	escuderia_pais
)
SELECT 
	escuderia_codigo,
	escuderia_nombre,
	escuderia_pais
FROM [NOCURSOMASLOSSABADOS].Escuderia


INSERT INTO [NOCURSOMASLOSSABADOS].bi_dim_carrera
(
	carrera_codigo,
	carrera_circuito,
	carrera_cantidad_vueltas,
	carrera_fecha,
	carrera_clima,
	carrera_total_carrera
)
SELECT 
	carrera_codigo,
	carrera_circuito,
	carrera_cantidad_vueltas,
	carrera_fecha,
	carrera_clima,
	carrera_total_carrera
FROM [NOCURSOMASLOSSABADOS].Carrera


/************************************/
/*	CREACION Y CARGA DE BI_HECHO_MEDICION	*/
/************************************/
CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_hecho_medicion
(
	hm_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hm_motor INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_motor_medicion,
	hm_caja INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_caja_de_cambio_medicion,
	hm_freno INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_freno_medicion,
	hm_neumatico INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_neumatico_medicion,
	hm_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_circuito,
	hm_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector,
	hm_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_fecha,
	hm_motor_potencia DECIMAL(18,6),
	hm_desgaste_caja decimal(18,2),
	hm_freno_grosor_promedio decimal(18,2),
	hm_neumatico_profundidad_promedio decimal(18,2),
	hm_numero_vuelta decimal(18,0),
	hm_tiempo_vuelta decimal(18,10),
	hm_combustible decimal(18,2),
	hm_velocidad decimal(18,2),
	hm_auto_carrera INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_auto_carrera,
	hm_circuito_nombre nvarchar(255),
	hm_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_escuderia,
	hm_escuderia_nombre nvarchar(255),
	hm_sector_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo,
	hm_sector_tipo_descripcion nvarchar(255)
)

INSERT INTO [NOCURSOMASLOSSABADOS].bi_hecho_medicion --TARDA 43 SEGUNDOS
(
	hm_motor, 
	hm_caja,
	hm_freno,
	hm_neumatico,
	hm_circuito,
	hm_sector,
	hm_fecha,
	hm_motor_potencia,
	hm_desgaste_caja,
	hm_freno_grosor_promedio,
	hm_neumatico_profundidad_promedio,
	hm_numero_vuelta,
	hm_tiempo_vuelta,
	hm_combustible,
	hm_velocidad,
	hm_auto_carrera,
	hm_circuito_nombre,
	hm_escuderia,
	hm_escuderia_nombre,
	hm_sector_tipo,
	hm_sector_tipo_descripcion
)
SELECT
	mm.motor_medicion_medicion,
	cm.caja_medicion_medicion,
	fm.freno_medicion_medicion,
	nm.neumatico_medicion_medicion,
	c.circuito_codigo,
	s.sector_codigo,
	f.fecha_id,
	mm.motor_medicion_potencia,
	cm.caja_medicion_desgaste,
	sum(fm.freno_medicion_grosor) /4,
	sum(nm.neumatico_medicion_profundidad) / 4,
	m.medicion_numero_vuelta,
	m.medicion_tiempo_vuelta,
	m.medicion_combustible,
	m.medicion_velocidad,
	ac.auto_carrera_codigo,
	c.circuitio_nombre,
	e.escuderia_codigo,
	e.escuderia_nombre,
	st.sector_tipo_codigo,
	st.sector_tipo_descripcion
FROM NOCURSOMASLOSSABADOS.bi_dim_medicion m
JOIN NOCURSOMASLOSSABADOS.bi_dim_motor_medicion mm ON m.medicion_codigo = mm.motor_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_caja_de_cambio_medicion cm ON m.medicion_codigo = cm.caja_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_freno_medicion fm ON m.medicion_codigo = fm.freno_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_neumatico_medicion nm ON m.medicion_codigo = nm.neumatico_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector s ON m.medicion_sector = s.sector_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON s.sector_circuito = c.circuito_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_carrera ac ON m.medicion_auto_carrera = ac.auto_carrera_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_carrera car ON ac.auto_carrera_carrera = car.carrera_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON a.auto_escuderia = e.escuderia_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector_tipo st ON s.sector_tipo = st.sector_tipo_codigo
group by 
	--m.medicion_codigo,
	mm.motor_medicion_medicion,
	cm.caja_medicion_medicion,
	fm.freno_medicion_medicion,
	nm.neumatico_medicion_medicion,
	m.medicion_numero_vuelta,
	m.medicion_tiempo_vuelta,
	m.medicion_combustible,
	m.medicion_velocidad,
	mm.motor_medicion_potencia,
	cm.caja_medicion_desgaste,
	c.circuito_codigo,
	s.sector_codigo,
	f.fecha_id,
	ac.auto_carrera_codigo,
	c.circuitio_nombre,
	e.escuderia_codigo,
	e.escuderia_nombre,
	st.sector_tipo_codigo,
	st.sector_tipo_descripcion



CREATE VIEW desgaste_motor
AS
SELECT --la primera tiene que dar 14.08
	hm.hm_auto_carrera,
	hm.hm_circuito_nombre,
	hm.hm_numero_vuelta,
	(select top 1 hm2.hm_motor_potencia --selecciono primera medicion de la vuelta
	from NOCURSOMASLOSSABADOS.bi_hecho_medicion hm2
	where hm2.hm_auto_carrera = hm.hm_auto_carrera
	and hm2.hm_numero_vuelta = hm.hm_numero_vuelta
	order by hm2.hm_tiempo_vuelta asc
	) -
	(select top 1 hm2.hm_motor_potencia --selecciono ultima medicion de la vuelta
	from NOCURSOMASLOSSABADOS.bi_hecho_medicion hm2
	where hm2.hm_auto_carrera = hm.hm_auto_carrera
	and hm2.hm_numero_vuelta = hm.hm_numero_vuelta
	order by hm2.hm_tiempo_vuelta desc
	)
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion hm
group by hm_auto_carrera, hm_numero_vuelta, hm_circuito_nombre
order by hm_auto_carrera, hm_numero_vuelta

select hm_id, hm_motor_potencia, hm_tiempo_vuelta from NOCURSOMASLOSSABADOS.bi_hecho_medicion
where hm_auto_carrera = 1 and hm_numero_vuelta = 1
GO



--CREATE VIEW mejor_tiempo_vuelta_escuderia_por_circuito_anual --este no se podia pq no se puede sacar
--AS
--SELECT 
--	hm.hm_auto_carrera
--FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion hm
----group by hm_auto_carrera, hm_numero_vuelta, hm_circuito_nombre
----order by hm_auto_carrera, hm_numero_vuelta

--select hm_id, hm_motor_potencia, hm_tiempo_vuelta from NOCURSOMASLOSSABADOS.bi_hecho_medicion
--where hm_auto_carrera = 1 and hm_numero_vuelta = 1
--GO

CREATE VIEW circuitos_mayor_consumo_combustible_promedio
AS
SELECT --falta algo con 'promedio'. promedio segun que?
	hm.hm_circuito_nombre
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion hm
group by hm.hm_circuito, hm.hm_circuito_nombre
having hm.hm_circuito in (select top 3 hm2.hm_circuito
							from NOCURSOMASLOSSABADOS.bi_hecho_medicion hm2
							group by hm2.hm_circuito
							order by sum(hm2.hm_combustible) desc
							)
GO


CREATE VIEW max_velocidad_cada_auto_en_tipo_sector_en_circuito
AS
SELECT 
	hm.hm_circuito_nombre,
	hm.hm_sector_tipo_descripcion,
	hm.hm_auto_carrera, --faltaria buscar el auto. buscamos modelo y numero?
	max(hm.hm_velocidad)
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion hm
group by hm.hm_circuito, hm.hm_circuito_nombre, hm.hm_auto_carrera, hm.hm_sector_tipo_descripcion
GO



-----------------------------------------------------------------------------------------


CREATE TABLE  [NOCURSOMASLOSSABADOS].bi_hecho_medicion_v2
(
	hm_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hm_medicion decimal(18,0) FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_medicion,
	hm_motor INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_motor_medicion,
	hm_caja INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_caja_de_cambio_medicion,
	hm_freno INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_freno_medicion,
	hm_neumatico INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_neumatico_medicion,
	hm_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_circuito,
	hm_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector,
	hm_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_fecha,
	hm_freno_grosor_promedio decimal(18,2),
	hm_neumatico_profundidad_promedio decimal(18,2),
	hm_auto_carrera INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_auto_carrera,
	hm_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_escuderia,
	hm_sector_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo,
)

INSERT INTO [NOCURSOMASLOSSABADOS].bi_hecho_medicion_v2 --TARDA 43 SEGUNDOS
(
	hm_medicion,
	hm_motor, 
	hm_caja,
	hm_freno,
	hm_neumatico,
	hm_circuito,
	hm_sector,
	hm_fecha,
	hm_freno_grosor_promedio,
	hm_neumatico_profundidad_promedio,
	hm_auto_carrera,
	hm_escuderia,
	hm_sector_tipo
)
SELECT
	m.medicion_codigo,
	mm.motor_medicion_medicion,
	cm.caja_medicion_medicion,
	fm.freno_medicion_medicion,
	nm.neumatico_medicion_medicion,
	c.circuito_codigo,
	s.sector_codigo,
	f.fecha_id,
	sum(fm.freno_medicion_grosor) /4,
	sum(nm.neumatico_medicion_profundidad) / 4,
	ac.auto_carrera_codigo,
	e.escuderia_codigo,
	st.sector_tipo_codigo
FROM NOCURSOMASLOSSABADOS.bi_dim_medicion m
JOIN NOCURSOMASLOSSABADOS.bi_dim_motor_medicion mm ON m.medicion_codigo = mm.motor_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_caja_de_cambio_medicion cm ON m.medicion_codigo = cm.caja_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_freno_medicion fm ON m.medicion_codigo = fm.freno_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_neumatico_medicion nm ON m.medicion_codigo = nm.neumatico_medicion_medicion
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector s ON m.medicion_sector = s.sector_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON s.sector_circuito = c.circuito_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_carrera ac ON m.medicion_auto_carrera = ac.auto_carrera_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_carrera car ON ac.auto_carrera_carrera = car.carrera_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON a.auto_escuderia = e.escuderia_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector_tipo st ON s.sector_tipo = st.sector_tipo_codigo
group by 
	m.medicion_codigo,
	mm.motor_medicion_medicion,
	cm.caja_medicion_medicion,
	fm.freno_medicion_medicion,
	nm.neumatico_medicion_medicion,
	c.circuito_codigo,
	s.sector_codigo,
	f.fecha_id,
	ac.auto_carrera_codigo,
	e.escuderia_codigo,
	st.sector_tipo_codigo


CREATE VIEW desgaste_motor
AS
SELECT --la primera tiene que dar 14.08
	hm.hm_auto_carrera,
	c.circuitio_nombre,
	m.medicion_numero_vuelta,
	(select top 1 mm.motor_medicion_potencia --selecciono primera medicion de la vuelta
	from NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm2
	JOIN NOCURSOMASLOSSABADOS.bi_dim_motor_medicion mm ON mm.motor_medicion_codigo = hm2.hm_motor
	JOIN NOCURSOMASLOSSABADOS.bi_dim_medicion m2 ON m2.medicion_codigo = hm2.hm_medicion
	where hm2.hm_auto_carrera = hm.hm_auto_carrera
	and m2.medicion_numero_vuelta = m.medicion_numero_vuelta
	order by m2.medicion_tiempo_vuelta asc
	) -
	(select top 1 mm.motor_medicion_potencia --selecciono ultima medicion de la vuelta
	from NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm2
	JOIN NOCURSOMASLOSSABADOS.bi_dim_motor_medicion mm ON mm.motor_medicion_codigo = hm2.hm_motor
	JOIN NOCURSOMASLOSSABADOS.bi_dim_medicion m2 ON m2.medicion_codigo = hm2.hm_medicion
	where hm2.hm_auto_carrera = hm.hm_auto_carrera
	and m2.medicion_numero_vuelta = m.medicion_numero_vuelta
	order by m2.medicion_tiempo_vuelta desc
	)
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.bi_dim_medicion m ON m.medicion_codigo = hm.hm_medicion
group by hm_auto_carrera, c.circuitio_nombre, m.medicion_numero_vuelta
order by hm_auto_carrera, m.medicion_numero_vuelta


GO


CREATE VIEW circuitos_mayor_consumo_combustible_promedio_v2
AS
SELECT --falta algo con 'promedio'. promedio segun que?
	c.circuitio_nombre
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
group by c.circuito_codigo, c.circuitio_nombre
having c.circuito_codigo in (select top 3 hm2.hm_circuito
							from NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm2
							JOIN NOCURSOMASLOSSABADOS.bi_dim_medicion m ON m.medicion_codigo = hm2.hm_medicion
							group by hm2.hm_circuito
							order by sum(m.medicion_combustible) desc
							)
GO


CREATE VIEW max_velocidad_cada_auto_en_tipo_sector_en_circuito_v2
AS
SELECT 
	c.circuitio_nombre,
	st.sector_tipo_descripcion,
	ac.auto_carrera_auto, --faltaria buscar el auto. buscamos modelo y numero?
	max(m.medicion_velocidad) as max_velocidad
FROM NOCURSOMASLOSSABADOS.bi_hecho_medicion_v2 hm
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector_tipo st ON st.sector_tipo_codigo = hm.hm_sector_tipo
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_carrera ac ON ac.auto_carrera_codigo = hm.hm_auto_carrera
JOIN NOCURSOMASLOSSABADOS.bi_dim_medicion m ON m.medicion_codigo = hm.hm_medicion
group by c.circuitio_nombre, st.sector_tipo_descripcion, ac.auto_carrera_auto
GO


/************************************/
/*	CREACION Y CARGA DE BI_HECHO_PARADA	*/
/************************************/

CREATE TABLE [NOCURSOMASLOSSABADOS].bi_hecho_parada_v2
(
	hp_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hp_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_fecha,
	hp_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_escuderia,
	hp_parada INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_parada_box,
	hp_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_circuito,

)

INSERT INTO [NOCURSOMASLOSSABADOS].bi_hecho_parada_v2
(
	hp_fecha,
	hp_escuderia,
	hp_parada,
	hp_circuito
)

SELECT 
	f.fecha_id,
	e.escuderia_codigo,
	p.parada_codigo,
	c.circuito_codigo
FROM NOCURSOMASLOSSABADOS.bi_dim_parada_box p
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_carrera ac ON ac.auto_carrera_auto = p.parada_auto_carrera
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.bi_dim_carrera car ON car.carrera_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = car.carrera_circuito
JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha)
group by
 	f.fecha_id,
	e.escuderia_codigo,
	p.parada_codigo,
	c.circuito_codigo


CREATE VIEW cantidad_parada_de_circuitos_por_escuderia_anio_v2
AS
	SELECT
		c.circuito_codigo,
		c.circuitio_nombre,
		e.escuderia_codigo,
		e.escuderia_nombre,
		f.fecha_anio,
		COUNT(DISTINCT p.parada_codigo)	 as cantidadParadasPorAnio
	FROM NOCURSOMASLOSSABADOS.bi_hecho_parada_v2 hp
	JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = hp.hp_escuderia
	JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f on f.fecha_anio = hp.hp_fecha
	JOIN NOCURSOMASLOSSABADOS.bi_dim_parada_box p on p.parada_codigo = hp.hp_parada
	group by 
		c.circuito_codigo,
		c.circuitio_nombre,
		e.escuderia_codigo,
		e.escuderia_nombre,
		f.fecha_anio
GO

CREATE VIEW circuitos_con_mayor_tiempo_parada_v2
AS
	SELECT TOP 3
		c.circuito_codigo,
		c.circuitio_nombre,
		ISNULL(SUM(parada_tiempo),0) as tiempoEnParada
	FROM NOCURSOMASLOSSABADOS.bi_hecho_parada_v2 hp
	JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	JOIN NOCURSOMASLOSSABADOS.bi_dim_parada_box p on p.parada_codigo = hp.hp_parada
	group by 
		c.circuito_codigo,
		c.circuitio_nombre,
		p.parada_codigo
	ORDER BY tiempoEnParada DESC
GO



/************************************/
/*	CREACION Y CARGA DE BI_HECHO_INCIDENTE	*/

/************************************/
CREATE TABLE [NOCURSOMASLOSSABADOS].bi_hecho_incidente_v2
(
	hi_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hi_incidente_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_incidente_tipo,
	hi_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_circuito,
	hi_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_fecha,
	hi_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector,
	hi_sector_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_sector_tipo,
	hi_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_escuderia,
	hi_incidente INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].bi_dim_incidente,
)

INSERT INTO [NOCURSOMASLOSSABADOS].bi_hecho_incidente_v2
(
	hi_incidente_tipo,
	hi_circuito,
	hi_fecha,
	hi_sector,
	hi_sector_tipo,
	hi_escuderia,
	hi_incidente
)


SELECT 
	it.incidente_tipo_codigo,
	c.circuito_codigo,
	f.fecha_id,
	s.sector_codigo,
	st.sector_tipo_codigo,
	e.escuderia_codigo,
	i.incidente_codigo
FROM NOCURSOMASLOSSABADOS.bi_dim_incidente i
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_incidente ai ON ai.auto_incidente_incidente_codigo=i.incidente_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_incidente_tipo it ON ai.auto_incidente_tipo=it.incidente_tipo_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector s ON s.sector_codigo=i.incidente_sector
JOIN NOCURSOMASLOSSABADOS.bi_dim_sector_tipo st ON s.sector_tipo=st.sector_tipo_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo=s.sector_circuito
JOIN NOCURSOMASLOSSABADOS.bi_dim_carrera car ON c.circuito_codigo=car.carrera_circuito
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto_carrera ac ON ac.auto_carrera_auto = car.carrera_codigo
JOIN NOCURSOMASLOSSABADOS.bi_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha)

group by
	c.circuito_codigo,
	f.fecha_id,
	s.sector_codigo,
	st.sector_tipo_codigo,
	e.escuderia_codigo,
	i.incidente_codigo

CREATE VIEW circuito_mas_peligrosos_v2
AS
	SELECT TOP 3
		c.circuito_codigo,
		c.circuitio_nombre,
		COUNT(DISTINCT i.incidente_codigo ) as cantidadIncidentes
	FROM NOCURSOMASLOSSABADOS.bi_hecho_incidente_v2 hi
	JOIN NOCURSOMASLOSSABADOS.bi_dim_incidente i ON i.incidente_codigo = hi.hi_incidente
	JOIN NOCURSOMASLOSSABADOS.bi_dim_circuito c ON c.circuito_codigo = hi.hi_circuito
	group by
		c.circuito_codigo,
		c.circuitio_nombre
	ORDER BY cantidadIncidentes DESC
GO

CREATE VIEW promedio_escuderia_anio_v2
AS
	SELECT
		AVG(i.incidente_codigo) promedioPorAnio,
		e.escuderia_codigo,
		e.escuderia_nombre,
		st.sector_tipo_codigo,
		st.sector_tipo_descripcion,
		f.fecha_anio
	FROM NOCURSOMASLOSSABADOS.bi_hecho_incidente_v2 hi
	JOIN NOCURSOMASLOSSABADOS.bi_dim_incidente i ON i.incidente_codigo = hi.hi_incidente
	JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = hi.hi_escuderia
	JOIN NOCURSOMASLOSSABADOS.bi_dim_sector_tipo st ON st.sector_tipo_codigo = hi.hi_sector_tipo
	JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f on f.fecha_anio = hi.hi_fecha
	group by
		e.escuderia_codigo,
		e.escuderia_nombre,
		st.sector_tipo_codigo,
		st.sector_tipo_descripcion,
		f.fecha_anio
GO


