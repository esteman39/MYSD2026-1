-- =====================================================
-- EGO - DisparadoresNoOK: Intentos bloqueados
--       por los disparadores
-- 
-- =====================================================
-- CU1: Mantener Usuario(Rol)   → Triggers 1, 2, 3, 4
-- CU2: Mantener Contenido      → Triggers 5, 6
-- CU3: Registrar Calificación  → Triggers 7, 8
-- =====================================================


-- =====================================================
-- CU1: MANTENER USUARIO - Pruebas inválidas
-- =====================================================

-- NoOK-1: trg_validar_edad_registro
-- Usuario con solo 10 años al registrarse → DEBE BLOQUEAR
-- Nacimiento: 2015 | Registro: 2025 | Edad: 10 años
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
-- VALUES ('user_nok1', 'menor@example.com', DATE '2025-01-15', DATE '2015-06-20');
-- ERROR ESPERADO: ORA-20001 - El usuario debe tener al menos 13 años al momento del registro.

-- NoOK-2: trg_fecha_registro_no_futura
-- Fecha de registro en el año 2035 → DEBE BLOQUEAR
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento)
-- VALUES ('user_nok2', 'futuro@example.com', DATE '2035-12-31', DATE '1990-03-10');
-- ERROR ESPERADO: ORA-20002 - La fecha de registro no puede ser una fecha futura.

-- NoOK-3: trg_resena_no_ofensiva (palabra: "basura")
-- Reseña con lenguaje ofensivo hacia el contenido → DEBE BLOQUEAR
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok1', 'user_001', 'cont_003',
--         'Esta película es una basura total, no entiendo por qué la recomiendan.', SYSDATE);
-- ERROR ESPERADO: ORA-20003 - La reseña contiene lenguaje ofensivo.

-- NoOK-4: trg_resena_no_ofensiva (palabra: "idiota")
-- Reseña con insulto hacia el director → DEBE BLOQUEAR
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok2', 'user_002', 'cont_006',
--         'El director es un idiota, arruinó la historia por completo.', SYSDATE);
-- ERROR ESPERADO: ORA-20003 - La reseña contiene lenguaje ofensivo.

-- NoOK-5: trg_fecha_resena_no_futura
-- Reseña con fecha del año 2030 → DEBE BLOQUEAR
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña)
-- VALUES ('res_nok3', 'user_001', 'cont_002',
--         'Una obra maestra del cine moderno.', DATE '2030-06-01');
-- ERROR ESPERADO: ORA-20004 - La fecha de la reseña no puede ser una fecha futura.


-- =====================================================
-- CU2: MANTENER CONTENIDO - Pruebas inválidas
-- =====================================================

-- NoOK-6: trg_personal_contenido_no_vacio
-- Intentar borrar el ÚNICO personal de cont_ok1 → DEBE BLOQUEAR
-- (Requiere haber ejecutado DisparadoresOK primero,
--  y que pers_ok2 ya fue eliminado en ese script)
-- DELETE FROM PERSONAL_CONTENIDO
-- WHERE Id_personal = 'pers_ok1' AND Id_content = 'cont_ok1';
-- ERROR ESPERADO: ORA-20005 - No se puede eliminar el último miembro de personal del contenido.

-- NoOK-7: trg_anno_estreno_valido (año anterior al cine)
-- Película con año 1800, antes de la invención del cine → DEBE BLOQUEAR
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
-- VALUES ('cont_nok1', 'Película Imposible', 1800, 90, 'Francia', 'Drama',
--         'Una película que no pudo existir.', 'NR', 'test');
-- ERROR ESPERADO: ORA-20006 - El año de estreno debe estar entre 1895 y el año actual.

-- NoOK-8: trg_anno_estreno_valido (año futuro)
-- Película con año 2099, que no ha ocurrido → DEBE BLOQUEAR
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta)
-- VALUES ('cont_nok2', 'Película del Futuro', 2099, 110, 'USA', 'Ciencia Ficción',
--         'Una película que todavía no se ha estrenado.', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-20006 - El año de estreno debe estar entre 1895 y el año actual.


-- =====================================================
-- CU3: REGISTRAR CALIFICACIÓN - Pruebas inválidas
-- =====================================================

-- NoOK-9: trg_una_calificacion_por_contenido
-- user_ok1 intenta calificar cont_ok1 por segunda vez → DEBE BLOQUEAR
-- (calif_ok1 ya fue insertado en DisparadoresOK)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
-- VALUES ('calif_nok1', 'user_ok1', 'cont_ok1', 2, SYSDATE);
-- ERROR ESPERADO: ORA-20007 - El usuario ya registró una calificación para este contenido.

-- NoOK-10: trg_fecha_calificacion_no_futura
-- Cliente intenta registrar calificación para el año 2030 → DEBE BLOQUEAR
-- Caso: quiere calificar "La Era de Hielo" antes de verla
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion)
-- VALUES ('calif_nok2', 'user_001', 'cont_ok1', 5, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-20008 - La fecha de calificación no puede ser una fecha futura.

COMMIT;