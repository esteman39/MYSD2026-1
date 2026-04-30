-- =====================================================
-- EGO - XDisparadores: Eliminación de disparadores
-- =====================================================

-- CU1: Triggers de USUARIOS y RESEÑAS
DROP TRIGGER trg_validar_edad_registro;
DROP TRIGGER trg_fecha_registro_no_futura;
DROP TRIGGER trg_resena_no_ofensiva;
DROP TRIGGER trg_fecha_resena_no_futura;

-- CU2: Triggers de CONTENIDO y PERSONAL_CONTENIDO
DROP TRIGGER trg_personal_contenido_no_vacio;
DROP TRIGGER trg_anno_estreno_valido;

-- CU3: Triggers de CALIFICACIONES
DROP TRIGGER trg_una_calificacion_por_contenido;
DROP TRIGGER trg_fecha_calificacion_no_futura;

-- Verificar eliminación (debe retornar 0 filas)
SELECT trigger_name, table_name, status
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
ORDER BY trigger_name;
-- RESULTADO ESPERADO: 0 filas (todos eliminados) 