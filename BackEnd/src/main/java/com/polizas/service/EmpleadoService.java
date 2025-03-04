package com.polizas.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.polizas.entity.EmpleadoEntity;
import com.polizas.repository.EmpleadoRepository;

@Service
public class EmpleadoService {

    @Autowired
    private EmpleadoRepository empleadoRepository;

    public List<EmpleadoEntity> getEmpleadoById(Integer idEmpleado) {
        return empleadoRepository.findEmpleadoById(idEmpleado);
    }

    public List<EmpleadoEntity> getAllEmpleados() {
        return empleadoRepository.findAllEmpleados();
    }

    public Integer insertEmpleado(String nombre, String apellido, String puesto) {
        return empleadoRepository.insertEmpleado(nombre, apellido, puesto);
    }

    public Integer updateEmpleado(Integer idEmpleado, String nombre, String apellido, String puesto) {
        return empleadoRepository.updateEmpleado(idEmpleado, nombre, apellido, puesto);
    }

    public Integer deleteEmpleado(Integer idEmpleado) {
        return empleadoRepository.deleteEmpleado(idEmpleado);
    }
}