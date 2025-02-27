CREATE OR REPLACE FUNCTION fn_insert_empleado (
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_puesto VARCHAR(100)
)
RETURNS INT AS $$
DECLARE
    v_id_empleado INT;
BEGIN
    INSERT INTO Empleado (Nombre, Apellido, Puesto)
    VALUES (p_nombre, p_apellido, p_puesto)
    RETURNING IdEmpleado INTO v_id_empleado;

    RETURN v_id_empleado;
END;
$$ LANGUAGE plpgsql;