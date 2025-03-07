import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClientModule } from '@angular/common/http';
import { GetEmpleadosService } from '../../../services/empleados/getEmpleados.service';
import { Empleado } from '../../../models/empleado.model';

@Component({
  selector: 'app-empleados',
  templateUrl: './empleados.component.html',
  styleUrls: ['./empleados.component.css'],
  standalone: true,
  imports: [CommonModule, HttpClientModule]
})
export class EmpleadosComponent implements OnInit {
  gerentes: Empleado[] = [];
  vendedores: Empleado[] = [];

  constructor(private getEmpleadosService: GetEmpleadosService) { }

  ngOnInit(): void {
    this.getEmpleadosService.getEmpleados().subscribe((data: Empleado[]) => {
      this.gerentes = data.filter(empleado => empleado.puesto === 'Gerente');
      this.vendedores = data.filter(empleado => empleado.puesto === 'Vendedor');
    });
  }
}