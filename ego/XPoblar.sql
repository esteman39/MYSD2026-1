-- =====================================================
-- EGO - Eliminación de Datos (XPoblar)
-- Oracle SQL Developer
-- =====================================================

-- =====================================================
-- 1. ELIMINAR DATOS DE TABLAS HIJAS (CASCADE se encargará del resto)
-- =====================================================

-- Eliminar todas las calificaciones de un usuario específico
DELETE FROM Calificaciones WHERE Id_usuario = 'user_001';

-- Eliminar todas las reseñas de un usuario específico
DELETE FROM RESEÑAS WHERE Id_usuario = 'user_001';

-- Eliminar todas las entradas de LISTA_CONTENIDO de un usuario
DELETE FROM LISTA_CONTENIDO WHERE id_usuario = 'user_001';

-- Eliminar todas las LISTA_PENDIENTE de un usuario
DELETE FROM LISTA_PENDIENTE WHERE Id_usuario = 'user_001';

-- Eliminar todas las ETIQUETAS de un usuario
DELETE FROM ETIQUETAS WHERE id_usuario = 'user_001';

-- Eliminar todas las LISTAS de un usuario
DELETE FROM LISTA WHERE Id_usuario = 'user_001';

-- =====================================================
-- 2. ELIMINAR DATOS DE TABLAS INTERMEDIAS
-- =====================================================

-- Eliminar todas las relaciones PERSONAL_CONTENIDO de un contenido
DELETE FROM PERSONAL_CONTENIDO WHERE Id_content = 'cont_001';

-- Eliminar todas las relaciones PERSONAL_ROL de un personal
DELETE FROM PERSONAL_ROL WHERE Id_personal = 'pers_001';

-- =====================================================
-- 3. ELIMINAR DATOS DE TABLAS PADRES
-- =====================================================

-- Eliminar un usuario específico (CASCADE eliminará dependencias)
DELETE FROM USUARIOS WHERE Id_usuario = 'user_005';

-- Eliminar un contenido específico (CASCADE eliminará dependencias)
DELETE FROM CONTENIDO WHERE Id_content = 'cont_010';

-- Eliminar un personal específico (CASCADE eliminará dependencias)
DELETE FROM PERSONAL WHERE Id_personal = 'pers_005';

-- =====================================================
-- 4. ELIMINAR TODOS LOS DATOS (LIMPIEZA COMPLETA)
-- =====================================================

-- NOTA: Ejecutar en orden inverso de dependencias

-- Eliminar todas las calificaciones
DELETE FROM Calificaciones;

-- Eliminar todas las reseñas
DELETE FROM RESEÑAS;

-- Eliminar todas las entradas de LISTA_CONTENIDO
DELETE FROM LISTA_CONTENIDO;

-- Eliminar todas las LISTA_PENDIENTE
DELETE FROM LISTA_PENDIENTE;

-- Eliminar todas las ETIQUETAS
DELETE FROM ETIQUETAS;

-- Eliminar todas las LISTAS
DELETE FROM LISTA;

-- Eliminar todas las relaciones PERSONAL_CONTENIDO
DELETE FROM PERSONAL_CONTENIDO;

-- Eliminar todas las relaciones PERSONAL_ROL
DELETE FROM PERSONAL_ROL;

-- Eliminar todas las SERIES
DELETE FROM SERIE;

-- Eliminar todas las PELICULAS
DELETE FROM PELICULA;

-- Eliminar todo el PERSONAL
DELETE FROM PERSONAL;

-- Eliminar todos los ROLES
DELETE FROM ROL;

-- Eliminar todo el CONTENIDO
DELETE FROM CONTENIDO;

-- Eliminar todos los USUARIOS
DELETE FROM USUARIOS;

COMMIT;

-- =====================================================
-- VERIFICACIÓN: Contar registros restantes
-- =====================================================
SELECT 'USUARIOS' AS tabla, COUNT(*) AS registros FROM USUARIOS
UNION ALL
SELECT 'CONTENIDO', COUNT(*) FROM CONTENIDO
UNION ALL
SELECT 'ETIQUETAS', COUNT(*) FROM ETIQUETAS
UNION ALL
SELECT 'LISTA', COUNT(*) FROM LISTA
UNION ALL
SELECT 'LISTA_CONTENIDO', COUNT(*) FROM LISTA_CONTENIDO
UNION ALL
SELECT 'LISTA_PENDIENTE', COUNT(*) FROM LISTA_PENDIENTE
UNION ALL
SELECT 'Calificaciones', COUNT(*) FROM Calificaciones
UNION ALL
SELECT 'RESEÑAS', COUNT(*) FROM RESEÑAS
UNION ALL
SELECT 'PERSONAL', COUNT(*) FROM PERSONAL
UNION ALL
SELECT 'ROL', COUNT(*) FROM ROL
UNION ALL
SELECT 'PERSONAL_ROL', COUNT(*) FROM PERSONAL_ROL
UNION ALL
SELECT 'PERSONAL_CONTENIDO', COUNT(*) FROM PERSONAL_CONTENIDO
UNION ALL
SELECT 'SERIE', COUNT(*) FROM SERIE
UNION ALL
SELECT 'PELICULA', COUNT(*) FROM PELICULA;