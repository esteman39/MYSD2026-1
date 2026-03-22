-- =====================================================
-- EGO - Definición de Claves Primarias
-- Oracle SQL Developer
-- =====================================================

-- -----------------------------------------------------
-- TABLA: USUARIOS
-- -----------------------------------------------------
ALTER TABLE USUARIOS ADD PRIMARY KEY (Id_usuario);

-- -----------------------------------------------------
-- TABLA: CONTENIDO
-- -----------------------------------------------------
ALTER TABLE CONTENIDO ADD PRIMARY KEY (Id_content);

-- -----------------------------------------------------
-- TABLA: ETIQUETAS
-- -----------------------------------------------------
ALTER TABLE ETIQUETAS ADD PRIMARY KEY (id_etiqueta);

-- -----------------------------------------------------
-- TABLA: LISTA
-- -----------------------------------------------------
ALTER TABLE LISTA ADD PRIMARY KEY (Id_lista);

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO
-- -----------------------------------------------------
ALTER TABLE LISTA_CONTENIDO ADD PRIMARY KEY (Id_lista, id_usuario, Id_content);

-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE
-- -----------------------------------------------------
ALTER TABLE LISTA_PENDIENTE ADD PRIMARY KEY (Id_lista, Id_usuario);

-- -----------------------------------------------------
-- TABLA: Calificaciones
-- -----------------------------------------------------
ALTER TABLE Calificaciones ADD PRIMARY KEY (Id_calificacion);

-- -----------------------------------------------------
-- TABLA: RESEÑAS
-- -----------------------------------------------------
ALTER TABLE RESEÑAS ADD PRIMARY KEY (id_reseña);

-- -----------------------------------------------------
-- TABLA: PERSONAL
-- -----------------------------------------------------
ALTER TABLE PERSONAL ADD PRIMARY KEY (Id_personal);

-- -----------------------------------------------------
-- TABLA: ROL
-- -----------------------------------------------------
ALTER TABLE ROL ADD PRIMARY KEY (Id_rol);

-- -----------------------------------------------------
-- TABLA: PERSONAL_ROL
-- -----------------------------------------------------
ALTER TABLE PERSONAL_ROL ADD PRIMARY KEY (Id_personal, Id_rol);

-- -----------------------------------------------------
-- TABLA: PERSONAL_CONTENIDO
-- -----------------------------------------------------
ALTER TABLE PERSONAL_CONTENIDO ADD PRIMARY KEY (Id_personal, Id_content);

-- -----------------------------------------------------
-- TABLA: SERIE
-- -----------------------------------------------------
ALTER TABLE SERIE ADD PRIMARY KEY (Id_content);

-- -----------------------------------------------------
-- TABLA: PELICULA
-- -----------------------------------------------------
ALTER TABLE PELICULA ADD PRIMARY KEY (Id_content);