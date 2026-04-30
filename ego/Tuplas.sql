-- =====================================================
-- EGO - RESTRICCIONES DE TUPLAS (Tuplas)
-- Oracle SQL Developer
-- =====================================================


-- USUARIOS: La fecha de registro no puede ser anterior a la fecha de nacimiento
ALTER TABLE USUARIOS
    ADD CONSTRAINT chk_registro_posterior_nacimiento
    CHECK (Fecha_registro >= fecha_nacimiento);
 
-- USUARIOS: El usuario debe tener al menos 13 años al momento del registro
ALTER TABLE USUARIOS
    ADD CONSTRAINT chk_edad_minima_registro
    CHECK (Fecha_registro >= fecha_nacimiento + INTERVAL '13' YEAR);
 
-- PELICULA: Si hay recaudación, debe existir un presupuesto mayor a cero
ALTER TABLE PELICULA
    ADD CONSTRAINT chk_presupuesto_si_recaudacion
    CHECK (recaudacion = 0 OR presupuesto > 0);
 
 
-- SERIE: Los episodios totales deben ser mayores o iguales al número de temporadas
ALTER TABLE SERIE
    ADD CONSTRAINT chk_episodios_vs_temporadas
    CHECK (episodios >= temporadas);
 
 