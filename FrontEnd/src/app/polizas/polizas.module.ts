import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { PolizasComponent } from './polizas.component';

const routes: Routes = [
  {
    path: '',
    component: PolizasComponent
  }
];

@NgModule({
  declarations: [PolizasComponent],
  imports: [
    CommonModule,
    RouterModule.forChild(routes)
  ]
})
export class PolizasModule { }