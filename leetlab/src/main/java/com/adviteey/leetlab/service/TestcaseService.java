package com.adviteey.leetlab.service;

import com.adviteey.leetlab.model.Testcase;
import com.adviteey.leetlab.repository.TestcaseRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestcaseService {
    private final TestcaseRepository testcaseRepository;

    public TestcaseService(TestcaseRepository testcaseRepository) {
        this.testcaseRepository = testcaseRepository;
    }

    public List<Testcase> getAllTestcases(Long problemId) {
        return testcaseRepository.findAllByProblemId(problemId);
    }

    public List<Testcase> getPublicTestcases(Long problemId) {
        return testcaseRepository.findAllByProblemIdAndHiddenFalse(problemId);
    }
}
