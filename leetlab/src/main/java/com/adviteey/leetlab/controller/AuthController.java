package com.adviteey.leetlab.controller;

import com.adviteey.leetlab.dto.LoginDto;
import com.adviteey.leetlab.dto.ProgrammerDto;
import com.adviteey.leetlab.model.Programmer;
import com.adviteey.leetlab.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<ProgrammerDto> register(@RequestBody Programmer programmer) {
        return ResponseEntity.ok(authService.register(programmer));
    }

    @PostMapping("/login")
    public ResponseEntity<LoginDto> login(@RequestBody Programmer programmer) {
        return ResponseEntity.ok(authService.login(programmer));
    }
}
