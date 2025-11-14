package com.adviteey.leetlab.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class LeetException extends RuntimeException{
    private final HttpStatus status;
    public LeetException(String message,HttpStatus status){
        super(message);
        this.status = status;
    }
}
