package com.polizas.controller;

import com.polizas.repository.HealthCheckRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class PolizasController {

    @Autowired
    private HealthCheckRepository healthCheckRepository;

    @GetMapping("/hello")
    public String hello() {
        return "Hello, World!";
    }

    @GetMapping("/healthcheck")
    public String healthCheck() {
        Integer result = healthCheckRepository.healthCheck();
        return result != null && result == 1 ? "Database is up!" : "Database is down!";
    }
}