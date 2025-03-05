package com.polizas.service;

import com.polizas.entity.PolizaEntity;
import com.polizas.repository.PolizaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;

import java.util.List;

@Service
public class PolizaService {

    @Autowired
    private PolizaRepository polizaRepository;

    public List<PolizaEntity> getPolizaById(Integer id) {
        return polizaRepository.findPolizaById(id);
    }

    public List<PolizaEntity> getAllPolizas() {
        return polizaRepository.findAllPolizas();
    }

    public Integer insertPoliza(Integer empleadoGenero, String sku, Integer cantidad, Date fecha) {
        return polizaRepository.insertPoliza(empleadoGenero, sku, cantidad, fecha);
    }

    public Integer updatePoliza(Integer id, Integer empleadoGenero, String sku, Integer cantidad, Date fecha) {
        return polizaRepository.updatePoliza(id, empleadoGenero, sku, cantidad, fecha);
    }

    public Integer deletePoliza(Integer id) {
        return polizaRepository.deletePoliza(id);
    }
}