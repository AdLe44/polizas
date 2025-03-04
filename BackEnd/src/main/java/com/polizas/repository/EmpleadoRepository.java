package com.polizas.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.polizas.entity.EmpleadoEntity;

@Repository
public interface EmpleadoRepository extends JpaRepository<EmpleadoEntity, Integer> {

    @Query(value = "SELECT * FROM fn_read_empleado(:idEmpleado)", nativeQuery = true)
    List<EmpleadoEntity> findEmpleadoById(@Param("idEmpleado") Integer idEmpleado);

    @Query(value = "SELECT * FROM fn_read_empleado()", nativeQuery = true)
    List<EmpleadoEntity> findAllEmpleados();

    @Query(value = "SELECT fn_insert_empleado(:nombre, :apellido, :puesto)", nativeQuery = true)
    Integer insertEmpleado(@Param("nombre") String nombre, @Param("apellido") String apellido, @Param("puesto") String puesto);

    @Query(value = "SELECT fn_update_empleado(:idEmpleado, :nombre, :apellido, :puesto)", nativeQuery = true)
    Integer updateEmpleado(@Param("idEmpleado") Integer idEmpleado, @Param("nombre") String nombre, @Param("apellido") String apellido, @Param("puesto") String puesto);

    @Query(value = "SELECT fn_delete_empleado(:idEmpleado)", nativeQuery = true)
    Integer deleteEmpleado(@Param("idEmpleado") Integer idEmpleado);
}