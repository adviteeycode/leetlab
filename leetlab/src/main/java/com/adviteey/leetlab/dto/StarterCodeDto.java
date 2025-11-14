package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.StarterCode;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StarterCodeDto {
    private String code;
    private String method;
    private int languageId;
    private String language;

    public StarterCodeDto(StarterCode starterCode){
        this.code = starterCode.getCode();
        this.method = starterCode.getMethod();
        this.languageId = starterCode.getLanguageId();
        this.language = starterCode.getLanguage();
    }
}
