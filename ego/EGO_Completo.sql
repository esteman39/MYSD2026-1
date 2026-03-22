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
    Id_usuario VARCHAR(20),
    Email VARCHAR(255) NOT NULL,
    Fecha_registro DATE NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

-- -----------------------------------------------------
-- TABLA: CONTENIDO
-- -----------------------------------------------------
CREATE TABLE CONTENIDO(
    Id_content VARCHAR(255),
    nombre VARCHAR(255) NOT NULL,
    Año_estreno INTEGER NOT NULL,
    duracion INTEGER NOT NULL,
    pais VARCHAR(100) NOT NULL,
    genero VARCHAR(100) NOT NULL,
    sinopsis VARCHAR2(120) NOT NULL,
    Clasificacion VARCHAR(100) NOT NULL,
    nombre_etiqueta VARCHAR(20) NOT NULL
);

-- -----------------------------------------------------
-- TABLA: ETIQUETAS
-- -----------------------------------------------------
CREATE TABLE ETIQUETAS(
    id_usuario VARCHAR(20) NOT NULL,
    id_etiqueta VARCHAR(50) NOT NULL,
    nombre_etiqueta VARCHAR(20) NOT NULL,
    categoria VARCHAR(20) NOT NULL
);

-- -----------------------------------------------------
-- TABLA: LISTA
-- -----------------------------------------------------
CREATE TABLE LISTA(
    Id_lista VARCHAR(255) NOT NULL,
    Id_usuario VARCHAR(20) NOT NULL,
    esPrivada CHAR(1) NOT NULL
);

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO
-- -----------------------------------------------------
CREATE TABLE LISTA_CONTENIDO(
    Id_lista VARCHAR(255) NOT NULL,
    id_usuario VARCHAR(20) NOT NULL,
    nombre_lista VARCHAR(255) NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    orden INTEGER NOT NULL,
    fecha_agregado DATE NOT NULL,
    Id_content VARCHAR(255) NOT NULL
);

-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE
-- -----------------------------------------------------
CREATE TABLE LISTA_PENDIENTE(
    Id_lista VARCHAR(255) NOT NULL,
    Id_usuario VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_agregado DATE NOT NULL
);

-- -----------------------------------------------------
-- TABLA: Calificaciones
-- -----------------------------------------------------
CREATE TABLE Calificaciones(
    Id_calificacion VARCHAR(255) NOT NULL,
    Id_usuario VARCHAR(20) NOT NULL,
    Id_content VARCHAR(255) NOT NULL,
    estrellas NUMBER(5) NOT NULL,
    fecha_calificacion DATE NOT NULL
);

-- -----------------------------------------------------
-- TABLA: RESEÑAS
-- -----------------------------------------------------
CREATE TABLE RESEÑAS(
    id_reseña VARCHAR(255) NOT NULL,
    Id_usuario VARCHAR(20) NOT NULL,
    Id_content VARCHAR(255) NOT NULL,
    comentario VARCHAR2(250) NOT NULL,
    fecha_reseña DATE NOT NULL
);

-- -----------------------------------------------------
-- TABLA: PERSONAL
-- -----------------------------------------------------
CREATE TABLE PERSONAL (
    Id_personal VARCHAR(255) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    contenidos VARCHAR(255) NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    nacionalidad VARCHAR(100) NOT NULL
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
    Id_content VARCHAR(255) NOT NULL,
    temporadas INTEGER NOT NULL,
    episodios INTEGER NOT NULL,
    show_runner VARCHAR(255) NOT NULL
);

-- -----------------------------------------------------
-- TABLA: PELICULA
-- -----------------------------------------------------
CREATE TABLE PELICULA(
    Id_content VARCHAR(255) NOT NULL,
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
    ADD CONSTRAINT chk_clasificacion CHECK (Clasificacion IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR'));
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_genero_no_vacio CHECK (LENGTH(TRIM(genero)) > 0);

-- ETIQUETAS
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT chk_categoria CHECK (categoria IN ('emocion', 'genero', 'momento', 'recomendacion'));
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT chk_nombre_etiqueta_no_vacio CHECK (LENGTH(TRIM(nombre_etiqueta)) > 0);

-- LISTA
ALTER TABLE LISTA
    ADD CONSTRAINT chk_esPrivada CHECK (esPrivada IN ('0', '1'));
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
    u.nombre AS usuario_nombre
FROM RESEÑAS r
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
WHERE r.Id_content = 'ID_DEL_CONTENIDO_ESPECIFICO'
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
WHERE lp.Id_usuario = 'ID_DEL_USUARIO'
  AND lp.estado = 'pendiente'
ORDER BY lp.fecha_agregado DESC;

-- Consulta 3: Filtrar contenidos por género, año y país
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    c.sinopsis
FROM CONTENIDO c
WHERE c.genero = 'GENERO_ESPECIFICO'
  AND c.Año_estreno BETWEEN 2000 AND 2023
  AND c.pais = 'PAIS_ESPECIFICO'
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
HAVING COUNT(cal.Id_calificacion) >= 3
ORDER BY promedio_calificacion DESC
FETCH FIRST 10 ROWS ONLY;

-- Consulta 5: Recomendaciones más frecuentes (top 10)
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    COUNT(r.id_reseña) AS total_reseñas,
    LISTAGG(u.nombre, ', ') WITHIN GROUP (ORDER BY u.nombre) AS usuarios_que_recomiendan
FROM CONTENIDO c
JOIN RESEÑAS r ON c.Id_content = r.Id_content
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
ORDER BY total_reseñas DESC
FETCH FIRST 10 ROWS ONLY;

-- Consulta 6: Filmografía de un director o actor específico
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    p.rol
FROM PERSONAL_CONTENIDO pc
JOIN PERSONAL p ON pc.Id_personal = p.Id_personal
JOIN CONTENIDO c ON pc.Id_content = c.Id_content
WHERE p.nombre = 'NOMBRE_DEL_DIRECTOR_O_ACTOR'
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
-- FIN DEL SCRIPT EGO_Completo.sql
-- =====================================================
