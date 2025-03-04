package com.polizas.controller;

import com.polizas.dto.EmpleadoDTO;
import com.polizas.entity.EmpleadoEntity;
import com.polizas.service.EmpleadoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/empleados")
public class EmpleadoController {

    @Autowired
    private EmpleadoService empleadoService;

    @GetMapping("/{id}")
    public List<EmpleadoEntity> getEmpleadoById(@PathVariable Integer id) {
        return empleadoService.getEmpleadoById(id);
    }

    @GetMapping
    public List<EmpleadoEntity> getAllEmpleados() {
        return empleadoService.getAllEmpleados();
    }

    @PostMapping
    public Integer insertEmpleado(@RequestBody EmpleadoDTO empleadoDTO) {
        return empleadoService.insertEmpleado(empleadoDTO.getNombre(), empleadoDTO.getApellido(), empleadoDTO.getPuesto());
    }

    @PutMapping("/{id}")
    public Integer updateEmpleado(@PathVariable Integer id, @RequestBody EmpleadoDTO empleadoDTO) {
        return empleadoService.updateEmpleado(id, empleadoDTO.getNombre(), empleadoDTO.getApellido(), empleadoDTO.getPuesto());
    }

    @DeleteMapping("/{id}")
    public Integer deleteEmpleado(@PathVariable Integer id) {
        return empleadoService.deleteEmpleado(id);
    }
}