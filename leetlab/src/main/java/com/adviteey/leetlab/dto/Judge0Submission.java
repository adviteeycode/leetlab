package com.adviteey.leetlab.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Judge0Submission {

    @JsonProperty("language_id")
    private int language_id;

    @JsonProperty("source_code")
    private String source_code;

    @JsonProperty("stdin")
    private String stdin;

    @JsonProperty("expected_output")
    private String expected_output;
}