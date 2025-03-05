package com.polizas.dto;

import lombok.Data;

@Data
public class PolizaDTO {
    private int idPoliza;
    private int cantidad;
    private String nombreEmpleado;
    private String apellidoEmpleado;
    private String sku;
    private String nombreArticulo;
}