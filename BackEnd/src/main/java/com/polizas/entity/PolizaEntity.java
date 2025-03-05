package com.polizas.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class PolizaEntity {

    @Id
    private int idPoliza;
    private int cantidad;
    private String nombreEmpleado;
    private String apellidoEmpleado;
    private String sku;
    private String nombreArticulo;
}