import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Empleado } from '../../models/empleado.model';
import { environment } from '../../../environments/environment.develop';

@Injectable({providedIn: 'root'})
export class GetEmpleadosService {
    private apiUrl = `${environment.apiUrl}/empleados`;
    constructor(private http: HttpClient) { }

    getEmpleados(): Observable<Empleado[]> {
        return this.http.get<Empleado[]>(this.apiUrl);
    }

    getEmpleadoById(id: number): Observable<Empleado> {
        const url = `${this.apiUrl}/${id}`;
        return this.http.get<Empleado>(url);
    }
}