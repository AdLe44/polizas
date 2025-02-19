package com.polizas.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class HealthCheckEntity {

    @Id
    private Long id;

    // Constructor, getters y setters
    public HealthCheckEntity() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}