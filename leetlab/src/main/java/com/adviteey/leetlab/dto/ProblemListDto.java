package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Difficulty;
import com.adviteey.leetlab.model.Problem;
import com.adviteey.leetlab.model.Topic;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class ProblemListDto {
    private Long id;
    private String title;
    private Difficulty difficulty;
    private Long likes;
    private List<String> topics;

    public ProblemListDto() {}
    public ProblemListDto(Problem problem) {
        this.id = problem.getId();
        this.title = problem.getTitle();
        this.difficulty = problem.getDifficulty();
        List<String> topics = new ArrayList<>();
        for(Topic topic: problem.getTopics()) {
            topics.add(topic.getName());
        }
        this.likes = problem.getLikes();
        this.topics = topics;
    }
}
