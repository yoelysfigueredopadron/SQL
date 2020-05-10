CREATE DATABASE NewDB;

USE NewDB;

CREATE TABLE Carrier(
    carrier_id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    capacity INTEGER
);

CREATE TABLE Zonas(
	zona_id INTEGER PRIMARY KEY,
	zona VARCHAR(50)
);

CREATE TABLE Costos(
	costo_id INTEGER PRIMARY KEY,
    carrier_id INTEGER NOT NULL,
    zona_id INTEGER NOT NULL,
    costo INTEGER,
	tiempo_entrega INTEGER,
	FOREIGN KEY (carrier_id) REFERENCES Carrier(carrier_id),
	FOREIGN KEY (zona_id) REFERENCES Zonas(zona_id)
);

CREATE TABLE Envios(
	envio_id INTEGER PRIMARY KEY,
	zona_id INTEGER NOT NULL,
	mes INTEGER,
	cantidad_envios INTEGER,
	FOREIGN KEY (zona_id) REFERENCES Zonas(zona_id)
);
 
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

SELECT Ca.nombre "Name", SUM(Ca.capacity * Co.costo *(E.cantidad_envios/Ca.capacity)) "Envio"
FROM Carrier Ca 
JOIN Costos Co ON (Ca.carrier_id = Co.carrier_id)
JOIN Envios E ON (E.zona_id = Co.zona_id)
GROUP BY Ca.nombre;
