CREATE OR REPLACE FUNCTION fn_administrar_inventario (
    IN p_accion VARCHAR(10),
	IN p_sku VARCHAR(10),
    IN p_nombre VARCHAR(100),
	IN p_cantidad INT
)
RETURNS TABLE (
	sku VARCHAR(10),
    nombre VARCHAR(100),
	cantidad INT
) AS $$
BEGIN
    IF p_accion = 'CREATE' THEN
        INSERT INTO Inventario (SKU, Nombre, Cantidad)
        VALUES (p_sku, p_nombre, p_cantidad)
        RETURNING SKU AS sku;
    ELSIF p_accion = 'READ' THEN
        RETURN QUERY
        SELECT i.SKU AS sku, i.Nombre AS nombre, i.Cantidad AS cantidad
        FROM Inventario i
        WHERE i.SKU = p_sku;
    ELSIF p_accion = 'READ_ALL' THEN
        RETURN QUERY
        SELECT i.SKU AS sku, i.Nombre AS nombre, i.Cantidad AS cantidad
        FROM Inventario i;
    ELSIF p_accion = 'UPDATE' THEN
        UPDATE Inventario
        SET SKU = p_sku, Nombre = p_nombre, Cantidad = p_cantidad
        WHERE SKU = p_sku
        RETURNING SKU AS sku;
    ELSIF p_accion = 'DELETE' THEN
        DELETE FROM Inventario
        WHERE SKU = p_sku
        RETURNING SKU AS sku;
    ELSE
        RAISE EXCEPTION 'Acción no válida. Use CREATE, READ, READ_ALL, UPDATE o DELETE';
    END IF;
END;
$$ LANGUAGE plpgsql;