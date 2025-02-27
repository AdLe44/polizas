CREATE OR REPLACE FUNCTION fn_delete_poliza (
    IN p_id_poliza INT
)
RETURNS INT AS $$
DECLARE
    v_id_poliza INT;
    v_sku VARCHAR(10);
    v_cantidad INT;
BEGIN
    -- Obtener la SKU y la cantidad de la poliza a eliminar
    SELECT SKU, Cantidad INTO v_sku, v_cantidad
    FROM Polizas
    WHERE IdPoliza = p_id_poliza;

    -- Eliminar la poliza
    DELETE FROM Polizas
    WHERE IdPoliza = p_id_poliza
    RETURNING IdPoliza INTO v_id_poliza;

    -- Restaurar la cantidad en la tabla Inventario
    UPDATE Inventario
    SET Cantidad = Cantidad + v_cantidad
    WHERE SKU = v_sku;

    RETURN v_id_poliza;
END;
$$ LANGUAGE plpgsql;