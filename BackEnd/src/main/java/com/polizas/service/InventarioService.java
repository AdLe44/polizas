package com.polizas.service;

import com.polizas.entity.InventarioEntity;
import com.polizas.repository.InventarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InventarioService {

    @Autowired
    private InventarioRepository inventarioRepository;

    public List<InventarioEntity> getInventarioBySku(String sku) {
        return inventarioRepository.findBySku(sku);
    }

    public List<InventarioEntity> getAllInventario() {
        return inventarioRepository.findAll();
    }

    public String insertInventario(String sku, String nombre, int cantidad) {
        return inventarioRepository.insertInventario(sku, nombre, cantidad);
    }

    public String updateInventario(String sku, String nombre, int cantidad) {
        return inventarioRepository.updateInventario(sku, nombre, cantidad);
    }

    public String deleteInventario(String sku) {
        return inventarioRepository.deleteInventario(sku);
    }
}