package com.polizas.repository;

import com.polizas.entity.HealthCheckEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HealthCheckRepository extends CrudRepository<HealthCheckEntity, Long> {
    @Query(value = "SELECT 1", nativeQuery = true)
    Integer healthCheck();
}