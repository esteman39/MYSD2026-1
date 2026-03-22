-- =====================================================
-- EGO - Restricciones de Atributos (CHECK, DEFAULT)
-- Oracle SQL Developer
-- =====================================================

-- -----------------------------------------------------
-- TABLA: USUARIOS
-- -----------------------------------------------------
ALTER TABLE USUARIOS 
    ADD CONSTRAINT chk_email_format CHECK (Email LIKE '%@%.%');

-- -----------------------------------------------------
-- TABLA: CONTENIDO
-- -----------------------------------------------------
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_duracion CHECK (duracion > 0);
ALTER TABLE CONTENIDO       
    ADD CONSTRAINT chk_clasificacion CHECK (Clasificacion IN ('G', 'PG', 'PG-13', 'R', 'NC-17', 'NR'));
ALTER TABLE CONTENIDO
    ADD CONSTRAINT chk_genero_no_vacio CHECK (LENGTH(TRIM(genero)) > 0);

-- -----------------------------------------------------
-- TABLA: ETIQUETAS
-- -----------------------------------------------------
ALTER TABLE ETIQUETAS 
    ADD CONSTRAINT chk_categoria CHECK (categoria IN ('emocion', 'genero', 'momento', 'recomendacion'));
ALTER TABLE ETIQUETAS
    ADD CONSTRAINT chk_nombre_etiqueta_no_vacio CHECK (LENGTH(TRIM(nombre_etiqueta)) > 0);

-- -----------------------------------------------------
-- TABLA: LISTA
-- -----------------------------------------------------
ALTER TABLE LISTA 
    ADD CONSTRAINT chk_esPrivada CHECK (esPrivada IN ('0', '1'));
ALTER TABLE LISTA
    ADD CONSTRAINT chk_Id_lista_no_vacio CHECK (LENGTH(TRIM(Id_lista)) > 0);

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO
-- -----------------------------------------------------
ALTER TABLE LISTA_CONTENIDO 
    ADD CONSTRAINT chk_orden CHECK (orden > 0);
ALTER TABLE LISTA_CONTENIDO
    ADD CONSTRAINT chk_nombre_lista_no_vacio CHECK (LENGTH(TRIM(nombre_lista)) > 0);

-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE
-- -----------------------------------------------------
ALTER TABLE LISTA_PENDIENTE 
    ADD CONSTRAINT chk_estado CHECK (estado IN ('pendiente', 'visto', 'en_progreso'));

-- -----------------------------------------------------
-- TABLA: Calificaciones
-- -----------------------------------------------------
ALTER TABLE Calificaciones 
    ADD CONSTRAINT chk_estrellas CHECK (estrellas BETWEEN 1 AND 5);

-- -----------------------------------------------------
-- TABLA: RESEÑAS
-- -----------------------------------------------------

ALTER TABLE RESEÑAS
    ADD CONSTRAINT chk_comentario_no_vacio CHECK (LENGTH(TRIM(comentario)) > 0);

-- -----------------------------------------------------
-- TABLA: PERSONAL
-- -----------------------------------------------------
ALTER TABLE PERSONAL 
    ADD CONSTRAINT chk_rol CHECK (rol IN ('actor', 'director', 'guionista', 'productor', 'sonidista'));
ALTER TABLE PERSONAL
    ADD CONSTRAINT chk_nombre_personal_no_vacio CHECK (LENGTH(TRIM(nombre)) > 0);

-- -----------------------------------------------------
-- TABLA: ROL
-- -----------------------------------------------------
ALTER TABLE ROL 
    ADD CONSTRAINT chk_nombre_rol_no_vacio CHECK (LENGTH(TRIM(nombre_rol)) > 0);

-- -----------------------------------------------------
-- TABLA: SERIE
-- -----------------------------------------------------
ALTER TABLE SERIE 
    ADD CONSTRAINT chk_temporadas CHECK (temporadas > 0);
ALTER TABLE SERIE
    ADD CONSTRAINT chk_episodios CHECK (episodios > 0);
ALTER TABLE SERIE
    ADD CONSTRAINT chk_show_runner_no_vacio CHECK (LENGTH(TRIM(show_runner)) > 0);

-- -----------------------------------------------------
-- TABLA: PELICULA
-- -----------------------------------------------------
ALTER TABLE PELICULA 
    ADD CONSTRAINT chk_presupuesto CHECK (presupuesto >= 0);

ALTER TABLE PELICULA
    ADD CONSTRAINT chk_recaudacion CHECK (recaudacion >= 0);