package com.polizas.repository;

import com.polizas.entity.InventarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InventarioRepository extends JpaRepository<InventarioEntity, String> {

    @SuppressWarnings("null")
    @Query(value = "SELECT * FROM fn_read_inventario()", nativeQuery = true)
    List<InventarioEntity> findAll();

    @Query(value = "SELECT * FROM fn_read_inventario(:sku)", nativeQuery = true)
    List<InventarioEntity> findBySku(@Param("sku") String sku);

    @Query(value = "SELECT fn_insert_inventario(:sku, :nombre, :cantidad)", nativeQuery = true)
    String insertInventario(@Param("sku") String sku, @Param("nombre") String nombre, @Param("cantidad") int cantidad);

    @Query(value = "SELECT fn_update_inventario(:sku, :nombre, :cantidad)", nativeQuery = true)
    String updateInventario(@Param("sku") String sku, @Param("nombre") String nombre, @Param("cantidad") int cantidad);

    @Query(value = "SELECT fn_delete_inventario(:sku)", nativeQuery = true)
    String deleteInventario(@Param("sku") String sku);
}