package com.coppel.crud_adrileal.repository;

import com.coppel.crud_adrileal.entity.HealthCheck;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface HealthCheckRepository extends CrudRepository<HealthCheck, Long> {
    @Query(value = "SELECT 1", nativeQuery = true)
    Integer healthCheck();
}