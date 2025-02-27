CREATE OR REPLACE FUNCTION fn_update_poliza (
    IN p_id_poliza INT,
    IN p_empleado_genero INT,
    IN p_sku VARCHAR(10),
    IN p_cantidad INT,
    IN p_fecha DATE
)
RETURNS INT AS $$
DECLARE
    v_id_poliza INT;
    v_cantidad_original INT;
    v_diferencia INT;
BEGIN
    -- Obtener la cantidad original de la poliza
    SELECT Cantidad INTO v_cantidad_original
    FROM Polizas
    WHERE IdPoliza = p_id_poliza;

    -- Calcular la diferencia entre la cantidad original y la cantidad actualizada
    v_diferencia := p_cantidad - v_cantidad_original;

    -- Verificar si hay suficiente cantidad en el inventario si la diferencia es positiva
    IF v_diferencia > 0 THEN
        IF (SELECT Cantidad FROM Inventario WHERE SKU = p_sku) < v_diferencia THEN
            RAISE EXCEPTION 'Cantidad insuficiente en el inventario';
        END IF;
    END IF;

    -- Actualizar la tabla Polizas
    UPDATE Polizas
    SET EmpleadoGenero = p_empleado_genero,
        SKU = p_sku,
        Cantidad = p_cantidad,
        Fecha = p_fecha
    WHERE IdPoliza = p_id_poliza
    RETURNING IdPoliza INTO v_id_poliza;

    -- Ajustar la cantidad en la tabla Inventario
    IF v_diferencia <> 0 THEN
        UPDATE Inventario
        SET Cantidad = Cantidad - v_diferencia
        WHERE SKU = p_sku;
    END IF;

    RETURN v_id_poliza;
END;
$$ LANGUAGE plpgsql;