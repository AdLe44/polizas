package com.polizas.health;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Component
public class DatabaseHealthIndicator implements HealthIndicator {

    @Value("${spring.datasource.url}")
    private String dbUrl;

    @Value("${spring.datasource.username}")
    private String dbUsername;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    @Override
    public Health health() {
        try (Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword)) {
            if (connection.isValid(2)) {
                return Health.up().withDetail("Database", "Database is up!").build();
            } else {
                return Health.down().withDetail("Database", "Database is down!").build();
            }
        } catch (SQLException e) {
            return Health.down(e).withDetail("Database", "Database is down!").build();
        }
    }
}