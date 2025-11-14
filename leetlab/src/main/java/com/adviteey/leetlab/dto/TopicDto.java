package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.Problem;
import com.adviteey.leetlab.model.Topic;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class TopicDto {
    private Long id;
    private String name;
    private List<ProblemSummaryDto> problems;

    public TopicDto() {}
    public TopicDto(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public TopicDto(Topic topic) {
        this.id = topic.getId();
        this.name = topic.getName();
        List<ProblemSummaryDto> problems = new ArrayList<>();
        for(Problem problem : topic.getProblems()){
            problems.add(new ProblemSummaryDto(problem));
        }
        this.problems = problems;
    }
}


//@Data
//class TopicSummaryDto {
//    private String name;
//
//    public TopicSummaryDto() {}
//    public TopicSummaryDto(Topic topic) {
//        this.name = topic.getName();
//    }
//}
