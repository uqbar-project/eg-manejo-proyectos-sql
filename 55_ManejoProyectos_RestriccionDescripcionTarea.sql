-- 5 Evitar que existan dos tareas con la misma descripcion
CREATE UNIQUE INDEX idxTareasDescripcion
   ON Tareas (Descripcion)
   
   

