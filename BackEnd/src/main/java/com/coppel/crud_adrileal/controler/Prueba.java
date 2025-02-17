package com.coppel.crud_adrileal.controler;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class Prueba {
    @GetMapping("/hello")
    public String hello() {
        return "Hello, World!";
    }
}
