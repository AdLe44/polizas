import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EmpleadosService } from '../../../services/empleados/Empleados.service';
import { Empleado } from '../../../models/empleado.model';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { EmpleadoModalComponent } from './empleado-modal/empleado-modal.component';

@Component({
  selector: 'app-empleados',
  templateUrl: './empleados.component.html',
  styleUrls: ['./empleados.component.css'],
  standalone: true,
  imports: [CommonModule]
})
export class EmpleadosComponent implements OnInit {
  gerentes: Empleado[] = [];
  vendedores: Empleado[] = [];

  constructor(private EmpleadosService: EmpleadosService, private modalService: NgbModal) { }

  ngOnInit(): void {
    this.loadEmpleados();
  }

  loadEmpleados(): void {
    this.EmpleadosService.getEmpleados().subscribe((data: Empleado[]) => {
      this.gerentes = data.filter(empleado => empleado.puesto === 'Gerente');
      this.vendedores = data.filter(empleado => empleado.puesto === 'Vendedor');
    });
  }

  addEmpleado(puesto: string): void {
    const modalRef = this.modalService.open(EmpleadoModalComponent);
    modalRef.componentInstance.empleado = { nombre: '', apellido: '', puesto: puesto } as Empleado;
    modalRef.result.then((result) => {
      if (result === 'save') {
        this.EmpleadosService.addEmpleado(modalRef.componentInstance.empleado).subscribe(() => {
          this.loadEmpleados(); // Actualizar la lista de empleados después de agregar
        });
      }
    }).catch((error) => {
      console.log('Modal dismissed with error:', error);
    });
  }

  viewEmpleado(empleado: Empleado): void {
    const modalRef = this.modalService.open(EmpleadoModalComponent);
    modalRef.componentInstance.empleado = empleado;
    modalRef.componentInstance.isViewMode = true;
  }

  editEmpleado(empleado: Empleado): void {
    const modalRef = this.modalService.open(EmpleadoModalComponent);
    modalRef.componentInstance.empleado = { ...empleado };
    modalRef.result.then((result) => {
      if (result === 'save') {
        this.EmpleadosService.updateEmpleado(empleado.idEmpleado, modalRef.componentInstance.empleado).subscribe(() => {
          this.loadEmpleados(); // Actualizar la lista de empleados después de modificar
        });
      }
    }).catch((error) => {
      console.log('Modal dismissed with error:', error);
    });
  }

  deleteEmpleado(empleado: Empleado): void {
    if (confirm(`¿Estás seguro de que deseas eliminar a ${empleado.nombre}?`)) {
      this.EmpleadosService.deleteEmpleado(empleado.idEmpleado).subscribe(() => {
        this.loadEmpleados(); // Actualizar la lista de empleados después de eliminar
      });
    }
  }
}