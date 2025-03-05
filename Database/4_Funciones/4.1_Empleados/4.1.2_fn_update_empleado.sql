CREATE OR REPLACE FUNCTION fn_update_empleado (
    IN p_id_empleado INT,
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_puesto VARCHAR(100)
)
RETURNS INT AS $$
DECLARE
    v_id_empleado INT;
    v_count INT;
BEGIN
    -- Verificar si la combinación de nombre y apellido ya existe en otro registro
    SELECT COUNT(*) INTO v_count
    FROM Empleado
    WHERE Nombre = p_nombre AND Apellido = p_apellido AND IdEmpleado <> p_id_empleado;

    IF v_count > 0 THEN
        RAISE EXCEPTION 'El empleado con nombre % y apellido % ya existe', p_nombre, p_apellido
        USING ERRCODE = 'P0001';
    END IF;

    -- Actualizar el empleado
    UPDATE Empleado
    SET Nombre = p_nombre,
        Apellido = p_apellido,
        Puesto = p_puesto
    WHERE IdEmpleado = p_id_empleado
    RETURNING IdEmpleado INTO v_id_empleado;

    RETURN v_id_empleado;
END;
$$ LANGUAGE plpgsql;