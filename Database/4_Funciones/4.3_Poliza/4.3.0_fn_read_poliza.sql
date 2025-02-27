CREATE OR REPLACE FUNCTION fn_read_poliza (
    IN p_id_poliza INT DEFAULT NULL
)
RETURNS TABLE (
    id_poliza INT,
    cantidad INT,
    nombre_empleado VARCHAR(100),
    apellido_empleado VARCHAR(100),
    sku VARCHAR(10),
    nombre_articulo VARCHAR(100)
) AS $$
BEGIN
    IF p_id_poliza IS NULL THEN
        RETURN QUERY
        SELECT 
            p.IdPoliza AS id_poliza,
            p.Cantidad AS cantidad,
            e.Nombre AS nombre_empleado,
            e.Apellido AS apellido_empleado,
            i.SKU AS sku,
            i.Nombre AS nombre_articulo
        FROM Polizas p
        JOIN Empleado e ON p.EmpleadoGenero = e.IdEmpleado
        JOIN Inventario i ON p.SKU = i.SKU;
    ELSE
        RETURN QUERY
        SELECT 
            p.IdPoliza AS id_poliza,
            p.Cantidad AS cantidad,
            e.Nombre AS nombre_empleado,
            e.Apellido AS apellido_empleado,
            i.SKU AS sku,
            i.Nombre AS nombre_articulo
        FROM Polizas p
        JOIN Empleado e ON p.EmpleadoGenero = e.IdEmpleado
        JOIN Inventario i ON p.SKU = i.SKU
        WHERE p.IdPoliza = p_id_poliza;
    END IF;
END;
$$ LANGUAGE plpgsql;