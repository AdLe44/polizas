CREATE TABLE Inventario (
    SKU VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
	Cantidad INT NOT NULL
);

CREATE TABLE Empleado (
    IdEmpleado SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
	Apellido VARCHAR(100) NOT NULL,
	Puesto VARCHAR(100) NOT NULL
);

CREATE TABLE Polizas (
    IdPoliza SERIAL PRIMARY KEY,
	EmpleadoGenero SERIAL,
	SKU VARCHAR(10),
	Cantidad INT NOT NULL,
    Fecha DATE NOT NULL,
    CONSTRAINT fk_poliza_empleado
        FOREIGN KEY (EmpleadoGenero)
        REFERENCES Empleado(IdEmpleado),
	CONSTRAINT fk_poliza_invantario
        FOREIGN KEY (SKU) 
        REFERENCES Inventario(SKU)
);