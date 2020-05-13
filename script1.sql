-- Creamos la base de datos test
CREATE DATABASE test;

-- Instanciamos la base de datos para que sea usada
USE test;

/* 
	Creamos 5 tablas con sus claves primarias y foráneas que serán utilizadas para relacionarlas entre sí. 
	Estas claves serán utilizadas a la hora de realizar las consultas para obtener la información de los
	registros en cuestión.
	
	También creamos en cada una de ellas sus diferentes campos con sus tipos de datos correspondientes.
	La información almacenada en el conjunto de todos los campos de	la tabla (la suma de todos ellos) nos dará
	como resultado un registro o tupla de las tablas ('Vendedores', 'Sitios', 'Categorias', 'Articulos', 'Ventas').
*/
 
 
 /*
	(vendedor_id) representa el campo (seller_id), los campos (nombre, apellidos) es información relacionada con cada vendedor.
	(vendedor_id) es el campo de clave primaria que utilizaremos para relacional la tabla 'Vendedores' con la tabla 'Ventas'.
 */
CREATE TABLE Vendedores(
    vendedor_id INTEGER PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50)
);

/*	
	(sitio_id) representa el campo (site_id) el mismo será utilizado para crear una relación entre la tabla 'Sitios'
	y la tabla 'Ventas'. El campo nombre contiene el (nombre) de cada sitio web
*/
CREATE TABLE Sitios(
	sitio_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

/*
	(categoria_id) es el campo de clave primaria que será usado para crear una relación entre la tabla 'Categorias'
	y la tabla 'Articulos'. El campo nombre contiene el (nombre) de cada categoría.
*/
CREATE TABLE Categorias(
	categoria_id VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50)
);

/*
	(articulo_id) es el campo de clave primaria que será usado para crear una relación entre la tabla 'Articulos'
	y la tabla 'Ventas'. Los campos (titulos, costo) contienen información relacionada con el artículo en sí. Mientras
	que 'categoria_id' es un campo definido como clave foránea que va hacer referencia al campo del mismo nombre en la tabla
	'Categorias' creando una relación de varios a uno donde varios artículos pertenecen a una categoría y una categoría puede
	contener varios artículos.
*/
CREATE TABLE Articulos(
	articulo_id VARCHAR(50) PRIMARY KEY,
    titulo VARCHAR(50),
	categoria_id VARCHAR(50),
    costo INTEGER,
	FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

/*
	(venta_id) es el campo de clave primaria de la tabla 'Ventas'. Dentro de está tabla tenemos otros campos como:
	(vendedor_id, sitio_id, articulo_id) los cuales están creados con los mismos nombre en las tablas 'Vendedores',
	'Sitios', 'Articulos' respectivamente y son usados como claves foráneas para crear las relaciones entre estás tablas.
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

-- Con INSERT INTO introducimos información en las tablas
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
	Creamos una consulta con cláusulas JOINs donde unimos todas las tablas 'Vendedores', 'Sitios', 'Categorias',
	'Articulos', 'Ventas' por sus campos de relación (claves primarias y foráneas) haciendo un filtro con la cláusula
	WHERE donde (vd.vendedor_id = 179571326  AND st.sitio_id = 'MLA'). vt, vd, st, at, ct son nombres de alias para las
	tablas 'Ventas', 'Vendedores', 'Sitios', 'Articulos' y 'Categorias' respectivamente. Finalmente si existen coincidencias
	con el filtro realizado mostramos el resultado de la consulta a través de la sentencia 
	SELECT at.articulo_id, at.titulo, ct.categoria_id, ct.nombre
	
	nota: He cambiado los nombres de los campos y recorrimos todos los ítems publicados por el seller_id = 179571326 del
	site_id = "MLA" mostrando los resultados "id" del ítem, "title" del item, "category_id" donde está publicado y "name" de la categoría.
*/
SELECT at.articulo_id, at.titulo, ct.categoria_id, ct.nombre
FROM Ventas vt
JOIN Vendedores vd ON(vt.vendedor_id = vd.vendedor_id)
JOIN Sitios st ON(vt.sitio_id = st.sitio_id)
JOIN Articulos at ON(vt.articulo_id = at.articulo_id)
JOIN Categorias ct ON(at.categoria_id = ct.categoria_id)
WHERE vd.vendedor_id = 179571326  AND st.sitio_id = 'MLA';
