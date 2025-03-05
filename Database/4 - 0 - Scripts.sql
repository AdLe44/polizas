-- Crear un nuevo empleado
SELECT fn_insert_empleado('Gabriel', 'Valdez', 'Gerente');

-- Leer un empleado
SELECT * FROM fn_read_empleado(1);

-- Leer todos los empleados
SELECT * FROM fn_read_empleado();

-- Actualizar un empleado existente
SELECT fn_update_empleado(1, 'Gabriel Antonio', 'Valdez Montes', 'Gerente');

-- Eliminar un empleado
SELECT fn_delete_empleado(1);

-- Crear un nuevo inventario
SELECT fn_insert_inventario('00000', 'Producto prueba', 20);

-- Leer un inventario
SELECT * FROM fn_read_inventario('12345');

-- Leer todos los inventarios
SELECT * FROM fn_read_inventario();

-- Actualizar un inventario existente
SELECT fn_update_inventario('00000', 'Prueba', 100);

-- Eliminar un inventario
SELECT fn_delete_inventario('00000');

-- Crear una nueva póliza
SELECT fn_insert_poliza(1, '00000', 10, '2025-02-10');

-- Leer una póliza
SELECT * FROM fn_read_poliza(1);

-- Leer todas las póliza
SELECT * FROM fn_read_poliza();

-- Actualizar una póliza
SELECT fn_update_poliza(1, 2, '00000', 15, '2025-02-11');

-- Eliminar una póliza
SELECT fn_delete_poliza(1);