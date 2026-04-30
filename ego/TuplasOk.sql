 
-- =====================================================
-- EGO - DATOS VÁLIDOS PARA TUPLAS (TuplasOk)
-- Oracle SQL Developer
-- =====================================================


-- USUARIOS: Registro posterior al nacimiento y con más de 13 años de edad
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_006', 'sofia@example.com', DATE '2020-06-15', DATE '2000-01-10');
-- Registro: 2020 | Nacimiento: 2000 | Edad al registrarse: 20 años
 
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_007', 'miguel@example.com', DATE '2018-03-22', DATE '1995-07-14');
-- Registro: 2018 | Nacimiento: 1995 | Edad al registrarse: 22 años
 
-- PELICULA: Con recaudación mayor a cero, el presupuesto también lo es
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_011', 'Dune', 2021, 155, 'USA', 'Ciencia Ficción', 'Un joven noble lidera una rebelión en un planeta desértico.', 'PG-13', 'epico');
 
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
('cont_011', 165000000, 401000000);
-- Presupuesto: 165M | Recaudación: 401M
 
-- PELICULA: Recaudación cero con presupuesto en cero también es válido
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_012', 'Cortometraje Indie', 2023, 15, 'Colombia', 'Drama', 'Una historia breve sobre la soledad urbana.', 'NR', 'indie');
 
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
('cont_012', 0, 0);
-- Sin presupuesto ni recaudación registrada
 
 
-- SERIE: Episodios mayores que temporadas
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_013', 'The Last of Us', 2023, 60, 'USA', 'Drama', 'Un contrabandista escolta a una joven inmune en un mundo postapocalíptico.', 'TV-MA', 'supervivencia');
 
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
('cont_013', 2, 17, 'Craig Mazin, Neil Druckmann');
-- 2 temporadas, 17 episodios: episodios >= temporadas ✓
 
COMMIT;
 
 