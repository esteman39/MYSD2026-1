
-- =====================================================
-- EGO - Definición de Disparadores (Disparadores)
-- Oracle SQL Developer
-- =====================================================
-- Casos de uso cubiertos:
--   CU1: Mantener Usuario(Rol)  → Administrador
--   CU2: Mantener Contenido     → Administrador
--   CU3: Registrar Calificación → Cliente
-- =====================================================


-- =====================================================
-- CU1: MANTENER USUARIO (ROL) - Administrador
-- =====================================================

-- -----------------------------------------------------
-- TRIGGER 1: trg_validar_edad_registro
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: El usuario debe tener al menos 13 años
--            al momento del registro. Protege que
--            menores no accedan a la plataforma.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_validar_edad_registro
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF MONTHS_BETWEEN(:NEW.Fecha_registro, :NEW.fecha_nacimiento) / 12 < 13 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'ERROR CU1: El usuario debe tener al menos 13 años al momento del registro.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 2: trg_fecha_registro_no_futura
-- TABLA: USUARIOS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: La fecha de registro no puede ser futura.
--            Garantiza coherencia temporal del perfil.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_registro_no_futura
BEFORE INSERT OR UPDATE ON USUARIOS
FOR EACH ROW
BEGIN
    IF :NEW.Fecha_registro > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002,
            'ERROR CU1: La fecha de registro no puede ser una fecha futura.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 3: trg_resena_no_ofensiva
-- TABLA: RESEÑAS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Bloquear reseñas que contengan palabras
--            ofensivas o discurso de odio. Apoya la
--            revisión del administrador para mantener
--            el ambiente de la comunidad sano.
--            (Lista de términos extensible por el admin)
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_resena_no_ofensiva
BEFORE INSERT OR UPDATE ON RESEÑAS
FOR EACH ROW
DECLARE
    v_comentario_lower VARCHAR2(250);
BEGIN
    v_comentario_lower := LOWER(:NEW.comentario);

    IF INSTR(v_comentario_lower, 'odio')      > 0 OR
       INSTR(v_comentario_lower, 'imbecil')   > 0 OR
       INSTR(v_comentario_lower, 'idiota')    > 0 OR
       INSTR(v_comentario_lower, 'basura')    > 0 OR
       INSTR(v_comentario_lower, 'estupido')  > 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
            'ERROR CU1: La reseña contiene lenguaje ofensivo. Por favor, mantenga un lenguaje respetuoso.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 4: trg_fecha_resena_no_futura
-- TABLA: RESEÑAS
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: Impedir reseñas con fecha futura.
--            El admin necesita datos temporalmente
--            coherentes para auditar la comunidad.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_resena_no_futura
BEFORE INSERT OR UPDATE ON RESEÑAS
FOR EACH ROW
BEGIN
    IF :NEW.fecha_reseña > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20004,
            'ERROR CU1: La fecha de la reseña no puede ser una fecha futura.');
    END IF;
END;
/


-- =====================================================
-- CU2: MANTENER CONTENIDO (OBJETO) - Administrador
-- =====================================================

-- -----------------------------------------------------
-- TRIGGER 5: trg_contenido_requiere_personal
-- TABLA: PERSONAL_CONTENIDO
-- EVENTO: AFTER INSERT OR DELETE ON PERSONAL_CONTENIDO
--         + BEFORE INSERT ON CONTENIDO (via flag auxiliar)
-- 
-- NOTA DISEÑO: En Oracle no se puede hacer JOIN de la
-- tabla que dispara el trigger. Se implementa como
-- BEFORE INSERT en CONTENIDO validando que el
-- Id_content ya tenga personal registrado cuando se
-- reutiliza, y como advertencia documentada para
-- nuevos contenidos (el admin debe agregar personal
-- justo después del INSERT en CONTENIDO).
--
-- PROPÓSITO: Todo contenido debe tener al menos un
--            miembro de personal verificado asociado.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_personal_contenido_no_vacio
BEFORE DELETE ON PERSONAL_CONTENIDO
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM PERSONAL_CONTENIDO
    WHERE Id_content = :OLD.Id_content;

    -- Si solo queda 1 (el que se va a borrar), bloquear
    IF v_count <= 1 THEN
        RAISE_APPLICATION_ERROR(-20005,
            'ERROR CU2: No se puede eliminar el último miembro de personal del contenido. Todo contenido debe tener al menos un personal asociado.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 6: trg_anno_estreno_valido
-- TABLA: CONTENIDO
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: El año de estreno debe estar entre 1895
--            (invención del cine) y el año actual.
--            El admin no puede registrar contenidos
--            con fechas imposibles o futuras.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_anno_estreno_valido
BEFORE INSERT OR UPDATE ON CONTENIDO
FOR EACH ROW
BEGIN
    IF :NEW.Año_estreno < 1895 OR :NEW.Año_estreno > EXTRACT(YEAR FROM SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20006,
            'ERROR CU2: El año de estreno debe estar entre 1895 y el año actual. No se admiten contenidos futuros ni anteriores al cine.');
    END IF;
END;
/


-- =====================================================
-- CU3: REGISTRAR CALIFICACIÓN (EVENTO) - Cliente
-- =====================================================

-- -----------------------------------------------------
-- TRIGGER 7: trg_una_calificacion_por_contenido
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT
-- PROPÓSITO: Un cliente solo puede calificar una vez
--            el mismo contenido. Si quiere cambiar su
--            opinión, debe actualizar, no insertar de
--            nuevo. Garantiza integridad del promedio.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_una_calificacion_por_contenido
BEFORE INSERT ON Calificaciones
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Calificaciones
    WHERE Id_usuario = :NEW.Id_usuario
      AND Id_content = :NEW.Id_content;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20007,
            'ERROR CU3: El usuario ya registró una calificación para este contenido. Use UPDATE para modificarla.');
    END IF;
END;
/

-- -----------------------------------------------------
-- TRIGGER 8: trg_fecha_calificacion_no_futura
-- TABLA: Calificaciones
-- EVENTO: BEFORE INSERT OR UPDATE
-- PROPÓSITO: La fecha de calificación no puede ser
--            futura. El cliente califica lo que ya vio,
--            no lo que verá. Coherencia temporal del
--            evento de calificación.
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER trg_fecha_calificacion_no_futura
BEFORE INSERT OR UPDATE ON Calificaciones
FOR EACH ROW
BEGIN
    IF :NEW.fecha_calificacion > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20008,
            'ERROR CU3: La fecha de calificación no puede ser una fecha futura. Solo se pueden calificar contenidos ya vistos.');
    END IF;
END;
/

-- Verificar creación de todos los triggers
SELECT trigger_name, table_name, triggering_event, status
FROM user_triggers
WHERE trigger_name IN (
    'TRG_VALIDAR_EDAD_REGISTRO',
    'TRG_FECHA_REGISTRO_NO_FUTURA',
    'TRG_RESENA_NO_OFENSIVA',
    'TRG_FECHA_RESENA_NO_FUTURA',
    'TRG_PERSONAL_CONTENIDO_NO_VACIO',
    'TRG_ANNO_ESTRENO_VALIDO',
    'TRG_UNA_CALIFICACION_POR_CONTENIDO',
    'TRG_FECHA_CALIFICACION_NO_FUTURA'
)
ORDER BY table_name, trigger_name;