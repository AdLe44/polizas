CREATE OR REPLACE FUNCTION fn_insert_empleado (
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_puesto VARCHAR(100)
)
RETURNS INT AS $$
DECLARE
    v_id_empleado INT;
    v_count INT;
BEGIN
    -- Verificar si la combinación de nombre y apellido ya existe
    SELECT COUNT(*) INTO v_count
    FROM Empleado
    WHERE Nombre = p_nombre AND Apellido = p_apellido;

    IF v_count > 0 THEN
        RAISE EXCEPTION 'El empleado con nombre % y apellido % ya existe', p_nombre, p_apellido;
    END IF;

    -- Insertar el nuevo empleado
    INSERT INTO Empleado (Nombre, Apellido, Puesto)
    VALUES (p_nombre, p_apellido, p_puesto)
    RETURNING IdEmpleado INTO v_id_empleado;

    RETURN v_id_empleado;
END;
$$ LANGUAGE plpgsql;