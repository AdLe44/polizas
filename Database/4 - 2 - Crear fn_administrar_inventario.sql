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
DECLARE
    v_old_cantidad INT;
    diff INT;
    v_tipo_movimiento VARCHAR(20);
    v_sku VARCHAR(10);
    v_nombre VARCHAR(100);
    v_cantidad INT;
BEGIN
    IF p_accion = 'CREATE' THEN
        -- Insertar el nuevo producto y capturar los valores retornados
        INSERT INTO Inventario (SKU, Nombre, Cantidad)
        VALUES (p_sku, p_nombre, p_cantidad)
        RETURNING SKU, Nombre, Cantidad INTO v_sku, v_nombre, v_cantidad;
        
        -- Registrar el movimiento en el inventario (Creacion)
        INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha)
        VALUES (v_sku, 0, p_cantidad, 'Creacion', CURRENT_TIMESTAMP);
        
        RETURN QUERY
        SELECT v_sku AS sku, v_nombre AS nombre, v_cantidad AS cantidad;
        
    ELSIF p_accion = 'READ' THEN
        RETURN QUERY
        SELECT SKU, Nombre, Cantidad
        FROM Inventario
        WHERE SKU = p_sku;
        
    ELSIF p_accion = 'READ_ALL' THEN
        RETURN QUERY
        SELECT SKU, Nombre, Cantidad
        FROM Inventario;
        
    ELSIF p_accion = 'UPDATE' THEN
        -- Obtener la cantidad actual antes de la actualización
        SELECT Cantidad INTO v_old_cantidad
        FROM Inventario
        WHERE SKU = p_sku;
        
        -- Actualizar el producto
        UPDATE Inventario
        SET Nombre = p_nombre,
            Cantidad = p_cantidad
        WHERE SKU = p_sku;
        
        diff := p_cantidad - v_old_cantidad;
        
        IF diff > 0 THEN
            v_tipo_movimiento := 'Incremento';
        ELSIF diff < 0 THEN
            v_tipo_movimiento := 'Decremento';
        ELSE
            v_tipo_movimiento := 'Actualizacion';
        END IF;
        
        -- Registrar el movimiento correspondiente a la actualización
        INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha)
        VALUES (p_sku, v_old_cantidad, diff, v_tipo_movimiento, CURRENT_TIMESTAMP);
        
        RETURN QUERY
        SELECT SKU, Nombre, Cantidad
        FROM Inventario
        WHERE SKU = p_sku;
        
    ELSIF p_accion = 'DELETE' THEN
        RETURN QUERY
        DELETE FROM Inventario
        WHERE SKU = p_sku
        RETURNING SKU, Nombre, Cantidad;
        
    ELSE
        RAISE EXCEPTION 'Acción no válida. Use CREATE, READ, READ_ALL, UPDATE o DELETE';
    END IF;
END;
$$ LANGUAGE plpgsql;