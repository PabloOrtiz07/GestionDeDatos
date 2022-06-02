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
	CONSTRAINT FK_id_PAIS FOREIGN KEY(escuderia_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
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
  CONSTRAINT FK_id_AUTO_MODELO FOREIGN KEY(auto_modelo) REFERENCES [Auto_Modelo](auto_modelo_codigo),
  CONSTRAINT FK_id_AUTO_ESCUDERIA FOREIGN KEY(auto_escuderia) REFERENCES [NOCURSOMASLOSSABADOS].[Escuderia](escuderia_codigo)
)



CREATE TABLE [NOCURSOMASLOSSABADOS].Piloto(
	piloto_codigo int NOT NULL,
	piloto_nombre nvarchar(50),
	piloto_apellido nvarchar(50),
	piloto_pais int,
	piloto_fecha_nacimiento date
	CONSTRAINT PK_PILOTO PRIMARY KEY(piloto_codigo)
	CONSTRAINT FK_id_PAIS FOREIGN KEY(piloto_pais) REFERENCES[NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
)



CREATE TABLE [NOCURSOMASLOSSABADOS].Circuito(
	circuito_codigo int NOT NULL,
	circuito_nombre nvarchar(255),
	circuito_pais int,
	CONSTRAINT PK_CIRCUITO PRIMARY KEY(circuito_codigo),
	CONSTRAINT FK_id_PAIS FOREIGN KEY(circuito_pais) REFERENCES [NOCURSOMASLOSSABADOS].[Pais](pais_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Carrera(
	carrera_codigo int NOT NULL,
	carrera_circuito int,
	carrera_cantidad_vueltas int,
	carrera_fecha date,
	carrera_clima nvarchar(100),
	CONSTRAINT PK_CARRERA PRIMARY KEY(carrera_codigo),
	CONSTRAINT FK_id_CIRCUITO FOREIGN KEY(carrera_circuito) REFERENCES [NOCURSOMASLOSSABADOS].[Circuito](circuito_codigo)
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

CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Medicion(
	medicion_codigo int NOT NULL,
	medicion_auto_carrera int,
	medicion_sector int,
	medicion_numero_vuelta decimal(18,0),
	medicion_distancia_carrera decimal(18,6),
	medicion_distancia_vuelta decimal(18,2),
	medicion_posicion decimal(18,0),
	medicion_velocidad decimal(18,2),
	medicion_combustible decimal(18,2),
	CONSTRAINT PK_MEDICION PRIMARY KEY(medicion_codigo),
	CONSTRAINT FK_id_CARRERA FOREIGN KEY(medicion_auto_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Carrera](carrera_codigo),
	CONSTRAINT FK_id_SECTOR FOREIGN KEY(medicion_sector) REFERENCES [NOCURSOMASLOSSABADOS].[Sector](sector_codigo)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Modelo(
	motor_modelo_codigo int NOT NULL,
	motor_descripcion nvarchar(255),
	CONSTRAINT PK_MOTOR PRIMARY KEY(motor_modelo_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Motor(
	motor_numero_serie nvarchar(255) NOT NULL,
	motor_modelo int,
	CONSTRAINT PK_MOTOR PRIMARY KEY(motor_numero_serie),
	CONSTRAINT FK_id_MOTOR_MODELO FOREIGN KEY(motor_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Motor_Modelo](motor_modelo_codigo)
	
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Motor_Medicion(
	motor_medicion_codigo int NOT NULL,
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
	caja_modelo_codigo int NOT NULL,
	caja_modelo_descripcion nvarchar(255),
	CONSTRAINT PK_MOTOR PRIMARY KEY(caja_modelo_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_de_cambio(
	caja_numero_serie nvarchar(255) NOT NULL,
	caja_modelo int,
	CONSTRAINT PK_CAJA_DE_CAMBIO PRIMARY KEY(caja_numero_serie),
	CONSTRAINT FK_id_CAJA_DE_CAMBIO_MODELO FOREIGN KEY(caja_modelo) REFERENCES [NOCURSOMASLOSSABADOS].[Caja_De_Cambio_Modelo](caja_modelo_codigo)	
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Caja_De_Cambio_Medicion(
	caja_medicion_codigo int NOT NULL,
	caja_medicion_medicion decimal(18,0),
	caja_medicion_caja_numero_serie nvarchar(255),
	caja_medicion_temperatura_aceite decimal(18,2),
	caja_medicion_rpm decimal(18,2),
	caja_medicion_desgaste decimal(18,2),
	CONSTRAINT PK_CAJA_DE_CAMBIO_MEDICION PRIMARY KEY(caja_medicion_codigo),
	CONSTRAINT FK_id_MEDICION FOREIGN KEY(caja_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
	CONSTRAINT FK_id_CAJA_DE_CAMBIO FOREIGN KEY(caja_medicion_caja_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Caja_De_Cambio](caja_numero_serie)
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Posicion(
	posicion_codigo int NOT NULL,
	posicion_posicion nvarchar(255),
	CONSTRAINT PK_POSICION PRIMARY KEY(posicion_codigo)	
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Freno(
	freno_numero_serie nvarchar(255) NOT NULL,
	freno_posicion int,
	CONSTRAINT PK_FRENO PRIMARY KEY(freno_numero_serie),
	CONSTRAINT FK_id_POSICION FOREIGN KEY(freno_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Freno_medicion(
	freno_medicion_codigo int NOT NULL,
	freno_medicion_medicion decimal(18,0),
	freno_medicion_freno_numero_serie nvarchar(255),
	freno_medicion_grosor decimal(18,2),
	freno_medicion_temperatura decimal(18,2),
	CONSTRAINT PK_FRENO_MEDICION PRIMARY KEY(freno_medicion_codigo),
	CONSTRAINT FK_id_FRENO FOREIGN KEY(freno_medicion_freno_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Freno](freno_numero_serie),
	CONSTRAINT FK_id_MEDICION FOREIGN KEY(freno_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](freno_medicon_medicion)
)
CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico_Tipo(
	neumatico_tipo_codigo int NOT NULL,
	neumatico_tipo_descripcion nvarchar(255),
	CONSTRAINT PK_MOTOR PRIMARY KEY(neumatico_tipo_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico(
	neumatico_numero_serie nvarchar(255) NOT NULL,
	neumatico_tipo int,
	neumatico_posicion int,
	CONSTRAINT PK_NEUMATICO PRIMARY KEY(neumatico_numero_serie),
	CONSTRAINT FK_id_NEUMATICO_TIPO FOREIGN KEY(neumatico_tipo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico_Tipo](neumatico_tipo_codigo),
	CONSTRAINT FK_id_POSICION FOREIGN KEY(neumatico_posicion) REFERENCES [NOCURSOMASLOSSABADOS].[Posicion](posicion_codigo)	
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Neumatico_Medicion(
	neumatico_medicion_codigo int NOT NULL,
	neumatico_medicion_medicion decimal(18,0),
	neumatico_medicion_neumatico_numero_serie nvarchar(255),
	neumatico_medicion_profundidad decimal(18,6),
	neumatico_medicion_presion decimal(18,6),
	neumatico_medicion_temperatura decimal(18,6),
	CONSTRAINT PK_NEUMATICO_MEDICION PRIMARY KEY(neumatico_numero_serie),
	CONSTRAINT FK_id_MEDICION FOREIGN KEY(neumatico_medicion_medicion) REFERENCES [NOCURSOMASLOSSABADOS].[Medicion](medicion_codigo),
	CONSTRAINT FK_id_NEUMATICO FOREIGN KEY(neumatico_medicion_neumatico_numero_serie) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie)
)


CREATE TABLE [NOCURSOMASLOSSABADOS].Parada_Box(
	parada_codigo int NOT NULL,
	parada_auto_carrera int,
	parada_numero_vuelta decimal(18,0),
	parada_tiempo decimal(18,2),
	parada_cambio_neumaticos int,
	CONSTRAINT PK_PARADA_BOX PRIMARY KEY(parada_codigo),
	CONSTRAINT FK_id_AUTO_CARRERA FOREIGN KEY(parada_auto_carrera) REFERENCES [NOCURSOMASLOSSABADOS].[Auto_Carrera](auto_carrera_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico(
	cambio_neumatico_codigo int NOT NULL,
	cambio_neumatico_parada int,
	CONSTRAINT PK_CAMBIO_NEUMATICO PRIMARY KEY(cambio_neumatico_codigo),
	CONSTRAINT FK_id_PARADA_BOX FOREIGN KEY(cambio_neumatico_parada) REFERENCES [NOCURSOMASLOSSABADOS].[Parada_Box](parada_codigo),
)

CREATE TABLE [NOCURSOMASLOSSABADOS].Cambio_Por_Neumatico(
	cambio_por_neumatico_codigo int NOT NULL,
	cambio_neumatico_codigo int,
	cambio_por_neumatico_nuevo_codigo nvarchar(255),
	cambio_por_neumatico_viejo_codigo nvarchar(255),
	CONSTRAINT PK_CAMBIO_POR_NEUMATICO PRIMARY KEY(cambio_por_neumatico_codigo),
	CONSTRAINT FK_id_NEUMATICO_NUEVO FOREIGN KEY(cambio_neumatico_nuevo_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie),
	CONSTRAINT FK_id_NEUMATICO_VIEJO FOREIGN KEY(cambio_neumatico_viejo_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Neumatico](neumatico_numero_serie),
	CONSTRAINT FK_id_CAMBIO_NEUMATICO FOREIGN KEY(cambio_neumatico_codigo) REFERENCES [NOCURSOMASLOSSABADOS].[Cambio_neumatico](cambio_neumatico_codigo)
)
END 
GO
