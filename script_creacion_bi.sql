USE [GD1C2022]
GO

/************************************/
/*			DROP STORE PROCEDURES	*/
/************************************/
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_dimensiones_BI')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_dimensiones_BI;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'crear_indice_para_carga_tabla_hecho_medicion_bi')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.crear_indice_para_carga_tabla_hecho_medicion_bi;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_hecho_medicion_bi')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_medicion_bi;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_hecho_parada_bi')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_parada_bi;
IF EXISTS (SELECT name FROM sys.procedures WHERE name = 'cargar_tabla_hecho_incidente_bi')
		DROP PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_incidente_bi;
GO

/************************************/
/*			DROP FUNCIONES         	*/
/************************************/
IF EXISTS (SELECT name FROM sys.objects WHERE name = 'tabla_combustible_max_circuito_auto_vuelta_sector')
		DROP FUNCTION NOCURSOMASLOSSABADOS.tabla_combustible_max_circuito_auto_vuelta_sector;
GO

/************************************/
/*			DROP INDICES			*/
/************************************/
IF EXISTS(SELECT name FROM sys.indexes WHERE name = 'indice_freno_medicion')
		DROP INDEX indice_freno_medicion ON NOCURSOMASLOSSABADOS.Freno_medicion
IF EXISTS(SELECT name FROM sys.indexes WHERE name = 'indice_neumatico_medicion')
		DROP INDEX indice_neumatico_medicion ON NOCURSOMASLOSSABADOS.Neumatico_Medicion
IF EXISTS(SELECT name FROM sys.indexes WHERE name = 'medicion_auto_carrera')
		DROP INDEX medicion_auto_carrera ON NOCURSOMASLOSSABADOS.Medicion
IF EXISTS(SELECT name FROM sys.indexes WHERE name = 'medicion_numero_vuelta')
		DROP INDEX medicion_numero_vuelta ON NOCURSOMASLOSSABADOS.Medicion
GO


/************************************/
/*			DROP TABLAS BI			*/
/************************************/

------------ DROP TABLA HECHO ------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_medicion')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_medicion;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_incidente')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_incidente;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hecho_parada')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_hecho_parada;
GO

-------------- DROP TABLA DIMENSIONES ------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_fecha')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_fecha;
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_dim_sector')
		DROP TABLE [NOCURSOMASLOSSABADOS].BI_dim_sector;
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
GO
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
		DROP VIEW [NOCURSOMASLOSSABADOS].promedio_incidentes_escuderia_anio;
GO

/************************************/
/*		CREACION DIMENSIONES  BI   */
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
		auto_modelo nvarchar(255),
		auto_numero integer
	)

	CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_piloto
	(
		piloto_codigo INTEGER PRIMARY KEY,
		piloto_nombre nvarchar(50),
		piloto_apellido nvarchar(50)
	)

	CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_dim_escuderia
	(
		escuderia_codigo INTEGER PRIMARY KEY,
		escuderia_nombre nvarchar(255)
	)

GO

/************************************/
/*			CARGA DIMENSIONES BI	*/
/************************************/

CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_dimensiones_BI AS
BEGIN

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
		a.auto_codigo,
		am.auto_modelo_descripcion,
		a.auto_numero
	FROM [NOCURSOMASLOSSABADOS].Auto a
	JOIN NOCURSOMASLOSSABADOS.Auto_Modelo am ON am.auto_modelo_codigo = a.auto_modelo


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


	INSERT INTO [NOCURSOMASLOSSABADOS].BI_dim_escuderia
	(
		escuderia_codigo,
		escuderia_nombre
	)
	SELECT 
		escuderia_codigo,
		escuderia_nombre
	FROM [NOCURSOMASLOSSABADOS].Escuderia

END
GO


/************************************/
/*	CREACION Y CARGA DE BI_HECHO_MEDICION	*/
/************************************/

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_hecho_medicion
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
GO

CREATE PROCEDURE NOCURSOMASLOSSABADOS.crear_indice_para_carga_tabla_hecho_medicion_bi AS
BEGIN
	CREATE INDEX indice_neumatico_medicion ON NOCURSOMASLOSSABADOS.Neumatico_Medicion(neumatico_medicion_medicion)
	CREATE INDEX indice_freno_medicion ON NOCURSOMASLOSSABADOS.Freno_medicion(freno_medicion_medicion)
	CREATE INDEX medicion_auto_carrera ON NOCURSOMASLOSSABADOS.Medicion(medicion_auto_carrera)
	CREATE INDEX medicion_numero_vuelta ON NOCURSOMASLOSSABADOS.Medicion(medicion_numero_vuelta)
END
GO

CREATE FUNCTION NOCURSOMASLOSSABADOS.tabla_combustible_max_circuito_auto_vuelta_sector() returns @Tabla table (
		circuito integer, 
		auto integer,
		numeroVuelta decimal(18,0),
		sector integer,
		consumoCombustible decimal(18,2)
	)
AS
BEGIN
	INSERT INTO @Tabla
	SELECT
		ac.auto_carrera_carrera,
		ac.auto_carrera_auto,
		m.medicion_numero_vuelta,
		m.medicion_sector,
		max(m.medicion_combustible)
	FROM NOCURSOMASLOSSABADOS.Medicion m
	join NOCURSOMASLOSSABADOS.Auto_Carrera ac on m.medicion_auto_carrera = ac.auto_carrera_codigo
	GROUP BY ac.auto_carrera_carrera,
		ac.auto_carrera_auto,
		m.medicion_numero_vuelta,
		m.medicion_sector
	ORDER BY 1,2,3,4
RETURN
END
GO


CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_medicion_bi AS
BEGIN
	INSERT INTO NOCURSOMASLOSSABADOS.BI_hecho_medicion
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
		hm_tiempo_vuelta,
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
	
		(
		max(fm1.freno_medicion_grosor) - min(fm1.freno_medicion_grosor)
		+ max(fm2.freno_medicion_grosor) - min(fm2.freno_medicion_grosor)
		+ max(fm3.freno_medicion_grosor) - min(fm3.freno_medicion_grosor)
		+ max(fm4.freno_medicion_grosor) - min(fm4.freno_medicion_grosor)	
		) /4 as freno_desg,

		(
		max(nm1.neumatico_medicion_profundidad) - min(nm1.neumatico_medicion_profundidad)
		+ max(nm2.neumatico_medicion_profundidad) - min(nm2.neumatico_medicion_profundidad)
		+ max(nm3.neumatico_medicion_profundidad) - min(nm3.neumatico_medicion_profundidad)
		+ max(nm4.neumatico_medicion_profundidad) - min(nm4.neumatico_medicion_profundidad)
		) /4 as neum_desg,

		max(m.medicion_tiempo_vuelta) - min(m.medicion_tiempo_vuelta),
		
		max(m.medicion_combustible) - 
		isnull(
			(select tabla.consumoCombustible
				from NOCURSOMASLOSSABADOS.tabla_combustible_max_circuito_auto_vuelta_sector() tabla
				where tabla.circuito = circuito_codigo
				and tabla.auto = au.auto_codigo
				and
				tabla.numeroVuelta = m.medicion_numero_vuelta
				and tabla.sector = s.sector_codigo +1
			),
			isnull(
				(select max(tabla2.consumoCombustible)
					from NOCURSOMASLOSSABADOS.tabla_combustible_max_circuito_auto_vuelta_sector() tabla2
					where tabla2.circuito = circuito_codigo
					and tabla2.auto = au.auto_codigo
					and tabla2.numeroVuelta = m.medicion_numero_vuelta +1
					and tabla2.sector = (select top 1 min(tabla3.sector)
										from NOCURSOMASLOSSABADOS.tabla_combustible_max_circuito_auto_vuelta_sector() tabla3
										where tabla3.circuito = circuito_codigo
										and tabla3.auto = au.auto_codigo
										group by tabla3.circuito, tabla3.auto
										)
				),
			max(m.medicion_combustible)
			)
		) as combus, 
		
		max(m.medicion_velocidad)
	FROM NOCURSOMASLOSSABADOS.Medicion m
	join NOCURSOMASLOSSABADOS.Auto_Carrera ac on ac.auto_carrera_codigo = m.medicion_auto_carrera
	join NOCURSOMASLOSSABADOS.Carrera carr on carr.carrera_codigo = ac.auto_carrera_carrera
	join NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_anio = year(carr.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, carr.carrera_fecha)
	join NOCURSOMASLOSSABADOS.BI_dim_auto au on au.auto_codigo = ac.auto_carrera_auto
	join NOCURSOMASLOSSABADOS.Auto a on a.auto_codigo = ac.auto_carrera_auto
	join NOCURSOMASLOSSABADOS.BI_dim_escuderia e on e.escuderia_codigo = a.auto_escuderia
	join NOCURSOMASLOSSABADOS.BI_dim_sector s on s.sector_codigo = m.medicion_sector
	join NOCURSOMASLOSSABADOS.BI_dim_circuito circ on circ.circuito_codigo = carr.carrera_circuito
	join NOCURSOMASLOSSABADOS.BI_dim_piloto p on p.piloto_codigo = a.auto_piloto
	join NOCURSOMASLOSSABADOS.Motor_Medicion mm on mm.motor_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Caja_De_Cambio_Medicion cm on cm.caja_medicion_medicion = m.medicion_codigo

	join NOCURSOMASLOSSABADOS.Freno_medicion fm1 on fm1.freno_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Freno fre1 on fre1.freno_numero_serie = fm1.freno_medicion_freno_numero_serie and fre1.freno_posicion = 1
	join NOCURSOMASLOSSABADOS.Freno_medicion fm2 on fm2.freno_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Freno fre2 on fre2.freno_numero_serie = fm2.freno_medicion_freno_numero_serie and fre2.freno_posicion = 2
	join NOCURSOMASLOSSABADOS.Freno_medicion fm3 on fm3.freno_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Freno fre3 on fre3.freno_numero_serie = fm3.freno_medicion_freno_numero_serie and fre3.freno_posicion = 3
	join NOCURSOMASLOSSABADOS.Freno_medicion fm4 on fm4.freno_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Freno fre4 on fre4.freno_numero_serie = fm4.freno_medicion_freno_numero_serie and fre4.freno_posicion = 4

	join NOCURSOMASLOSSABADOS.Neumatico_Medicion nm1 on nm1.neumatico_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Neumatico neu1 on neu1.neumatico_numero_serie = nm1.neumatico_medicion_neumatico_numero_serie and neu1.neumatico_posicion = 1
	join NOCURSOMASLOSSABADOS.Neumatico_Medicion nm2 on nm2.neumatico_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Neumatico neu2 on neu2.neumatico_numero_serie = nm2.neumatico_medicion_neumatico_numero_serie and neu2.neumatico_posicion = 2
	join NOCURSOMASLOSSABADOS.Neumatico_Medicion nm3 on nm3.neumatico_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Neumatico neu3 on neu3.neumatico_numero_serie = nm3.neumatico_medicion_neumatico_numero_serie and neu3.neumatico_posicion = 3
	join NOCURSOMASLOSSABADOS.Neumatico_Medicion nm4 on nm4.neumatico_medicion_medicion = m.medicion_codigo
	join NOCURSOMASLOSSABADOS.Neumatico neu4 on neu4.neumatico_numero_serie = nm4.neumatico_medicion_neumatico_numero_serie and neu4.neumatico_posicion = 4
	group by
		f.fecha_id,
		e.escuderia_codigo,
		au.auto_codigo,
		s.sector_codigo,
		circ.circuito_codigo,
		m.medicion_numero_vuelta,
		p.piloto_codigo
END
GO


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
group by c.circuitio_nombre ,a.auto_modelo, a.auto_numero, hm.hm_numero_vuelta
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].mejor_tiempo_vuelta_escuderia_anual_por_circuito
AS
SELECT 
	f.fecha_anio,
	c.circuitio_nombre,
	e.escuderia_nombre,
	(select top 1 sum(hm2.hm_tiempo_vuelta) 
		from NOCURSOMASLOSSABADOS.BI_hecho_medicion hm2
		where hm2.hm_circuito = hm.hm_circuito 
		and hm2.hm_escuderia = hm.hm_escuderia
		and hm2.hm_fecha = hm.hm_fecha
		group by hm2.hm_circuito, hm2.hm_auto, hm2.hm_numero_vuelta
		having sum(hm2.hm_tiempo_vuelta) > 0 
		order by 1 asc
	) as mejor_tiempo_vuelta
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_id = hm.hm_fecha
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hm.hm_escuderia
group by f.fecha_anio, c.circuito_codigo, c.circuitio_nombre, e.escuderia_codigo, e.escuderia_nombre, hm.hm_circuito, hm.hm_escuderia, hm.hm_fecha 
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].circuitos_mayor_consumo_combustible_promedio
AS
SELECT top 3 
	c.circuitio_nombre,
	sum(hm.hm_consumo_combustible) / count(distinct hm.hm_auto) as consumo_combustible_promedio
FROM NOCURSOMASLOSSABADOS.BI_hecho_medicion hm
JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hm.hm_circuito
group by c.circuito_codigo, c.circuitio_nombre, hm.hm_circuito
order by 2 desc
GO


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
GO



/************************************/
/*	CREACION Y CARGA DE BI_HECHO_PARADA	*/
/************************************/

CREATE TABLE [NOCURSOMASLOSSABADOS].BI_hecho_parada
(
	hp_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hp_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_fecha,
	hp_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_escuderia,
	hp_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_circuito,
	hp_neumatico_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_neumatico_tipo,
	hp_cantidad_paradas integer,
	hp_tiempo_parada decimal(18,2),
	hp_tiempo_parada_promedio decimal(18,2)
)
GO

CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_parada_bi AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].BI_hecho_parada
	(
		hp_fecha,
		hp_escuderia,
		hp_circuito,
		hp_neumatico_tipo,
		hp_cantidad_paradas,
		hp_tiempo_parada,
		hp_tiempo_parada_promedio
	)
	SELECT
		f.fecha_id,
		e.escuderia_codigo,
		c.circuito_codigo,
		nt.neumatico_tipo_codigo,
		count(distinct p.parada_codigo) as cantidadParadas,
		isnull(sum(p.parada_tiempo),0),
		avg(p.parada_tiempo)
	FROM NOCURSOMASLOSSABADOS.Parada_Box p
	JOIN NOCURSOMASLOSSABADOS.Auto_Carrera ac ON ac.auto_carrera_codigo = p.parada_auto_carrera
	JOIN NOCURSOMASLOSSABADOS.Carrera car ON car.carrera_codigo = ac.auto_carrera_carrera
	JOIN NOCURSOMASLOSSABADOS.Auto a ON a.auto_codigo = ac.auto_carrera_auto
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = car.carrera_circuito
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
	JOIN NOCURSOMASLOSSABADOS.Cambio_Por_Neumatico cpn ON cpn.cambio_parada_box_codigo = p.parada_codigo
	JOIN NOCURSOMASLOSSABADOS.Neumatico neu ON neu.neumatico_numero_serie = cpn.cambio_por_neumatico_viejo_codigo
	JOIN NOCURSOMASLOSSABADOS.BI_dim_neumatico_tipo nt ON nt.neumatico_tipo_codigo = neu.neumatico_tipo
	group by
 		f.fecha_id,
		e.escuderia_codigo,
		c.circuito_codigo,
		nt.neumatico_tipo_codigo
END
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].tiempo_promedio_cuatrimestre 
AS
	SELECT
		e.escuderia_nombre,
		f.fecha_anio, 
		f.fecha_cuatrimestre,
		avg(hp.hp_tiempo_parada_promedio) as PromedioPorCuatrimestre
	FROM NOCURSOMASLOSSABADOS.bi_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.bi_dim_escuderia e ON e.escuderia_codigo = hp.hp_escuderia
	JOIN NOCURSOMASLOSSABADOS.bi_dim_fecha f on f.fecha_id = hp.hp_fecha
	group by 
		e.escuderia_nombre,
		f.fecha_anio, 
		f.fecha_cuatrimestre
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].cantidad_parada_de_circuitos_por_escuderia_anio
AS
	SELECT
		c.circuitio_nombre,
		e.escuderia_nombre,
		f.fecha_anio,
		sum(hp.hp_cantidad_paradas) as cantidad_paradas
	FROM NOCURSOMASLOSSABADOS.BI_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hp.hp_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_id = hp.hp_fecha
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
		isnull(sum(hp.hp_tiempo_parada),0) as tiempoEnParada
	FROM NOCURSOMASLOSSABADOS.BI_hecho_parada hp
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hp.hp_circuito
	group by 
		c.circuito_codigo,
		c.circuitio_nombre
	ORDER BY tiempoEnParada DESC
GO



/************************************/
/*	CREACION Y CARGA DE BI_HECHO_INCIDENTE	*/
/************************************/

CREATE TABLE  [NOCURSOMASLOSSABADOS].BI_hecho_incidente
(
	hi_id INTEGER IDENTITY(1,1) PRIMARY KEY,
	hi_fecha INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_fecha,
	hi_escuderia INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_escuderia,
	hi_sector INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_sector,
	hi_circuito INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_circuito,
	hi_incidente_tipo INTEGER FOREIGN KEY references [NOCURSOMASLOSSABADOS].BI_dim_incidente_tipo,
	hi_cantidad_incidente INTEGER
)
GO

CREATE PROCEDURE NOCURSOMASLOSSABADOS.cargar_tabla_hecho_incidente_bi AS
BEGIN
	INSERT INTO [NOCURSOMASLOSSABADOS].BI_hecho_incidente
	(
		hi_fecha,
		hi_escuderia,
		hi_sector,
		hi_circuito,
		hi_incidente_tipo,
		hi_cantidad_incidente
	)
	SELECT
		f.fecha_id,
		e.escuderia_codigo,
		s.sector_codigo,
		circ.circuito_codigo,
		it.incidente_tipo_codigo,
		count(distinct i.incidente_codigo) as cantidadIncidentes
	FROM NOCURSOMASLOSSABADOS.Incidente i
	JOIN NOCURSOMASLOSSABADOS.Auto_Incidente ai ON ai.auto_incidente_incidente_codigo = i.incidente_codigo
	JOIN NOCURSOMASLOSSABADOS.BI_dim_incidente_tipo it on it.incidente_tipo_codigo = ai.auto_incidente_tipo 
	JOIN NOCURSOMASLOSSABADOS.BI_dim_sector s ON s.sector_codigo = i.incidente_sector
	JOIN NOCURSOMASLOSSABADOS.Carrera car ON i.incidente_carrera = car.carrera_codigo
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito circ ON circ.circuito_codigo = car.carrera_circuito
	JOIN NOCURSOMASLOSSABADOS.Auto a ON a.auto_codigo = ai.auto_incidente_auto
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = a.auto_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f ON f.fecha_anio = year(car.carrera_fecha) and f.fecha_cuatrimestre = DATEPART(QUARTER, car.carrera_fecha)
		group by
		f.fecha_id,
		e.escuderia_codigo,
		s.sector_codigo,
		circ.circuito_codigo,
		it.incidente_tipo_codigo
END
GO


CREATE VIEW [NOCURSOMASLOSSABADOS].circuito_mas_peligrosos
AS
	SELECT TOP 3
		c.circuitio_nombre,
		f.fecha_anio,
		isnull(sum(hi.hi_cantidad_incidente),0) as cantidadIncidentes
	FROM NOCURSOMASLOSSABADOS.BI_hecho_incidente hi
	JOIN NOCURSOMASLOSSABADOS.BI_dim_circuito c ON c.circuito_codigo = hi.hi_circuito
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_id = hi.hi_fecha
	group by
		c.circuito_codigo,
		c.circuitio_nombre,
		f.fecha_anio
	ORDER BY cantidadIncidentes desc
GO



CREATE VIEW [NOCURSOMASLOSSABADOS].promedio_incidentes_escuderia_anio
AS
	SELECT
		cast(sum(hi.hi_cantidad_incidente) as decimal(10,2)) / count(distinct hi.hi_circuito) as promedioporAnio,
		e.escuderia_nombre,
		s.sector_tipo,
		f.fecha_anio
	FROM NOCURSOMASLOSSABADOS.BI_hecho_incidente hi
	JOIN NOCURSOMASLOSSABADOS.BI_dim_escuderia e ON e.escuderia_codigo = hi.hi_escuderia
	JOIN NOCURSOMASLOSSABADOS.BI_dim_sector s ON s.sector_codigo = hi.hi_sector
	JOIN NOCURSOMASLOSSABADOS.BI_dim_fecha f on f.fecha_id = hi.hi_fecha
	group by
		e.escuderia_codigo,
		e.escuderia_nombre,
		s.sector_tipo,
		f.fecha_anio
GO


-------------------- EJECUCION DE PROCEDURES ---------------------
EXEC NOCURSOMASLOSSABADOS.cargar_dimensiones_BI
EXEC NOCURSOMASLOSSABADOS.crear_indice_para_carga_tabla_hecho_medicion_bi;
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_hecho_medicion_bi;
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_hecho_parada_bi;
EXEC NOCURSOMASLOSSABADOS.cargar_tabla_hecho_incidente_bi;