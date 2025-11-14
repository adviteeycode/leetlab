package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.ProblemConstraint;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ProblemConstraintDto {
    private String text;
    private Boolean valueConstraint;

    public ProblemConstraintDto(ProblemConstraint problemConstraint) {
        this.text = problemConstraint.getText();
        this.valueConstraint = problemConstraint.getValueConstraint();
    }
}
