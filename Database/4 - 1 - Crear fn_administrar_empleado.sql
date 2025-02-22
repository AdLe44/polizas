CREATE OR REPLACE FUNCTION fn_administrar_empleado (
    IN p_accion VARCHAR(10),
    IN p_id_empleado INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_puesto VARCHAR(100)
)
RETURNS TABLE (
    id_empleado INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    puesto VARCHAR(100)
) AS $$
BEGIN
    IF p_accion = 'CREATE' THEN
        INSERT INTO Empleado (Nombre, Apellido, Puesto)
        VALUES (p_nombre, p_apellido, p_puesto)
        RETURNING IdEmpleado AS id_empleado, Nombre AS nombre, Apellido AS apellido, Puesto AS puesto;
    ELSIF p_accion = 'READ' THEN
        RETURN QUERY
        SELECT e.IdEmpleado AS id_empleado, e.Nombre AS nombre, e.Apellido AS apellido, e.Puesto AS puesto
        FROM Empleado e
        WHERE e.IdEmpleado = p_id_empleado;
    ELSIF p_accion = 'READ_ALL' THEN
        RETURN QUERY
        SELECT e.IdEmpleado AS id_empleado, e.Nombre AS nombre, e.Apellido AS apellido, e.Puesto AS puesto
        FROM Empleado e;
    ELSIF p_accion = 'UPDATE' THEN
        UPDATE Empleado
        SET Nombre = p_nombre, Apellido = p_apellido, Puesto = p_puesto
        WHERE IdEmpleado = p_id_empleado
        RETURNING IdEmpleado AS id_empleado, Nombre AS nombre, Apellido AS apellido, Puesto AS puesto;
    ELSIF p_accion = 'DELETE' THEN
        DELETE FROM Empleado
        WHERE IdEmpleado = p_id_empleado
        RETURNING IdEmpleado AS id_empleado, Nombre AS nombre, Apellido AS apellido, Puesto AS puesto;
    ELSE
        RAISE EXCEPTION 'Acción no válida. Use CREATE, READ, READ_ALL, UPDATE o DELETE';
    END IF;
END;
$$ LANGUAGE plpgsql;