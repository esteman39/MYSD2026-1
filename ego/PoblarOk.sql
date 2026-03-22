-- =====================================================
-- EGO - Inserción de Datos Correctos (PoblarOK)
-- Oracle SQL Developer
-- =====================================================

-- =====================================================
-- 1. INSERTAR USUARIOS
-- =====================================================
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_001', 'esteban@example.com', SYSDATE - 100, DATE '1998-05-15'),
('user_002', 'daniel@example.com', SYSDATE - 90, DATE '1999-08-22'),
('user_003', 'ana@example.com', SYSDATE - 80, DATE '2000-03-10'),
('user_004', 'carlos@example.com', SYSDATE - 70, DATE '1997-11-30'),
('user_005', 'laura@example.com', SYSDATE - 60, DATE '2001-07-18');

-- =====================================================
-- 2. INSERTAR CONTENIDO (PELÍCULAS)
-- =====================================================
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_001', 'Interestelar', 2014, 169, 'USA', 'Ciencia Ficción', 'Un grupo de astronautas viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.', 'PG-13', 'espacial'),
('cont_002', 'Inception', 2010, 148, 'USA', 'Ciencia Ficción', 'Un ladrón que roba secretos corporativos mediante la tecnología de compartir sueños recibe una oportunidad de redención.', 'PG-13', 'sueños'),
('cont_003', 'El Padrino', 1972, 175, 'USA', 'Drama', 'La historia de la familia Corleone, una poderosa organización criminal italiana.', 'R', 'mafia'),
('cont_004', 'Parasite', 2019, 132, 'Corea del Sur', 'Drama', 'Una familia pobre se infiltra en la vida de una familia rica mediante engaños.', 'R', 'clases_sociales'),
('cont_005', 'Mad Max: Fury Road', 2015, 120, 'Australia', 'Acción', 'En un mundo postapocalíptico, un hombre se une a una mujer rebelde para escapar de un tirano.', 'R', 'postapocalipsis');

-- =====================================================
-- 3. INSERTAR CONTENIDO (SERIES)
-- =====================================================
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_006', 'Breaking Bad', 2008, 49, 'USA', 'Drama', 'Un profesor de química se convierte en fabricante de metanfetamina para asegurar el futuro financiero de su familia.', 'TV-MA', 'crimen'),
('cont_007', 'Game of Thrones', 2011, 60, 'USA', 'Fantasía', 'Nueve familias nobles luchan por el control del continente de Westeros.', 'TV-MA', 'medieval'),
('cont_008', 'The Office', 2005, 22, 'USA', 'Comedia', 'Una serie de comedia sobre la vida cotidiana en una oficina de papel.', 'TV-14', 'oficina'),
('cont_009', 'Stranger Things', 2016, 50, 'USA', 'Ciencia Ficción', 'En los 80, un niño desaparece misteriosamente y sus amigos buscan respuestas.', 'TV-14', 'nostalgia'),
('cont_010', 'Friends', 1994, 22, 'USA', 'Comedia', 'Seis amigos neoyorquinos navegan por la vida y el amor en la ciudad.', 'TV-14', 'amistad');

-- =====================================================
-- 4. INSERTAR ETIQUETAS
-- =====================================================
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_001', 'etiq_001', 'nostalgia', 'emocion'),
('user_001', 'etiq_002', 'inspiracion', 'emocion'),
('user_002', 'etiq_003', 'accion', 'genero'),
('user_003', 'etiq_004', 'drama', 'genero'),
('user_004', 'etiq_005', 'comedia', 'genero');

-- =====================================================
-- 5. INSERTAR LISTAS
-- =====================================================
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES
('lista_001', 'user_001', 'N'),
('lista_002', 'user_001', 'N'),
('lista_003', 'user_002', 'N'),
('lista_004', 'user_003', 'S'),
('lista_005', 'user_004', 'N');

-- =====================================================
-- 6. INSERTAR LISTA_CONTENIDO
-- =====================================================
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_001', 'user_001', 'Películas pendientes', 'Películas que quiero ver pronto', 1, SYSDATE - 30, 'cont_001'),
('lista_001', 'user_001', 'Películas pendientes', 'Películas que quiero ver pronto', 2, SYSDATE - 25, 'cont_004'),
('lista_002', 'user_001', 'Favoritas de ciencia ficción', 'Mis películas de ciencia ficción preferidas', 1, SYSDATE - 20, 'cont_002'),
('lista_003', 'user_002', 'Para ver en vacaciones', 'Películas para disfrutar en días libres', 1, SYSDATE - 15, 'cont_005'),
('lista_004', 'user_003', 'Clásicos del cine', 'Películas que todo cinéfilo debe ver', 1, SYSDATE - 10, 'cont_003');

-- =====================================================
-- 7. INSERTAR LISTA_PENDIENTE
-- =====================================================
INSERT INTO LISTA_PENDIENTE (Id_lista, Id_usuario, estado, fecha_agregado) VALUES
('lista_001', 'user_001', 'pendiente', SYSDATE - 30),
('lista_003', 'user_002', 'pendiente', SYSDATE - 15);

-- =====================================================
-- 8. INSERTAR CALIFICACIONES
-- =====================================================
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_001', 'user_001', 'cont_002', 5, SYSDATE - 20),
('calif_002', 'user_003', 'cont_003', 5, SYSDATE - 10),
('calif_003', 'user_004', 'cont_006', 4, SYSDATE - 5),
('calif_004', 'user_005', 'cont_004', 5, SYSDATE - 3),
('calif_005', 'user_002', 'cont_009', 4, SYSDATE - 2);

-- =====================================================
-- 9. INSERTAR RESEÑAS
-- =====================================================
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
('res_001', 'user_001', 'cont_002', 'Vi esta película el día que decidí estudiar arquitectura. La forma en que Nolan juega con los espacios me inspiró.', SYSDATE - 20),
('res_002', 'user_003', 'cont_003', 'La primera vez que vi esta película fue con mi abuelo. Él me explicó cada escena y me contó sobre el cine italiano.', SYSDATE - 10),
('res_003', 'user_005', 'cont_004', 'Esta película me abrió los ojos sobre las desigualdades sociales. La mezcla de géneros es magistral.', SYSDATE - 3);

-- =====================================================
-- 10. INSERTAR PERSONAL
-- =====================================================
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_001', 'Christopher Nolan', 'director', 'cont_001,cont_002', 'Director británico conocido por películas de ciencia ficción', 'Británico'),
('pers_002', 'Francis Ford Coppola', 'director', 'cont_003', 'Director estadounidense, figura clave del Nuevo Hollywood', 'Estadounidense'),
('pers_003', 'Bong Joon-ho', 'director', 'cont_004', 'Director surcoreano ganador del Oscar', 'Surcoreano'),
('pers_004', 'Leonardo DiCaprio', 'actor', 'cont_002', 'Actor estadounidense, protagonista de múltiples éxitos', 'Estadounidense'),
('pers_005', 'Vince Gilligan', 'director', 'cont_006', 'Creador y productor ejecutivo de Breaking Bad', 'Estadounidense');

-- =====================================================
-- 11. INSERTAR ROL
-- =====================================================
INSERT INTO ROL (Id_rol, nombre_rol) VALUES
('rol_001', 'actor'),
('rol_002', 'director'),
('rol_003', 'guionista'),
('rol_004', 'productor'),
('rol_005', 'sonidista');

-- =====================================================
-- 12. INSERTAR PERSONAL_ROL
-- =====================================================
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES
('pers_001', 'rol_002'),
('pers_002', 'rol_002'),
('pers_003', 'rol_002'),
('pers_004', 'rol_001'),
('pers_005', 'rol_002');

-- =====================================================
-- 13. INSERTAR PERSONAL_CONTENIDO
-- =====================================================
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES
('pers_001', 'cont_001'),
('pers_001', 'cont_002'),
('pers_002', 'cont_003'),
('pers_003', 'cont_004'),
('pers_004', 'cont_002'),
('pers_005', 'cont_006');

-- =====================================================
-- 14. INSERTAR SERIE
-- =====================================================
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
('cont_006', 5, 62, 'Vince Gilligan'),
('cont_007', 8, 73, 'David Benioff, D.B. Weiss'),
('cont_008', 9, 201, 'Greg Daniels'),
('cont_009', 4, 34, 'Los hermanos Duffer'),
('cont_010', 10, 236, 'David Crane, Marta Kauffman');

-- =====================================================
-- 15. INSERTAR PELICULA
-- =====================================================
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
('cont_001', 165000000, 701000000),
('cont_002', 160000000, 836000000),
('cont_003', 6000000, 246000000),
('cont_004', 11000000, 258000000),
('cont_005', 150000000, 375000000);

COMMIT;