-- =====================================================
-- EGO - Script SQL Completo
-- Oracle SQL Developer
-- =====================================================
-- Orden de ejecución:
--   1. xTablas    → Eliminar tablas existentes (limpieza)
--   2. Tablas     → Crear tablas
--   3. Primarias  → Claves primarias
--   4. Unicos     → Restricciones únicas
--   5. Foraneas   → Claves foráneas
--   6. Atributos  → Restricciones CHECK / DEFAULT
--   7. PoblarOk   → Insertar datos válidos
--   8. PoblarNoOK → Pruebas de inserción inválida (comentadas)
--   9. Consultas  → Consultas de casos de uso
--  10. XPoblar    → Eliminación de datos
-- =====================================================
 
 
-- =====================================================
-- SECCIÓN 1: ELIMINAR TABLAS EXISTENTES (xTablas)
-- =====================================================
 
DROP TABLE RESEÑAS CASCADE CONSTRAINTS;
DROP TABLE Calificaciones CASCADE CONSTRAINTS;
DROP TABLE LISTA_CONTENIDO CASCADE CONSTRAINTS;
DROP TABLE LISTA_PENDIENTE CASCADE CONSTRAINTS;
DROP TABLE LISTA CASCADE CONSTRAINTS;
DROP TABLE ETIQUETAS CASCADE CONSTRAINTS;
DROP TABLE PERSONAL_CONTENIDO CASCADE CONSTRAINTS;
DROP TABLE PERSONAL_ROL CASCADE CONSTRAINTS;
DROP TABLE PERSONAL CASCADE CONSTRAINTS;
DROP TABLE SERIE CASCADE CONSTRAINTS;
DROP TABLE PELICULA CASCADE CONSTRAINTS;
DROP TABLE CONTENIDO CASCADE CONSTRAINTS;
DROP TABLE ROL CASCADE CONSTRAINTS;
DROP TABLE USUARIOS CASCADE CONSTRAINTS;
 
 
-- =====================================================
-- SECCIÓN 2: CREACIÓN DE TABLAS (Tablas)
-- =====================================================
 
-- -----------------------------------------------------
-- TABLA: USUARIOS
-- -----------------------------------------------------
CREATE TABLE USUARIOS (
    Id_usuario VARCHAR2(20),
    Email VARCHAR2(255) NOT NULL,
    Fecha_registro DATE NOT NULL,
    fecha_nacimiento DATE NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: CONTENIDO
-- -----------------------------------------------------
CREATE TABLE CONTENIDO(
    Id_content VARCHAR2(255),
    nombre VARCHAR2(255) NOT NULL,
    Año_estreno INTEGER NOT NULL,
    duracion INTEGER NOT NULL,
    pais VARCHAR2(100) NOT NULL,
    genero VARCHAR2(100) NOT NULL,
    sinopsis VARCHAR2(300) NOT NULL,
    Clasificacion VARCHAR2(100) NOT NULL,
    nombre_etiqueta VARCHAR2(20) NOT NULL
);
 
 
 
-- -----------------------------------------------------
-- TABLA: ETIQUETAS
-- -----------------------------------------------------
CREATE TABLE ETIQUETAS(
    id_usuario VARCHAR2(20) NOT NULL,
    id_etiqueta VARCHAR2(50) NOT NULL,
    nombre_etiqueta VARCHAR2(20) NOT NULL,
    categoria VARCHAR2(20) NOT NULL
);
 
 
-- -----------------------------------------------------
-- TABLA: LISTA
-- -----------------------------------------------------
CREATE TABLE LISTA(
    Id_lista VARCHAR2(255) NOT NULL,
    Id_usuario VARCHAR2(20) NOT NULL,
    esPrivada CHAR(1) NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO
-- -----------------------------------------------------
CREATE TABLE LISTA_CONTENIDO(
    Id_lista VARCHAR2(255) NOT NULL,
    id_usuario VARCHAR2(20) NOT NULL,
    nombre_lista VARCHAR2(255) NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    orden INTEGER NOT NULL,
    fecha_agregado DATE NOT NULL,
    Id_content VARCHAR2(255) NOT NULL
);
-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE
-- -----------------------------------------------------
CREATE TABLE LISTA_PENDIENTE(
    Id_lista VARCHAR2(255) NOT NULL,
    Id_usuario VARCHAR2(20) NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    fecha_agregado DATE NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: Calificaciones
-- -----------------------------------------------------
CREATE TABLE Calificaciones(
    Id_calificacion VARCHAR2(255) NOT NULL,
    Id_usuario VARCHAR2(20) NOT NULL,
    Id_content VARCHAR2(255) NOT NULL,
    estrellas NUMBER(5) NOT NULL,
    fecha_calificacion DATE NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: RESEÑAS
-- -----------------------------------------------------
CREATE TABLE RESEÑAS(
    id_reseña VARCHAR2(255) NOT NULL,
    Id_usuario VARCHAR2(20) NOT NULL,
    Id_content VARCHAR2(255) NOT NULL,
    comentario VARCHAR2(250) NOT NULL,
    fecha_reseña DATE NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: PERSONAL
-- -----------------------------------------------------
CREATE TABLE PERSONAL (
    Id_personal VARCHAR2(255) NOT NULL,
    nombre VARCHAR2(255) NOT NULL,
    rol VARCHAR2(50) NOT NULL,
    contenidos VARCHAR2(255) NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    nacionalidad VARCHAR2(100) NOT NULL
);
 
 
-- -----------------------------------------------------
-- TABLA: ROL
-- -----------------------------------------------------
CREATE TABLE ROL (
    Id_rol VARCHAR2(50),
    nombre_rol VARCHAR2(50) NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: PERSONAL_ROL
-- -----------------------------------------------------
CREATE TABLE PERSONAL_ROL (
    Id_personal VARCHAR2(255) NOT NULL,
    Id_rol VARCHAR2(50) NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: PERSONAL_CONTENIDO
-- -----------------------------------------------------
CREATE TABLE PERSONAL_CONTENIDO (
    Id_personal VARCHAR2(255) NOT NULL,
    Id_content VARCHAR2(255) NOT NULL
);
 
-- -----------------------------------------------------
-- TABLA: SERIE
-- -----------------------------------------------------
CREATE TABLE SERIE(
    Id_content VARCHAR2(255) NOT NULL,
    temporadas INTEGER NOT NULL,
    episodios INTEGER NOT NULL,
    show_runner VARCHAR2(255) NOT NULL
);
-- -----------------------------------------------------
-- TABLA: PELICULA
-- -----------------------------------------------------
CREATE TABLE PELICULA(
    Id_content VARCHAR2(255) NOT NULL,
    presupuesto DECIMAL(15, 2) NOT NULL,
    recaudacion DECIMAL(15, 2) NOT NULL
);
 
-- Verificar que todas las tablas se crearon
SELECT table_name
FROM user_tables
WHERE table_name IN (
    'USUARIOS','CONTENIDO','ETIQUETAS','LISTA','LISTA_CONTENIDO',
    'LISTA_PENDIENTE','CALIFICACIONES','RESEÑAS','PERSONAL','ROL',
    'PERSONAL_ROL','PERSONAL_CONTENIDO','SERIE','PELICULA'
)
ORDER BY table_name;
 
 
-- =====================================================
-- SECCIÓN 3: CLAVES PRIMARIAS (Primarias)
-- =====================================================
 
ALTER TABLE USUARIOS ADD PRIMARY KEY (Id_usuario);
ALTER TABLE CONTENIDO ADD PRIMARY KEY (Id_content);
ALTER TABLE ETIQUETAS ADD PRIMARY KEY (id_etiqueta);
ALTER TABLE LISTA ADD PRIMARY KEY (Id_lista);
ALTER TABLE LISTA_CONTENIDO ADD PRIMARY KEY (Id_lista, id_usuario, Id_content);
ALTER TABLE LISTA_PENDIENTE ADD PRIMARY KEY (Id_lista, Id_usuario);
ALTER TABLE Calificaciones ADD PRIMARY KEY (Id_calificacion);
ALTER TABLE RESEÑAS ADD PRIMARY KEY (id_reseña);
ALTER TABLE PERSONAL ADD PRIMARY KEY (Id_personal);
ALTER TABLE ROL ADD PRIMARY KEY (Id_rol);
ALTER TABLE PERSONAL_ROL ADD PRIMARY KEY (Id_personal, Id_rol);
ALTER TABLE PERSONAL_CONTENIDO ADD PRIMARY KEY (Id_personal, Id_content);
ALTER TABLE SERIE ADD PRIMARY KEY (Id_content);
ALTER TABLE PELICULA ADD PRIMARY KEY (Id_content);
 
 
-- =====================================================
-- SECCIÓN 4: RESTRICCIONES ÚNICAS (Unicos)
-- =====================================================
 
ALTER TABLE USUARIOS ADD UNIQUE (Email);
ALTER TABLE ETIQUETAS ADD UNIQUE (nombre_etiqueta, id_usuario);
ALTER TABLE ROL ADD UNIQUE (nombre_rol);
 
 
-- =====================================================
-- SECCIÓN 5: CLAVES FORÁNEAS (Foraneas)
-- =====================================================
 
-- ETIQUETAS → USUARIOS
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT fk_etiquetas_usuario
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- LISTA → USUARIOS
ALTER TABLE LISTA
    ADD CONSTRAINT fk_lista_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- LISTA_CONTENIDO → LISTA
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT fk_lista_contenido_lista
    FOREIGN KEY (Id_lista) REFERENCES LISTA(Id_lista) ON DELETE CASCADE;
 
-- LISTA_CONTENIDO → USUARIOS
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT fk_lista_contenido_usuario
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- LISTA_CONTENIDO → CONTENIDO
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT fk_lista_contenido_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
-- LISTA_PENDIENTE → LISTA
ALTER TABLE LISTA_PENDIENTE
    ADD CONSTRAINT fk_lista_pendiente_lista
    FOREIGN KEY (Id_lista) REFERENCES LISTA(Id_lista) ON DELETE CASCADE;
 
-- LISTA_PENDIENTE → USUARIOS
ALTER TABLE LISTA_PENDIENTE
    ADD CONSTRAINT fk_lista_pendiente_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- Calificaciones → USUARIOS
ALTER TABLE Calificaciones
    ADD CONSTRAINT fk_calificaciones_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- Calificaciones → CONTENIDO
ALTER TABLE Calificaciones
    ADD CONSTRAINT fk_calificaciones_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
-- RESEÑAS → USUARIOS
ALTER TABLE RESEÑAS
    ADD CONSTRAINT fk_resenas_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;
 
-- RESEÑAS → CONTENIDO
ALTER TABLE RESEÑAS
    ADD CONSTRAINT fk_resenas_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
-- PERSONAL_ROL → PERSONAL
ALTER TABLE PERSONAL_ROL
    ADD CONSTRAINT fk_personal_rol_personal
    FOREIGN KEY (Id_personal) REFERENCES PERSONAL(Id_personal) ON DELETE CASCADE;
 
-- PERSONAL_ROL → ROL
ALTER TABLE PERSONAL_ROL
    ADD CONSTRAINT fk_personal_rol_rol
    FOREIGN KEY (Id_rol) REFERENCES ROL(Id_rol) ON DELETE CASCADE;
 
-- PERSONAL_CONTENIDO → PERSONAL
ALTER TABLE PERSONAL_CONTENIDO
    ADD CONSTRAINT fk_personal_contenido_personal
    FOREIGN KEY (Id_personal) REFERENCES PERSONAL(Id_personal) ON DELETE CASCADE;
 
-- PERSONAL_CONTENIDO → CONTENIDO
ALTER TABLE PERSONAL_CONTENIDO
    ADD CONSTRAINT fk_personal_contenido_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
-- SERIE → CONTENIDO
ALTER TABLE SERIE
    ADD CONSTRAINT fk_serie_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
-- PELICULA → CONTENIDO
ALTER TABLE PELICULA
    ADD CONSTRAINT fk_pelicula_contenido
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;
 
 
-- =====================================================
-- SECCIÓN 6: RESTRICCIONES DE ATRIBUTOS (Atributos)
-- =====================================================
 
-- USUARIOS
ALTER TABLE USUARIOS
    ADD CONSTRAINT chk_email_format CHECK (Email LIKE '%@%.%');
 
-- CONTENIDO
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_duracion CHECK (duracion > 0);
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_clasificacion CHECK (Clasificacion IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR', 'TV-MA', 'TV-14'));
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_genero_no_vacio CHECK (LENGTH(TRIM(genero)) > 0);
 
-- ETIQUETAS
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT chk_categoria CHECK (categoria IN ('emocion', 'genero', 'momento', 'recomendacion'));
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT chk_nombre_etiqueta_no_vacio CHECK (LENGTH(TRIM(nombre_etiqueta)) > 0);
 
-- LISTA
ALTER TABLE LISTA
    ADD CONSTRAINT chk_esPrivada CHECK (esPrivada IN ('S', 'N'));
ALTER TABLE LISTA
    ADD CONSTRAINT chk_Id_lista_no_vacio CHECK (LENGTH(TRIM(Id_lista)) > 0);
 
-- LISTA_CONTENIDO
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT chk_orden CHECK (orden > 0);
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT chk_nombre_lista_no_vacio CHECK (LENGTH(TRIM(nombre_lista)) > 0);
 
-- LISTA_PENDIENTE
ALTER TABLE LISTA_PENDIENTE
    ADD CONSTRAINT chk_estado CHECK (estado IN ('pendiente', 'visto', 'en_progreso'));
 
-- Calificaciones
ALTER TABLE Calificaciones
    ADD CONSTRAINT chk_estrellas CHECK (estrellas BETWEEN 1 AND 5);
 
-- RESEÑAS
ALTER TABLE RESEÑAS
    ADD CONSTRAINT chk_comentario_no_vacio CHECK (LENGTH(TRIM(comentario)) > 0);
 
-- PERSONAL
ALTER TABLE PERSONAL
    ADD CONSTRAINT chk_rol CHECK (rol IN ('actor', 'director', 'guionista', 'productor', 'sonidista'));
ALTER TABLE PERSONAL
    ADD CONSTRAINT chk_nombre_personal_no_vacio CHECK (LENGTH(TRIM(nombre)) > 0);
 
-- ROL
ALTER TABLE ROL
    ADD CONSTRAINT chk_nombre_rol_no_vacio CHECK (LENGTH(TRIM(nombre_rol)) > 0);
 
-- SERIE
ALTER TABLE SERIE
    ADD CONSTRAINT chk_temporadas CHECK (temporadas > 0);
ALTER TABLE SERIE
    ADD CONSTRAINT chk_episodios CHECK (episodios > 0);
ALTER TABLE SERIE
    ADD CONSTRAINT chk_show_runner_no_vacio CHECK (LENGTH(TRIM(show_runner)) > 0);
 
-- PELICULA
ALTER TABLE PELICULA
    ADD CONSTRAINT chk_presupuesto CHECK (presupuesto >= 0);
ALTER TABLE PELICULA
    ADD CONSTRAINT chk_recaudacion CHECK (recaudacion >= 0);
 
 
-- =====================================================
-- SECCIÓN 7: INSERCIÓN DE DATOS VÁLIDOS (PoblarOk)
-- =====================================================
 
-- 1. USUARIOS
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_001', 'esteban@example.com', SYSDATE - 100, DATE '1998-05-15');
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_002', 'daniel@example.com', SYSDATE - 90, DATE '1999-08-22');
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_003', 'ana@example.com', SYSDATE - 80, DATE '2000-03-10');
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_004', 'carlos@example.com', SYSDATE - 70, DATE '1997-11-30');
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_005', 'laura@example.com', SYSDATE - 60, DATE '2001-07-18');
 
 
-- 2. CONTENIDO (Películas)
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_001', 'Interestelar', 2014, 169, 'USA', 'Ciencia Ficción', 'Un grupo de astronautas viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.', 'PG-13', 'espacial');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_002', 'Inception', 2010, 148, 'USA', 'Ciencia Ficción', 'Un ladrón que roba secretos corporativos mediante la tecnología de compartir sueños recibe una oportunidad de redención.', 'PG-13', 'sueños');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_003', 'El Padrino', 1972, 175, 'USA', 'Drama', 'La historia de la familia Corleone, una poderosa organización criminal italiana.', 'R', 'mafia');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_004', 'Parasite', 2019, 132, 'Corea del Sur', 'Drama', 'Una familia pobre se infiltra en la vida de una familia rica mediante engaños.', 'R', 'clases_sociales');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_005', 'Mad Max: Fury Road', 2015, 120, 'Australia', 'Acción', 'En un mundo postapocalíptico, un hombre se une a una mujer rebelde para escapar de un tirano.', 'R', 'postapocalipsis');
 
 
-- 3. CONTENIDO (Series)
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_006', 'Breaking Bad', 2008, 49, 'USA', 'Drama', 'Un profesor de química se convierte en fabricante de metanfetamina para asegurar el futuro financiero de su familia.', 'TV-MA', 'crimen');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_007', 'Game of Thrones', 2011, 60, 'USA', 'Fantasía', 'Nueve familias nobles luchan por el control del continente de Westeros.', 'TV-MA', 'medieval');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_008', 'The Office', 2005, 22, 'USA', 'Comedia', 'Una serie de comedia sobre la vida cotidiana en una oficina de papel.', 'TV-14', 'oficina');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_009', 'Stranger Things', 2016, 50, 'USA', 'Ciencia Ficción', 'En los 80, un niño desaparece misteriosamente y sus amigos buscan respuestas.', 'TV-14', 'nostalgia');
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_010', 'Friends', 1994, 22, 'USA', 'Comedia', 'Seis amigos neoyorquinos navegan por la vida y el amor en la ciudad.', 'TV-14', 'amistad');
 
-- 4. ETIQUETAS
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_001', 'etiq_001', 'nostalgia', 'emocion');
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_001', 'etiq_002', 'inspiracion', 'emocion');
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_002', 'etiq_003', 'accion', 'genero');
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_003', 'etiq_004', 'drama', 'genero');
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_004', 'etiq_005', 'comedia', 'genero');
 
-- 5. LISTAS
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES ('lista_001', 'user_001', 'N');
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES ('lista_002', 'user_001', 'N');
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES ('lista_003', 'user_002', 'N');
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES ('lista_004', 'user_003', 'S');
INSERT INTO LISTA (Id_lista, Id_usuario, esPrivada) VALUES ('lista_005', 'user_004', 'N');
 
-- 6. LISTA_CONTENIDO
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_001', 'user_001', 'Películas pendientes', 'Películas que quiero ver pronto', 1, SYSDATE - 30, 'cont_001');
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_001', 'user_001', 'Películas pendientes', 'Películas que quiero ver pronto', 2, SYSDATE - 25, 'cont_004');
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_002', 'user_001', 'Favoritas de ciencia ficción', 'Mis películas de ciencia ficción preferidas', 1, SYSDATE - 20, 'cont_002');
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_003', 'user_002', 'Para ver en vacaciones', 'Películas para disfrutar en días libres', 1, SYSDATE - 15, 'cont_005');
INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
('lista_004', 'user_003', 'Clásicos del cine', 'Películas que todo cinéfilo debe ver', 1, SYSDATE - 10, 'cont_003');
 
-- 7. LISTA_PENDIENTE
INSERT INTO LISTA_PENDIENTE (Id_lista, Id_usuario, estado, fecha_agregado) VALUES
('lista_001', 'user_001', 'pendiente', SYSDATE - 30);
INSERT INTO LISTA_PENDIENTE (Id_lista, Id_usuario, estado, fecha_agregado) VALUES
('lista_003', 'user_002', 'pendiente', SYSDATE - 15);
 
-- 8. CALIFICACIONES
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_001', 'user_001', 'cont_002', 5, SYSDATE - 20);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_002', 'user_003', 'cont_003', 5, SYSDATE - 10);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_003', 'user_004', 'cont_006', 4, SYSDATE - 5);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_004', 'user_005', 'cont_004', 5, SYSDATE - 3);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_005', 'user_002', 'cont_009', 4, SYSDATE - 2);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_006', 'user_002', 'cont_002', 4, SYSDATE);
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_007', 'user_003', 'cont_002', 5, SYSDATE);
 
-- 9. RESEÑAS
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
('res_001', 'user_001', 'cont_002', 'Vi esta película el día que decidí estudiar arquitectura. La forma en que Nolan juega con los espacios me inspiró.', SYSDATE - 20);
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
('res_002', 'user_003', 'cont_003', 'La primera vez que vi esta película fue con mi abuelo. Él me explicó cada escena y me contó sobre el cine italiano.', SYSDATE - 10);
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
('res_003', 'user_005', 'cont_004', 'Esta película me abrió los ojos sobre las desigualdades sociales. La mezcla de géneros es magistral.', SYSDATE - 3);
 
-- 10. PERSONAL
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_001', 'Christopher Nolan', 'director', 'cont_001,cont_002', 'Director británico conocido por películas de ciencia ficción', 'Británico');
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_002', 'Francis Ford Coppola', 'director', 'cont_003', 'Director estadounidense, figura clave del Nuevo Hollywood', 'Estadounidense');
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_003', 'Bong Joon-ho', 'director', 'cont_004', 'Director surcoreano ganador del Oscar', 'Surcoreano');
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_004', 'Leonardo DiCaprio', 'actor', 'cont_002', 'Actor estadounidense, protagonista de múltiples éxitos', 'Estadounidense');
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_005', 'Vince Gilligan', 'director', 'cont_006', 'Creador y productor ejecutivo de Breaking Bad', 'Estadounidense');
 
-- 11. ROL
INSERT INTO ROL (Id_rol, nombre_rol) VALUES ('rol_001', 'actor');
INSERT INTO ROL (Id_rol, nombre_rol) VALUES ('rol_002', 'director');
INSERT INTO ROL (Id_rol, nombre_rol) VALUES ('rol_003', 'guionista');
INSERT INTO ROL (Id_rol, nombre_rol) VALUES ('rol_004', 'productor');
INSERT INTO ROL (Id_rol, nombre_rol) VALUES ('rol_005', 'sonidista');
 
-- 12. PERSONAL_ROL
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES ('pers_001', 'rol_002');
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES ('pers_002', 'rol_002');
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES ('pers_003', 'rol_002');
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES ('pers_004', 'rol_001');
INSERT INTO PERSONAL_ROL (Id_personal, Id_rol) VALUES ('pers_005', 'rol_002');
 
-- 13. PERSONAL_CONTENIDO
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_001', 'cont_001');
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_001', 'cont_002');
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_002', 'cont_003');
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_003', 'cont_004');
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_004', 'cont_002');
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES ('pers_005', 'cont_006');
 
-- 14. SERIE
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES ('cont_006', 5, 62, 'Vince Gilligan');
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES ('cont_007', 8, 73, 'David Benioff, D.B. Weiss');
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES ('cont_008', 9, 201, 'Greg Daniels');
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES ('cont_009', 4, 34, 'Los hermanos Duffer');
INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES ('cont_010', 10, 236, 'David Crane, Marta Kauffman');
 
-- 15. PELICULA
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES ('cont_001', 165000000, 701000000);
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES ('cont_002', 160000000, 836000000);
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES ('cont_003', 6000000, 246000000);
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES ('cont_004', 11000000, 258000000);
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES ('cont_005', 150000000, 375000000);
 
COMMIT;
 
 
-- =====================================================
-- SECCIÓN 8: PRUEBAS DE INSERCIÓN INVÁLIDA (PoblarNoOK)
-- =====================================================
-- Descomentar cada bloque para probar la restricción correspondiente.
 
-- PRUEBA 1: Email con formato inválido (debe fallar - CHECK email)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test1', 'email_invalido', SYSDATE, DATE '1998-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 2: Fecha de nacimiento en el futuro (debe fallar - CHECK fecha_nacimiento)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test2', 'test2@example.com', SYSDATE, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 3: Fecha de registro en el futuro (debe fallar - CHECK fecha_registro)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test3', 'test3@example.com', DATE '2030-01-01', DATE '1998-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 4: Año de estreno inválido (< 1895) (debe fallar - CHECK año_estreno)
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
-- ('cont_test1', 'Película Inválida', 1800, 100, 'USA', 'Drama', 'Sinopsis', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 5: Duración inválida (<= 0) (debe fallar - CHECK duracion)
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
-- ('cont_test2', 'Película Inválida', 2020, 0, 'USA', 'Drama', 'Sinopsis', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 6: Calificación con estrellas fuera de rango (debe fallar - CHECK estrellas)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test1', 'user_001', 'cont_001', 6, SYSDATE);
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 7: Calificación con estrellas < 1 (debe fallar - CHECK estrellas)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test2', 'user_001', 'cont_001', 0, SYSDATE);
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 8: Fecha de calificación en el futuro (debe fallar - CHECK fecha_calificacion)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test3', 'user_001', 'cont_001', 5, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 9: Comentario de reseña vacío (debe fallar - NOT NULL)
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test1', 'user_001', 'cont_001', '', SYSDATE);
-- ERROR ESPERADO: ORA-01400: cannot insert NULL into column
 
-- PRUEBA 10: Fecha de reseña en el futuro (debe fallar - CHECK fecha_reseña)
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test2', 'user_001', 'cont_001', 'Comentario válido', DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 11: Rol inválido en PERSONAL (debe fallar - CHECK rol)
-- INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
-- ('pers_test1', 'Test Actor', 'rol_invalido', 'cont_001', 'Descripción', 'Nacionalidad');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 12: Temporadas <= 0 en SERIE (debe fallar - CHECK temporadas)
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_test3', 0, 10, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 13: Episodios <= 0 en SERIE (debe fallar - CHECK episodios)
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_test4', 1, 0, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 14: Presupuesto negativo en PELICULA (debe fallar - CHECK presupuesto)
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_test5', -1000000, 5000000);
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 15: Recaudación negativa en PELICULA (debe fallar - CHECK recaudacion)
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_test6', 1000000, -500000);
-- ERROR ESPERADO: ORA-02290: check constraint violated
 
-- PRUEBA 16: Clave foránea inválida en Calificaciones (debe fallar - FK usuario)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test4', 'user_inexistente', 'cont_001', 5, SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found
 
-- PRUEBA 17: Clave foránea inválida en Calificaciones (debe fallar - FK contenido)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test5', 'user_001', 'cont_inexistente', 5, SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found
 
-- PRUEBA 18: Clave foránea inválida en RESEÑAS (debe fallar - FK usuario)
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test3', 'user_inexistente', 'cont_001', 'Comentario', SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found
 
-- PRUEBA 19: Clave foránea inválida en RESEÑAS (debe fallar - FK contenido)
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test4', 'user_001', 'cont_inexistente', 'Comentario', SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found
 
-- PRUEBA 20: Clave foránea inválida en LISTA_CONTENIDO (debe fallar - FK lista)
-- INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
-- ('lista_inexistente', 'user_001', 'Test', 'Test', 1, SYSDATE, 'cont_001');
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found
 
COMMIT;
 
 
-- =====================================================
-- SECCIÓN 9: CONSULTAS DE CASOS DE USO (Consultas)
-- =====================================================
 
-- Consulta 1: Consultar las reseñas de un contenido específico
SELECT
    r.id_reseña,
    r.comentario,
    r.fecha_reseña,
    u.Id_usuario,
    r.Id_content
FROM RESEÑAS r
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
WHERE r.Id_content = 'cont_002'   -- Ejemplo: cont_001 --
ORDER BY r.fecha_reseña DESC;
 
-- Consulta 2: Ver lista de contenidos pendientes de un usuario
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    lp.estado,
    lp.fecha_agregado
FROM LISTA_PENDIENTE lp
JOIN LISTA l ON lp.Id_lista = l.Id_lista
JOIN LISTA_CONTENIDO lc ON l.Id_lista = lc.Id_lista
JOIN CONTENIDO c ON lc.Id_content = c.Id_content
WHERE lp.Id_usuario = 'user_001' -- Ejemplo: user_001 --
  AND lp.estado = 'pendiente'
ORDER BY lp.fecha_agregado DESC;
 
-- Consulta 3: Filtrar contenidos por género, año y país
 
-- Lista de contenidos, paises y años de estreno
 
SELECT genero, pais, Año_estreno
FROM CONTENIDO
ORDER BY genero, pais;
------------------------------------------------
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    c.sinopsis
FROM CONTENIDO c
WHERE c.genero = 'Acción'
  AND c.Año_estreno BETWEEN 2000 AND 2023
  AND c.pais = 'Australia'
ORDER BY c.Año_estreno DESC, c.nombre;
 
-- Consulta 4: Contenido mejor clasificado (top 10)
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    ROUND(AVG(cal.estrellas), 2) AS promedio_calificacion,
    COUNT(cal.Id_calificacion) AS total_calificaciones
FROM CONTENIDO c
JOIN Calificaciones cal ON c.Id_content = cal.Id_content
GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
ORDER BY promedio_calificacion DESC
FETCH FIRST 10 ROWS ONLY;
 
-- Consulta 5: Recomendaciones más frecuentes (top 10)
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    COUNT(r.id_reseña) AS total_reseñas,
    LISTAGG(u.id_usuario, ', ') WITHIN GROUP (ORDER BY u.id_usuario) AS usuarios_que_recomiendan
FROM CONTENIDO c
JOIN RESEÑAS r ON c.Id_content = r.Id_content
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
ORDER BY total_reseñas DESC
FETCH FIRST 10 ROWS ONLY;
 
-- Consulta 6: Filmografía de un director o actor específico
 
-- personal para buscar
SELECT * FROM personal;
-----------------------------------------------------------------
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    p.rol
FROM PERSONAL_CONTENIDO pc
JOIN PERSONAL p ON pc.Id_personal = p.Id_personal
JOIN CONTENIDO c ON pc.Id_content = c.Id_content
WHERE p.nombre = 'Christopher Nolan'
  AND p.rol IN ('director', 'actor')
ORDER BY c.Año_estreno DESC, c.nombre;
 
 
-- =====================================================
-- SECCIÓN 10: ELIMINACIÓN DE DATOS (XPoblar)
-- =====================================================
-- Descomentar los bloques que necesites ejecutar.
 
-- --- Eliminación por usuario específico ---
-- DELETE FROM Calificaciones WHERE Id_usuario = 'user_001';
-- DELETE FROM RESEÑAS WHERE Id_usuario = 'user_001';
-- DELETE FROM LISTA_CONTENIDO WHERE id_usuario = 'user_001';
-- DELETE FROM LISTA_PENDIENTE WHERE Id_usuario = 'user_001';
-- DELETE FROM ETIQUETAS WHERE id_usuario = 'user_001';
-- DELETE FROM LISTA WHERE Id_usuario = 'user_001';
 
-- --- Eliminación de relaciones intermedias ---
-- DELETE FROM PERSONAL_CONTENIDO WHERE Id_content = 'cont_001';
-- DELETE FROM PERSONAL_ROL WHERE Id_personal = 'pers_001';
 
-- --- Eliminación de registros padres (CASCADE elimina dependencias) ---
-- DELETE FROM USUARIOS WHERE Id_usuario = 'user_005';
-- DELETE FROM CONTENIDO WHERE Id_content = 'cont_010';
-- DELETE FROM PERSONAL WHERE Id_personal = 'pers_005';
 
-- --- Limpieza completa (en orden inverso de dependencias) ---
-- DELETE FROM Calificaciones;
-- DELETE FROM RESEÑAS;
-- DELETE FROM LISTA_CONTENIDO;
-- DELETE FROM LISTA_PENDIENTE;
-- DELETE FROM ETIQUETAS;
-- DELETE FROM LISTA;
-- DELETE FROM PERSONAL_CONTENIDO;
-- DELETE FROM PERSONAL_ROL;
-- DELETE FROM SERIE;
-- DELETE FROM PELICULA;
-- DELETE FROM PERSONAL;
-- DELETE FROM ROL;
-- DELETE FROM CONTENIDO;
-- DELETE FROM USUARIOS;
-- COMMIT;
 
-- Verificación: contar registros por tabla
SELECT 'USUARIOS'          AS tabla, COUNT(*) AS registros FROM USUARIOS          UNION ALL
SELECT 'CONTENIDO',                  COUNT(*)               FROM CONTENIDO                   UNION ALL
SELECT 'ETIQUETAS',                  COUNT(*)               FROM ETIQUETAS                   UNION ALL
SELECT 'LISTA',                      COUNT(*)               FROM LISTA                       UNION ALL
SELECT 'LISTA_CONTENIDO',            COUNT(*)               FROM LISTA_CONTENIDO             UNION ALL
SELECT 'LISTA_PENDIENTE',            COUNT(*)               FROM LISTA_PENDIENTE             UNION ALL
SELECT 'Calificaciones',             COUNT(*)               FROM Calificaciones              UNION ALL
SELECT 'RESEÑAS',                    COUNT(*)               FROM RESEÑAS                     UNION ALL
SELECT 'PERSONAL',                   COUNT(*)               FROM PERSONAL                    UNION ALL
SELECT 'ROL',                        COUNT(*)               FROM ROL                         UNION ALL
SELECT 'PERSONAL_ROL',               COUNT(*)               FROM PERSONAL_ROL                UNION ALL
SELECT 'PERSONAL_CONTENIDO',         COUNT(*)               FROM PERSONAL_CONTENIDO          UNION ALL
SELECT 'SERIE',                      COUNT(*)               FROM SERIE                       UNION ALL
SELECT 'PELICULA',                   COUNT(*)               FROM PELICULA;

-- =====================================================
-- SECCIÓN 11: RESTRICCIONES DE TUPLAS (Tuplas)
-- =====================================================
 
-- USUARIOS: La fecha de registro no puede ser anterior a la fecha de nacimiento
ALTER TABLE USUARIOS
    ADD CONSTRAINT chk_registro_posterior_nacimiento
    CHECK (Fecha_registro >= fecha_nacimiento);
 
-- USUARIOS: El usuario debe tener al menos 13 años al momento del registro
ALTER TABLE USUARIOS
    ADD CONSTRAINT chk_edad_minima_registro
    CHECK (Fecha_registro >= fecha_nacimiento + INTERVAL '13' YEAR);
 
-- PELICULA: Si hay recaudación, debe existir un presupuesto mayor a cero
ALTER TABLE PELICULA
    ADD CONSTRAINT chk_presupuesto_si_recaudacion
    CHECK (recaudacion = 0 OR presupuesto > 0);
 
 
-- SERIE: Los episodios totales deben ser mayores o iguales al número de temporadas
ALTER TABLE SERIE
    ADD CONSTRAINT chk_episodios_vs_temporadas
    CHECK (episodios >= temporadas);
 
 
-- =====================================================
-- SECCIÓN 12: DATOS VÁLIDOS PARA TUPLAS (TuplasOK)
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
 
 
-- =====================================================
-- SECCIÓN 13: DATOS INVÁLIDOS PARA TUPLAS (TuplasNoOK)
-- =====================================================
 
-- PRUEBA T1: Fecha de registro anterior a la fecha de nacimiento (debe fallar)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_t01', 'invalido1@example.com', DATE '1990-01-01', DATE '2000-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_registro_posterior_nacimiento) violated
 
-- PRUEBA T2: Usuario menor de 13 años al momento del registro (debe fallar)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_t02', 'invalido2@example.com', DATE '2010-06-01', DATE '2000-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_edad_minima_registro) violated
 
-- PRUEBA T3: Recaudación mayor a cero con presupuesto en cero (debe fallar)
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_012', 0, 500000);
-- ERROR ESPERADO: ORA-02290: check constraint (chk_presupuesto_si_recaudacion) violated
 
-- PRUEBA T4: Fecha de agregado en lista con fecha futura (debe fallar)
-- INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
-- ('lista_006', 'user_006', 'Lista futura', 'Descripción', 2, DATE '2030-12-31', 'cont_011');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_fecha_agregado_no_futura) violated
 
-- PRUEBA T5: Fecha de calificación futura (debe fallar)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_t01', 'user_006', 'cont_011', 4, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_fecha_calificacion_no_futura) violated
 
-- PRUEBA T6: Episodios menores que temporadas en SERIE (debe fallar)
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_013', 10, 3, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_episodios_vs_temporadas) violated
 
COMMIT;
 
-- =====================================================
-- SECCIÓN 14: ACCIONES DE REFERENCIA (Acciones)
-- =====================================================
 
-- Primero eliminamos las FK existentes que vamos a redefinir
 
-- RESEÑAS → USUARIOS (era CASCADE, cambia a SET NULL)
ALTER TABLE RESEÑAS
    DROP CONSTRAINT fk_resenas_usuario;
 
-- ETIQUETAS → USUARIOS (era CASCADE, cambia a SET NULL)
ALTER TABLE ETIQUETAS
    DROP CONSTRAINT fk_etiquetas_usuario;
 
-- PERSONAL_CONTENIDO → PERSONAL (era CASCADE, cambia a NO ACTION)
ALTER TABLE PERSONAL_CONTENIDO
    DROP CONSTRAINT fk_personal_contenido_personal;
 
-- CALIFICACIONES → USUARIOS (era CASCADE, cambia a SET NULL)
ALTER TABLE Calificaciones
    DROP CONSTRAINT fk_calificaciones_usuario;
 
 
-- Permitir NULL en las columnas que recibirán SET NULL
 
-- RESEÑAS: Id_usuario puede quedar NULL si se elimina el usuario
ALTER TABLE RESEÑAS
    MODIFY Id_usuario NULL;
 
-- ETIQUETAS: id_usuario puede quedar NULL si se elimina el usuario
ALTER TABLE ETIQUETAS
    MODIFY id_usuario NULL;
 
-- CALIFICACIONES: Id_usuario puede quedar NULL si se elimina el usuario
ALTER TABLE Calificaciones
    MODIFY Id_usuario NULL;
 
 
-- Redefinir las FK con las nuevas acciones de referencia
 
-- ACCIÓN 1: RESEÑAS → USUARIOS con SET NULL
-- Si se elimina un usuario, sus reseñas se conservan de forma anónima
ALTER TABLE RESEÑAS
    ADD CONSTRAINT fk_resenas_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario)
    ON DELETE SET NULL;
 
-- ACCIÓN 2: ETIQUETAS → USUARIOS con SET NULL
-- Si se elimina un usuario, sus etiquetas se conservan huérfanas en el sistema
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT fk_etiquetas_usuario
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(Id_usuario)
    ON DELETE SET NULL;
 
-- ACCIÓN 3: PERSONAL_CONTENIDO → PERSONAL con NO ACTION
-- Si se intenta eliminar personal con contenidos asociados, Oracle bloquea la operación
ALTER TABLE PERSONAL_CONTENIDO
    ADD CONSTRAINT fk_personal_contenido_personal
    FOREIGN KEY (Id_personal) REFERENCES PERSONAL(Id_personal);
 
-- ACCIÓN 4: CALIFICACIONES → USUARIOS con SET NULL
-- Si se elimina un usuario, sus calificaciones se conservan de forma anónima
ALTER TABLE Calificaciones
    ADD CONSTRAINT fk_calificaciones_usuario
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario)
    ON DELETE SET NULL;
 
-- =====================================================
-- SECCIÓN 15: PRUEBAS DE ACCIONES DE REFERENCIA (AccionesOK)
-- =====================================================
 
-- Datos de apoyo para las pruebas
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
('user_008', 'prueba_acc@example.com', DATE '2021-05-10', DATE '1990-03-01');
 
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
('cont_014', 'Oppenheimer', 2023, 180, 'USA', 'Drama', 'La historia del padre de la bomba atómica.', 'R', 'historia');
 
INSERT INTO ETIQUETAS (id_usuario, id_etiqueta, nombre_etiqueta, categoria) VALUES
('user_008', 'etiq_006', 'historico', 'genero');
 
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
('calif_009', 'user_008', 'cont_014', 4, DATE '2024-06-15');
 
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
('res_005', 'user_008', 'cont_014', 'Una película impresionante sobre la historia nuclear.', DATE '2024-06-20');
 
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
('pers_006', 'Cillian Murphy', 'actor', 'cont_014', 'Actor irlandés protagonista de Oppenheimer', 'Irlandés');
 
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content) VALUES
('pers_006', 'cont_014');
 
COMMIT;
 
-- ----------------------------------------------------
-- PRUEBA A1: SET NULL en RESEÑAS → USUARIOS
-- Al eliminar user_008, Id_usuario en RESEÑAS queda NULL
-- ----------------------------------------------------
DELETE FROM USUARIOS WHERE Id_usuario = 'user_008';
 
-- Verificar que Id_usuario quedó NULL
SELECT id_reseña, Id_usuario, comentario
FROM RESEÑAS
WHERE id_reseña = 'res_005';
-- RESULTADO ESPERADO: Id_usuario = NULL ✓
 
ROLLBACK;
 
-- ----------------------------------------------------
-- PRUEBA A2: SET NULL en ETIQUETAS → USUARIOS
-- Al eliminar user_008, id_usuario en ETIQUETAS queda NULL
-- ----------------------------------------------------
DELETE FROM USUARIOS WHERE Id_usuario = 'user_008';
 
-- Verificar que id_usuario quedó NULL
SELECT id_etiqueta, nombre_etiqueta, id_usuario
FROM ETIQUETAS
WHERE id_etiqueta = 'etiq_006';
-- RESULTADO ESPERADO: id_usuario = NULL ✓
 
ROLLBACK;
 
-- ----------------------------------------------------
-- PRUEBA A3: NO ACTION en PERSONAL_CONTENIDO → PERSONAL
-- Intentar eliminar pers_006 que tiene contenidos asociados debe fallar
-- ----------------------------------------------------
DELETE FROM PERSONAL WHERE Id_personal = 'pers_006';
-- RESULTADO ESPERADO: ORA-02292: integrity constraint violated - child record found ✓
 
ROLLBACK;
 
-- ----------------------------------------------------
-- PRUEBA A4: SET NULL en CALIFICACIONES → USUARIOS
-- Al eliminar user_008, Id_usuario en CALIFICACIONES queda NULL
-- ----------------------------------------------------
DELETE FROM USUARIOS WHERE Id_usuario = 'user_008';
 
-- Verificar que Id_usuario quedó NULL
SELECT Id_calificacion, Id_usuario, estrellas
FROM Calificaciones
WHERE Id_calificacion = 'calif_009';
-- RESULTADO ESPERADO: Id_usuario = NULL ✓
 
ROLLBACK;
 
COMMIT;

-- =====================================================
-- SECCIÓN 16: DISPARADORES (Disparadores)
-- =====================================================
-- Casos de uso cubiertos:
--   CU1: Mantener Usuario(Rol)   → Administrador
--   CU2: Mantener Contenido      → Administrador
--   CU3: Registrar Calificación  → Cliente
-- =====================================================
 
 
-- =====================================================
-- CU1: MANTENER USUARIO (ROL) - Administrador
-- =====================================================
 
-- -----------------------------------------------------
-- TRIGGER 1: trg_validar_edad_registro
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: El usuario debe tener al menos 13 años
--            al momento del registro. Protege que
--            menores no accedan a la plataforma.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_validar_edad_registro
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF MONTHS_BETWEEN(:NEW.Fecha_registro, :NEW.fecha_nacimiento) / 12 < 13 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'ERROR CU1: El usuario debe tener al menos 13 años al momento del registro.');
    END IF;
END;
/
 
-- -----------------------------------------------------
-- TRIGGER 2: trg_fecha_registro_no_futura
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: La fecha de registro no puede ser futura.
--            Garantiza coherencia temporal del perfil.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_registro_no_futura
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF :NEW.Fecha_registro > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002,
            'ERROR CU1: La fecha de registro no puede ser una fecha futura.');
    END IF;
END;
/
 
-- -----------------------------------------------------
-- TRIGGER 3: trg_resena_no_ofensiva
-- TABLA: RESEÑAS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Bloquear reseñas con lenguaje ofensivo.
--            Apoya la revisión del administrador para
--            mantener el ambiente de la comunidad sano.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_resena_no_ofensiva
BEFORE INSERT OR UPDATE ON RESEÑAS
FOR EACH ROW
DECLARE
    v_comentario_lower VARCHAR2(250);
BEGIN
    v_comentario_lower := LOWER(:NEW.comentario);
 
    IF INSTR(v_comentario_lower, 'odio')      > 0 OR
       INSTR(v_comentario_lower, 'imbecil')   > 0 OR
       INSTR(v_comentario_lower, 'idiota')    > 0 OR
       INSTR(v_comentario_lower, 'basura')    > 0 OR
       INSTR(v_comentario_lower, 'estupido')  > 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'ERROR CU1: La reseña contiene lenguaje ofensivo. Por favor, mantenga un lenguaje respetuoso.');
    END IF;
END;
/
 
-- -----------------------------------------------------
-- TRIGGER 4: trg_fecha_resena_no_futura
-- TABLA: RESEÑAS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir reseñas con fecha futura.
--            El admin necesita datos temporalmente
--            coherentes para auditar la comunidad.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_resena_no_futura
BEFORE INSERT OR UPDATE ON RESEÑAS
FOR EACH ROW
BEGIN
    IF :NEW.fecha_reseña > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20004,
            'ERROR CU1: La fecha de la reseña no puede ser una fecha futura.');
    END IF;
END;
/
 
 
-- =====================================================
-- CU2: MANTENER CONTENIDO (OBJETO) - Administrador
-- =====================================================
 
-- -----------------------------------------------------
-- TRIGGER 5: trg_personal_contenido_no_vacio
-- TABLA: PERSONAL_CONTENIDO
-- EVENTO: BEFORE DELETE
-- PROPÓSITO: Todo contenido debe tener al menos un
--            miembro de personal verificado asociado.
--            El admin no puede dejar contenido huérfano.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_personal_contenido_no_vacio
BEFORE DELETE ON PERSONAL_CONTENIDO
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM PERSONAL_CONTENIDO
    WHERE Id_content = :OLD.Id_content;
 
    IF v_count <= 1 THEN
        RAISE_APPLICATION_ERROR(-20005,
            'ERROR CU2: No se puede eliminar el último miembro de personal del contenido. Todo contenido debe tener al menos un personal asociado.');
    END IF;
END;
/
 
-- -----------------------------------------------------
-- TRIGGER 6: trg_anno_estreno_valido
-- TABLA: CONTENIDO
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: El año de estreno debe estar entre 1895
--            (invención del cine) y el año actual.
--            El admin no puede registrar contenidos
--            con fechas imposibles o futuras.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_anno_estreno_valido
BEFORE INSERT OR UPDATE ON CONTENIDO
FOR EACH ROW
BEGIN
    IF :NEW.Año_estreno < 1895 OR :NEW.Año_estreno > EXTRACT(YEAR FROM SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20006,
            'ERROR CU2: El año de estreno debe estar entre 1895 y el año actual. No se admiten contenidos futuros ni anteriores al cine.');
    END IF;
END;
/
 
 
-- =====================================================
-- CU3: REGISTRAR CALIFICACIÓN (EVENTO) - Cliente
-- =====================================================
 
-- -----------------------------------------------------
-- TRIGGER 7: trg_una_calificacion_por_contenido
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT
-- PROPÓSITO: Un cliente solo puede calificar una vez
--            el mismo contenido. Garantiza integridad
--            del promedio de calificaciones.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_una_calificacion_por_contenido
BEFORE INSERT ON Calificaciones
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Calificaciones
    WHERE Id_usuario = :NEW.Id_usuario
      AND Id_content = :NEW.Id_content;
 
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20007,
            'ERROR CU3: El usuario ya registró una calificación para este contenido. Use UPDATE para modificarla.');
    END IF;
END;
/
 
-- -----------------------------------------------------
-- TRIGGER 8: trg_fecha_calificacion_no_futura
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: La fecha de calificación no puede ser
--            futura. El cliente califica lo que ya vio.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_calificacion_no_futura
BEFORE INSERT OR UPDATE ON Calificaciones
FOR EACH ROW
BEGIN
    IF :NEW.fecha_calificacion > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20008,
            'ERROR CU3: La fecha de calificación no puede ser una fecha futura. Solo se pueden calificar contenidos ya vistos.');
    END IF;
END;
/
 
-- Verificar creación de triggers
SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
WHERE trigger_name IN (
    'TRG_VALIDAR_EDAD_REGISTRO',
    'TRG_FECHA_REGISTRO_NO_FUTURA',
    'TRG_RESENA_NO_OFENSIVA',
    'TRG_FECHA_RESENA_NO_FUTURA',
    'TRG_PERSONAL_CONTENIDO_NO_VACIO',
    'TRG_ANNO_ESTRENO_VALIDO',
    'TRG_UNA_CALIFICACION_POR_CONTENIDO',
    'TRG_FECHA_CALIFICACION_NO_FUTURA'
)
ORDER BY table_name, trigger_name;
 
 
-- =====================================================
-- SECCIÓN 17: DATOS VÁLIDOS PARA DISPARADORES (DisparadoresOK)
-- =====================================================
 
-- Datos de apoyo
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
VALUES ('cont_ok1', 'La Era de Hielo', 2002, 81, 'USA', 'Animación',
        'Una manada de animales prehistóricos ayuda a devolver un bebé humano con su familia.', 'PG', 'familiar');
 
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion)
VALUES ('cont_ok1', 59000000, 383257136);
 
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad)
VALUES ('pers_ok1', 'Chris Wedge', 'director', 'cont_ok1', 'Director de animación de Blue Sky Studios', 'Estadounidense');
 
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content)
VALUES ('pers_ok1', 'cont_ok1');
 
-- OK-1: trg_validar_edad_registro → usuario 25 años al registrarse
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
VALUES ('user_ok1', 'sofia_ok@example.com', DATE '2022-08-10', DATE '1997-04-20');
-- Edad al registrarse: 25 años ✓
 
-- OK-2: trg_fecha_registro_no_futura → fecha = hoy
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
VALUES ('user_ok2', 'miguel_ok@example.com', SYSDATE, DATE '1993-11-05');
-- Fecha registro = SYSDATE ✓
 
-- OK-3: trg_resena_no_ofensiva → lenguaje respetuoso
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
VALUES ('res_ok1', 'user_ok1', 'cont_ok1',
        'Una película entrañable que marcó mi infancia. Los personajes son muy carismáticos.', SYSDATE);
-- Sin palabras ofensivas ✓
 
-- OK-4: trg_fecha_resena_no_futura → fecha de ayer
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
VALUES ('res_ok2', 'user_ok2', 'cont_ok1',
        'Clásico de la animación que nunca envejece. Muy recomendada para toda la familia.', SYSDATE - 1);
-- fecha_reseña = ayer ✓
 
-- OK-5: trg_personal_contenido_no_vacio → agregar segundo personal y borrar uno
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad)
VALUES ('pers_ok2', 'Carlos Saldanha', 'director', 'cont_ok1', 'Co-director de La Era de Hielo', 'Brasileño');
 
INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content)
VALUES ('pers_ok2', 'cont_ok1');
 
DELETE FROM PERSONAL_CONTENIDO WHERE Id_personal = 'pers_ok2' AND Id_content = 'cont_ok1';
-- Queda pers_ok1 → operación permitida ✓
 
-- OK-6: trg_anno_estreno_valido → año 2000, dentro del rango
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
VALUES ('cont_ok2', 'Gladiador', 2000, 155, 'USA', 'Acción',
        'Un general romano traicionado busca venganza como gladiador.', 'R', 'historico');
-- 2000 entre 1895 y año actual ✓
 
INSERT INTO PELICULA (Id_content, presupuesto, recaudacion)
VALUES ('cont_ok2', 103000000, 457640427);
 
-- OK-7: trg_una_calificacion_por_contenido → primera calificación
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
VALUES ('calif_ok1', 'user_ok1', 'cont_ok1', 5, SYSDATE);
-- Primera calificación de user_ok1 sobre cont_ok1 ✓
 
-- OK-8: trg_fecha_calificacion_no_futura → fecha de hace 3 días
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
VALUES ('calif_ok2', 'user_ok2', 'cont_ok1', 4, SYSDATE - 3);
-- fecha = hace 3 días ✓
 
COMMIT;
 
-- Verificación
SELECT 'USUARIOS ok'      AS tabla, COUNT(*) AS insertados FROM USUARIOS      WHERE Id_usuario      IN ('user_ok1','user_ok2')       UNION ALL
SELECT 'RESEÑAS ok',                COUNT(*)               FROM RESEÑAS        WHERE id_reseña       IN ('res_ok1','res_ok2')         UNION ALL
SELECT 'CONTENIDO ok',              COUNT(*)               FROM CONTENIDO      WHERE Id_content      IN ('cont_ok1','cont_ok2')       UNION ALL
SELECT 'CALIFICACIONES ok',         COUNT(*)               FROM Calificaciones WHERE Id_calificacion IN ('calif_ok1','calif_ok2');
 
 
-- =====================================================
-- SECCIÓN 18: DATOS INVÁLIDOS PARA DISPARADORES (DisparadoresNoOK)
-- =====================================================
-- Descomentar cada bloque para probar individualmente.
 
-- NoOK-1: trg_validar_edad_registro → usuario con 10 años
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
-- VALUES ('user_nok1', 'menor@example.com', DATE '2025-01-15', DATE '2015-06-20');
-- ERROR ESPERADO: ORA-20001 - El usuario debe tener al menos 13 años al momento del registro.
 
-- NoOK-2: trg_fecha_registro_no_futura → fecha año 2035
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
-- VALUES ('user_nok2', 'futuro@example.com', DATE '2035-12-31', DATE '1990-03-10');
-- ERROR ESPERADO: ORA-20002 - La fecha de registro no puede ser una fecha futura.
 
-- NoOK-3: trg_resena_no_ofensiva → palabra "basura"
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok1', 'user_001', 'cont_003',
--         'Esta película es una basura total, no entiendo por qué la recomiendan.', SYSDATE);
-- ERROR ESPERADO: ORA-20003 - La reseña contiene lenguaje ofensivo.
 
-- NoOK-4: trg_resena_no_ofensiva → palabra "idiota"
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok2', 'user_002', 'cont_006',
--         'El director es un idiota, arruinó la historia por completo.', SYSDATE);
-- ERROR ESPERADO: ORA-20003 - La reseña contiene lenguaje ofensivo.
 
-- NoOK-5: trg_fecha_resena_no_futura → fecha año 2030
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok3', 'user_001', 'cont_002', 'Una obra maestra del cine moderno.', DATE '2030-06-01');
-- ERROR ESPERADO: ORA-20004 - La fecha de la reseña no puede ser una fecha futura.
 
-- NoOK-6: trg_personal_contenido_no_vacio → borrar único personal
-- DELETE FROM PERSONAL_CONTENIDO WHERE Id_personal = 'pers_ok1' AND Id_content = 'cont_ok1';
-- ERROR ESPERADO: ORA-20005 - No se puede eliminar el último miembro de personal del contenido.
 
-- NoOK-7: trg_anno_estreno_valido → año 1800 (antes del cine)
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
-- VALUES ('cont_nok1', 'Película Imposible', 1800, 90, 'Francia', 'Drama',
--         'Una película que no pudo existir.', 'NR', 'test');
-- ERROR ESPERADO: ORA-20006 - El año de estreno debe estar entre 1895 y el año actual.
 
-- NoOK-8: trg_anno_estreno_valido → año 2099 (futuro)
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
-- VALUES ('cont_nok2', 'Película del Futuro', 2099, 110, 'USA', 'Ciencia Ficción',
--         'Una película que todavía no se ha estrenado.', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-20006 - El año de estreno debe estar entre 1895 y el año actual.
 
-- NoOK-9: trg_una_calificacion_por_contenido → calificación duplicada
-- (calif_ok1 ya fue insertado en DisparadoresOK: user_ok1 calificó cont_ok1)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
-- VALUES ('calif_nok1', 'user_ok1', 'cont_ok1', 2, SYSDATE);
-- ERROR ESPERADO: ORA-20007 - El usuario ya registró una calificación para este contenido.
 
-- NoOK-10: trg_fecha_calificacion_no_futura → calificar La Era de Hielo con fecha 2030
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
-- VALUES ('calif_nok2', 'user_001', 'cont_ok1', 5, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-20008 - La fecha de calificación no puede ser una fecha futura.
 
COMMIT;
 
 
-- =====================================================
-- SECCIÓN 19: ELIMINACIÓN DE DISPARADORES (XDisparadores)
-- =====================================================
 
-- DROP TRIGGER trg_validar_edad_registro;
-- DROP TRIGGER trg_fecha_registro_no_futura;
-- DROP TRIGGER trg_resena_no_ofensiva;
-- DROP TRIGGER trg_fecha_resena_no_futura;
-- DROP TRIGGER trg_personal_contenido_no_vacio;
-- DROP TRIGGER trg_anno_estreno_valido;
-- DROP TRIGGER trg_una_calificacion_por_contenido;
-- DROP TRIGGER trg_fecha_calificacion_no_futura;
 
-- Verificar eliminación (debe retornar 0 filas)
-- SELECT trigger_name, table_name, status
-- FROM user_triggers
-- WHERE trigger_name IN (
--     'TRG_VALIDAR_EDAD_REGISTRO',
--     'TRG_FECHA_REGISTRO_NO_FUTURA',
--     'TRG_RESENA_NO_OFENSIVA',
--     'TRG_FECHA_RESENA_NO_FUTURA',
--     'TRG_PERSONAL_CONTENIDO_NO_VACIO',
--     'TRG_ANNO_ESTRENO_VALIDO',
--     'TRG_UNA_CALIFICACION_POR_CONTENIDO',
--     'TRG_FECHA_CALIFICACION_NO_FUTURA'
-- )
-- ORDER BY trigger_name;
 
 
-- =====================================================
-- FIN DEL SCRIPT EGO_Completo.sql
-- =====================================================
 