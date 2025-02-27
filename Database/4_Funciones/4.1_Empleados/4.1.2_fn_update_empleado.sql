CREATE OR REPLACE FUNCTION fn_update_empleado (
    IN p_id_empleado INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_puesto VARCHAR(100)
)
RETURNS INT AS $$
DECLARE
    v_id_empleado INT;
BEGIN
    UPDATE Empleado
    SET Nombre = p_nombre,
        Apellido = p_apellido,
        Puesto = p_puesto
    WHERE IdEmpleado = p_id_empleado
    RETURNING IdEmpleado INTO v_id_empleado;

    RETURN v_id_empleado;
END;
$$ LANGUAGE plpgsql;