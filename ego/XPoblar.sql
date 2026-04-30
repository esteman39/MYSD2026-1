-- =====================================================
-- EGO - Eliminación de Datos (XPoblar)
-- Oracle SQL Developer
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
