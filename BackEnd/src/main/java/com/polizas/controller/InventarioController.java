package com.polizas.controller;

import com.polizas.dto.InventarioDTO;
import com.polizas.entity.InventarioEntity;
import com.polizas.service.InventarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inventario")
public class InventarioController {

    @Autowired
    private InventarioService inventarioService;

    @GetMapping("/{sku}")
    public List<InventarioEntity> getInventarioBySku(@PathVariable String sku) {
        return inventarioService.getInventarioBySku(sku);
    }

    @GetMapping
    public List<InventarioEntity> getAllInventario() {
        return inventarioService.getAllInventario();
    }

    @PostMapping
    public String insertInventario(@RequestBody InventarioDTO inventarioDTO) {
        return inventarioService.insertInventario(inventarioDTO.getSku(), inventarioDTO.getNombre(), inventarioDTO.getCantidad());
    }

    @PutMapping("/{sku}")
    public String updateInventario(@PathVariable String sku, @RequestBody InventarioDTO inventarioDTO) {
        return inventarioService.updateInventario(sku, inventarioDTO.getNombre(), inventarioDTO.getCantidad());
    }

    @DeleteMapping("/{sku}")
    public String deleteInventario(@PathVariable String sku) {
        return inventarioService.deleteInventario(sku);
    }
}