-- \CONNECT manejo_proyectos;

-- 4 Cada vez que se agregue una tarea a un proyecto hay que generar un log, con la fecha, 
-- la descripción del evento ("Alta de tarea") y la referencia a la tarea generada.
DROP TABLE IF EXISTS LogTareas;

CREATE OR REPLACE FUNCTION InsertLog() RETURNS trigger
language plpgsql  
as  
$$

BEGIN   
   INSERT INTO LogTareas
   (DescripcionEvento, Fecha, Tarea_Id)
   VALUES
   ('Alta de Tarea ', now(), NEW.Id);
   RETURN NULL;
END;

$$

CREATE TABLE LogTareas (
  Id SERIAL NOT NULL PRIMARY KEY,
  DescripcionEvento varchar (150) NULL ,
  Fecha TIMESTAMP NOT NULL ,
  Tarea_Id int NOT NULL
) ;


CREATE OR REPLACE TRIGGER AltaTarea 
AFTER INSERT ON TAREAS
FOR EACH ROW 
EXECUTE FUNCTION InsertLog();

INSERT INTO TAREAS
(Complejidad, Tiempo, Descripcion, Proyecto_Id)
VALUES
('E', 50, 'Revision modelo de datos', 4);

SELECT *
  FROM LogTareas;
