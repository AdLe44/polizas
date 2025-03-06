import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { PolizasComponent } from './components/inicio/polizas.component';
import { EmpleadosComponent } from './components/empleados/empleados.component';
import { InventarioComponent } from './components/inventario/inventario.component';

const routes: Routes = [
    {
        path: '',
        component: PolizasComponent
    },
    {
        path: 'empleados',
        component: EmpleadosComponent
    },
    {
        path: 'inventario',
        component: InventarioComponent
    },
    {
        path: '**',
        component: PolizasComponent
    }
];

@NgModule({
    imports: [
        CommonModule,
        RouterModule.forChild(routes)
    ],
    declarations: [],
    exports: [
        RouterModule
    ]
})
export class PolizasModule { }