package com.polizas.controller;

import com.polizas.dto.PolizaDTO;
import com.polizas.entity.PolizaEntity;
import com.polizas.service.PolizaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/polizas")
public class PolizaController {

    @Autowired
    private PolizaService polizaService;

    @GetMapping("/{id}")
    public Map<String, Object> getPolizaById(@PathVariable Integer id) {
        List<PolizaEntity> polizaList = polizaService.getPolizaById(id);
        return formatPolizaResponse(polizaList);
    }

    @GetMapping
    public Map<String, Object> getAllPolizas() {
        List<PolizaEntity> polizaList = polizaService.getAllPolizas();
        return formatPolizaResponse(polizaList);
    }

    private Map<String, Object> formatPolizaResponse(List<PolizaEntity> polizaList) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> meta = new HashMap<>();
        meta.put("Status", "OK");
        response.put("Meta", meta);

        if (!polizaList.isEmpty()) {
            PolizaEntity poliza = polizaList.get(0);
            Map<String, Object> data = new HashMap<>();
            Map<String, Object> polizaData = new HashMap<>();
            polizaData.put("IDPoliza", poliza.getIdPoliza());
            polizaData.put("Cantidad", poliza.getCantidad());
            data.put("Poliza", polizaData);

            Map<String, Object> empleadoData = new HashMap<>();
            empleadoData.put("Nombre", poliza.getNombreEmpleado());
            empleadoData.put("Apellido", poliza.getApellidoEmpleado());
            data.put("Empleado", empleadoData);

            Map<String, Object> articuloData = new HashMap<>();
            articuloData.put("SKU", poliza.getSku());
            articuloData.put("Nombre", poliza.getNombreArticulo());
            data.put("DetalleArticulo", articuloData);

            response.put("Data", data);
        }

        return response;
    }
}