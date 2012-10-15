-- 6 que el tiempo de una tarea esté en el rango de los 2..50 días
ALTER TABLE TAREAS
ADD CONSTRAINT CHK_TIEMPO CHECK (TIEMPO < 50);

INSERT INTO TAREAS
(Complejidad, Tiempo, Descripcion, Proyecto_Id)
VALUES
('E', 150, 'Actualizacion modelo de datos', 4);

delete 
  FROM TAREAS where id = 17;




