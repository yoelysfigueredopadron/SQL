-- Creamos una nueva base de datos llamada NewDB
CREATE DATABASE NewDB;

-- La instanciamos
USE NewDB;

--  Creamos las diferentes tablas con sus campos y tipos de datos. También creamos sus claves primarias y foráneas para relacionarlas

/*	
	(carrier_id) es clave primaria de la tabla 'Carrier' donde hay dos campos más (nombre, capacity) en los cuales almacenamos
	información referente a los Carriers o transportistas (Carrier A, Carrier B, Carrier C). El campo (carrier_id) es clave
	foránea en la tabla 'Costos'
*/
CREATE TABLE Carrier(
    carrier_id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    capacity INTEGER
);

/*
	(zona_id) es clave primaria de la tabla 'Zonas'. Tenemos otro campo para especificar los nombres de las diferentes zonas.
	(zona_id) es clave foránea en la tabla 'Envios'
*/
CREATE TABLE Zonas(
	zona_id INTEGER PRIMARY KEY,
	zona VARCHAR(50)
);

/*
	(costo_id) es clave primaria de la tabla 'Costos'. Tenemos otros campos con los nombres de (carrier_id, zona_id, costo, tiempo_entrega).
	La tabla 'Costos' contiene la información los (costos) por envió de cada carrier(carrier_id) por las diferentes zonas(zona_id) y su (tiempo_entrega).
	(carrier_id, zona_id) son claves foráneas en las tablas 'Carrier' y 'Zonas' respectivamente. 
*/
CREATE TABLE Costos(
	costo_id INTEGER PRIMARY KEY,
    carrier_id INTEGER NOT NULL,
    zona_id INTEGER NOT NULL,
    costo INTEGER,
	tiempo_entrega INTEGER,
	FOREIGN KEY (carrier_id) REFERENCES Carrier(carrier_id),
	FOREIGN KEY (zona_id) REFERENCES Zonas(zona_id)
);

/*
	(envio_id) es clave primaria de la tabla 'Envios'. Tenemos otros campos con los nombres de ('zona_id', 'mes', 'cantidad_envios')
	Los registros de la tabla 'Envios' nos brinda el detalle de la (cantidad_envios) de envios por zona (zona_id) en cada (mes).
	(zona_id) es clave foránea en la tabla 'Envios'
*/
CREATE TABLE Envios(
	envio_id INTEGER PRIMARY KEY,
	zona_id INTEGER NOT NULL,
	mes INTEGER,
	cantidad_envios INTEGER,
	FOREIGN KEY (zona_id) REFERENCES Zonas(zona_id)
);
 
-- Introducimos los datos con el INSERT INTO en cada tabla para todos sus campos

-- Insert Carrier
INSERT INTO Carrier VALUES(1, 'Carrier A', 10000);
INSERT INTO Carrier VALUES(2, 'Carrier B', 10000);
INSERT INTO Carrier VALUES(3, 'Carrier C', 3000);

-- Insert Zonas
INSERT INTO Zonas VALUES(1, 'Amba');
INSERT INTO Zonas VALUES(2, 'Bs As');
INSERT INTO Zonas VALUES(3, 'Resto');

-- Insert Costos
INSERT INTO Costos VALUES(1, 1, 1, 10, 3);
INSERT INTO Costos VALUES(2, 1, 2, 20, 5);
INSERT INTO Costos VALUES(3, 1, 3, 50, 7);
INSERT INTO Costos VALUES(4, 2, 1, 15, 2);
INSERT INTO Costos VALUES(5, 2, 2, 19, 4);
INSERT INTO Costos VALUES(6, 2, 3, 55, 6);
INSERT INTO Costos VALUES(7, 3, 1, 20, 1);
 
-- Insert Envios
INSERT INTO Envios VALUES(1, 1, 1, 40000);
INSERT INTO Envios VALUES(2, 2, 1, 50000);
INSERT INTO Envios VALUES(3, 3, 1, 60000);

/*
	Creamos una consulta con cláusulas JOINs donde unimos las tablas 'Carrier', 'Costos' y 'Envios' donde Ca, Co y E son sus
	alias respectivamente. Hacemos la unión de las tablas a través del campo carrier_id y zona_id donde (Ca.carrier_id = Co.carrier_id)
	y (E.zona_id = Co.zona_id). Agrupamos los Carriers por su campo nombre y los mostramos como resultado de la consulta usando
	la sentencia SELECT Ca.nombre "Name", SUM(Ca.capacity * Co.costo *(E.cantidad_envios/Ca.capacity)) "Envio"
	donde mostramos el costos total de la cantidad de envió por cada (Carrier) a través de un campo calculado usando la fórmula
	capacidad de envio del carrier(Ca.capacity) multiplicado por el costo del envió del carrier(Co.costo) multiplicado por el resultado
	de la cantidad de envios de la tabla 'Envios' (E.cantidad_envios) divido entre la capacidad del carrier(Ca.capacity) 
*/
SELECT Ca.nombre "Name", SUM(Ca.capacity * Co.costo *(E.cantidad_envios/Ca.capacity)) "Envio"
FROM Carrier Ca 
JOIN Costos Co ON (Ca.carrier_id = Co.carrier_id)
JOIN Envios E ON (E.zona_id = Co.zona_id)
GROUP BY Ca.nombre;
