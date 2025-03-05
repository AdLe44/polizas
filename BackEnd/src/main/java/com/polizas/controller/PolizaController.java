package com.polizas.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.polizas.dto.PolizaDTO;
import com.polizas.entity.PolizaEntity;
import com.polizas.service.PolizaService;

@RestController
@RequestMapping("/api/polizas")
public class PolizaController {

    @Autowired
    private PolizaService polizaService;

    @GetMapping("/{id}")
    public Map<String, Object> getPolizaById(@PathVariable Integer id) {
        try {
            List<PolizaEntity> polizaList = polizaService.getPolizaById(id);
            return formatPolizaResponse(polizaList);
        } catch (Exception e) {
            return formatErrorResponse("Ha ocurrido un error al consultar la póliza.");
        }
    }

    @GetMapping
    public Map<String, Object> getAllPolizas() {
        try {
            List<PolizaEntity> polizaList = polizaService.getAllPolizas();
            return formatPolizaResponse(polizaList);
        } catch (Exception e) {
            return formatErrorResponse("Ha ocurrido un error al consultar la póliza.");
        }
    }

    @PostMapping
    public Map<String, Object> insertPoliza(@RequestBody PolizaDTO polizaDTO) {
        try {
            Date parsedDate = polizaDTO.getFecha();
            Integer insertedPolizaId = polizaService.insertPoliza(Integer.valueOf(polizaDTO.getEmpleadoGenero()), polizaDTO.getSku(), polizaDTO.getCantidad(), parsedDate);
            List<PolizaEntity> polizaList = polizaService.getPolizaById(insertedPolizaId);
            return formatPolizaResponse(polizaList);
        } catch (Exception e) {
            return formatErrorResponse("Ha ocurrido un error en los grabados de póliza.");
        }
    }

    @PutMapping("/{id}")
    public Map<String, Object> updatePoliza(@PathVariable Integer id, @RequestBody PolizaDTO polizaDTO) {
        try {
            Date parsedDate = polizaDTO.getFecha();
            Integer updatedPolizaId = polizaService.updatePoliza(id, Integer.valueOf(polizaDTO.getEmpleadoGenero()), polizaDTO.getSku(), polizaDTO.getCantidad(), parsedDate);
            return formatUpdateResponse(updatedPolizaId);
        } catch (Exception e) {
            return formatErrorResponse("Ha ocurrido un error al intentar actualizar la póliza.");
        }
    }

    @DeleteMapping("/{id}")
    public Map<String, Object> deletePoliza(@PathVariable Integer id) {
        try {
            Integer deletedPolizaId = polizaService.deletePoliza(id);
            return formatDeleteResponse(deletedPolizaId);
        } catch (Exception e) {
            return formatErrorResponse("Ha ocurrido un error al intentar eliminar la póliza.");
        }
    }

    private Map<String, Object> formatPolizaResponse(List<PolizaEntity> polizaList) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> meta = new HashMap<>();
        meta.put("Status", "OK");
        response.put("Meta", meta);

        List<Map<String, Object>> dataList = new ArrayList<>();

        for (PolizaEntity poliza : polizaList) {
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

            dataList.add(data);
        }

        response.put("Data", dataList);

        return response;
    }

    private Map<String, Object> formatUpdateResponse(Integer updatedPolizaId) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> meta = new HashMap<>();
        meta.put("Status", "OK");
        response.put("Meta", meta);

        Map<String, Object> data = new HashMap<>();
        Map<String, Object> mensajeData = new HashMap<>();
        mensajeData.put("IDMensaje", "Se actualizó correctamente la poliza " + updatedPolizaId);
        data.put("Mensaje", mensajeData);

        response.put("Data", data);

        return response;
    }

    private Map<String, Object> formatDeleteResponse(Integer deletedPolizaId) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> meta = new HashMap<>();
        meta.put("Status", "OK");
        response.put("Meta", meta);

        Map<String, Object> data = new HashMap<>();
        Map<String, Object> mensajeData = new HashMap<>();
        mensajeData.put("IDMensaje", "Se eliminó correctamente la poliza " + deletedPolizaId);
        data.put("Mensaje", mensajeData);

        response.put("Data", data);

        return response;
    }

    private Map<String, Object> formatErrorResponse(String errorMessage) {
        Map<String, Object> response = new HashMap<>();
        Map<String, Object> meta = new HashMap<>();
        meta.put("Status", "FAILURE");
        response.put("Meta", meta);

        Map<String, Object> data = new HashMap<>();
        data.put("Mensaje", errorMessage);

        response.put("Data", data);

        return response;
    }
}