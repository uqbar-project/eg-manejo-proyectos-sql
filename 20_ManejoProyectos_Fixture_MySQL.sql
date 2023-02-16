\connect manejo_proyectos

CREATE FUNCTION get_proyecto(descripcion_proyecto text) RETURNS integer
    AS 
    $$ 
    SELECT ID 
      FROM PROYECTOS 
     WHERE DESCRIPCION = descripcion_proyecto
     LIMIT 1
    $$
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;


CREATE FUNCTION get_tarea(descripcion_tarea text) RETURNS integer
    AS 
    $$ 
    SELECT ID 
      FROM TAREAS 
    WHERE DESCRIPCION = descripcion_tarea
    LIMIT 1
    $$
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;


INSERT INTO PROYECTOS 
(DESCRIPCION)
VALUES ('MIGRACION SQL');

INSERT INTO PROYECTOS 
(DESCRIPCION)
VALUES ('MIGRACION GIRAFE 1.0 A 1.5');

INSERT INTO PROYECTOS 
(DESCRIPCION)
SELECT 'RRHH 5.5';

-- Proyecto WebMail 2.1 de la guía 6.1.1 Manejo de proyectos
INSERT INTO PROYECTOS 
(DESCRIPCION)
SELECT 'Webmail 2.1';

INSERT INTO IMPUESTOS
(DESCRIPCION, VALOR)
VALUES ('A', 3);

INSERT INTO IMPUESTOS
(DESCRIPCION, VALOR)
VALUES ('B', 5);

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('I', 10, 'Relevamiento', get_proyecto('Webmail 2.1'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('E', 30, 'Desarrollo', get_proyecto('Webmail 2.1'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('A', 2, 'Implementación', get_proyecto('Webmail 2.1'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('E', 5, 'Iteración 1', get_proyecto('Webmail 2.1'), get_tarea('Desarrollo'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('I', 2, 'Iteración 2', get_proyecto('Webmail 2.1'), get_tarea('Desarrollo'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('A', 20, 'Iteración 3', get_proyecto('Webmail 2.1'), get_tarea('Desarrollo'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('I', 2, 'Implementación Sucursal Central', get_proyecto('Webmail 2.1'), get_tarea('Implementación'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('E', 3, 'Implementación Sucursal Liniers', get_proyecto('Webmail 2.1'), get_tarea('Implementación'));

-- Proyecto del enunciado
INSERT INTO PROYECTOS 
(DESCRIPCION)
SELECT 'Proyecto A';
 
INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('A', 30, 'Tarea 1', get_proyecto('Proyecto A'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('E', 15, 'Tarea 2', get_proyecto('Proyecto A'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID)
VALUES
('I', 25, 'Tarea 3', get_proyecto('Proyecto A'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('I', 8, 'subtarea 1', get_proyecto('Proyecto A'), get_tarea('Tarea 2'));

INSERT INTO TAREAS
(COMPLEJIDAD, TIEMPO, DESCRIPCION, PROYECTO_ID, TAREAPADRE_ID)
VALUES
('E', 5, 'subtarea 2', get_proyecto('Proyecto A'), get_tarea('Tarea 2'));


