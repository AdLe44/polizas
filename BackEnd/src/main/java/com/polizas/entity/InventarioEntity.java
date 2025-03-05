package com.polizas.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class InventarioEntity {

    @Id
    private String sku;
    private String nombre;
    private int cantidad;
}