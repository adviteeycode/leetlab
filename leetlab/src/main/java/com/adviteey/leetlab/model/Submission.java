package com.adviteey.leetlab.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Submission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Integer languageId;

    private String language;

    @Column(length = 10000, nullable = false)
    private String code;

    private String status; // ACCEPTED, WRONG_ANSWER, TIME_LIMIT_EXCEEDED, etc.

    private String time; // Execution time

    private String memory; // Memory used

    private Integer passedTestcases;

    private Integer totalTestcases;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    @JsonIgnore
    private Problem problem;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "programmer_id", nullable = false)
    @JsonIgnore
    private Programmer programmer;
}