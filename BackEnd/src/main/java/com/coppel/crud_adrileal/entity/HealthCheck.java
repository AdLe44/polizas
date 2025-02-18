package com.coppel.crud_adrileal.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class HealthCheck {

    @Id
    private Long id;

    // Constructor, getters y setters
    public HealthCheck() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}