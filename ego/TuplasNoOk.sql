-- =====================================================
-- EGO : Datos inválidos para Tuplas (TuplasNoOK)
-- =====================================================
 
-- PRUEBA T1: Fecha de registro anterior a la fecha de nacimiento (debe fallar)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_t01', 'invalido1@example.com', DATE '1990-01-01', DATE '2000-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_registro_posterior_nacimiento) violated
 
-- PRUEBA T2: Usuario menor de 13 años al momento del registro (debe fallar)
-- INSERT INTO USUARIOS (Id_usuario, Email, Fecha_registro, fecha_nacimiento) VALUES
-- ('user_t02', 'invalido2@example.com', DATE '2010-06-01', DATE '2000-05-15');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_edad_minima_registro) violated
 
-- PRUEBA T3: Recaudación mayor a cero con presupuesto en cero (debe fallar)
-- INSERT INTO PELICULA (Id_content, presupuesto, recaudacion) VALUES
-- ('cont_012', 0, 500000);
-- ERROR ESPERADO: ORA-02290: check constraint (chk_presupuesto_si_recaudacion) violated
 
-- PRUEBA T4: Fecha de agregado en lista con fecha futura (debe fallar)
-- INSERT INTO LISTA_CONTENIDO (Id_lista, id_usuario, nombre_lista, descripcion, orden, fecha_agregado, Id_content) VALUES
-- ('lista_006', 'user_006', 'Lista futura', 'Descripción', 2, DATE '2030-12-31', 'cont_011');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_fecha_agregado_no_futura) violated
 
-- PRUEBA T5: Fecha de calificación futura (debe fallar)
-- INSERT INTO Calificaciones (Id_calificacion, Id_usuario, Id_content, estrellas, fecha_calificacion) VALUES
-- ('calif_t01', 'user_006', 'cont_011', 4, DATE '2030-01-01');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_fecha_calificacion_no_futura) violated
 
-- PRUEBA T6: Episodios menores que temporadas en SERIE (debe fallar)
-- INSERT INTO SERIE (Id_content, temporadas, episodios, show_runner) VALUES
-- ('cont_013', 10, 3, 'Test Runner');
-- ERROR ESPERADO: ORA-02290: check constraint (chk_episodios_vs_temporadas) violated
 
COMMIT;
 