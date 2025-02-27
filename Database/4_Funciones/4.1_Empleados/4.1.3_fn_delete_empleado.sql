CREATE OR REPLACE FUNCTION fn_delete_empleado (
    IN p_id_empleado INT
)
RETURNS INT AS $$
DECLARE
    v_id_empleado INT;
BEGIN
    DELETE FROM Empleado
    WHERE IdEmpleado = p_id_empleado
    RETURNING IdEmpleado INTO v_id_empleado;

    RETURN v_id_empleado;
END;
$$ LANGUAGE plpgsql;