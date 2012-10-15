-- 4 Cada vez que se agregue una tarea a un proyecto hay que generar un log, con la fecha, 
-- la descripción del evento ("Alta de tarea") y la referencia a la tarea generada.
DROP TABLE IF EXISTS LogTareas;

CREATE TABLE LogTareas (
  Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
  DescripcionEvento varchar (150) NULL ,
  Fecha datetime NOT NULL ,
  Tarea_Id int NOT NULL
) ;

DELIMITER |

CREATE TRIGGER Alta_Tarea AFTER INSERT ON TAREAS
FOR EACH ROW 
BEGIN
   INSERT INTO LogTareas
   (DescripcionEvento, Fecha, Tarea_Id)
   VALUES
   ('Alta de Tarea ', SYSDATE(), NEW.Id);
END
|

DELIMITER ;

INSERT INTO Tareas
(Complejidad, Tiempo, Descripcion, Proyecto_Id)
VALUES
('E', 50, 'Revision modelo de datos', 4);

SELECT *
  FROM LogTareas;
  
select *
  from Tareas where id = 15;




