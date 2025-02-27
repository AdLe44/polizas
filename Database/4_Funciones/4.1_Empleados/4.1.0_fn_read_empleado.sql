CREATE OR REPLACE FUNCTION fn_read_empleado (
    IN p_id_empleado INT DEFAULT NULL
)
RETURNS TABLE (
    id_empleado INT,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    puesto VARCHAR(100)
) AS $$
BEGIN
    IF p_id_empleado IS NULL THEN
        RETURN QUERY
        SELECT IdEmpleado, Nombre, Apellido, Puesto
        FROM Empleado;
    ELSE
        RETURN QUERY
        SELECT IdEmpleado, Nombre, Apellido, Puesto
        FROM Empleado
        WHERE IdEmpleado = p_id_empleado;
    END IF;
END;
$$ LANGUAGE plpgsql;