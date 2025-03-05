package com.polizas.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.dao.DataAccessException;
import org.postgresql.util.PSQLException;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(PSQLException.class)
    public ResponseEntity<Map<String, String>> handlePSQLException(PSQLException ex, WebRequest request) {
        Map<String, String> response = new HashMap<>();
        
        if ("P0001".equals(ex.getSQLState())) {
            response.put("error", "El empleado con el nombre y apellido especificados ya existe");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        }
        
        response.put("error", "JDBC exception executing SQL");
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<Map<String, String>> handleDataAccessException(DataAccessException ex, WebRequest request) {
        Map<String, String> response = new HashMap<>();
        
        Throwable rootCause = ex.getRootCause();
        if (rootCause instanceof PSQLException) {
            PSQLException psqlException = (PSQLException) rootCause;
            if ("P0001".equals(psqlException.getSQLState())) {
                response.put("error", "El empleado con el nombre y apellido especificados ya existe");
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
