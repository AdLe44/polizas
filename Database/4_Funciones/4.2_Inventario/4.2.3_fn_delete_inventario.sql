CREATE OR REPLACE FUNCTION fn_delete_inventario (
    IN p_sku VARCHAR(10)
)
RETURNS VARCHAR(10) AS $$
DECLARE
    v_sku VARCHAR(10);
BEGIN
    DELETE FROM Inventario
    WHERE SKU = p_sku
    RETURNING SKU INTO v_sku;

    RETURN v_sku;
END;
$$ LANGUAGE plpgsql;