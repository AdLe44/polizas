package com.polizas.dto;

import lombok.Data;

@Data
public class InventarioDTO {
    private String sku;
    private String nombre;
    private int cantidad;
}