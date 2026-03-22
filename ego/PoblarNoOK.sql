-- =====================================================
-- EGO - Intentos de Inserción de Datos Erróneos (PoblarNoOK)
-- Oracle SQL Developer
-- (Descomentar para probar restricciones)
-- =====================================================

-- =====================================================
-- PRUEBA 1: Email con formato inválido (debe fallar - CHECK email)
-- =====================================================
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test1', 'email_invalido', SYSDATE, DATE '1998-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 2: Fecha de nacimiento en el futuro (debe fallar - CHECK fecha_nacimiento)
-- =====================================================
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test2', 'test2@example.com', SYSDATE, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 3: Fecha de registro en el futuro (debe fallar - CHECK fecha_registro)
-- =====================================================
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_test3', 'test3@example.com', DATE '2030-01-01', DATE '1998-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 4: Año de estreno inválido (< 1895) (debe fallar - CHECK año_estreno)
-- =====================================================
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
-- ('cont_test1', 'Película Inválida', 1800, 100, 'USA', 'Drama', 'Sinopsis', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 5: Duración inválida (<= 0) (debe fallar - CHECK duracion)
-- =====================================================
-- INSERT INTO CONTENIDO (Id_content, nombre, Año_estreno, duracion, pais, genero, sinopsis, Clasificacion, nombre_etiqueta) VALUES
-- ('cont_test2', 'Película Inválida', 2020, 0, 'USA', 'Drama', 'Sinopsis', 'PG-13', 'test');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 6: Calificación con estrellas fuera de rango (debe fallar - CHECK estrellas)
-- =====================================================
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test1', 'user_001', 'cont_001', 6, SYSDATE);
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 7: Calificación con estrellas < 1 (debe fallar - CHECK estrellas)
-- =====================================================
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test2', 'user_001', 'cont_001', 0, SYSDATE);
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 8: Fecha de calificación en el futuro (debe fallar - CHECK fecha_calificacion)
-- =====================================================
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test3', 'user_001', 'cont_001', 5, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 9: Comentario de reseña vacío (debe fallar - NOT NULL)
-- =====================================================
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test1', 'user_001', 'cont_001', '', SYSDATE);
-- ERROR ESPERADO: ORA-01400: cannot insert NULL into column

-- =====================================================
-- PRUEBA 10: Fecha de reseña en el futuro (debe fallar - CHECK fecha_reseña)
-- =====================================================
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test2', 'user_001', 'cont_001', 'Comentario válido', DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 11: Rol inválido en PERSONAL (debe fallar - CHECK rol)
-- =====================================================
-- INSERT INTO PERSONAL (Id_personal, nombre, rol, contenidos, descripcion, nacionalidad) VALUES
-- ('pers_test1', 'Test Actor', 'rol_invalido', 'cont_001', 'Descripción', 'Nacionalidad');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 12: Temporadas <= 0 en SERIE (debe fallar - CHECK temporadas)
-- =====================================================
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_test3', 0, 10, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 13: Episodios <= 0 en SERIE (debe fallar - CHECK episodios)
-- =====================================================
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_test4', 1, 0, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 14: Presupuesto negativo en PELICULA (debe fallar - CHECK presupuesto)
-- =====================================================
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_test5', -1000000, 5000000);
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 15: Recaudación negativa en PELICULA (debe fallar - CHECK recaudacion)
-- =====================================================
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_test6', 1000000, -500000);
-- ERROR ESPERADO: ORA-02290: check constraint violated

-- =====================================================
-- PRUEBA 16: Clave foránea inválida en Calificaciones (debe fallar - FK usuario)
-- =====================================================
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test4', 'user_inexistente', 'cont_001', 5, SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found

-- =====================================================
-- PRUEBA 17: Clave foránea inválida en Calificaciones (debe fallar - FK contenido)
-- =====================================================
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_test5', 'user_001', 'cont_inexistente', 5, SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found

-- =====================================================
-- PRUEBA 18: Clave foránea inválida en RESEÑAS (debe fallar - FK usuario)
-- =====================================================
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test3', 'user_inexistente', 'cont_001', 'Comentario', SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found

-- =====================================================
-- PRUEBA 19: Clave foránea inválida en RESEÑAS (debe fallar - FK contenido)
-- =====================================================
-- INSERT INTO RESEÑAS (id_reseña, Id_usuario, Id_content, comentario, fecha_reseña) VALUES
-- ('res_test4', 'user_001', 'cont_inexistente', 'Comentario', SYSDATE);
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found

-- =====================================================
-- PRUEBA 20: Clave foránea inválida en LISTA_CONTENIDO (debe fallar - FK lista)
-- =====================================================
-- INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
-- ('lista_inexistente', 'user_001', 'Test', 'Test', 1, SYSDATE, 'cont_001');
-- ERROR ESPERADO: ORA-02291: integrity constraint violated - parent key not found

COMMIT;