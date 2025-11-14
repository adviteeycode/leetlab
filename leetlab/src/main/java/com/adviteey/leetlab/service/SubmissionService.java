package com.adviteey.leetlab.service;

import com.adviteey.leetlab.dto.SubmissionDto;
import com.adviteey.leetlab.exception.LeetException;
import com.adviteey.leetlab.model.Problem;
import com.adviteey.leetlab.model.Programmer;
import com.adviteey.leetlab.model.Submission;
import com.adviteey.leetlab.repository.ProblemRepository;
import com.adviteey.leetlab.repository.ProgrammerRepository;
import com.adviteey.leetlab.repository.SubmissionRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SubmissionService {

    @Autowired
    private SubmissionRepository submissionRepository;

    @Autowired
    private ProblemRepository problemRepository;

    @Autowired
    private ProgrammerRepository programmerRepository;


    public List<SubmissionDto> findAll() {
        List<Submission> submissions = submissionRepository.findAll();
        List<SubmissionDto> submissionDtos = new ArrayList<>();
        for (Submission submission : submissions) {
            submissionDtos.add(new SubmissionDto(submission));
        }
        return submissionDtos;
    }

    public SubmissionDto findById(Long id) {
        Submission submission = submissionRepository.findById(id).orElseThrow(() -> new LeetException("Submission not found.", HttpStatus.NOT_FOUND));
        return new SubmissionDto(submission);
    }

    public List<SubmissionDto> findByProgrammerId(Long programmerId) {
        List<Submission> submissions = submissionRepository.findByProgrammerId(programmerId);
        List<SubmissionDto> submissionDtos = new ArrayList<>();
        for (Submission submission : submissions) {
            submissionDtos.add(new SubmissionDto(submission));
        }
        return submissionDtos;
    }

    public List<SubmissionDto> findByProblemIdAndProgrammerId(Long problemId, Long programmerId) {
        List<Submission> submissions = submissionRepository.findByProgrammerIdAndProblemId(programmerId, problemId);
        List<SubmissionDto> submissionDtos = new ArrayList<>();
        for (Submission submission : submissions) {
            submissionDtos.add(new SubmissionDto(submission));
        }
        return submissionDtos;
    }

    public Submission saveWithProgrammer(Map<String, String> result, Long programmerId) {
        // Fetch the programmer
        Programmer programmer = programmerRepository.findById(programmerId)
                .orElseThrow(() -> new LeetException("Programmer not found", HttpStatus.NOT_FOUND));

        // Extract data from result map
        Long problemId = Long.parseLong(result.get("problemId"));
        Integer languageId = Integer.parseInt(result.get("languageId"));
        String languageName = result.get("languageName");
        String code = result.get("code");
        String status = result.get("status");

        // Parse testcase string like "4/5"
        String testcaseStr = result.get("testcase");
        String[] parts = testcaseStr.split("/");
        Integer passedTestcases = Integer.parseInt(parts[0]);
        Integer totalTestcases = Integer.parseInt(parts[1]);

        // Fetch the problem
        Problem problem = problemRepository.findById(problemId)
                .orElseThrow(() -> new LeetException("Problem not found", HttpStatus.NOT_FOUND));

        // Create submission
        Submission submission = new Submission();
        submission.setProblem(problem);
        submission.setProgrammer(programmer);
        submission.setLanguageId(languageId);
        submission.setLanguage(languageName);
        submission.setCode(code);
        submission.setStatus(status.equalsIgnoreCase("ACCEPTED") ? "ACCEPTED" : "WRONG_ANSWER");
        submission.setPassedTestcases(passedTestcases);
        submission.setTotalTestcases(totalTestcases);
        submission.setSubmittedAt(LocalDateTime.now());
        submission.setTime(result.getOrDefault("time", null));
        submission.setMemory(result.getOrDefault("memory", null));

        return submissionRepository.save(submission);
    }
}