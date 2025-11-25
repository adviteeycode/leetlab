package com.adviteey.leetlab.service;

import com.adviteey.leetlab.dto.Judge0Submission;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.*;

@Service
public class Judge0Service {

    private final WebClient webClient;
    private final String judge0Url;
    private final String rapidApiHost;
    private final String rapidApiKey;

    public Judge0Service(
            @Value("${judge0.api.url}") String judge0Url,
            @Value("${judge0.api.host}") String rapidApiHost,
            @Value("${judge0.api.key}") String rapidApiKey
    ) {
        this.webClient = WebClient.builder().build();
        this.judge0Url = judge0Url;
        this.rapidApiHost = rapidApiHost;
        this.rapidApiKey = rapidApiKey;
    }

    public Mono<List<Map<String, Object>>> executeBatch(List<Judge0Submission> submissions) {
        Map<String, Object> payload = Map.of("submissions", submissions);

        return webClient.post()
                .uri(judge0Url + "/submissions/batch?base64_encoded=false&wait=true")
                .header("Content-Type", "application/json")
                .header("X-RapidAPI-Host", rapidApiHost)
                .header("X-RapidAPI-Key", rapidApiKey)
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<List<Map<String, Object>>>() {});
    }

    // Fetch a single submission result by token
    public Mono<Map<String, Object>> getSubmissionByToken(String token) {
        return webClient.get()
                .uri(judge0Url + "/submissions/" + token + "?base64_encoded=false")
                .header("X-RapidAPI-Host", rapidApiHost)
                .header("X-RapidAPI-Key", rapidApiKey)
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<Map<String, Object>>() {});
    }
}