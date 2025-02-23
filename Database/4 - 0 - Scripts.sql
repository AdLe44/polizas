-- Crear un nuevo empleado
SELECT * FROM fn_administrar_empleado('CREATE', NULL, 'Juan', 'Pérez', 'Gerente');

-- Leer un empleado
SELECT * FROM fn_administrar_empleado('READ', 1, NULL, NULL, NULL);

-- Actualizar un empleado existente
SELECT * FROM fn_administrar_empleado('UPDATE', 1, 'Juan', 'Pérez', 'Director');

-- Eliminar un empleado
SELECT * FROM fn_administrar_empleado('DELETE', 1, NULL, NULL, NULL);

-- Seleccionar todos los empleados
SELECT * FROM fn_administrar_empleado('READ_ALL', NULL, NULL, NULL, NULL);

-- Crear un nuevo inventario
SELECT * FROM fn_administrar_inventario('CREATE', 'A001', 'Producto A', 100);

-- Leer un inventario
SELECT * FROM fn_administrar_inventario('READ', 'A001', NULL, NULL);

-- Leer todos los inventarios
SELECT * FROM fn_administrar_inventario('READ_ALL', NULL, NULL, NULL);

-- Actualizar un inventario existente
SELECT * FROM fn_administrar_inventario('UPDATE', 'A001', 'Producto A Modificado', 150);

-- Eliminar un inventario
SELECT * FROM fn_administrar_inventario('DELETE', 'A001', NULL, NULL);

-- Crear una nueva póliza
SELECT * FROM fn_administrar_polizas('CREATE', NULL, 1, 'SKU123', 10, '2025-02-22');

-- Leer una póliza
SELECT * FROM fn_administrar_polizas('READ', 1, NULL, NULL, NULL, NULL);

-- Leer todas las póliza
SELECT * FROM fn_administrar_polizas('READ_ALL', NULL, NULL, NULL, NULL, NULL);

-- Actualizar una póliza
SELECT * FROM fn_administrar_polizas('UPDATE', 5, 2, 'SKU123', 10, '2025-02-22');

-- Leer una póliza
SELECT * FROM fn_administrar_polizas('DELETE', 1, NULL, NULL, NULL, '2025-02-22');