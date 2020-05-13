-- Creamos la base de datos test
CREATE DATABASE test;

-- Instanciamos la base de datos para que sea usada
USE test;

/* 
	Creamos 5 tablas con sus claves primarias y for�neas que ser�n utilizadas para relacionarlas entre s�. 
	Estas claves ser�n utilizadas a la hora de realizar las consultas para obtener la informaci�n de los
	registros en cuesti�n.
	
	Tambi�n creamos en cada una de ellas sus diferentes campos con sus tipos de datos correspondientes.
	La informaci�n almacenada en el conjunto de todos los campos de	la tabla (la suma de todos ellos) nos dar�
	como resultado un registro o tupla de las tablas ('Vendedores', 'Sitios', 'Categorias', 'Articulos', 'Ventas').
*/
 
 
 /*
	(vendedor_id) representa el campo (seller_id), los campos (nombre, apellidos) es informaci�n relacionada con cada vendedor.
	(vendedor_id) es el campo de clave primaria que utilizaremos para relacional la tabla 'Vendedores' con la tabla 'Ventas'.
 */
CREATE TABLE Vendedores(
    vendedor_id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

/*	
	(sitio_id) representa el campo (site_id) el mismo ser� utilizado para crear una relaci�n entre la tabla 'Sitios'
	y la tabla 'Ventas'. El campo nombre contiene el (nombre) de cada sitio web
*/
CREATE TABLE Sitios(
	sitio_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

/*
	(categoria_id) es el campo de clave primaria que ser� usado para crear una relaci�n entre la tabla 'Categorias'
	y la tabla 'Articulos'. El campo nombre contiene el (nombre) de cada categor�a.
*/
CREATE TABLE Categorias(
	categoria_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

/*
	(articulo_id) es el campo de clave primaria que ser� usado para crear una relaci�n entre la tabla 'Articulos'
	y la tabla 'Ventas'. Los campos (titulos, costo) contienen informaci�n relacionada con el art�culo en s�. Mientras
	que 'categoria_id' es un campo definido como clave for�nea que va hacer referencia al campo del mismo nombre en la tabla
	'Categorias' creando una relaci�n de varios a uno donde varios art�culos pertenecen a una categor�a y una categor�a puede
	contener varios art�culos.
*/
CREATE TABLE Articulos(
	articulo_id VARCHAR(50) PRIMARY KEY,
    titulo VARCHAR(50),
	categoria_id VARCHAR(50),
    costo INTEGER,
	FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

/*
	(venta_id) es el campo de clave primaria de la tabla 'Ventas'. Dentro de est� tabla tenemos otros campos como:
	(vendedor_id, sitio_id, articulo_id) los cuales est�n creados con los mismos nombre en las tablas 'Vendedores',
	'Sitios', 'Articulos' respectivamente y son usados como claves for�neas para crear las relaciones entre est�s tablas.
*/
CREATE TABLE Ventas(
    venta_id VARCHAR(50) PRIMARY KEY,
    vendedor_id INTEGER,
	sitio_id VARCHAR(50),
	articulo_id VARCHAR(50),
	FOREIGN KEY (vendedor_id) REFERENCES Vendedores(vendedor_id),
	FOREIGN KEY (sitio_id) REFERENCES Sitios(sitio_id),
	FOREIGN KEY (articulo_id) REFERENCES Articulos(articulo_id)
); 

-- Con INSERT INTO introducimos informaci�n en las tablas
-- Insert Vendedores
INSERT INTO Vendedores VALUES(179571324, 'Juan', 'Hernandez');
INSERT INTO Vendedores VALUES(179571325, 'Pedro', 'Gonzales');
INSERT INTO Vendedores VALUES(179571326, 'Julio', 'Rodiguez');

-- Insert Sitios
INSERT INTO Sitios VALUES('MLA', 'www.mercadolibre.com');
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

/*
	Creamos una consulta con cl�usulas JOINs donde unimos todas las tablas 'Vendedores', 'Sitios', 'Categorias',
	'Articulos', 'Ventas' por sus campos de relaci�n (claves primarias y for�neas) haciendo un filtro con la cl�usula
	WHERE donde (vd.vendedor_id = 179571326  AND st.sitio_id = 'MLA'). vt, vd, st, at, ct son nombres de alias para las
	tablas 'Ventas', 'Vendedores', 'Sitios', 'Articulos' y 'Categorias' respectivamente. Finalmente si existen coincidencias
	con el filtro realizado mostramos el resultado de la consulta a trav�s de la sentencia 
	SELECT at.articulo_id, at.titulo, ct.categoria_id, ct.nombre
	
	nota: He cambiado los nombres de los campos y recorrimos todos los �tems publicados por el seller_id = 179571326 del
	site_id = "MLA" mostrando los resultados "id" del �tem, "title" del item, "category_id" donde est� publicado y "name" de la categor�a.
*/
SELECT at.articulo_id, at.titulo, ct.categoria_id, ct.nombre
FROM Ventas vt
JOIN Vendedores vd ON(vt.vendedor_id = vd.vendedor_id)
JOIN Sitios st ON(vt.sitio_id = st.sitio_id)
JOIN Articulos at ON(vt.articulo_id = at.articulo_id)
JOIN Categorias ct ON(at.categoria_id = ct.categoria_id)
WHERE vd.vendedor_id = 179571326  AND st.sitio_id = 'MLA';
