package com.adviteey.leetlab.controller;

import com.adviteey.leetlab.dto.SubmissionDto;
import com.adviteey.leetlab.service.SubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/submissions")
@CrossOrigin(origins = "*")
public class SubmissionController {

    @Autowired
    private SubmissionService submissionService;

    @GetMapping
    public List<SubmissionDto> findAll() {
        return submissionService.findAll();
    }

    @GetMapping("/{id}")
    public SubmissionDto findById(@PathVariable Long id) {
        return submissionService.findById(id);
    }

    @GetMapping("/programmer/{programmerId}")
    public List<SubmissionDto> findByProgrammerId(@PathVariable Long programmerId) {
        return submissionService.findByProgrammerId(programmerId);
    }

    @GetMapping("/programmer/{programmerId}/problem/{problemId}")
    public List<SubmissionDto> findByProblemIdAndProgrammerId(@PathVariable Long programmerId, @PathVariable Long problemId) {
        return submissionService.findByProblemIdAndProgrammerId(problemId,programmerId);
    }
}