-- =====================================================
-- EGO - Definición de Claves Foráneas
-- Oracle SQL Developer
-- =====================================================

-- -----------------------------------------------------
-- TABLA: ETIQUETAS → USUARIOS
-- -----------------------------------------------------
ALTER TABLE ETIQUETAS 
    ADD CONSTRAINT fk_etiquetas_usuario 
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA → USUARIOS
-- -----------------------------------------------------
ALTER TABLE LISTA 
    ADD CONSTRAINT fk_lista_usuario 
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO → LISTA
-- -----------------------------------------------------
ALTER TABLE LISTA_CONTENIDO 
    ADD CONSTRAINT fk_lista_contenido_lista 
    FOREIGN KEY (Id_lista) REFERENCES LISTA(Id_lista) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO → USUARIOS
-- -----------------------------------------------------
ALTER TABLE LISTA_CONTENIDO 
    ADD CONSTRAINT fk_lista_contenido_usuario 
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA_CONTENIDO → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE LISTA_CONTENIDO 
    ADD CONSTRAINT fk_lista_contenido_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE → LISTA
-- -----------------------------------------------------
ALTER TABLE LISTA_PENDIENTE 
    ADD CONSTRAINT fk_lista_pendiente_lista 
    FOREIGN KEY (Id_lista) REFERENCES LISTA(Id_lista) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: LISTA_PENDIENTE → USUARIOS
-- -----------------------------------------------------
ALTER TABLE LISTA_PENDIENTE 
    ADD CONSTRAINT fk_lista_pendiente_usuario 
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: Calificaciones → USUARIOS
-- -----------------------------------------------------
ALTER TABLE Calificaciones 
    ADD CONSTRAINT fk_calificaciones_usuario 
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: Calificaciones → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE Calificaciones 
    ADD CONSTRAINT fk_calificaciones_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: RESEÑAS → USUARIOS
-- -----------------------------------------------------
ALTER TABLE RESEÑAS 
    ADD CONSTRAINT fk_resenas_usuario 
    FOREIGN KEY (Id_usuario) REFERENCES USUARIOS(Id_usuario) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: RESEÑAS → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE RESEÑAS 
    ADD CONSTRAINT fk_resenas_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: PERSONAL_ROL → PERSONAL
-- -----------------------------------------------------
ALTER TABLE PERSONAL_ROL 
    ADD CONSTRAINT fk_personal_rol_personal 
    FOREIGN KEY (Id_personal) REFERENCES PERSONAL(Id_personal) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: PERSONAL_ROL → ROL
-- -----------------------------------------------------
ALTER TABLE PERSONAL_ROL 
    ADD CONSTRAINT fk_personal_rol_rol 
    FOREIGN KEY (Id_rol) REFERENCES ROL(Id_rol) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: PERSONAL_CONTENIDO → PERSONAL
-- -----------------------------------------------------
ALTER TABLE PERSONAL_CONTENIDO 
    ADD CONSTRAINT fk_personal_contenido_personal 
    FOREIGN KEY (Id_personal) REFERENCES PERSONAL(Id_personal) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: PERSONAL_CONTENIDO → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE PERSONAL_CONTENIDO 
    ADD CONSTRAINT fk_personal_contenido_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: SERIE → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE SERIE 
    ADD CONSTRAINT fk_serie_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;

-- -----------------------------------------------------
-- TABLA: PELICULA → CONTENIDO
-- -----------------------------------------------------
ALTER TABLE PELICULA 
    ADD CONSTRAINT fk_pelicula_contenido 
    FOREIGN KEY (Id_content) REFERENCES CONTENIDO(Id_content) ON DELETE CASCADE;



