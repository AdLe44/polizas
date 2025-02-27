CREATE OR REPLACE FUNCTION fn_update_inventario (
    IN p_sku VARCHAR(10),
    IN p_nombre VARCHAR(100),
    IN p_cantidad INT
)
RETURNS VARCHAR(10) AS $$
DECLARE
    v_sku VARCHAR(10);
BEGIN
    UPDATE Inventario
    SET Nombre = p_nombre,
        Cantidad = p_cantidad
    WHERE SKU = p_sku
    RETURNING SKU INTO v_sku;

    RETURN v_sku;
END;
$$ LANGUAGE plpgsql;