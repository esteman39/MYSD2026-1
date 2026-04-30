-- =====================================================
-- EGO - Definición de Claves Primarias
-- Oracle SQL Developer
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