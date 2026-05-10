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

-- -----------------------------------------------------
-- TABLA: ETIQUETA_CONTENIDO
-- -----------------------------------------------------
CREATE TABLE ETIQUETA_CONTENIDO (
    id_etiqueta VARCHAR2(50) NOT NULL,
    Id_content VARCHAR2(255) NOT NULL
);
 
-- Verificar que todas las tablas se crearon
SELECT table_name
FROM user_tables
WHERE table_name IN (
    'USUARIOS','CONTENIDO','ETIQUETAS','LISTA','LISTA_CONTENIDO',
    'LISTA_PENDIENTE','CALIFICACIONES','RESEÑAS','PERSONAL','ROL',
    'PERSONAL_ROL','PERSONAL_CONTENIDO','SERIE','PELICULA', 'ETIQUETA_CONTENIDO'
)
ORDER BY table_name;
 
 
-- =====================================================
-- SECCIÓN 3: CLAVES PRIMARIAS (Primarias)
-- =====================================================
 
ALTER TABLE USUARIOS ADD PRIMARY KEY (Id_usuario);
ALTER TABLE CONTENIDO ADD PRIMARY KEY (Id_content);
ALTER TABLE ETIQUETAS ADD PRIMARY KEY (id_etiqueta);
ALTER TABLE ETIQUETA_CONTENIDO ADD PRIMARY KEY (id_etiqueta, Id_content);
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

-- ETIQUETA_CONTENIDO → ETIQUETAS   
ALTER TABLE ETIQUETA_CONTENIDO
    ADD CONSTRAINT fk_etiqueta_contenido_etiquetas
    FOREIGN KEY (id_etiqueta) REFERENCES ETIQUETAS(id_etiqueta) ON DELETE CASCADE;

-- ETIQUETA_CONTENIDO → CONTENIDO
ALTER TABLE ETIQUETA_CONTENIDO
    ADD CONSTRAINT fk_etiqueta_contenido_contenido
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

-- 16. ETIQUETA_CONTENIDO
INSERT INTO ETIQUETA_CONTENIDO (id_etiqueta, Id_content) VALUES ('etiq_001', 'cont_002');
INSERT INTO ETIQUETA_CONTENIDO (id_etiqueta, Id_content) VALUES ('etiq_001', 'cont_009');
INSERT INTO ETIQUETA_CONTENIDO (id_etiqueta, Id_content) VALUES ('etiq_002', 'cont_001');
INSERT INTO ETIQUETA_CONTENIDO (id_etiqueta, Id_content) VALUES ('etiq_002', 'cont_006');
INSERT INTO ETIQUETA_CONTENIDO (id_etiqueta, Id_content) VALUES ('etiq_003', 'cont_005');
 
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
-- SECCIÓN 20: ÍNDICES (Indices)
-- =====================================================

-- Índice sobre Id_content en Calificaciones
-- Acelera el cálculo de promedios y conteo de calificaciones por contenido
CREATE INDEX idx_calificaciones_content
    ON Calificaciones(Id_content);

-- Índice sobre Id_content en RESEÑAS
-- Acelera la consulta de reseñas asociadas a un contenido específico
CREATE INDEX idx_resenas_content
    ON RESEÑAS(Id_content);

-- Índice sobre genero en CONTENIDO
-- Acelera los filtros por género en el catálogo
CREATE INDEX idx_contenido_genero
    ON CONTENIDO(genero);

-- Índice sobre Id_content en PERSONAL_CONTENIDO
-- Acelera la consulta de filmografías y personal asociado a un contenido
CREATE INDEX idx_personal_contenido_content
    ON PERSONAL_CONTENIDO(Id_content);

-- Índice sobre id_usuario en LISTA_CONTENIDO
-- Acelera la consulta de listas y contenidos asociados a un usuario
CREATE INDEX idx_lista_contenido_usuario
    ON LISTA_CONTENIDO(id_usuario);

-- Verificar creación de índices
SELECT index_name, table_name, status
FROM user_indexes
WHERE index_name IN (
    'IDX_CALIFICACIONES_CONTENT',
    'IDX_RESENAS_CONTENT',
    'IDX_CONTENIDO_GENERO',
    'IDX_PERSONAL_CONTENIDO_CONTENT',
    'IDX_LISTA_CONTENIDO_USUARIO'
)
ORDER BY table_name;


-- =====================================================
-- SECCIÓN 21: VISTAS (Vistas)
-- =====================================================

-- -----------------------------------------------------
-- VISTA 1: VW_CONTENIDO_CALIFICADO
-- Muestra cada contenido con su promedio de estrellas
-- y total de calificaciones recibidas
-- -----------------------------------------------------
CREATE OR REPLACE VIEW VW_CONTENIDO_CALIFICADO AS
SELECT
    c.Id_content,
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    c.Clasificacion,
    ROUND(AVG(cal.estrellas), 2)    AS promedio_estrellas,
    COUNT(cal.Id_calificacion)      AS total_calificaciones
FROM CONTENIDO c
LEFT JOIN Calificaciones cal ON c.Id_content = cal.Id_content
GROUP BY
    c.Id_content,
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    c.Clasificacion;

-- -----------------------------------------------------
-- VISTA 2: VW_RESENAS_DETALLE
-- Muestra reseñas con nombre de usuario y
-- nombre del contenido al que pertenecen
-- -----------------------------------------------------
CREATE OR REPLACE VIEW VW_RESENAS_DETALLE AS
SELECT
    r.id_reseña,
    u.Id_usuario,
    u.Email,
    c.Id_content,
    c.nombre          AS nombre_contenido,
    c.genero,
    r.comentario,
    r.fecha_reseña
FROM RESEÑAS r
LEFT JOIN USUARIOS u  ON r.Id_usuario  = u.Id_usuario
LEFT JOIN CONTENIDO c ON r.Id_content  = c.Id_content
ORDER BY r.fecha_reseña DESC;

-- -----------------------------------------------------
-- VISTA 3: VW_FILMOGRAFIA_PERSONAL
-- Muestra cada miembro del personal con todos
-- sus contenidos asociados y su rol
-- -----------------------------------------------------
CREATE OR REPLACE VIEW VW_FILMOGRAFIA_PERSONAL AS
SELECT
    p.Id_personal,
    p.nombre          AS nombre_personal,
    p.rol,
    p.nacionalidad,
    c.Id_content,
    c.nombre          AS nombre_contenido,
    c.genero,
    c.Año_estreno
FROM PERSONAL p
JOIN PERSONAL_CONTENIDO pc ON p.Id_personal  = pc.Id_personal
JOIN CONTENIDO c            ON pc.Id_content = c.Id_content
ORDER BY p.nombre, c.Año_estreno DESC;

-- -----------------------------------------------------
-- VISTA 4: VW_LISTAS_USUARIO
-- Muestra las listas de cada usuario con los
-- contenidos que tienen dentro y su estado
-- -----------------------------------------------------
CREATE OR REPLACE VIEW VW_LISTAS_USUARIO AS
SELECT
    u.Id_usuario,
    u.Email,
    l.Id_lista,
    l.esPrivada,
    lc.nombre_lista,
    lc.descripcion,
    lc.orden,
    lc.fecha_agregado,
    c.Id_content,
    c.nombre          AS nombre_contenido,
    c.genero,
    c.Año_estreno
FROM USUARIOS u
JOIN LISTA          l  ON u.Id_usuario   = l.Id_usuario
JOIN LISTA_CONTENIDO lc ON l.Id_lista   = lc.Id_lista
LEFT JOIN CONTENIDO  c  ON lc.Id_content = c.Id_content
ORDER BY u.Id_usuario, l.Id_lista, lc.orden;

-- Verificar creación de vistas
SELECT view_name, status
FROM user_views
WHERE view_name IN (
    'VW_CONTENIDO_CALIFICADO',
    'VW_RESENAS_DETALLE',
    'VW_FILMOGRAFIA_PERSONAL',
    'VW_LISTAS_USUARIO'
)
ORDER BY view_name;


-- =====================================================
-- SECCIÓN 22: CONSULTAS CON ÍNDICES Y VISTAS (IndicesVistasOK)
-- =====================================================

-- Consulta IV-1: Top 10 contenidos mejor calificados (usa VW_CONTENIDO_CALIFICADO + idx_calificaciones_content)
SELECT nombre, genero, Año_estreno, promedio_estrellas, total_calificaciones
FROM VW_CONTENIDO_CALIFICADO
WHERE total_calificaciones > 0
ORDER BY promedio_estrellas DESC
FETCH FIRST 10 ROWS ONLY;

-- Consulta IV-2: Reseñas de un contenido específico con detalle de usuario (usa VW_RESENAS_DETALLE + idx_resenas_content)
SELECT id_reseña, Id_usuario, Email, comentario, fecha_reseña
FROM VW_RESENAS_DETALLE
WHERE Id_content = 'cont_002'
ORDER BY fecha_reseña DESC;

-- Consulta IV-3: Filmografía completa de un director (usa VW_FILMOGRAFIA_PERSONAL + idx_personal_contenido_content)
SELECT nombre_personal, rol, nombre_contenido, genero, Año_estreno
FROM VW_FILMOGRAFIA_PERSONAL
WHERE nombre_personal = 'Christopher Nolan'
ORDER BY Año_estreno DESC;

-- Consulta IV-4: Contenidos de las listas de un usuario (usa VW_LISTAS_USUARIO + idx_lista_contenido_usuario)
SELECT Id_lista, nombre_lista, nombre_contenido, genero, orden, fecha_agregado
FROM VW_LISTAS_USUARIO
WHERE Id_usuario = 'user_001'
ORDER BY Id_lista, orden;

-- Consulta IV-5: Catálogo filtrado por género (usa idx_contenido_genero)
SELECT nombre, Año_estreno, pais, Clasificacion, promedio_estrellas
FROM VW_CONTENIDO_CALIFICADO
WHERE genero = 'Drama'
ORDER BY promedio_estrellas DESC NULLS LAST;


-- =====================================================
-- SECCIÓN 23: ELIMINACIÓN DE ÍNDICES Y VISTAS (XIndicesVistas)
-- =====================================================

-- DROP INDEX idx_calificaciones_content;
-- DROP INDEX idx_resenas_content;
-- DROP INDEX idx_contenido_genero;
-- DROP INDEX idx_personal_contenido_content;
-- DROP INDEX idx_lista_contenido_usuario;

-- DROP VIEW VW_CONTENIDO_CALIFICADO;
-- DROP VIEW VW_RESENAS_DETALLE;
-- DROP VIEW VW_FILMOGRAFIA_PERSONAL;
-- DROP VIEW VW_LISTAS_USUARIO;

-- Verificar eliminación (debe retornar 0 filas)
-- SELECT index_name FROM user_indexes
-- WHERE index_name IN (
--     'IDX_CALIFICACIONES_CONTENT','IDX_RESENAS_CONTENT',
--     'IDX_CONTENIDO_GENERO','IDX_PERSONAL_CONTENIDO_CONTENT',
--     'IDX_LISTA_CONTENIDO_USUARIO'
-- );
-- SELECT view_name FROM user_views
-- WHERE view_name IN (
--     'VW_CONTENIDO_CALIFICADO','VW_RESENAS_DETALLE',
--     'VW_FILMOGRAFIA_PERSONAL','VW_LISTAS_USUARIO'
-- );


-- =====================================================
-- SECCIÓN 24: ESPECIFICACIÓN DE PAQUETES (CRUDE)
-- =====================================================

-- -----------------------------------------------------
-- PAQUETE 1: PKG_USUARIOS
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_USUARIOS AS

    -- Agregar un nuevo usuario
    PROCEDURE agregar_usuario(
        p_id_usuario      IN USUARIOS.Id_usuario%TYPE,
        p_email           IN USUARIOS.Email%TYPE,
        p_fecha_registro  IN USUARIOS.Fecha_registro%TYPE,
        p_fecha_nac       IN USUARIOS.fecha_nacimiento%TYPE
    );

    -- Consultar un usuario por ID (retorna datos por parámetros OUT)
    PROCEDURE consultar_usuario(
        p_id_usuario      IN  USUARIOS.Id_usuario%TYPE,
        p_email           OUT USUARIOS.Email%TYPE,
        p_fecha_registro  OUT USUARIOS.Fecha_registro%TYPE,
        p_fecha_nac       OUT USUARIOS.fecha_nacimiento%TYPE
    );

    -- Listar todos los usuarios (retorna cursor)
    FUNCTION listar_usuarios
        RETURN SYS_REFCURSOR;

    -- Modificar email de un usuario
    PROCEDURE modificar_email(
        p_id_usuario  IN USUARIOS.Id_usuario%TYPE,
        p_nuevo_email IN USUARIOS.Email%TYPE
    );

    -- Eliminar un usuario por ID
    PROCEDURE eliminar_usuario(
        p_id_usuario IN USUARIOS.Id_usuario%TYPE
    );

END PKG_USUARIOS;
/

-- -----------------------------------------------------
-- PAQUETE 2: PKG_CONTENIDO
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_CONTENIDO AS

    -- Agregar contenido base + película
    PROCEDURE agregar_pelicula(
        p_id_content    IN CONTENIDO.Id_content%TYPE,
        p_nombre        IN CONTENIDO.nombre%TYPE,
        p_anno_estreno  IN CONTENIDO.Año_estreno%TYPE,
        p_duracion      IN CONTENIDO.duracion%TYPE,
        p_pais          IN CONTENIDO.pais%TYPE,
        p_genero        IN CONTENIDO.genero%TYPE,
        p_sinopsis      IN CONTENIDO.sinopsis%TYPE,
        p_clasificacion IN CONTENIDO.Clasificacion%TYPE,
        p_etiqueta      IN CONTENIDO.nombre_etiqueta%TYPE,
        p_presupuesto   IN PELICULA.presupuesto%TYPE,
        p_recaudacion   IN PELICULA.recaudacion%TYPE
    );

    -- Agregar contenido base + serie
    PROCEDURE agregar_serie(
        p_id_content    IN CONTENIDO.Id_content%TYPE,
        p_nombre        IN CONTENIDO.nombre%TYPE,
        p_anno_estreno  IN CONTENIDO.Año_estreno%TYPE,
        p_duracion      IN CONTENIDO.duracion%TYPE,
        p_pais          IN CONTENIDO.pais%TYPE,
        p_genero        IN CONTENIDO.genero%TYPE,
        p_sinopsis      IN CONTENIDO.sinopsis%TYPE,
        p_clasificacion IN CONTENIDO.Clasificacion%TYPE,
        p_etiqueta      IN CONTENIDO.nombre_etiqueta%TYPE,
        p_temporadas    IN SERIE.temporadas%TYPE,
        p_episodios     IN SERIE.episodios%TYPE,
        p_show_runner   IN SERIE.show_runner%TYPE
    );

    -- Consultar contenido por ID
    PROCEDURE consultar_contenido(
        p_id_content    IN  CONTENIDO.Id_content%TYPE,
        p_nombre        OUT CONTENIDO.nombre%TYPE,
        p_anno_estreno  OUT CONTENIDO.Año_estreno%TYPE,
        p_genero        OUT CONTENIDO.genero%TYPE,
        p_pais          OUT CONTENIDO.pais%TYPE,
        p_clasificacion OUT CONTENIDO.Clasificacion%TYPE
    );

    -- Listar contenidos por género
    FUNCTION listar_por_genero(
        p_genero IN CONTENIDO.genero%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Modificar sinopsis y clasificación de un contenido
    PROCEDURE modificar_contenido(
        p_id_content        IN CONTENIDO.Id_content%TYPE,
        p_nueva_sinopsis     IN CONTENIDO.sinopsis%TYPE,
        p_nueva_clasificacion IN CONTENIDO.Clasificacion%TYPE
    );

    -- Eliminar contenido por ID
    PROCEDURE eliminar_contenido(
        p_id_content IN CONTENIDO.Id_content%TYPE
    );

END PKG_CONTENIDO;
/

-- -----------------------------------------------------
-- PAQUETE 3: PKG_CALIFICACIONES
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE PKG_CALIFICACIONES AS

    -- Registrar una nueva calificación
    PROCEDURE agregar_calificacion(
        p_id_calificacion  IN Calificaciones.Id_calificacion%TYPE,
        p_id_usuario       IN Calificaciones.Id_usuario%TYPE,
        p_id_content       IN Calificaciones.Id_content%TYPE,
        p_estrellas        IN Calificaciones.estrellas%TYPE,
        p_fecha            IN Calificaciones.fecha_calificacion%TYPE
    );

    -- Consultar calificaciones de un contenido (retorna cursor)
    FUNCTION consultar_por_contenido(
        p_id_content IN Calificaciones.Id_content%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Consultar historial de calificaciones de un usuario (retorna cursor)
    FUNCTION historial_usuario(
        p_id_usuario IN Calificaciones.Id_usuario%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Modificar estrellas de una calificación existente
    PROCEDURE modificar_calificacion(
        p_id_calificacion IN Calificaciones.Id_calificacion%TYPE,
        p_nuevas_estrellas IN Calificaciones.estrellas%TYPE
    );

    -- Eliminar una calificación por ID
    PROCEDURE eliminar_calificacion(
        p_id_calificacion IN Calificaciones.Id_calificacion%TYPE
    );

END PKG_CALIFICACIONES;
/

-- Verificar creación de especificaciones
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type = 'PACKAGE'
  AND object_name IN ('PKG_USUARIOS', 'PKG_CONTENIDO', 'PKG_CALIFICACIONES')
ORDER BY object_name;


-- =====================================================
-- SECCIÓN 25: IMPLEMENTACIÓN DE PAQUETES (CRUDI)
-- =====================================================

-- -----------------------------------------------------
-- CUERPO PAQUETE 1: PKG_USUARIOS
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_USUARIOS AS

    -- Agregar un nuevo usuario
    PROCEDURE agregar_usuario(
        p_id_usuario      IN USUARIOS.Id_usuario%TYPE,
        p_email           IN USUARIOS.Email%TYPE,
        p_fecha_registro  IN USUARIOS.Fecha_registro%TYPE,
        p_fecha_nac       IN USUARIOS.fecha_nacimiento%TYPE
    ) IS
    BEGIN
        INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
        VALUES (p_id_usuario, p_email, p_fecha_registro, p_fecha_nac);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Usuario ' || p_id_usuario || ' agregado correctamente.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Ya existe un usuario con el ID o email proporcionado.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al agregar usuario: ' || SQLERRM);
    END agregar_usuario;

    -- Consultar un usuario por ID
    PROCEDURE consultar_usuario(
        p_id_usuario      IN  USUARIOS.Id_usuario%TYPE,
        p_email           OUT USUARIOS.Email%TYPE,
        p_fecha_registro  OUT USUARIOS.Fecha_registro%TYPE,
        p_fecha_nac       OUT USUARIOS.fecha_nacimiento%TYPE
    ) IS
    BEGIN
        SELECT Email, Fecha_registro, fecha_nacimiento
        INTO p_email, p_fecha_registro, p_fecha_nac
        FROM USUARIOS
        WHERE Id_usuario = p_id_usuario;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el usuario ' || p_id_usuario || '.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR al consultar usuario: ' || SQLERRM);
    END consultar_usuario;

    -- Listar todos los usuarios
    FUNCTION listar_usuarios
        RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT Id_usuario, Email, Fecha_registro, fecha_nacimiento
            FROM USUARIOS
            ORDER BY Fecha_registro DESC;
        RETURN v_cursor;
    END listar_usuarios;

    -- Modificar email de un usuario
    PROCEDURE modificar_email(
        p_id_usuario  IN USUARIOS.Id_usuario%TYPE,
        p_nuevo_email IN USUARIOS.Email%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM USUARIOS WHERE Id_usuario = p_id_usuario;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el usuario ' || p_id_usuario || '.');
        ELSE
            UPDATE USUARIOS
            SET Email = p_nuevo_email
            WHERE Id_usuario = p_id_usuario;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Email del usuario ' || p_id_usuario || ' actualizado correctamente.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al modificar usuario: ' || SQLERRM);
    END modificar_email;

    -- Eliminar un usuario por ID
    PROCEDURE eliminar_usuario(
        p_id_usuario IN USUARIOS.Id_usuario%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM USUARIOS WHERE Id_usuario = p_id_usuario;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el usuario ' || p_id_usuario || '.');
        ELSE
            DELETE FROM USUARIOS WHERE Id_usuario = p_id_usuario;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Usuario ' || p_id_usuario || ' eliminado. Reseñas y calificaciones conservadas de forma anónima.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al eliminar usuario: ' || SQLERRM);
    END eliminar_usuario;

END PKG_USUARIOS;
/

-- -----------------------------------------------------
-- CUERPO PAQUETE 2: PKG_CONTENIDO
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_CONTENIDO AS

    -- Agregar película
    PROCEDURE agregar_pelicula(
        p_id_content    IN CONTENIDO.Id_content%TYPE,
        p_nombre        IN CONTENIDO.nombre%TYPE,
        p_anno_estreno  IN CONTENIDO.Año_estreno%TYPE,
        p_duracion      IN CONTENIDO.duracion%TYPE,
        p_pais          IN CONTENIDO.pais%TYPE,
        p_genero        IN CONTENIDO.genero%TYPE,
        p_sinopsis      IN CONTENIDO.sinopsis%TYPE,
        p_clasificacion IN CONTENIDO.Clasificacion%TYPE,
        p_etiqueta      IN CONTENIDO.nombre_etiqueta%TYPE,
        p_presupuesto   IN PELICULA.presupuesto%TYPE,
        p_recaudacion   IN PELICULA.recaudacion%TYPE
    ) IS
    BEGIN
        INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
        VALUES (p_id_content, p_nombre, p_anno_estreno, p_duracion, p_pais, p_genero, p_sinopsis, p_clasificacion, p_etiqueta);

        INSERT INTO PELICULA (Id_content, presupuesto, recaudacion)
        VALUES (p_id_content, p_presupuesto, p_recaudacion);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Película ' || p_nombre || ' agregada correctamente.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Ya existe contenido con el ID ' || p_id_content || '.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al agregar película: ' || SQLERRM);
    END agregar_pelicula;

    -- Agregar serie
    PROCEDURE agregar_serie(
        p_id_content    IN CONTENIDO.Id_content%TYPE,
        p_nombre        IN CONTENIDO.nombre%TYPE,
        p_anno_estreno  IN CONTENIDO.Año_estreno%TYPE,
        p_duracion      IN CONTENIDO.duracion%TYPE,
        p_pais          IN CONTENIDO.pais%TYPE,
        p_genero        IN CONTENIDO.genero%TYPE,
        p_sinopsis      IN CONTENIDO.sinopsis%TYPE,
        p_clasificacion IN CONTENIDO.Clasificacion%TYPE,
        p_etiqueta      IN CONTENIDO.nombre_etiqueta%TYPE,
        p_temporadas    IN SERIE.temporadas%TYPE,
        p_episodios     IN SERIE.episodios%TYPE,
        p_show_runner   IN SERIE.show_runner%TYPE
    ) IS
    BEGIN
        INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
        VALUES (p_id_content, p_nombre, p_anno_estreno, p_duracion, p_pais, p_genero, p_sinopsis, p_clasificacion, p_etiqueta);

        INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner)
        VALUES (p_id_content, p_temporadas, p_episodios, p_show_runner);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Serie ' || p_nombre || ' agregada correctamente.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Ya existe contenido con el ID ' || p_id_content || '.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al agregar serie: ' || SQLERRM);
    END agregar_serie;

    -- Consultar contenido por ID
    PROCEDURE consultar_contenido(
        p_id_content    IN  CONTENIDO.Id_content%TYPE,
        p_nombre        OUT CONTENIDO.nombre%TYPE,
        p_anno_estreno  OUT CONTENIDO.Año_estreno%TYPE,
        p_genero        OUT CONTENIDO.genero%TYPE,
        p_pais          OUT CONTENIDO.pais%TYPE,
        p_clasificacion OUT CONTENIDO.Clasificacion%TYPE
    ) IS
    BEGIN
        SELECT nombre, Año_estreno, genero, pais, Clasificacion
        INTO p_nombre, p_anno_estreno, p_genero, p_pais, p_clasificacion
        FROM CONTENIDO
        WHERE Id_content = p_id_content;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el contenido ' || p_id_content || '.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR al consultar contenido: ' || SQLERRM);
    END consultar_contenido;

    -- Listar por género
    FUNCTION listar_por_genero(
        p_genero IN CONTENIDO.genero%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT Id_content, nombre, Año_estreno, pais, Clasificacion
            FROM CONTENIDO
            WHERE genero = p_genero
            ORDER BY Año_estreno DESC;
        RETURN v_cursor;
    END listar_por_genero;

    -- Modificar sinopsis y clasificación
    PROCEDURE modificar_contenido(
        p_id_content          IN CONTENIDO.Id_content%TYPE,
        p_nueva_sinopsis       IN CONTENIDO.sinopsis%TYPE,
        p_nueva_clasificacion  IN CONTENIDO.Clasificacion%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM CONTENIDO WHERE Id_content = p_id_content;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el contenido ' || p_id_content || '.');
        ELSE
            UPDATE CONTENIDO
            SET sinopsis       = p_nueva_sinopsis,
                Clasificacion  = p_nueva_clasificacion
            WHERE Id_content = p_id_content;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Contenido ' || p_id_content || ' modificado correctamente.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al modificar contenido: ' || SQLERRM);
    END modificar_contenido;

    -- Eliminar contenido
    PROCEDURE eliminar_contenido(
        p_id_content IN CONTENIDO.Id_content%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM CONTENIDO WHERE Id_content = p_id_content;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe el contenido ' || p_id_content || '.');
        ELSE
            DELETE FROM CONTENIDO WHERE Id_content = p_id_content;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Contenido ' || p_id_content || ' eliminado. Dependencias eliminadas en cascada.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al eliminar contenido: ' || SQLERRM);
    END eliminar_contenido;

END PKG_CONTENIDO;
/

-- -----------------------------------------------------
-- CUERPO PAQUETE 3: PKG_CALIFICACIONES
-- -----------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PKG_CALIFICACIONES AS

    -- Registrar calificación
    PROCEDURE agregar_calificacion(
        p_id_calificacion  IN Calificaciones.Id_calificacion%TYPE,
        p_id_usuario       IN Calificaciones.Id_usuario%TYPE,
        p_id_content       IN Calificaciones.Id_content%TYPE,
        p_estrellas        IN Calificaciones.estrellas%TYPE,
        p_fecha            IN Calificaciones.fecha_calificacion%TYPE
    ) IS
    BEGIN
        INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
        VALUES (p_id_calificacion, p_id_usuario, p_id_content, p_estrellas, p_fecha);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Calificación ' || p_id_calificacion || ' registrada correctamente.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR: Ya existe una calificación con ese ID.');
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al registrar calificación: ' || SQLERRM);
    END agregar_calificacion;

    -- Consultar calificaciones de un contenido
    FUNCTION consultar_por_contenido(
        p_id_content IN Calificaciones.Id_content%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT
                cal.Id_calificacion,
                cal.Id_usuario,
                cal.estrellas,
                cal.fecha_calificacion,
                ROUND(AVG(cal.estrellas) OVER (PARTITION BY cal.Id_content), 2) AS promedio_contenido
            FROM Calificaciones cal
            WHERE cal.Id_content = p_id_content
            ORDER BY cal.fecha_calificacion DESC;
        RETURN v_cursor;
    END consultar_por_contenido;

    -- Historial de calificaciones de un usuario
    FUNCTION historial_usuario(
        p_id_usuario IN Calificaciones.Id_usuario%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT
                cal.Id_calificacion,
                cal.Id_content,
                c.nombre AS nombre_contenido,
                cal.estrellas,
                cal.fecha_calificacion
            FROM Calificaciones cal
            LEFT JOIN CONTENIDO c ON cal.Id_content = c.Id_content
            WHERE cal.Id_usuario = p_id_usuario
            ORDER BY cal.fecha_calificacion DESC;
        RETURN v_cursor;
    END historial_usuario;

    -- Modificar estrellas
    PROCEDURE modificar_calificacion(
        p_id_calificacion  IN Calificaciones.Id_calificacion%TYPE,
        p_nuevas_estrellas IN Calificaciones.estrellas%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM Calificaciones WHERE Id_calificacion = p_id_calificacion;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe la calificación ' || p_id_calificacion || '.');
        ELSE
            UPDATE Calificaciones
            SET estrellas = p_nuevas_estrellas
            WHERE Id_calificacion = p_id_calificacion;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Calificación ' || p_id_calificacion || ' actualizada a ' || p_nuevas_estrellas || ' estrellas.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al modificar calificación: ' || SQLERRM);
    END modificar_calificacion;

    -- Eliminar calificación
    PROCEDURE eliminar_calificacion(
        p_id_calificacion IN Calificaciones.Id_calificacion%TYPE
    ) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count
        FROM Calificaciones WHERE Id_calificacion = p_id_calificacion;

        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: No existe la calificación ' || p_id_calificacion || '.');
        ELSE
            DELETE FROM Calificaciones WHERE Id_calificacion = p_id_calificacion;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Calificación ' || p_id_calificacion || ' eliminada correctamente.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERROR al eliminar calificación: ' || SQLERRM);
    END eliminar_calificacion;

END PKG_CALIFICACIONES;
/

-- Verificar compilación de cuerpos
SELECT object_name, object_type, status
FROM user_objects
WHERE object_type = 'PACKAGE BODY'
  AND object_name IN ('PKG_USUARIOS', 'PKG_CONTENIDO', 'PKG_CALIFICACIONES')
ORDER BY object_name;


-- =====================================================
-- SECCIÓN 26: PRUEBAS VÁLIDAS DE PAQUETES (CRUDOK)
-- =====================================================

-- Activar salida de mensajes
SET SERVEROUTPUT ON;

-- -------------------------------------------------------
-- PRUEBAS PKG_USUARIOS
-- -------------------------------------------------------

-- OK-U1: Agregar usuario válido (25 años al registrarse)
EXEC PKG_USUARIOS.agregar_usuario('user_p01', 'pedro_pkg@example.com', DATE '2023-05-10', DATE '1998-02-14');

-- OK-U2: Consultar usuario recién creado
DECLARE
    v_email          USUARIOS.Email%TYPE;
    v_fecha_reg      USUARIOS.Fecha_registro%TYPE;
    v_fecha_nac      USUARIOS.fecha_nacimiento%TYPE;
BEGIN
    PKG_USUARIOS.consultar_usuario('user_p01', v_email, v_fecha_reg, v_fecha_nac);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Fecha registro: ' || TO_CHAR(v_fecha_reg, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Fecha nacimiento: ' || TO_CHAR(v_fecha_nac, 'DD/MM/YYYY'));
END;
/

-- OK-U3: Modificar email
EXEC PKG_USUARIOS.modificar_email('user_p01', 'pedro_nuevo@example.com');

-- OK-U4: Eliminar usuario (reseñas y calificaciones quedan anónimas)
EXEC PKG_USUARIOS.eliminar_usuario('user_p01');


-- -------------------------------------------------------
-- PRUEBAS PKG_CONTENIDO
-- -------------------------------------------------------

-- OK-C1: Agregar película válida
EXEC PKG_CONTENIDO.agregar_pelicula(
    'cont_p01', 'El Gran Lebowski', 1998, 117,
    'USA', 'Comedia',
    'Un hombre confundido con otro se ve envuelto en un caso de secuestro.',
    'R', 'cult',
    15000000, 46200000
);

-- OK-C2: Agregar serie válida
EXEC PKG_CONTENIDO.agregar_serie(
    'cont_p02', 'Severance', 2022, 52,
    'USA', 'Drama',
    'Trabajadores se someten a un procedimiento que separa sus memorias laborales de las personales.',
    'TV-MA', 'distopia',
    3, 19, 'Dan Erickson'
);

-- OK-C3: Consultar contenido
DECLARE
    v_nombre   CONTENIDO.nombre%TYPE;
    v_anno     CONTENIDO.Año_estreno%TYPE;
    v_genero   CONTENIDO.genero%TYPE;
    v_pais     CONTENIDO.pais%TYPE;
    v_clasif   CONTENIDO.Clasificacion%TYPE;
BEGIN
    PKG_CONTENIDO.consultar_contenido('cont_p01', v_nombre, v_anno, v_genero, v_pais, v_clasif);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Año: ' || v_anno || ' | Género: ' || v_genero);
    DBMS_OUTPUT.PUT_LINE('País: ' || v_pais || ' | Clasificación: ' || v_clasif);
END;
/

-- OK-C4: Modificar contenido
EXEC PKG_CONTENIDO.modificar_contenido(
    'cont_p01',
    'Un hombre apodado "El Nota" se ve involucrado en un enredo tras el robo de su alfombra.',
    'R'
);

-- OK-C5: Eliminar contenido
EXEC PKG_CONTENIDO.eliminar_contenido('cont_p02');


-- -------------------------------------------------------
-- PRUEBAS PKG_CALIFICACIONES
-- -------------------------------------------------------

-- Datos de apoyo
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
VALUES ('user_p02', 'lucia_pkg@example.com', DATE '2022-01-15', DATE '1996-09-30');
COMMIT;

-- OK-CA1: Agregar calificación válida
EXEC PKG_CALIFICACIONES.agregar_calificacion('calif_p01', 'user_p02', 'cont_p01', 4, SYSDATE);

-- OK-CA2: Modificar calificación
EXEC PKG_CALIFICACIONES.modificar_calificacion('calif_p01', 5);

-- OK-CA3: Eliminar calificación
EXEC PKG_CALIFICACIONES.eliminar_calificacion('calif_p01');

-- Limpieza datos de apoyo
EXEC PKG_USUARIOS.eliminar_usuario('user_p02');
EXEC PKG_CONTENIDO.eliminar_contenido('cont_p01');

COMMIT;


-- =====================================================
-- SECCIÓN 27: PRUEBAS INVÁLIDAS DE PAQUETES (CRUDNoOK)
-- =====================================================

-- NoOK-U1: Agregar usuario menor de 13 años (falla por trigger trg_validar_edad_registro)
-- EXEC PKG_USUARIOS.agregar_usuario('user_nok_p1', 'menor_pkg@example.com', DATE '2024-01-01', DATE '2015-06-20');
-- ERROR ESPERADO: ORA-20001 - El usuario debe tener al menos 13 años.

-- NoOK-U2: Agregar usuario con email duplicado (falla por UNIQUE Email)
-- EXEC PKG_USUARIOS.agregar_usuario('user_nok_p2', 'esteban@example.com', DATE '2022-01-01', DATE '1995-03-10');
-- ERROR ESPERADO: ERROR: Ya existe un usuario con el ID o email proporcionado.

-- NoOK-U3: Consultar usuario inexistente
-- DECLARE
--     v_email     USUARIOS.Email%TYPE;
--     v_freg      USUARIOS.Fecha_registro%TYPE;
--     v_fnac      USUARIOS.fecha_nacimiento%TYPE;
-- BEGIN
--     PKG_USUARIOS.consultar_usuario('user_inexistente', v_email, v_freg, v_fnac);
-- END;
-- /
-- ERROR ESPERADO: ERROR: No existe el usuario user_inexistente.

-- NoOK-C1: Agregar película con año anterior a 1895 (falla por trigger trg_anno_estreno_valido)
-- EXEC PKG_CONTENIDO.agregar_pelicula(
--     'cont_nok_p1', 'Película Imposible', 1800, 90,
--     'Francia', 'Drama', 'Una sinopsis cualquiera.', 'NR', 'test',
--     0, 0
-- );
-- ERROR ESPERADO: ORA-20006 - El año de estreno debe estar entre 1895 y el año actual.

-- NoOK-C2: Agregar serie con episodios menores que temporadas (falla por chk_episodios_vs_temporadas)
-- EXEC PKG_CONTENIDO.agregar_serie(
--     'cont_nok_p2', 'Serie Inválida', 2020, 45,
--     'USA', 'Drama', 'Sinopsis de prueba.', 'TV-14', 'test',
--     10, 3, 'Test Runner'
-- );
-- ERROR ESPERADO: ORA-02290 - check constraint (chk_episodios_vs_temporadas) violated.

-- NoOK-CA1: Calificación duplicada (falla por trigger trg_una_calificacion_por_contenido)
-- (Requiere que calif_001 ya exista: user_001 calificó cont_002)
-- EXEC PKG_CALIFICACIONES.agregar_calificacion('calif_nok_p1', 'user_001', 'cont_002', 3, SYSDATE);
-- ERROR ESPERADO: ORA-20007 - El usuario ya registró una calificación para este contenido.

-- NoOK-CA2: Calificación con estrellas fuera de rango (falla por chk_estrellas)
-- EXEC PKG_CALIFICACIONES.agregar_calificacion('calif_nok_p2', 'user_003', 'cont_001', 7, SYSDATE);
-- ERROR ESPERADO: ORA-02290 - check constraint (chk_estrellas) violated.

-- NoOK-CA3: Modificar calificación inexistente
-- EXEC PKG_CALIFICACIONES.modificar_calificacion('calif_inexistente', 4);
-- ERROR ESPERADO: ERROR: No existe la calificación calif_inexistente.

COMMIT;


-- =====================================================
-- SECCIÓN 28: ELIMINACIÓN DE PAQUETES (XCRUD)
-- =====================================================

-- DROP PACKAGE PKG_USUARIOS;
-- DROP PACKAGE PKG_CONTENIDO;
-- DROP PACKAGE PKG_CALIFICACIONES;

-- Verificar eliminación (debe retornar 0 filas)
-- SELECT object_name, object_type, status
-- FROM user_objects
-- WHERE object_type IN ('PACKAGE', 'PACKAGE BODY')
--   AND object_name IN ('PKG_USUARIOS', 'PKG_CONTENIDO', 'PKG_CALIFICACIONES')
-- ORDER BY object_name;


 
-- =====================================================
-- FIN DEL SCRIPT EGO_Completo.sql
-- =====================================================
 