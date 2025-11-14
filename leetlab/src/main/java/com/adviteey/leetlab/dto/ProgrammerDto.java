package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Programmer;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProgrammerDto {
    private String name;
    private String email;
    private String password;

    public ProgrammerDto(Programmer programmer) {
        this.name = programmer.getName();
        this.email = programmer.getEmail();
        this.password = programmer.getPassword();
    }
}
