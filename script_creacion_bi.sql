USE [GD1C2022]
GO

/************************************/
/*			DROP TABLAS BI				*/
/************************************/


-------------- DROP TABLA DIMENSIONES ------------------------

------------ DROP TABLA HECHO ------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_parada')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_parada;

-------------- DROP TABLA DIMENSIONES ------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_fecha')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_fecha;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_sector')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_sector;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_auto_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_auto_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_incidente_tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_incidente_tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_circuito')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_circuito;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_neumatico_tipo')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_neumatico_tipo;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_auto')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_auto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_piloto')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_piloto;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_parada_box')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_parada_box;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_escuderia')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_escuderia;
/*
------------- DROP VIEWS -----------------------------------
IF EXISTS (SELECT name FROM sys.views WHERE name = 'desgaste_promedio_componente_auto_vuelta_circuito')
		DROP VIEW [NOCURSOMASLOSSABADOS].desgaste_promedio_componente_auto_vuelta_circuito;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'mejor_tiempo_vuelta_escuderia_anual_por_circuito')
		DROP VIEW [NOCURSOMASLOSSABADOS].mejor_tiempo_vuelta_escuderia_anual_por_circuito;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'circuitos_mayor_consumo_combustible_promedio')
		DROP VIEW [NOCURSOMASLOSSABADOS].circuitos_mayor_consumo_combustible_promedio;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'max_velocidad_cada_auto_en_tipo_sector_en_circuito')
		DROP VIEW [NOCURSOMASLOSSABADOS].max_velocidad_cada_auto_en_tipo_sector_en_circuito;			
IF EXISTS (SELECT name FROM sys.views WHERE name = 'tiempo_promedio_cuatrimestre')
		DROP VIEW [NOCURSOMASLOSSABADOS].tiempo_promedio_cuatrimestre;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'cantidad_parada_de_circuitos_por_escuderia_anio')
		DROP VIEW [NOCURSOMASLOSSABADOS].cantidad_parada_de_circuitos_por_escuderia_anio;		
IF EXISTS (SELECT name FROM sys.views WHERE name = 'tres_circuitos_con_mayor_tiempo_parada')
		DROP VIEW [NOCURSOMASLOSSABADOS].tres_circuitos_con_mayor_tiempo_parada;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'circuito_mas_peligrosos')
		DROP VIEW [NOCURSOMASLOSSABADOS].circuito_mas_peligrosos;	
IF EXISTS (SELECT name FROM sys.views WHERE name = 'promedio_incidentes_escuderia_anio')
		DROP VIEW [NOCURSOMASLOSSABADOS].promedio_incidentes_escuderia_anio;*/
/************************************/
/*			CREACION DIMENSIONES  BI				*/
/************************************/

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_fecha
(
	fecha_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	fecha_anio integer,
	fecha_cuatrimestre integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_sector
(
	sector_codigo INTEGER PRIMARY KEY,
	sector_tipo nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_auto_incidente
(
	auto_incidente_codigo INTEGER PRIMARY KEY,
	auto_incidente_auto integer,
	auto_incidente_incidente_codigo integer,
	auto_incidente_tipo integer,
	auto_incidente_numero_vuelta decimal(18,0),
)


CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_incidente
(
	incidente_codigo INTEGER PRIMARY KEY,
	incidente_sector integer,
	incidente_carrera integer,
	incidente_tiempo decimal(18,2),
	incidente_bandera integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_incidente_tipo
(
	incidente_tipo_codigo INTEGER PRIMARY KEY,
	incidente_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_circuito
(
	circuito_codigo INTEGER PRIMARY KEY,
	circuitio_nombre nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_neumatico_tipo
(
	neumatico_tipo_codigo INTEGER PRIMARY KEY,
	neumatico_tipo_descripcion nvarchar(255)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_auto
(
	auto_codigo INTEGER PRIMARY KEY,
	auto_modelo integer,
	auto_numero integer
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_piloto
(
	piloto_codigo INTEGER PRIMARY KEY,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50)
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_parada_box
(
	parada_codigo INTEGER PRIMARY KEY,
	parada_auto_carrera integer,
	parada_numero_vuelta decimal(18,0),
	parada_tiempo decimal(18,2),
)

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_escuderia
(
	escuderia_codigo INTEGER PRIMARY KEY,
	escuderia_nombre nvarchar(255)
)


/************************************/
/*			CARGA DIMENSIONES BI				*/
/************************************/

INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_fecha
(
	fecha_anio,
	fecha_cuatrimestre
)
SELECT distinct
	year(carrera_fecha),
	DATEPART(QUARTER, carrera_fecha)
FROM [NOCURSOMASLOSSABADOS].Carrera


INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_sector
(
	sector_codigo,
	sector_tipo
)
SELECT 
	s.sector_codigo,
	st.sector_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Sector s
JOIN NOCURSOMASLOSSABADOS.Sector_Tipo st on st.sector_tipo_codigo = s.sector_tipo


INSERT INTO  [NOCURSOMASLOSSABADOS].BI_dim_auto_incidente
(
	auto_incidente_codigo,
	auto_incidente_auto,
	auto_incidente_incidente_codigo,
	auto_incidente_tipo ,
	auto_incidente_numero_vuelta
)
SELECT
	auto_incidente_codigo,
	auto_incidente_auto,
	auto_incidente_codigo,
	auto_incidente_tipo,
	auto_incidente_numero_vuelta
FROM [NOCURSOMASLOSSABADOS].Auto_Incidente



INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_incidente
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

INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_incidente_tipo
(
	incidente_tipo_codigo,
	incidente_tipo_descripcion
)
SELECT 
	incidente_tipo_codigo,
	incidente_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Incidente_Tipo

INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_circuito
(
	circuito_codigo,
	circuitio_nombre
)
SELECT 
	circuito_codigo,
	circuito_nombre
FROM [NOCURSOMASLOSSABADOS].Circuito


INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_neumatico_tipo
(
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
)
SELECT 
	neumatico_tipo_codigo,
	neumatico_tipo_descripcion
FROM [NOCURSOMASLOSSABADOS].Neumatico_Tipo


INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_auto
(
	auto_codigo,
	auto_modelo,
	auto_numero
)
SELECT 
	auto_codigo,
	auto_modelo,
	auto_numero
FROM [NOCURSOMASLOSSABADOS].Auto


INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_piloto
(
	piloto_codigo,
	piloto_nombre,
	piloto_apellido
)
SELECT 
	piloto_codigo,
	piloto_nombre,
	piloto_apellido
FROM [NOCURSOMASLOSSABADOS].Piloto



INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_parada_box
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


INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_escuderia
(
	escuderia_codigo,
	escuderia_nombre
)
SELECT 
	escuderia_codigo,
	escuderia_nombre
FROM [NOCURSOMASLOSSABADOS].Escuderia




/************************************/
/*	CREACION Y CARGA DE BI_HECHO_MEDICION	*/
/************************************/
CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_hecho_medicion --granularidad mas chica es sector
(
	hm_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hm_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_fecha,
	hm_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_escuderia,
	hm_auto INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_auto,
	hm_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_sector,
	hm_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_circuito,
	
	hm_numero_vuelta decimal(18,0),

	hm_piloto INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_piloto,
	
	hm_motor_potencia_desgastada decimal(18,6),
	hm_caja_desgaste decimal(18,2),
	hm_freno_grosor_promedio decimal(18,2),
	hm_neumatico_profundidad_promedio decimal(18,6),
	hm_tiempo_vuelta decimal(18,10),
	hm_consumo_combustible decimal(18,2),
	hm_max_velocidad decimal(18,2)
)


INSERT INTO [NOCURSOMASLOSSABADOS].BI_hecho_medicion
(
	hm_fecha,
	hm_escuderia,
	hm_auto,
	hm_sector,
	hm_circuito,
	
	hm_numero_vuelta,

	hm_piloto,
	
	hm_motor_potencia_desgastada,
	hm_caja_desgaste,
	hm_freno_grosor_promedio,
	hm_neumatico_profundidad_promedio,
	hm_tiempo_vuelta, --tiempo de vuelta que consumio este sector. la suma de los tiempo_vuelta de los sectores nos da el tiempo de la vuelta total
	hm_consumo_combustible,
	hm_max_velocidad
)
SELECT
	f.fecha_id,
	e.escuderia_codigo,
	au.auto_codigo,
	s.sector_codigo,
	circ.circuito_codigo,
	m.medicion_numero_vuelta,
	p.piloto_codigo,
	max(mm.motor_medicion_potencia) - min(mm.motor_medicion_potencia),
	max(cm.caja_medicion_desgaste) - min(cm.caja_medicion_desgaste),
	max(fm.freno_medicion_grosor) - min(fm.freno_medicion_grosor), --mmmm hay que ver si falta algun /4  --sum(fm.freno_medicion_grosor)/4 --subselect?
	max(nm.neumatico_medicion_profundidad) - min(nm.neumatico_medicion_profundidad), --mmmm hay que ver si falta algun /4
	max(m.medicion_tiempo_vuelta) - min(m.medicion_tiempo_vuelta), --el ultimo tiempo medido en cada sector - el primero. eso me da un minimo error de decimales, pq entre la ultima medicion de un sector y la primera del siguiente pasan unas decimas de segundo. Lo dejamos pasar no? sino creo que hay que hacer subselect para lo que va restado
	max(m.medicion_combustible) - min(m.medicion_combustible),
	max(m.medicion_velocidad)
FROM NOCURSOMASLOSSABADOS.Medicion m
join NOCURSOMASLOSSABADOS.Auto_Carrera ac on ac.auto_carrera_codigo = m.medicion_auto_carrera
join NOCURSOMASLOSSABADOS.Carrera carr on carr.carrera_codigo = ac.auto_carrera_carrera
join NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_anio = year(carr.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, carr.carrera_fecha)
join NOCURSOMASLOSSABADOS.BI_dim_auto au on au.auto_codigo = ac.auto_carrera_auto --me cuesta saber si teia que joinear con auto o BI_dim_auto
join NOCURSOMASLOSSABADOS.Auto a on a.auto_codigo = ac.auto_carrera_auto
join NOCURSOMASLOSSABADOS.BI_dim_escuderia e on e.escuderia_codigo = a.auto_escuderia
join NOCURSOMASLOSSABADOS.BI_dim_sector s on s.sector_codigo = m.medicion_sector
join NOCURSOMASLOSSABADOS.BI_dim_circuito circ on circ.circuito_codigo = carr.carrera_circuito
join NOCURSOMASLOSSABADOS.BI_dim_piloto p on p.piloto_codigo = a.auto_piloto
join NOCURSOMASLOSSABADOS.Motor_Medicion mm on mm.motor_medicion_medicion = m.medicion_codigo
join NOCURSOMASLOSSABADOS.Caja_De_Cambio_Medicion cm on cm.caja_medicion_medicion = m.medicion_codigo
join NOCURSOMASLOSSABADOS.Freno_medicion fm on fm.freno_medicion_medicion = m.medicion_codigo
join NOCURSOMASLOSSABADOS.Neumatico_Medicion nm on nm.neumatico_medicion_medicion = m.medicion_codigo
group by
	f.fecha_id,
	e.escuderia_codigo,
	au.auto_codigo,
	s.sector_codigo, --el mas chico
	circ.circuito_codigo,
	m.medicion_numero_vuelta,
	p.piloto_codigo
GO


--select * from NOCURSOMASLOSSABADOS.Medicion 
--join NOCURSOMASLOSSABADOS.Freno_medicion on freno_medicion_medicion = medicion_codigo
--where medicion_auto_carrera = 19 and medicion_numero_vuelta = 17

--select * from NOCURSOMASLOSSABADOS.Carrera where carrera_circuito = 1
--select * from NOCURSOMASLOSSABADOS.Auto where auto_codigo = 14
--select * from NOCURSOMASLOSSABADOS.Auto_Carrera where auto_carrera_carrera = 1 and auto_carrera_auto = 14 --ac 19
--select * from NOCURSOMASLOSSABADOS.Sector where sector_tipo = 2


CREATE VIEW [NOCURSOMASLOSSABADOS].desgaste_promedio_componente_auto_vuelta_circuito
AS
SELECT
	c.circuitio_nombre,
	a.auto_modelo, a.auto_numero,
	hm.hm_numero_vuelta,
	sum(hm.hm_motor_potencia_desgastada) as desgaste_motor,
	sum(hm.hm_caja_desgaste) as desgaste_caja,
	sum(hm.hm_freno_grosor_promedio) as desgaste_frenos,
	sum(hm.hm_neumatico_profundidad_promedio) as desgaste_neumaticos
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto a ON a.auto_codigo = hm_auto
group by c.circuitio_nombre, a.auto_modelo, a.auto_numero, hm.hm_numero_vuelta
order by 1, 2,3,4
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].mejor_tiempo_vuelta_escuderia_anual_por_circuito
AS
SELECT 
	f.fecha_anio,
	c.circuitio_nombre,
	e.escuderia_nombre,
	(select top 1 sum(hm2.hm_tiempo_vuelta) --esto me trae el tiempo de vuelta total de cada vuelta
		from NOCURSOMASLOSSABADOS.BI_hecho_medicion hm2
		where hm2.hm_circuito = hm.hm_circuito 
		and hm2.hm_escuderia = hm.hm_escuderia
		and hm2.hm_fecha = hm.hm_fecha
		group by hm2.hm_circuito, hm2.hm_auto, hm2.hm_numero_vuelta
		having sum(hm2.hm_tiempo_vuelta) > 0 --sino me traia 0 pq capaz un auto corrio 0 
		order by 1 asc
	) as mejor_tiempo_vuelta
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_id = hm.hm_fecha
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hm.hm_escuderia
group by f.fecha_anio, c.circuito_codigo, c.circuitio_nombre, e.escuderia_codigo, e.escuderia_nombre, hm.hm_circuito, hm.hm_escuderia, hm.hm_fecha 
order by 1,2,3
GO

--select * from NOCURSOMASLOSSABADOS.Carrera where carrera_circuito = 1 
--select * from NOCURSOMASLOSSABADOS.Medicion where medicion_auto_carrera = 1 --este auto la vuelta 3 tiene una sola medicion (habrá chocado ponele)
--select * from NOCURSOMASLOSSABADOS.Auto_Carrera where auto_carrera_codigo = 17 --auto 12 carrera 1



CREATE VIEW [NOCURSOMASLOSSABADOS].circuitos_mayor_consumo_combustible_promedio
AS
SELECT top 3 
	c.circuitio_nombre,
	--hm.hm_auto,
	sum(hm.hm_consumo_combustible)
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
group by c.circuito_codigo, c.circuitio_nombre, hm.hm_circuito--, hm.hm_auto
GO
--lo comnetado estaba de prueba nomas. Parece q esta bien, salvo eso de la pregunta del foro

--select * from NOCURSOMASLOSSABADOS.Auto_Carrera where auto_carrera_auto = 11 --ac 16
--select * from NOCURSOMASLOSSABADOS.Medicion where medicion_auto_carrera = 16 --600 - 194 = 406


CREATE VIEW [NOCURSOMASLOSSABADOS].max_velocidad_cada_auto_en_tipo_sector_en_circuito
AS
SELECT 
	c.circuitio_nombre,
	a.auto_modelo, a.auto_numero,
	s.sector_tipo,
	max(hm.hm_max_velocidad) as max_velocidad
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto a ON a.auto_codigo = hm.hm_auto
JOIN NOCURSOMASLOSSABADOS.BI_dim_sector s ON s.sector_codigo = hm.hm_sector
group by c.circuitio_nombre, a.auto_modelo, a.auto_numero, s.sector_tipo
order by 1,2,3,4
GO



/************************************/
/*	CREACION Y CARGA DE BI_HECHO_PARADA	*/
/************************************/

CREATE TABLE [NOCURSOMASLOSSABADOS].BI_hecho_parada
(
	hp_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hp_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_fecha,
	hp_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_escuderia,
	hp_parada INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_parada_box,
	hp_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_circuito,
)

INSERT INTO [NOCURSOMASLOSSABADOS].BI_hecho_parada
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
FROM NOCURSOMASLOSSABADOS.BI_dim_parada_box p
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto_carrera ac ON ac.auto_carrera_auto = p.parada_auto_carrera
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.BI_dim_carrera car ON car.carrera_codigo = ac.auto_carrera_carrera
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = car.carrera_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
group by
 	f.fecha_id,
	e.escuderia_codigo,
	p.parada_codigo,
	c.circuito_codigo
GO

CREATE VIEW [NOCURSOMASLOSSABADOS].tiempo_promedio_cuatrimestre
AS
	SELECT
		e.escuderia_nombre,
		f.fecha_cuatrimestre,
		AVG(p.parada_tiempo) as PromedioPorCuatrimestre
	FROM NOCURSOMASLOSSABADOS.bi_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = hp.hp_escuderia
	JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f on f.fecha_id = hp.hp_fecha
	JOIN NOCURSOMASLOSSABADOS.bi_dim_parada_box p on p.parada_codigo = hp.hp_parada
	group by 
		e.escuderia_nombre,
		f.fecha_cuatrimestre
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].cantidad_parada_de_circuitos_por_escuderia_anio
AS
	SELECT
		c.circuitio_nombre,
		e.escuderia_nombre,
		f.fecha_anio,
		COUNT(DISTINCT p.parada_codigo)	 as cantidadParadasPorAnio
	FROM NOCURSOMASLOSSABADOS.BI_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hp.hp_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_id = hp.hp_fecha
	JOIN NOCURSOMASLOSSABADOS.BI_dim_parada_box p on p.parada_codigo = hp.hp_parada
	group by 
		c.circuito_codigo,
		c.circuitio_nombre,
		e.escuderia_codigo,
		e.escuderia_nombre,
		f.fecha_anio
GO

CREATE VIEW [NOCURSOMASLOSSABADOS].tres_circuitos_con_mayor_tiempo_parada
AS
	SELECT TOP 3
		c.circuitio_nombre,
		ISNULL(sum(parada_tiempo),0) as tiempoEnParada
	FROM NOCURSOMASLOSSABADOS.BI_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	JOIN NOCURSOMASLOSSABADOS.BI_dim_parada_box p on p.parada_codigo = hp.hp_parada
	group by 
		c.circuito_codigo,
		c.circuitio_nombre
	ORDER BY tiempoEnParada DESC
GO


/************************************/
/*	CREACION Y CARGA DE BI_HECHO_INCIDENTE	*/
/************************************/

CREATE TABLE [NOCURSOMASLOSSABADOS].BI_hecho_incidente
(
	hi_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hi_incidente_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_incidente_tipo,
	hi_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_circuito,
	hi_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_fecha,
	hi_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_sector,
	hi_sector_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_sector_tipo,
	hi_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_escuderia,
	hi_incidente INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_incidente,
)

INSERT INTO [NOCURSOMASLOSSABADOS].BI_hecho_incidente
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
FROM NOCURSOMASLOSSABADOS.BI_dim_incidente i
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto_incidente ai ON ai.auto_incidente_incidente_codigo=i.incidente_codigo
JOIN NOCURSOMASLOSSABADOS.BI_dim_incidente_tipo it ON ai.auto_incidente_tipo=it.incidente_tipo_codigo
JOIN NOCURSOMASLOSSABADOS.BI_dim_sector s ON s.sector_codigo=i.incidente_sector
JOIN NOCURSOMASLOSSABADOS.BI_dim_sector_tipo st ON s.sector_tipo=st.sector_tipo_codigo
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo=s.sector_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_carrera car ON c.circuito_codigo=car.carrera_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto_carrera ac ON ac.auto_carrera_auto = car.carrera_codigo
JOIN NOCURSOMASLOSSABADOS.BI_dim_auto a ON a.auto_codigo = ac.auto_carrera_auto
JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
group by
	it.incidente_tipo_codigo,
	c.circuito_codigo,
	f.fecha_id,
	s.sector_codigo,
	st.sector_tipo_codigo,
	e.escuderia_codigo,
	i.incidente_codigo
GO

CREATE VIEW [NOCURSOMASLOSSABADOS].circuito_mas_peligrosos
AS
	SELECT TOP 3
		c.circuitio_nombre,
		COUNT(DISTINCT i.incidente_codigo ) as cantidadIncidentes
	FROM NOCURSOMASLOSSABADOS.BI_hecho_incidente hi
	JOIN NOCURSOMASLOSSABADOS.BI_dim_incidente i ON i.incidente_codigo = hi.hi_incidente
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hi.hi_circuito
	group by
		c.circuito_codigo,
		c.circuitio_nombre
	ORDER BY cantidadIncidentes DESC
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].promedio_incidentes_escuderia_anio
AS
	SELECT
		AVG(i.incidente_codigo) promedioPorAnio,
		e.escuderia_nombre,
		st.sector_tipo_descripcion,
		f.fecha_anio
	FROM NOCURSOMASLOSSABADOS.BI_hecho_incidente hi
	JOIN NOCURSOMASLOSSABADOS.BI_dim_incidente i ON i.incidente_codigo = hi.hi_incidente
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hi.hi_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_sector_tipo st ON st.sector_tipo_codigo = hi.hi_sector_tipo
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_id = hi.hi_fecha
	group by
		e.escuderia_codigo,
		e.escuderia_nombre,
		st.sector_tipo_codigo,
		st.sector_tipo_descripcion,
		f.fecha_anio
GO
