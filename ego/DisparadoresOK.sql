-- =====================================================
-- EGO - DisparadoresOK Datos válidos que pasan
--       correctamente por los disparadores
-- =====================================================
-- CU1: Mantener Usuario(Rol)   → Triggers 1, 2, 3, 4
-- CU2: Mantener Contenido      → Triggers 5, 6
-- CU3: Registrar Calificación  → Triggers 7, 8
-- =====================================================


-- =====================================================
-- CU1: MANTENER USUARIO - Pruebas válidas
-- =====================================================

-- Datos de apoyo para las pruebas OK
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
VALUES ('cont_ok1', 'La Era de Hielo', 2002, 81, 'USA', 'Animación',
        'Una manada de animales prehistóricos ayuda a devolver un bebé humano con su familia.', 'PG', 'familiar');

INSERT INTO PELICULA (Id_content, presupuesto, recaudacion)
VALUES ('cont_ok1', 59000000, 383257136);

INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad)
VALUES ('pers_ok1', 'Chris Wedge', 'director', 'cont_ok1', 'Director de animación de Blue Sky Studios', 'Estadounidense');

INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content)
VALUES ('pers_ok1', 'cont_ok1');

-- OK-1: trg_validar_edad_registro
-- Usuario adulto (25 años al registrarse) → DEBE PASAR
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
VALUES ('user_ok1', 'sofia_ok@example.com', DATE '2022-08-10', DATE '1997-04-20');
-- Edad al registrarse: 25 años ✓

-- OK-2: trg_fecha_registro_no_futura
-- Fecha de registro = hoy → DEBE PASAR
INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
VALUES ('user_ok2', 'miguel_ok@example.com', SYSDATE, DATE '1993-11-05');
-- Fecha registro = SYSDATE, no futura ✓

-- OK-3: trg_resena_no_ofensiva
-- Reseña con lenguaje respetuoso → DEBE PASAR
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
VALUES ('res_ok1', 'user_ok1', 'cont_ok1',
        'Una película entrañable que marcó mi infancia. Los personajes son muy carismáticos.', SYSDATE);
-- Sin palabras ofensivas ✓

-- OK-4: trg_fecha_resena_no_futura
-- Reseña con fecha de ayer → DEBE PASAR
INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
VALUES ('res_ok2', 'user_ok2', 'cont_ok1',
        'Clásico de la animación que nunca envejece. Muy recomendada para toda la familia.', SYSDATE - 1);
-- fecha_reseña = ayer, no futura ✓


-- =====================================================
-- CU2: MANTENER CONTENIDO - Pruebas válidas
-- =====================================================

-- OK-5: trg_personal_contenido_no_vacio
-- Agregar un segundo personal antes de intentar borrar el primero → DEBE PASAR
INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad)
VALUES ('pers_ok2', 'Carlos Saldanha', 'director', 'cont_ok1', 'Co-director de La Era de Hielo', 'Brasileño');

INSERT INTO PERSONAL_CONTENIDO (Id_personal, Id_content)
VALUES ('pers_ok2', 'cont_ok1');

-- Ahora sí se puede borrar uno porque queda el otro
DELETE FROM PERSONAL_CONTENIDO WHERE Id_personal = 'pers_ok2' AND Id_content = 'cont_ok1';
-- cont_ok1 aún tiene pers_ok1 → operación permitida ✓

-- OK-6: trg_anno_estreno_valido
-- Año de estreno = 2002, dentro del rango válido → DEBE PASAR
INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
VALUES ('cont_ok2', 'Gladiador', 2000, 155, 'USA', 'Acción',
        'Un general romano traicionado busca venganza como gladiador.', 'R', 'historico');
-- 2000 está entre 1895 y el año actual ✓

INSERT INTO PELICULA (Id_content, presupuesto, recaudacion)
VALUES ('cont_ok2', 103000000, 457640427);


-- =====================================================
-- CU3: REGISTRAR CALIFICACIÓN - Pruebas válidas
-- =====================================================

-- OK-7: trg_una_calificacion_por_contenido
-- user_ok1 califica cont_ok1 por PRIMERA vez → DEBE PASAR
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
VALUES ('calif_ok1', 'user_ok1', 'cont_ok1', 5, SYSDATE);
-- Primera calificación de user_ok1 sobre cont_ok1 ✓

-- OK-8: trg_fecha_calificacion_no_futura
-- Calificación con fecha de hace 3 días → DEBE PASAR
INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
VALUES ('calif_ok2', 'user_ok2', 'cont_ok1', 4, SYSDATE - 3);
-- fecha_calificacion = hace 3 días, no futura ✓

COMMIT;

-- Verificación final
SELECT 'USUARIOS ok'       AS tabla, COUNT(*) AS insertados FROM USUARIOS       WHERE Id_usuario  IN ('user_ok1','user_ok2')   UNION ALL
SELECT 'RESEÑAS ok',                 COUNT(*)               FROM RESEÑAS         WHERE id_reseña   IN ('res_ok1','res_ok2')      UNION ALL
SELECT 'CONTENIDO ok',               COUNT(*)               FROM CONTENIDO       WHERE Id_content  IN ('cont_ok1','cont_ok2')    UNION ALL
SELECT 'CALIFICACIONES ok',          COUNT(*)               FROM Calificaciones  WHERE Id_calificacion IN ('calif_ok1','calif_ok2');