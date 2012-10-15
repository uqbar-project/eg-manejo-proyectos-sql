 
-- 3 Cuál es el costo de una tarea
DROP FUNCTION IF EXISTS CostoTarea;

DELIMITER //

CREATE FUNCTION CostoTarea(TareaDescripcion VARCHAR(150)) RETURNS NUMERIC(11, 2)
BEGIN
   DECLARE CostoBase NUMERIC(11, 2) DEFAULT 0;
   DECLARE CostoDefault NUMERIC(11, 2) DEFAULT 0;
   DECLARE TareaConOverhead BOOLEAN DEFAULT FALSE;

   SELECT COMPLEJIDAD, TIEMPO, ID
     INTO @Complejidad, @Tiempo, @Id_Tarea
     FROM TAREAS
    WHERE DESCRIPCION = TareaDescripcion
    LIMIT 1;
   
   SET CostoDefault = 25 * @Tiempo;

    CASE @Complejidad
    WHEN 'A' THEN 
    BEGIN
        SET CostoBase = CostoDefault * 1.07;
        IF (@Tiempo > 10) THEN
            SET CostoBase = CostoBase + ((@Tiempo - 10) * 10);
        END IF;
    END;
    WHEN 'E' THEN SET CostoBase = CostoDefault * 1.05;
    WHEN 'I' THEN SET CostoBase = CostoDefault;
    END CASE;

   IF (EXISTS(
          SELECT *
            FROM TAREAS_CON_OVERHEAD
           WHERE TAREAPADRE_ID = @Id_Tarea)) THEN
       SET TareaConOverhead = TRUE;
    END IF;

    IF (TareaConOverhead) THEN
       SET CostoBase = CostoBase * 1.04;
    END IF;

   SELECT SUM(VALOR)
     INTO @TotalImpuestos
     FROM IMPUESTOS I,
          TAREASIMPUESTOS TI
    WHERE TI.IMPUESTO_ID = I.ID
      AND TI.TAREA_ID = @Id_Tarea
    LIMIT 1;

    IF (@TotalImpuestos > 0) THEN
       SET CostoBase = CostoBase * (1 + (@TotalImpuestos / 100));
    END IF;
    
    RETURN CostoBase;
    
END //

DELIMITER ;