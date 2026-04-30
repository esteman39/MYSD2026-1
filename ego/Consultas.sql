-- =====================================================
-- EGO - Consultas para Casos de Uso UML
-- Oracle SQL Developer
-- =====================================================

-- Consulta 1: Consultar las reseñas de un contenido específico
SELECT
    r.id_reseña,
    r.comentario,
    r.fecha_reseña,
    u.Id_usuario,
    r.Id_content
FROM RESEÑAS r
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
WHERE r.Id_content = 'cont_002'   -- Ejemplo: cont_001 --
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
WHERE lp.Id_usuario = 'user_001' -- Ejemplo: user_001 --
  AND lp.estado = 'pendiente'
ORDER BY lp.fecha_agregado DESC;
 
-- Consulta 3: Filtrar contenidos por género, año y país
 
-- Lista de contenidos, paises y años de estreno
 
SELECT genero, pais, Año_estreno
FROM CONTENIDO
ORDER BY genero, pais;
------------------------------------------------
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    c.pais,
    c.sinopsis
FROM CONTENIDO c
WHERE c.genero = 'Acción'
  AND c.Año_estreno BETWEEN 2000 AND 2023
  AND c.pais = 'Australia'
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
ORDER BY promedio_calificacion DESC
FETCH FIRST 10 ROWS ONLY;
 
-- Consulta 5: Recomendaciones más frecuentes (top 10)
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    COUNT(r.id_reseña) AS total_reseñas,
    LISTAGG(u.id_usuario, ', ') WITHIN GROUP (ORDER BY u.id_usuario) AS usuarios_que_recomiendan
FROM CONTENIDO c
JOIN RESEÑAS r ON c.Id_content = r.Id_content
JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
ORDER BY total_reseñas DESC
FETCH FIRST 10 ROWS ONLY;
 
-- Consulta 6: Filmografía de un director o actor específico
 
-- personal para buscar
SELECT * FROM personal;
-----------------------------------------------------------------
SELECT
    c.nombre,
    c.genero,
    c.Año_estreno,
    p.rol
FROM PERSONAL_CONTENIDO pc
JOIN PERSONAL p ON pc.Id_personal = p.Id_personal
JOIN CONTENIDO c ON pc.Id_content = c.Id_content
WHERE p.nombre = 'Christopher Nolan'
  AND p.rol IN ('director', 'actor')
ORDER BY c.Año_estreno DESC, c.nombre;
 