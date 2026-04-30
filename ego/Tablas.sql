-- =====================================================
-- EGO - Creación de tablas 
-- Oracle SQL Developer
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