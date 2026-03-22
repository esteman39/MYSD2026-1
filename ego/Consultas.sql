-- =====================================================
-- EGO - Consultas para Casos de Uso UML
-- Oracle SQL Developer
-- =====================================================

-- Consulta 1: Consultar las reseñas del contenido
SELECT 
     r.id_reseña,
     r.comentario,
     r.fecha_reseña,
     u.Id_usuario,
     u.nombre AS usuario_nombre
 FROM RESEÑAS r
 JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
 WHERE r.Id_content = 'ID_DEL_CONTENIDO_ESPECIFICO'
 ORDER BY r.fecha_reseña DESC;

-- Consulta 2: Ver mi lista única de contenidos pendientes
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
 WHERE lp.Id_usuario = 'ID_DEL_USUARIO'
   AND lp.estado = 'pendiente'
 ORDER BY lp.fecha_agregado DESC;

-- Consulta 3: Filtrar contenidos por género, año y país
 SELECT 
     c.nombre,
     c.genero,
     c.Año_estreno,
     c.pais,
     c.sinopsis
 FROM CONTENIDO c
 WHERE c.genero = 'GENERO_ESPECIFICO'
   AND c.Año_estreno BETWEEN 2000 AND 2023
   AND c.pais = 'PAIS_ESPECIFICO'
 ORDER BY c.Año_estreno DESC, c.nombre;

-- Consulta 4: Consultar el contenido mejor clasificado
 SELECT 
     c.nombre,
     c.genero,
     c.Año_estreno,
     ROUND(AVG(cal.estrellas), 2) AS promedio_calificacion,
     COUNT(cal.Id_calificacion) AS total_calificaciones
 FROM CONTENIDO c
 JOIN Calificaciones cal ON c.Id_content = cal.Id_content
 GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
 HAVING COUNT(cal.Id_calificacion) >= 3
 ORDER BY promedio_calificacion DESC
 FETCH FIRST 10 ROWS ONLY;

-- Consulta 5: Consultar las recomendaciones mas frecuentes
 SELECT 
     c.nombre,
     c.genero,
     c.Año_estreno,
     COUNT(r.id_reseña) AS total_reseñas,
     LISTAGG(u.nombre, ', ') WITHIN GROUP (ORDER BY u.nombre) AS usuarios_que_recomiendan
 FROM CONTENIDO c
 JOIN RESEÑAS r ON c.Id_content = r.Id_content
 JOIN USUARIOS u ON r.Id_usuario = u.Id_usuario
 GROUP BY c.Id_content, c.nombre, c.genero, c.Año_estreno
 ORDER BY total_reseñas DESC
 FETCH FIRST 10 ROWS ONLY;

-- Consulta 6: Ver todas las películas y series donde participa un director o actor específico
 SELECT 
     c.nombre,
     c.genero,
     c.Año_estreno,
     p.rol
 FROM PERSONAL_CONTENIDO pc
 JOIN PERSONAL p ON pc.Id_personal = p.Id_personal
 JOIN CONTENIDO c ON pc.Id_content = c.Id_content
 WHERE p.nombre = 'NOMBRE_DEL_DIRECTOR_O_ACTOR'
   AND p.rol IN ('director', 'actor')
 ORDER BY c.Año_estreno DESC, c.nombre;