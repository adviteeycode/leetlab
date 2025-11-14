package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Submission;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class SubmissionDto {
    private Integer languageId;
    private String language;
    private String code;
    private String status;
    private String time;
    private String memory;
    private Integer passedTestcases;
    private Integer totalTestcases;
    private LocalDateTime submittedAt;

    private Long problemId;
    private String problemTitle;

    private Long programmerId;
    private String programmerName;

    public SubmissionDto(Submission submission) {
        this.languageId = submission.getLanguageId();
        this.language = submission.getLanguage();
        this.code = submission.getCode();
        this.status = submission.getStatus();
        this.time = submission.getTime();
        this.memory = submission.getMemory();
        this.passedTestcases = submission.getPassedTestcases();
        this.totalTestcases = submission.getTotalTestcases();
        this.submittedAt = submission.getSubmittedAt();

        if (submission.getProblem() != null) {
            this.problemId = submission.getProblem().getId();
            this.problemTitle = submission.getProblem().getTitle();
        }

        if (submission.getProgrammer() != null) {
            this.programmerId = submission.getProgrammer().getId();
            this.programmerName = submission.getProgrammer().getName();
        }
    }

}