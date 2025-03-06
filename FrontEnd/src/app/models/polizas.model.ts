import { Empleado } from './empleado.model';
import { Inventario } from './inventario.model';

export interface Poliza {
    idPoliza: number;
    empleado: Empleado;
    inventario: Inventario;
    cantidad: number;
    fecha: Date;
}