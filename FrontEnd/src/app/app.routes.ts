import { Routes } from '@angular/router';

export const routes: Routes = [
  {
    path: 'polizas',
    loadChildren: () => import('./polizas/polizas.module').then(m => m.PolizasModule)
  },
  {
    path: '',
    redirectTo: '/polizas',
    pathMatch: 'full'
  },
  {
    path: '**',
    redirectTo: '/polizas'
  }
];