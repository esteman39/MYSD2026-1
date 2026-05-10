# MYSD2026-

EGO — Plataforma de Gestión de Contenido Audiovisual

Proyecto académico — Bases de Datos
Diseño e implementación completa de una base de datos relacional para una plataforma de reseñas y catalogación de películas y series, incluyendo modelo conceptual, lógico, físico, restricciones, triggers y paquetes PL/SQL CRUD.


Descripción del proyecto
EGO es una base de datos relacional desarrollada en Oracle SQL Developer que modela una plataforma de contenido audiovisual al estilo de Letterboxd o IMDb. Permite a los usuarios explorar un catálogo de películas y series, crear listas personalizadas, calificar contenidos y escribir reseñas. Los administradores pueden gestionar el catálogo y moderar la comunidad.
El proyecto recorre el ciclo completo de diseño de bases de datos:
Modelo Conceptual (UML)  →  Modelo Lógico (Relacional)  →  Modelo Físico (Oracle SQL + PL/SQL)

Casos de uso
Administrador
Caso de usoHistoria de usuarioMantener Usuario (Rol)Como administrador, quiero revisar los perfiles de los usuarios y sus reseñas, para mantener el ambiente de la comunidad de buenas maneras y amigable.Mantener Contenido (Objeto)Como administrador, quiero consultar los contenidos, para eliminar los que no corresponden al orden de la cinefilia o no tienen personal verificado asociado.
Cliente
Caso de usoHistoria de usuarioRegistrar Calificación (Evento)Como cliente, quiero consultar una película (ej. La Era de Hielo) para poder poner mi calificación.Consultar reseñasVer las reseñas de otros usuarios sobre un contenido específico.Ver filmografíaConsultar todas las obras de un director o actor específico.Filtrar contenidosBuscar por género, año de estreno y país.
Ver lista de pendientesConsultar los contenidos marcados como pendientes.

Estructura del repositorio
EGO/
│
├── EGO_Completo.sql          ← Script único con las 19 secciones en orden de ejecución
│
├── Scripts/                  ← Scripts individuales por sección
│   ├── xTablas.sql           ← S1:  Eliminar tablas existentes
│   ├── Tablas.sql            ← S2:  Crear tablas
│   ├── Primarias.sql         ← S3:  Claves primarias
│   ├── Unicos.sql            ← S4:  Restricciones únicas
│   ├── Foraneas.sql          ← S5:  Claves foráneas
│   ├── Atributos.sql         ← S6:  Restricciones CHECK
│   ├── PoblarOk.sql          ← S7:  Datos válidos
│   ├── PoblarNoOK.sql        ← S8:  Pruebas de datos inválidos (comentadas)
│   ├── Consultas.sql         ← S9:  Consultas de casos de uso
│   ├── XPoblar.sql           ← S10: Eliminación de datos
│   ├── Tuplas.sql            ← S11: Restricciones de tupla (multi-atributo)
│   ├── TuplasOK.sql          ← S12: Datos válidos para restricciones de tupla
│   ├── TuplasNoOK.sql        ← S13: Datos inválidos para restricciones de tupla (comentadas)
│   ├── Acciones.sql          ← S14: Acciones de referencia (SET NULL, NO ACTION)
│   ├── AccionesOK.sql        ← S15: Pruebas de acciones de referencia
│   ├── Disparadores.sql      ← S16: Definición de triggers (CU1, CU2, CU3)
│   ├── DisparadoresOK.sql    ← S17: Datos válidos protegidos por triggers
│   ├── DisparadoresNoOK.sql  ← S18: Intentos bloqueados por triggers (comentadas)
│   └── XDisparadores.sql     ← S19: Eliminación de triggers (comentada)
│
├── assets/                   ← Diagramas e imágenes del proyecto
│   ├── Conceptos.jpg         ← Modelo conceptual UML
│   ├── Modelo_Logico.jpg     ← Modelo lógico relacional
│   └── CasosDeUso.jpg        ← Diagrama de casos de uso
│
└── README.md

Modelo de datos
El esquema está compuesto por 15 tablas organizadas en tres grupos:
Entidades principales
TablaDescripciónUSUARIOSPerfiles de los miembros de la plataformaCONTENIDOCatálogo base de películas y seriesPELICULADatos específicos de películas (presupuesto, recaudación)SERIEDatos específicos de series (temporadas, episodios, showrunner)PERSONALActores, directores y equipo creativoROLCatálogo de roles del personalETIQUETASEtiquetas personalizadas asignadas por los usuarios
Entidades de interacción
TablaDescripciónLISTAListas creadas por los usuariosLISTA_CONTENIDOContenidos dentro de cada listaLISTA_PENDIENTEEstado de seguimiento del usuario sobre una listaCalificacionesCalificaciones de 1 a 5 estrellas por usuario y contenidoRESEÑASComentarios escritos por los usuarios
Tablas de relación
TablaDescripciónPERSONAL_ROLRelación entre personal y sus rolesPERSONAL_CONTENIDORelación entre personal y los contenidos en los que participó

Restricciones implementadas
Restricciones de atributo (CHECK)

Email con formato válido (%@%.%)
Duración de contenido mayor a 0
Clasificación dentro de valores permitidos: G, PG, PG-13, R, NC-17, NR, TV-MA, TV-14
Calificación entre 1 y 5 estrellas
Estado de lista pendiente: pendiente, visto, en_progreso
Rol del personal: actor, director, guionista, productor, sonidista
Categoría de etiqueta: emocion, genero, momento, recomendacion
Presupuesto y recaudación ≥ 0
Temporadas y episodios > 0

Restricciones de tupla (multi-atributo)
RestricciónReglachk_registro_posterior_nacimientoLa fecha de registro no puede ser anterior a la fecha de nacimientochk_edad_minima_registroEl usuario debe tener al menos 13 años al registrarsechk_presupuesto_si_recaudacionSi la recaudación es > 0, el presupuesto también debe serlochk_episodios_vs_temporadasLos episodios totales deben ser ≥ al número de temporadas
Acciones de referencia
RelaciónAcciónJustificaciónRESEÑAS → USUARIOSSET NULLLas reseñas se conservan de forma anónima si se elimina un usuarioETIQUETAS → USUARIOSSET NULLLas etiquetas quedan en el sistema sin propietarioCalificaciones → USUARIOSSET NULLLas calificaciones no se pierden; contribuyen al promedio de forma anónimaPERSONAL_CONTENIDO → PERSONALNO ACTIONOracle bloquea eliminar personal que tenga contenidos asociadosLISTA → USUARIOSCASCADESi se elimina el usuario, sus listas desaparecenLISTA_CONTENIDO → LISTACASCADELos ítems de una lista se eliminan con ella

⚡ Disparadores (Triggers)
Los 8 triggers están organizados directamente por caso de uso:
CU1 — Mantener Usuario (Administrador)
TriggerTablaQué protegetrg_validar_edad_registroUSUARIOSBloquea el registro de usuarios menores de 13 añostrg_fecha_registro_no_futuraUSUARIOSImpide que la fecha de registro sea futuratrg_resena_no_ofensivaRESEÑASDetecta y bloquea lenguaje ofensivo en reseñastrg_fecha_resena_no_futuraRESEÑASImpide reseñas con fecha futura
CU2 — Mantener Contenido (Administrador)
TriggerTablaQué protegetrg_personal_contenido_no_vacioPERSONAL_CONTENIDOImpide dejar un contenido sin personal asociado verificadotrg_anno_estreno_validoCONTENIDOValida que el año esté entre 1895 y el año actual
CU3 — Registrar Calificación (Cliente)
TriggerTablaQué protegetrg_una_calificacion_por_contenidoCalificacionesUn usuario solo puede calificar una vez el mismo contenidotrg_fecha_calificacion_no_futuraCalificacionesImpide calificar con fecha futura

📦 Modelo Físico — Paquetes PL/SQL (CRUD)
El modelo físico implementa tres paquetes PL/SQL que encapsulan toda la lógica de acceso a datos. Cada paquete corresponde a un caso de uso principal.

PKG_USUARIOS — Gestión de usuarios

Caso de uso: Mantener Usuario (Rol) — Administrador
Tabla principal: USUARIOS

OperaciónProcedimiento / FunciónDescripciónAdicionaragregar_usuario(id, email, fecha_registro, fecha_nac)Inserta un nuevo usuario. Los triggers validan edad mínima y fecha no futura automáticamente.Consultarconsultar_usuario(id) → OUTRetorna todos los atributos del usuario por ID.Consultarlistar_usuarios() → SYS_REFCURSORRetorna cursor con todos los usuarios ordenados por fecha de registro.Modificarmodificar_email(id, nuevo_email)Actualiza el email; re-valida CHECK y UNIQUE automáticamente.Eliminareliminar_usuario(id)Elimina el usuario. Por acciones de referencia: reseñas y calificaciones quedan anónimas (SET NULL), listas y etiquetas se eliminan (CASCADE).
Efectos en cascada al eliminar:
USUARIOS eliminado
  ├── RESEÑAS.Id_usuario          → SET NULL  (reseñas anónimas)
  ├── Calificaciones.Id_usuario   → SET NULL  (calificaciones anónimas)
  ├── LISTA                       → CASCADE DELETE
  │     ├── LISTA_CONTENIDO       → CASCADE DELETE
  │     └── LISTA_PENDIENTE       → CASCADE DELETE
  └── ETIQUETAS.id_usuario        → SET NULL

PKG_CONTENIDO — Gestión del catálogo

Caso de uso: Mantener Contenido (Objeto) — Administrador
Tabla principal: CONTENIDO + PELICULA / SERIE

OperaciónProcedimiento / FunciónDescripciónAdicionaragregar_pelicula(...)Inserta en CONTENIDO y en PELICULA. Trigger valida año de estreno.Adicionaragregar_serie(...)Inserta en CONTENIDO y en SERIE. CHECK valida episodios ≥ temporadas.Consultarconsultar_contenido(id) → OUTRetorna atributos del contenido más datos de película o serie según tipo.Consultarlistar_por_genero(genero) → SYS_REFCURSORCursor con contenidos del género indicado.Modificarmodificar_contenido(id, sinopsis, clasificacion)Actualiza metadatos; CHECK re-valida clasificación automáticamente.Eliminareliminar_contenido(id)Elimina el contenido. Por CASCADE se eliminan todos los registros dependientes.
Efectos en cascada al eliminar:
CONTENIDO eliminado
  ├── PELICULA              → CASCADE DELETE
  ├── SERIE                 → CASCADE DELETE
  ├── PERSONAL_CONTENIDO    → CASCADE DELETE
  ├── LISTA_CONTENIDO       → CASCADE DELETE
  ├── Calificaciones        → CASCADE DELETE
  └── RESEÑAS               → CASCADE DELETE

PKG_CALIFICACIONES — Gestión de calificaciones

Caso de uso: Registrar Calificación (Evento) — Cliente
Tabla principal: Calificaciones

OperaciónProcedimiento / FunciónDescripciónAdicionaragregar_calificacion(id, usuario, contenido, estrellas, fecha)Registra la calificación. El trigger bloquea duplicados y fechas futuras automáticamente.Consultarconsultar_por_contenido(id_content) → SYS_REFCURSORCursor con todas las calificaciones del contenido e incluye promedio con función de ventana AVG() OVER.Consultarhistorial_usuario(id_usuario) → SYS_REFCURSORHistorial de calificaciones del usuario con nombre del contenido, ordenado por fecha DESC.Modificarmodificar_calificacion(id_calif, nuevas_estrellas)Actualiza las estrellas; CHECK re-valida rango 1–5.Eliminareliminar_calificacion(id_calif)Elimina la calificación. No tiene tablas dependientes.

Matriz de relaciones — Paquetes, tablas y triggers activos
Paquete / OperaciónEscribe enLee deTriggers activosCascadaPKG_USUARIOS / AdicionarUSUARIOS—trg_validar_edad_registro, trg_fecha_registro_no_futura—PKG_USUARIOS / Consultar—USUARIOS——PKG_USUARIOS / ModificarUSUARIOSUSUARIOSCHECK email, UNIQUE email—PKG_USUARIOS / EliminarUSUARIOS——SET NULL en RESEÑAS, Calificaciones; CASCADE en LISTA, ETIQUETASPKG_CONTENIDO / AdicionarCONTENIDO, PELICULA/SERIE—trg_anno_estreno_valido, CHECK duracion, clasificacion—PKG_CONTENIDO / Consultar—CONTENIDO, PELICULA/SERIE——PKG_CONTENIDO / ModificarCONTENIDOCONTENIDOCHECK clasificacion—PKG_CONTENIDO / EliminarCONTENIDO——CASCADE a PELICULA, SERIE, PERSONAL_CONTENIDO, LISTA_CONTENIDO, Calificaciones, RESEÑASPKG_CALIFICACIONES / AdicionarCalificacionesCalificacionestrg_una_calificacion_por_contenido, trg_fecha_calificacion_no_futura, CHECK estrellas—PKG_CALIFICACIONES / Consultar—Calificaciones, CONTENIDO——PKG_CALIFICACIONES / ModificarCalificacionesCalificacionesCHECK estrellas—PKG_CALIFICACIONES / EliminarCalificaciones——Sin dependientes

🔍 Consultas implementadas
#ConsultaCaso de uso1Reseñas de un contenido específico con datos del usuarioConsultar reseñas2Lista de contenidos pendientes de un usuarioVer pendientes3Filtrar contenidos por género, año y paísFiltrar catálogo4Top 10 contenidos mejor calificados (promedio + total)Ranking5Top 10 contenidos con más reseñas + usuarios que recomiendanRecomendaciones6Filmografía completa de un director o actor específicoVer filmografía

🚀 Cómo ejecutar

Se requiere Oracle SQL Developer con una conexión activa a una base de datos Oracle.

Opción A — Script único (recomendado)
Abrir EGO_Completo.sql en SQL Developer y ejecutarlo completo. Las 19 secciones están ordenadas para correr sin conflictos de arriba a abajo.
Opción B — Scripts individuales
Ejecutar cada archivo de la carpeta Scripts/ en el orden numérico (S1 → S19).
Orden de ejecución
S1  xTablas          → Limpieza previa (DROP de tablas existentes)
S2  Tablas           → Creación de estructura
S3  Primarias        → Claves primarias
S4  Unicos           → Restricciones únicas
S5  Foraneas         → Claves foráneas
S6  Atributos        → CHECK y DEFAULT
S7  PoblarOk         → Datos válidos de prueba
S8  PoblarNoOK       → (opcional) Probar restricciones de atributo
S9  Consultas        → Consultas funcionales de casos de uso
S10 XPoblar          → (opcional) Limpiar datos
S11 Tuplas           → Restricciones de tupla (multi-atributo)
S12 TuplasOK         → Datos válidos para restricciones de tupla
S13 TuplasNoOK       → (opcional) Probar restricciones de tupla
S14 Acciones         → Acciones de referencia (SET NULL, NO ACTION)
S15 AccionesOK       → Pruebas de acciones de referencia
S16 Disparadores     → Creación de los 8 triggers
S17 DisparadoresOK   → Datos válidos con triggers activos
S18 DisparadoresNoOK → (opcional) Probar triggers
S19 XDisparadores    → (opcional) Eliminar triggers

Los archivos NoOK y X tienen sus sentencias comentadas. Para probar una restricción, descomentar el bloque deseado y ejecutar individualmente.


Datos de prueba incluidos
TablaRegistrosUSUARIOS9 (incluye usuarios de prueba para triggers)CONTENIDO13 (5 películas + 5 series + 3 adicionales)PERSONAL7Calificaciones9RESEÑAS5LISTA5LISTA_CONTENIDO5SERIE6PELICULA7ROL5

Tecnologías
TecnologíaUsoOracle DatabaseMotor de base de datos relacionalOracle SQL DeveloperEntorno de desarrollo y ejecuciónPL/SQLTriggers y paquetes CRUDSQL (DDL / DML)Definición y manipulación de datos

Conceptos académicos aplicados
ConceptoDónde se aplicaModelo Entidad-Relación → RelacionalSecciones S1–S5Normalización (1FN, 2FN, 3FN)Diseño de las 14 tablasIntegridad de dominioCHECK, NOT NULL (S6)Integridad referencialClaves foráneas (S5)Restricciones de tuplaCHECK multi-atributo (S11)Acciones de referenciaCASCADE, SET NULL, NO ACTION (S14)Triggers BEFORE INSERT/UPDATE/DELETEPL/SQL con RAISE_APPLICATION_ERROR (S16)Paquetes PL/SQLPKG_USUARIOS, PKG_CONTENIDO, PKG_CALIFICACIONESSubconsultas y JOINsConsultas de casos de uso (S9)Funciones de ventanaAVG() OVER (PARTITION BY) en PKG_CALIFICACIONESLISTAGG, FETCH FIRSTConsultas de ranking y recomendaciones