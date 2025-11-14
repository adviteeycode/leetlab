package com.adviteey.leetlab.dto;

import com.adviteey.leetlab.model.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class ProblemDto {
    private Long id;
    private String title;
    private String description;
    private Difficulty difficulty;
    private List<String> topics;
    private List<StarterCodeDto> starterCodes;
    private List<TestcaseDto> testcases;
    private List<ExampleDto> examples;
    private List<ProblemConstraintDto> constraints;
    private List<HintDto> hints;

    public ProblemDto() {}
    public ProblemDto(Problem problem) {
        this.id = problem.getId();
        this.title = problem.getTitle();
        this.description = problem.getDescription();
        this.difficulty = problem.getDifficulty();

        List<String> topics = new ArrayList<>();
        for(Topic topic : problem.getTopics()){
            topics.add(topic.getName());
        }
        this.topics = topics;
        List<TestcaseDto> testcases = new ArrayList<>();
        for(Testcase testcase : problem.getTestcases()){
            if(!testcase.isHidden()){ // ensure only public testcases
                testcases.add(new TestcaseDto(testcase));
            }
        }
        this.testcases = testcases;

        List<ExampleDto> examples = new ArrayList<>();
        for(Example example : problem.getExamples()){
            examples.add(new ExampleDto(example));
        }
        this.examples = examples;
        List<ProblemConstraintDto> constraints = new ArrayList<>();
        for(ProblemConstraint problemConstraint : problem.getProblemConstraints()){
            constraints.add(new ProblemConstraintDto(problemConstraint));
        }
        this.constraints = constraints;
        List<HintDto> hints = new ArrayList<>();
        for(Hint hint : problem.getHints()){
            hints.add(new HintDto(hint));
        }
        this.hints = hints;

        List<StarterCodeDto> starterCodes = new ArrayList<>();
        for(StarterCode starterCode : problem.getStarterCodes()){
            starterCodes.add(new StarterCodeDto(starterCode));
        }
        this.starterCodes= starterCodes;
    }
}



@Data
class ProblemSummaryDto {
    private Long id;
    private String title;
    private String description;
    private Difficulty difficulty;

    public ProblemSummaryDto() {}
    public ProblemSummaryDto(Problem problem) {
        this.id = problem.getId();
        this.title = problem.getTitle();
        this.description = problem.getDescription();
        this.difficulty = problem.getDifficulty();
    }
}