CREATE OR REPLACE FUNCTION fn_read_inventario (
    IN p_sku VARCHAR(10) DEFAULT NULL
)
RETURNS TABLE (
    sku VARCHAR(10),
    nombre VARCHAR(100),
    cantidad INT
) AS $$
BEGIN
    IF p_sku IS NULL THEN
        RETURN QUERY
        SELECT i.SKU, i.Nombre, i.Cantidad
        FROM Inventario i;
    ELSE
        RETURN QUERY
        SELECT i.SKU, i.Nombre, i.Cantidad
        FROM Inventario i
        WHERE i.SKU = p_sku;
    END IF;
END;
$$ LANGUAGE plpgsql;