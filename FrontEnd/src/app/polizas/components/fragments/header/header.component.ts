import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, NavigationEnd } from '@angular/router';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css'],
  standalone: true,
  imports: [CommonModule]
})
export class HeaderComponent implements OnInit {
  pageTitle: string = '';

  constructor(private router: Router) { }

  ngOnInit(): void {
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd)
    ).subscribe(() => {
      this.updatePageTitle();
    });
  }

  updatePageTitle(): void {
    const currentRoute = this.router.url;
    if (currentRoute.includes('/polizas/empleados')) {
      this.pageTitle = 'Empleados';
    } else if (currentRoute.includes('/polizas/inventario')) {
      this.pageTitle = 'Inventario';
    } else if (currentRoute.includes('/polizas')) {
      this.pageTitle = 'Polizas';
    } else {
      this.pageTitle = '';
    }
  }
}