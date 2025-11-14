package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Testcase;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
class TestcaseDto {
    private String input;
    private String expectedOutput;

    public TestcaseDto(Testcase testcase) {
        this.input = testcase.getInput();
        this.expectedOutput = testcase.getExpectedOutput();
    }
}