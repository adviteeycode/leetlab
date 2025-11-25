package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Hint;
import lombok.Data;

@Data
public class HintDto {
    private String text;

    public HintDto() {}

    public HintDto(Hint hint) {
        this.text = hint.getText();
    }
}
