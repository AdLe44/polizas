CREATE OR REPLACE FUNCTION fn_insert_poliza (
    IN p_empleado_genero INT,
    IN p_sku VARCHAR(10),
    IN p_cantidad INT,
    IN p_fecha DATE
)
RETURNS INT AS $$
DECLARE
    v_id_poliza INT;
BEGIN
    -- Verificar si hay suficiente cantidad en el inventario
    IF (SELECT Cantidad FROM Inventario WHERE SKU = p_sku) < p_cantidad THEN
        RAISE EXCEPTION 'Cantidad insuficiente en el inventario'
        USING ERRCODE = 'P0003';
    END IF;

    -- Insertar en la tabla Polizas
    INSERT INTO Polizas (EmpleadoGenero, SKU, Cantidad, Fecha)
    VALUES (p_empleado_genero, p_sku, p_cantidad, p_fecha)
    RETURNING IdPoliza INTO v_id_poliza;

    -- Reducir la cantidad en la tabla Inventario
    UPDATE Inventario
    SET Cantidad = Cantidad - p_cantidad
    WHERE SKU = p_sku;

    RETURN v_id_poliza;
END;
$$ LANGUAGE plpgsql;