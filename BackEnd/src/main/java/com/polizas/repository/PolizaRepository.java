package com.polizas.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.polizas.entity.PolizaEntity;

@Repository
public interface PolizaRepository extends JpaRepository<PolizaEntity, Integer> {

    @Query(value = "SELECT * FROM fn_read_poliza(:id)", nativeQuery = true)
    List<PolizaEntity> findPolizaById(@Param("id") Integer id);

    @Query(value = "SELECT * FROM fn_read_poliza()", nativeQuery = true)
    List<PolizaEntity> findAllPolizas();

    @Query(value = "SELECT fn_insert_poliza(:empleadoGenero, :sku, :cantidad, :fecha)", nativeQuery = true)
    Integer insertPoliza(@Param("empleadoGenero") Integer empleadoGenero, @Param("sku") String sku, @Param("cantidad") Integer cantidad, @Param("fecha") Date fecha);

    @Query(value = "SELECT fn_update_poliza(:id, :empleadoGenero, :sku, :cantidad, :fecha)", nativeQuery = true)
    Integer updatePoliza(@Param("id") Integer id, @Param("empleadoGenero") Integer empleadoGenero, @Param("sku") String sku, @Param("cantidad") Integer cantidad, @Param("fecha") Date fecha);

    @Query(value = "SELECT fn_delete_poliza(:id)", nativeQuery = true)
    Integer deletePoliza(@Param("id") Integer id);
}