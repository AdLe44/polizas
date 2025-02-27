CREATE OR REPLACE FUNCTION fn_insert_inventario (
    IN p_sku VARCHAR(10),
    IN p_nombre VARCHAR(100),
    IN p_cantidad INT
)
RETURNS VARCHAR(10) AS $$
DECLARE
    v_sku VARCHAR(10);
BEGIN
    INSERT INTO Inventario (SKU, Nombre, Cantidad)
    VALUES (p_sku, p_nombre, p_cantidad)
    RETURNING SKU INTO v_sku;

    RETURN v_sku;
END;
$$ LANGUAGE plpgsql;