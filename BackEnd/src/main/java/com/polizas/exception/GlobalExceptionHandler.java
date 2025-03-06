// filepath: c:\Users\nem.madrian\Documents\DEV\PERSONAL\polizas\BackEnd\src\main\java\com\polizas\exception\GlobalExceptionHandler.java
package com.polizas.exception;

import java.util.HashMap;
import java.util.Map;

import org.postgresql.util.PSQLException;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(PSQLException.class)
    public ResponseEntity<Map<String, String>> handlePSQLException(PSQLException ex, WebRequest request) {
        Map<String, String> response = new HashMap<>();
        
        switch (ex.getSQLState()) {
            case "P0001":
                response.put("error", "El empleado con el nombre y apellido especificados ya existe");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            case "P0002":
                response.put("error", "El puesto especificado no es válido. Debe ser 'Gerente' o 'Vendedor'");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            case "P0003":
                response.put("error", "Cantidad insuficiente en el inventario");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            default:
                response.put("error", "JDBC exception executing SQL");
                return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
    }

    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<Map<String, String>> handleDataAccessException(DataAccessException ex, WebRequest request) {
        Map<String, String> response = new HashMap<>();
        
        Throwable rootCause = ex.getRootCause();
        if (rootCause instanceof PSQLException) {
            PSQLException psqlException = (PSQLException) rootCause;
            switch (psqlException.getSQLState()) {
                case "P0001":
                    response.put("error", "El empleado con el nombre y apellido especificados ya existe");
                    return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
                case "P0002":
                    response.put("error", "El puesto especificado no es válido. Debe ser 'Gerente' o 'Vendedor'");
                    return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
                case "P0003":
                    response.put("error", "Cantidad insuficiente en el inventario");
                    return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
                default:
                    response.put("error", "Database access error");
                    return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
            }
        }
        
        response.put("error", "Database access error");
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> handleGlobalException(Exception ex, WebRequest request) {
        Map<String, String> response = new HashMap<>();
        response.put("error", "An unexpected error occurred");
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}