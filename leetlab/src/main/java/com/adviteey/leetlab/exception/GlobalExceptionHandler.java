package com.adviteey.leetlab.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    private ResponseEntity<Map<String, Object>> buildErrorResponse(
            String message,
            HttpStatus status,
            HttpServletRequest request) {

        Map<String, Object> map = new HashMap<>();
        map.put("timestamp", LocalDateTime.now().toString());
        map.put("message", message);
        map.put("status", status.value());
        map.put("error", status.getReasonPhrase());
        map.put("path", request.getRequestURI());

        return new ResponseEntity<>(map, status);
    }

    @ExceptionHandler(LeetException.class)
    public ResponseEntity<Map<String, Object>> handleLeetException(
            LeetException ex,
            HttpServletRequest request) {

        return buildErrorResponse(ex.getMessage(), ex.getStatus(), request);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> handleException(
            Exception ex,
            HttpServletRequest request) {

        return buildErrorResponse(
                "An unexpected error occurred: " + ex.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR,
                request
        );
    }
}