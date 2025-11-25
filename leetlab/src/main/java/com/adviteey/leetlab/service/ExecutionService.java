package com.adviteey.leetlab.service;

import com.adviteey.leetlab.dto.Judge0Submission;
import com.adviteey.leetlab.exception.LeetException;
import com.adviteey.leetlab.model.Testcase;
import com.adviteey.leetlab.repository.TestcaseRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@Transactional
public class ExecutionService {
    @Autowired
    private TestcaseRepository testcaseRepository;

    @Autowired
    private Judge0Service judge0Service;

    @Autowired
    private SubmissionService submissionService;

    public Map<String, String> run(Map<String, String> programRequest, List<Testcase> testcases) {
        int languageId = Integer.parseInt(programRequest.get("languageId"));
        String code = programRequest.get("code");



        List<Judge0Submission> jSubmissions = new ArrayList<>();
        for (Testcase testcase : testcases) {
            jSubmissions.add(new Judge0Submission(
                    languageId,
                    code,
                    testcase.getInput(),
                    testcase.getExpectedOutput() + "\n"
            ));
        }


        List<Map<String, Object>> submissionsResp = judge0Service.executeBatch(jSubmissions).block();

        if (submissionsResp == null || submissionsResp.isEmpty()) {
            throw new LeetException("Judge0 error while batch submission", HttpStatus.EXPECTATION_FAILED);
        }

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new LeetException("Judge0 interrupted while waiting for results", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        List<Map<String, String>> testcaseResult = new ArrayList<>();

        for (int i = 0; i < submissionsResp.size(); i++) {
            String token = (String) submissionsResp.get(i).get("token");
            Map<String, Object> judge0Result = judge0Service.getSubmissionByToken(token).block();

            if (judge0Result == null) {
                throw new LeetException("Judge0 returned null for token: " + token, HttpStatus.BAD_GATEWAY);
            }

            String stdout = getString(judge0Result, "stdout");
            String stderr = getString(judge0Result, "stderr");
            String compileOutput = getString(judge0Result, "compile_output");
            String message = getString(judge0Result, "message");
            String expected = testcases.get(i).getExpectedOutput().trim();
            String input = testcases.get(i).getInput();

            Map<String, Object> status = (Map<String, Object>) judge0Result.get("status");
            String description = status != null ? (String) status.get("description") : "Unknown";

            String time = judge0Result.get("time") != null ? judge0Result.get("time").toString() : "0";
            String memory = judge0Result.get("memory") != null ? judge0Result.get("memory").toString() : "0";

            // --- Prepare Result Map ---
            Map<String, String> result = new HashMap<>();
            result.put("testcase", (i + 1) + "/" + submissionsResp.size());
            result.put("input", input);
            result.put("expected", expected);
            result.put("stdout", stdout);
            result.put("stderr", stderr);
            result.put("compile_output", compileOutput);
            result.put("message", message);
            result.put("status", description);
            result.put("time", time + "s");
            result.put("memory", memory + " KB");

            if (stdout.equals(expected)) {
                result.put("verdict", "Passed");
            } else if (description.equalsIgnoreCase("Compilation Error")) {
                result.put("verdict", "Compilation Error");
            } else if (description.equalsIgnoreCase("Runtime Error")) {
                result.put("verdict", "Runtime Error");
            } else {
                result.put("verdict", "Failed");
            }

            testcaseResult.add(result);
        }

        Map<String, String> finalResult = new HashMap<>();
        boolean allPassed = testcaseResult.stream()
                .allMatch(res -> res.get("verdict").equals("Passed"));

        if (allPassed) {
            finalResult.put("status", "Accepted");
        } else {
            Map<String, String> failed = testcaseResult.stream()
                    .filter(res -> !res.get("verdict").equals("Passed"))
                    .findFirst()
                    .orElse(testcaseResult.get(0));
            finalResult.putAll(failed);
            return finalResult;
        }

        finalResult.put("testcase", testcaseResult.get(testcaseResult.size() - 1).get("testcase"));

        double totalTime = testcaseResult.stream()
                .mapToDouble(r -> {
                    try {
                        return Double.parseDouble(r.get("time").replace("s", ""));
                    } catch (Exception e) {
                        return 0.0;
                    }
                })
                .sum();

        int totalMemory = testcaseResult.stream()
                .mapToInt(r -> {
                    try {
                        return Integer.parseInt(r.get("memory").replace("KB", "").trim());
                    } catch (Exception e) {
                        return 0;
                    }
                })
                .sum();

        finalResult.put("time", String.format("%.3fs", totalTime));
        finalResult.put("memory", totalMemory + " KB");
        finalResult.put("status", "ACCEPTED");
        return finalResult;

    }

    private String getString(Map<String, Object> map, String key) {
        Object value = map.get(key);
        return value != null ? value.toString().trim() : "";
    }

    public Map<String, String> execute(Map<String, String> programRequest, boolean submission) {
        Long problemId = Long.parseLong(programRequest.get("problemId"));
        List<Testcase> testcases;

        if(submission){
            testcases = testcaseRepository.findAllByProblemId(problemId);
        }else{
            testcases = testcaseRepository.findAllByProblemIdAndHiddenFalse(problemId);
        }

        if (testcases.isEmpty()) {
            throw new LeetException("No testcases found for problem ID: " + problemId, HttpStatus.NOT_FOUND);
        }

        Map<String, String> result = run(programRequest, testcases);

        if(submission &&programRequest.containsKey("programmerId")){
            result.put("problemId", String.valueOf(problemId));
            result.put("languageId", programRequest.get("languageId"));
            result.put("languageName", programRequest.get("languageName"));
            result.put("code", programRequest.get("code"));
            Long programmerId = Long.parseLong(programRequest.get("programmerId"));
            submissionService.saveWithProgrammer(result, programmerId);
        }
        return result;
    }
}
