-- =====================================================
-- EGO - Pruebas de Acciones de Referencia (AccionesOK)
-- Oracle SQL Developer
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

 