import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { Empleado } from '../../../../models/empleado.model';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-empleado-modal',
  templateUrl: './empleado-modal.component.html',
  styleUrls: ['./empleado-modal.component.css'],
  standalone: true,
  imports: [CommonModule, FormsModule]
})
export class EmpleadoModalComponent implements OnInit {
  @Input() empleado: Empleado | null = null;
  @Input() isViewMode: boolean = false;

  constructor(public activeModal: NgbActiveModal) {}

  ngOnInit(): void {
    if (!this.empleado) {
      this.empleado = { nombre: '', apellido: '', puesto: '' } as Empleado;
    }
  }

  save(): void {
    this.activeModal.close('save');
  }

  cancel(): void {
    this.activeModal.dismiss('cancel');
  }
}