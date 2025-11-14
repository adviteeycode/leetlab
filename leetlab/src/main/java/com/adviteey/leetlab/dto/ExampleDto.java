package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Example;
import lombok.Data;

@Data
public class ExampleDto {
    private String input;
    private String explanation;
    private String output;

    public ExampleDto(){}

    public ExampleDto(Example example) {
        this.input = example.getInput();
        this.output = example.getOutput();
        this.explanation = example.getExplanation();
    }
}
