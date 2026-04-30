
-- =====================================================
-- EGO - Acciones de Referencia (Acciones)
-- Oracle SQL Developer
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
 