SELECT CostoTarea('Tarea 1');

SELECT CostoTarea('Tarea 2');

SELECT CostoTarea('subtarea 1');

SELECT *
  FROM TAREAS
WHERE DESCRIPCION = 'Tarea 1';
  
UPDATE TAREAS
SET COMPLEJIDAD = 'A'
WHERE ID = 9;