CREATE DATABASE test;

USE test;

CREATE TABLE Vendedores(
    vendedor_id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

CREATE TABLE Sitios(
	sitio_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

CREATE TABLE Categorias(
	categoria_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

CREATE TABLE Articulos(
	articulo_id VARCHAR(50) PRIMARY KEY,
    titulo VARCHAR(50),
	categoria_id VARCHAR(50),
    costo INTEGER,
	FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

CREATE TABLE Ventas(
    venta_id VARCHAR(50) PRIMARY KEY,
    vendedor_id INTEGER,
	sitio_id VARCHAR(50),
	articulo_id VARCHAR(50),
	FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id),
	FOREIGN KEY (sitio_id) REFERENCES Sitios(sitio_id),
	FOREIGN KEY (articulo_id) REFERENCES Articulos(articulo_id)
); 

-- Insert Vendedores
INSERT INTO Vendedores VALUES(179571324, 'Juan', 'Hernandez');
INSERT INTO Vendedores VALUES(179571325, 'Pedro', 'Gonzales');
INSERT INTO Vendedores VALUES(179571326, 'Julio', 'Rodiguez');

-- Insert Sitios
INSERT INTO Sitios VALUES('MLA', 'www.melian.com');
INSERT INTO Sitios VALUES('POD', 'www.podemos.com');
INSERT INTO Sitios VALUES('JOY', 'www.joyas.com');


-- Insert Categorias
INSERT INTO Categorias VALUES('CAT1', 'Accesorios');
INSERT INTO Categorias VALUES('CAT2', 'Calzados');
INSERT INTO Categorias VALUES('CAT3', 'Joyas');

-- Insert Articulos
INSERT INTO Articulos VALUES('ART1', 'Billeteras', 'CAT1', 20);
INSERT INTO Articulos VALUES('ART2', 'Carteras', 'CAT1', 35);
INSERT INTO Articulos VALUES('ART3', 'Cinturones', 'CAT1', 10);
INSERT INTO Articulos VALUES('ART4', 'Mocacines', 'CAT2', 45 );
INSERT INTO Articulos VALUES('ART5', 'Zapatillas', 'CAT2', 50 );
INSERT INTO Articulos VALUES('ART6', 'Mocacines', 'CAT2', 30 );
INSERT INTO Articulos VALUES('ART7', 'Anillos', 'CAT3', 80);
INSERT INTO Articulos VALUES('ART8', 'Aros', 'CAT3', 90);
INSERT INTO Articulos VALUES('ART9', 'Collares', 'CAT3', 100);

-- Insert Ventas
INSERT INTO Ventas VALUES('VTS1', 179571324, 'MLA', 'ART1');
INSERT INTO Ventas VALUES('VTS2', 179571324, 'MLA', 'ART2');
INSERT INTO Ventas VALUES('VTS3', 179571325, 'POD', 'ART3');
INSERT INTO Ventas VALUES('VTS4', 179571325, 'POD', 'ART4');
INSERT INTO Ventas VALUES('VTS5', 179571325, 'JOY', 'ART5');
INSERT INTO Ventas VALUES('VTS6', 179571326, 'MLA', 'ART8');
INSERT INTO Ventas VALUES('VTS7', 179571326, 'MLA', 'ART9');

/*	Recorrer todos los ítems publicados mostrando los resultados "id" del ítem, 
  "title" del item, "category_id" donde está publicado y "name" de la categoría.*/
SELECT at.articulo_id, at.titulo, ct.categoria_id, ct.nombre
FROM Ventas vt
JOIN Vendedores vd ON(vt.vendedor_id = vd.vendedor_id)
JOIN Sitios st ON(vt.sitio_id = st.sitio_id)
JOIN Articulos at ON(vt.articulo_id = at.articulo_id)
JOIN Categorias ct ON(at.categoria_id = ct.categoria_id)
WHERE vd.vendedor_id = 179571326  AND st.sitio_id = 'MLA';
