/* 
CREATE:
– Se verifica que el SKU exista y que el inventario tenga la cantidad suficiente.
– Se actualiza el inventario restando la cantidad solicitada.
– Se inserta la nueva póliza y se registra el movimiento en InventarioMovimientos con tipo Salida, almacenando además la cantidad original antes de la operación.

UPDATE:
– Se obtiene la póliza actual para saber el SKU y cantidad previos.
– Si el SKU cambia, se revierte la operación en el SKU original (sumando la cantidad previamente retirada y registrando un movimiento de Entrada) y se aplica la nueva operación para el nuevo SKU.
– Si el SKU es el mismo, se calcula la diferencia entre la nueva cantidad y la anterior. Según corresponda, se retira (Salida) o se reintegra (Entrada) la diferencia en el inventario y se registra el movimiento.

DELETE:
– Se obtienen los datos de la póliza a eliminar.
– Se reintegra la cantidad de la póliza al inventario y se registra un movimiento de Entrada.
– Finalmente, se elimina la póliza.
 */
CREATE OR REPLACE FUNCTION fn_administrar_polizas (
    IN p_accion VARCHAR(10),
    IN p_id_poliza INT,
    IN p_empleado_genero INT,
    IN p_sku VARCHAR(10),
    IN p_cantidad INT,
    IN p_fecha DATE
)
RETURNS TABLE (
    id_poliza INT,
    empleado_genero INT,
    sku VARCHAR(10),
    cantidad INT,
    fecha DATE
) AS $$
DECLARE
    current_inventory INT;
    v_inventory_before INT;
    v_poliza_id INT;
    v_old_cantidad INT;
    v_old_sku VARCHAR(10);
    diff INT;
BEGIN
    IF p_accion = 'CREATE' THEN
        -- Verificar inventario para el SKU solicitado
        SELECT Cantidad INTO current_inventory
        FROM Inventario
        WHERE SKU = p_sku;
        IF current_inventory IS NULL THEN
            RAISE EXCEPTION 'El SKU "%" no existe en el inventario.', p_sku;
        END IF;
        IF p_cantidad > current_inventory THEN
            RAISE EXCEPTION 'La cantidad a retirar (%), excede el inventario actual (%)', p_cantidad, current_inventory;
        END IF;
        
        v_inventory_before := current_inventory;
        
        -- Actualizar el inventario restando la cantidad
        UPDATE Inventario
        SET Cantidad = Cantidad - p_cantidad
        WHERE SKU = p_sku;
        
        -- Insertar la nueva póliza y capturar su ID
        INSERT INTO Polizas (EmpleadoGenero, SKU, Cantidad, Fecha)
        VALUES (p_empleado_genero, p_sku, p_cantidad, p_fecha)
        RETURNING IdPoliza INTO v_poliza_id;
        
        -- Registrar el movimiento: salida del inventario
        INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
        VALUES (p_sku, v_inventory_before, p_cantidad, 'Salida', p_fecha, v_poliza_id);
        
        RETURN QUERY
        SELECT IdPoliza, EmpleadoGenero, SKU, Cantidad, Fecha
        FROM Polizas
        WHERE IdPoliza = v_poliza_id;
        
    ELSIF p_accion = 'READ' THEN
        RETURN QUERY
        SELECT IdPoliza, EmpleadoGenero, SKU, Cantidad, Fecha
        FROM Polizas
        WHERE IdPoliza = p_id_poliza;
        
    ELSIF p_accion = 'READ_ALL' THEN
        RETURN QUERY
        SELECT IdPoliza, EmpleadoGenero, SKU, Cantidad, Fecha
        FROM Polizas;
        
    ELSIF p_accion = 'UPDATE' THEN
        -- Obtener los datos actuales de la póliza
        SELECT SKU, Cantidad INTO v_old_sku, v_old_cantidad
        FROM Polizas
        WHERE IdPoliza = p_id_poliza;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'La póliza con Id % no existe.', p_id_poliza;
        END IF;
        
        IF v_old_sku <> p_sku THEN
            -- Si el SKU cambia, se revierte la operación en el SKU original...
            SELECT Cantidad INTO current_inventory FROM Inventario WHERE SKU = v_old_sku;
            v_inventory_before := current_inventory;
            UPDATE Inventario
            SET Cantidad = Cantidad + v_old_cantidad
            WHERE SKU = v_old_sku;
            INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
            VALUES (v_old_sku, v_inventory_before, v_old_cantidad, 'Entrada', p_fecha, p_id_poliza);
            
            -- ...y se aplica la nueva operación en el SKU indicado
            SELECT Cantidad INTO current_inventory FROM Inventario WHERE SKU = p_sku;
            IF current_inventory IS NULL THEN
                RAISE EXCEPTION 'El SKU "%" no existe en el inventario.', p_sku;
            END IF;
            IF p_cantidad > current_inventory THEN
                RAISE EXCEPTION 'La cantidad a retirar (%), excede el inventario actual (%)', p_cantidad, current_inventory;
            END IF;
            v_inventory_before := current_inventory;
            UPDATE Inventario
            SET Cantidad = Cantidad - p_cantidad
            WHERE SKU = p_sku;
            INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
            VALUES (p_sku, v_inventory_before, p_cantidad, 'Salida', p_fecha, p_id_poliza);
        ELSE
            -- Mismo SKU: se ajusta la diferencia de cantidad
            diff := p_cantidad - v_old_cantidad;
            IF diff > 0 THEN
                -- Se requiere retirar cantidad adicional
                SELECT Cantidad INTO current_inventory FROM Inventario WHERE SKU = p_sku;
                IF diff > current_inventory THEN
                    RAISE EXCEPTION 'La cantidad adicional a retirar (%), excede el inventario actual (%)', diff, current_inventory;
                END IF;
                v_inventory_before := current_inventory;
                UPDATE Inventario
                SET Cantidad = Cantidad - diff
                WHERE SKU = p_sku;
                INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
                VALUES (p_sku, v_inventory_before, diff, 'Salida', p_fecha, p_id_poliza);
            ELSIF diff < 0 THEN
                -- Se devuelve parte del inventario
                diff := ABS(diff);
                SELECT Cantidad INTO current_inventory FROM Inventario WHERE SKU = p_sku;
                v_inventory_before := current_inventory;
                UPDATE Inventario
                SET Cantidad = Cantidad + diff
                WHERE SKU = p_sku;
                INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
                VALUES (p_sku, v_inventory_before, diff, 'Entrada', p_fecha, p_id_poliza);
            END IF;
        END IF;
        
        -- Actualizar la póliza con los nuevos datos
        UPDATE Polizas
        SET EmpleadoGenero = p_empleado_genero,
            SKU = p_sku,
            Cantidad = p_cantidad,
            Fecha = p_fecha
        WHERE IdPoliza = p_id_poliza;
        
        RETURN QUERY
        SELECT IdPoliza, EmpleadoGenero, SKU, Cantidad, Fecha
        FROM Polizas
        WHERE IdPoliza = p_id_poliza;
        
    ELSIF p_accion = 'DELETE' THEN
        -- Obtener datos de la póliza a eliminar
        SELECT SKU, Cantidad INTO v_old_sku, v_old_cantidad
        FROM Polizas
        WHERE IdPoliza = p_id_poliza;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'La póliza con Id % no existe.', p_id_poliza;
        END IF;
        
        -- Reintegrar la cantidad de la póliza al inventario
        SELECT Cantidad INTO current_inventory FROM Inventario WHERE SKU = v_old_sku;
        v_inventory_before := current_inventory;
        UPDATE Inventario
        SET Cantidad = Cantidad + v_old_cantidad
        WHERE SKU = v_old_sku;
        INSERT INTO InventarioMovimientos (SKU, CantidadOriginal, Cantidad, TipoMovimiento, Fecha, PolizaID)
        VALUES (v_old_sku, v_inventory_before, v_old_cantidad, 'Entrada', p_fecha, p_id_poliza);
        
        -- Eliminar la póliza
        RETURN QUERY
        DELETE FROM Polizas
        WHERE IdPoliza = p_id_poliza
        RETURNING IdPoliza, EmpleadoGenero, SKU, Cantidad, Fecha;
        
    ELSE
        RAISE EXCEPTION 'Acción no válida. Use CREATE, READ, READ_ALL, UPDATE o DELETE';
    END IF;
END;
$$ LANGUAGE plpgsql;
