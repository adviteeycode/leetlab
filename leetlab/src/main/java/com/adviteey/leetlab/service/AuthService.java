package com.adviteey.leetlab.service;

import com.adviteey.leetlab.dto.LoginDto;
import com.adviteey.leetlab.dto.ProgrammerDto;
import com.adviteey.leetlab.exception.LeetException;
import com.adviteey.leetlab.model.Programmer;
import com.adviteey.leetlab.repository.ProgrammerRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Transactional
public class AuthService {

    @Autowired
    private ProgrammerRepository programmerRepository;

    public ProgrammerDto register(Programmer programmer) {
        // Validate email
        if(programmer.getEmail() == null || programmer.getEmail().trim().isEmpty()){
            throw new LeetException("Email is required", HttpStatus.BAD_REQUEST);
        }

        // Validate password
        if(programmer.getPassword() == null || programmer.getPassword().trim().isEmpty()){
            throw new LeetException("Password is required", HttpStatus.BAD_REQUEST);
        }

        // Check if email already exists
        if(programmerRepository.findByEmail(programmer.getEmail()).isPresent()) {
            throw new LeetException("Email id already exists: " + programmer.getEmail(), HttpStatus.CONFLICT);
        }

        // Set name if not provided
        if(programmer.getName() == null || programmer.getName().trim().isEmpty()){
            programmer.setName(programmer.getEmail().trim().replace("@gmail.com", ""));
        }

        // Save programmer
        Programmer saved = programmerRepository.save(programmer);

        return new ProgrammerDto(saved);
    }

    public LoginDto login(Programmer programmer) {
        // Validate email
        if(programmer.getEmail() == null || programmer.getEmail().trim().isEmpty()){
            throw new LeetException("Email is required", HttpStatus.BAD_REQUEST);
        }

        // Validate password
        if(programmer.getPassword() == null || programmer.getPassword().trim().isEmpty()){
            throw new LeetException("Password is required", HttpStatus.BAD_REQUEST);
        }

        // Find programmer by email
        Optional<Programmer> savedProgrammer = programmerRepository.findByEmail(programmer.getEmail());

        if(savedProgrammer.isPresent()){
            if(savedProgrammer.get().getPassword().equals(programmer.getPassword())){
                return new LoginDto("TokenToken", "Logged In Successfully");
            }
            throw new LeetException("Invalid password", HttpStatus.UNAUTHORIZED);
        }

        throw new LeetException("Email not found", HttpStatus.NOT_FOUND);
    }
}