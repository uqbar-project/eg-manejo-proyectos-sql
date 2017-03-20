USE manejo_proyectos;

-- 5 Evitar que existan dos tareas con la misma descripcion
CREATE UNIQUE INDEX idxTareasDescripcion
   ON TAREAS (Descripcion)
   
   

