-- =====================================================
-- EGO - Disparadores: Definición de triggers
-- Oracle SQL Developer
-- =====================================================

-- -----------------------------------------------------
-- TRIGGER 1: trg_validar_edad_usuario
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Garantizar que el usuario tenga al menos
--            13 años al momento del registro.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_validar_edad_usuario
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF :NEW.fecha_nacimiento > :NEW.Fecha_registro - INTERVAL '13' YEAR THEN
        RAISE_APPLICATION_ERROR(-20001,
            'ERROR: El usuario debe tener al menos 13 años al momento del registro.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 2: trg_fecha_registro_no_futura
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir que la fecha de registro sea
--            posterior a la fecha actual (SYSDATE).
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_registro_no_futura
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF :NEW.Fecha_registro > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002,
            'ERROR: La fecha de registro no puede ser una fecha futura.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 3: trg_fecha_calificacion_no_futura
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir que se registre una calificación
--            con fecha futura.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_calificacion_no_futura
BEFORE INSERT OR UPDATE ON Calificaciones
FOR EACH ROW
BEGIN
    IF :NEW.fecha_calificacion > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20003,
            'ERROR: La fecha de calificación no puede ser una fecha futura.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 4: trg_fecha_resena_no_futura
-- TABLA: RESEÑAS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir que se registre una reseña
--            con fecha futura.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_resena_no_futura
BEFORE INSERT OR UPDATE ON RESEÑAS
FOR EACH ROW
BEGIN
    IF :NEW.fecha_reseña > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20004,
            'ERROR: La fecha de la reseña no puede ser una fecha futura.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 5: trg_fecha_lista_no_futura
-- TABLA: LISTA_CONTENIDO
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir que la fecha en que se agrega un
--            contenido a una lista sea futura.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_lista_no_futura
BEFORE INSERT OR UPDATE ON LISTA_CONTENIDO
FOR EACH ROW
BEGIN
    IF :NEW.fecha_agregado > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20005,
            'ERROR: La fecha en que se agregó el contenido a la lista no puede ser futura.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 6: trg_anno_estreno_valido
-- TABLA: CONTENIDO
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Validar que el año de estreno no sea
--            anterior a 1895 (invención del cine) ni
--            mayor al año actual.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_anno_estreno_valido
BEFORE INSERT OR UPDATE ON CONTENIDO
FOR EACH ROW
BEGIN
    IF :NEW.Año_estreno < 1895 OR :NEW.Año_estreno > EXTRACT(YEAR FROM SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20006,
            'ERROR: El año de estreno debe estar entre 1895 y el año actual.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 7: trg_una_calificacion_por_usuario
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT
-- PROPÓSITO: Evitar que un mismo usuario califique
--            el mismo contenido más de una vez.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_una_calificacion_por_usuario
BEFORE INSERT ON Calificaciones
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Calificaciones
    WHERE Id_usuario  = :NEW.Id_usuario
      AND Id_content  = :NEW.Id_content;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20007,
            'ERROR: El usuario ya calificó este contenido. Solo se permite una calificación por contenido.');
    END IF;
END;
/

-- Verificar que los triggers fueron creados
SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
WHERE trigger_name IN (
    'TRG_VALIDAR_EDAD_USUARIO',
    'TRG_FECHA_REGISTRO_NO_FUTURA',
    'TRG_FECHA_CALIFICACION_NO_FUTURA',
    'TRG_FECHA_RESENA_NO_FUTURA',
    'TRG_FECHA_LISTA_NO_FUTURA',
    'TRG_ANNO_ESTRENO_VALIDO',
    'TRG_UNA_CALIFICACION_POR_USUARIO'
)
ORDER BY trigger_name;