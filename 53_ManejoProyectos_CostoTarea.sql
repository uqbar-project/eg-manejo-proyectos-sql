-- \CONNECT manejo_proyectos;
 
-- 3 Cuál es el costo de una tarea
DROP FUNCTION IF EXISTS CostoTarea;

CREATE FUNCTION CostoTarea(TareaDescripcion VARCHAR(150)) RETURNS NUMERIC(11, 2)
language plpgsql  
as  
$$

DECLARE ComplejidadTarea CHARACTER VARYING(1) DEFAULT 0;
DECLARE TiempoTarea INTEGER DEFAULT 0;
DECLARE Id_Tarea INTEGER DEFAULT 0;
DECLARE TotalImpuestos NUMERIC(18,0) DEFAULT 0;
DECLARE CostoBase NUMERIC(11, 2) DEFAULT 0;
DECLARE CostoDefault NUMERIC(11, 2);
BEGIN   
   SELECT COMPLEJIDAD, TIEMPO, ID
     INTO ComplejidadTarea, TiempoTarea, Id_Tarea
     FROM TAREAS
    WHERE DESCRIPCION = TareaDescripcion
    LIMIT 1;
   
   CostoDefault := 25 * TiempoTarea;

    CASE ComplejidadTarea
    WHEN 'A' THEN 
    BEGIN
        CostoBase := CostoDefault * 1.07;
        IF (TiempoTarea > 10) THEN
            CostoBase := CostoBase + ((TiempoTarea - 10) * 10);
        END IF;
    END;
    WHEN 'E' THEN CostoBase := CostoDefault * 1.05;
    WHEN 'I' THEN CostoBase := CostoDefault;
    END CASE;

   IF (EXISTS(
          SELECT *
            FROM TAREAS_CON_OVERHEAD
           WHERE TAREAPADRE_ID = Id_Tarea)) THEN
       CostoBase := CostoBase * 1.04;
    END IF;

   SELECT SUM(VALOR)
     INTO TotalImpuestos
     FROM IMPUESTOS I,
          TAREASIMPUESTOS TI
    WHERE TI.IMPUESTO_ID = I.ID
      AND TI.TAREA_ID = @Id_Tarea
    LIMIT 1;

    IF (TotalImpuestos > 0) THEN
       CostoBase := CostoBase * (1 + (TotalImpuestos / 100));
    END IF;
    
    RETURN CostoBase;
    
END;
$$;

-- Luego se ejecuta con
-- SELECT CostoTarea('Desarrollo');