package com.adviteey.leetlab.service;

import com.adviteey.leetlab.dto.ProblemDto;
import com.adviteey.leetlab.dto.ProblemListDto;
import com.adviteey.leetlab.exception.LeetException;
import com.adviteey.leetlab.model.*;
import com.adviteey.leetlab.repository.ProblemRepository;
import com.adviteey.leetlab.repository.TopicRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProblemService {

    @Autowired
    private ProblemRepository problemRepository;

    @Autowired
    private TopicRepository topicRepository;

    @Transactional(readOnly = true)
    public List<ProblemListDto> getAll() {
        List<Problem> problems = problemRepository.findAll();
        if(problems.isEmpty())
            throw new LeetException("No Problem found.", HttpStatus.NOT_FOUND);

        return problems.stream()
                .map(ProblemListDto::new)
                .toList();
    }

    public ProblemDto createProblem(Problem problem) {
        if(problem.getId() != null)
            throw new LeetException("Id is not required at this moment: " + problem.getId(), HttpStatus.BAD_REQUEST);

        // Process topics: find existing or create new ones
        if(problem.getTopics() != null && !problem.getTopics().isEmpty()) {
            List<Topic> processedTopics = new ArrayList<>();
            for(Topic topic : problem.getTopics()) {
                if(topic.getName() == null || topic.getName().trim().isEmpty()) {
                    throw new LeetException("Topic name cannot be empty", HttpStatus.BAD_REQUEST);
                }
                Optional<Topic> existingTopic = topicRepository.findByName(topic.getName().toUpperCase().trim());
                if(existingTopic.isPresent()) {
                    processedTopics.add(existingTopic.get());
                } else {
                    Topic newTopic = new Topic();
                    newTopic.setName(topic.getName().toUpperCase().trim());
                    processedTopics.add(topicRepository.save(newTopic));
                }
            }

            problem.setTopics(processedTopics);
        }

        if(problem.getTestcases() != null && !problem.getTestcases().isEmpty()) {
            for(Testcase testcase : problem.getTestcases()) {
                testcase.setProblem(problem);
            }
        }
        if(problem.getProblemConstraints() != null && !problem.getProblemConstraints().isEmpty()) {
            for(ProblemConstraint problemConstraint : problem.getProblemConstraints()) {
                problemConstraint.setProblem(problem);
            }
        }
        if(problem.getExamples() != null && !problem.getExamples().isEmpty()) {
            for(Example example : problem.getExamples()) {
                example.setProblem(problem);
            }
        }
        if(problem.getHints() != null && !problem.getHints().isEmpty()) {
            for(Hint hint : problem.getHints()) {
                hint.setProblem(problem);
            }
        }

        if(problem.getStarterCodes() != null && !problem.getStarterCodes().isEmpty()) {
            for(StarterCode starterCode : problem.getStarterCodes()) {
                starterCode.setProblem(problem);
            }
        }

        Problem saved = problemRepository.save(problem);
        return new ProblemDto(saved);
    }

    @Transactional(readOnly = true)
    public ProblemDto getProblemById(Long id) {
        Problem problem = problemRepository.findById(id)
                .orElseThrow(() -> new LeetException("Problem not found with id: " + id, HttpStatus.NOT_FOUND));
        return new ProblemDto(problem);
    }

    @Transactional(readOnly = true)
    public List<ProblemListDto> getProblemsByDifficulty(Difficulty difficulty) {
        List<Problem> problems = problemRepository.findProblemsByDifficulty(difficulty)
                .orElseThrow(() -> new LeetException("Problem not found with difficulty: " + difficulty, HttpStatus.NOT_FOUND));

        return problems.stream()
                .map(ProblemListDto::new)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<ProblemListDto> getProblemsByTopic(String topicName) {
        List<Problem> problems = problemRepository.findProblemsByTopicName(topicName.toUpperCase())
                .orElseThrow(() -> new LeetException(
                        "No problems found with topic: " + topicName,
                        HttpStatus.NOT_FOUND
                ));

        return problems.stream()
                .map(ProblemListDto::new)
                .toList();
    }

    public ProblemDto updateProblem(Long id, Problem problem) {
        Problem existing = problemRepository.findById(id)
                .orElseThrow(() -> new LeetException("Problem not found with id: " + id, HttpStatus.NOT_FOUND));

        existing.setTitle(problem.getTitle());
        existing.setDescription(problem.getDescription());
        existing.setDifficulty(problem.getDifficulty());

        // Process topics
        if(problem.getTopics() != null) {
            List<Topic> processedTopics = new ArrayList<>();

            for(Topic topic : problem.getTopics()) {
                if(topic.getName() == null || topic.getName().trim().isEmpty()) {
                    throw new LeetException("Topic name cannot be empty", HttpStatus.BAD_REQUEST);
                }

                Optional<Topic> existingTopic = topicRepository.findByName(topic.getName().trim());

                if(existingTopic.isPresent()) {
                    processedTopics.add(existingTopic.get());
                } else {
                    Topic newTopic = new Topic();
                    newTopic.setName(topic.getName().trim());
                    processedTopics.add(topicRepository.save(newTopic));
                }
            }

            existing.getTopics().clear();
            existing.setTopics(processedTopics);
        } else {
            existing.getTopics().clear();
        }

        existing.getTestcases().clear();
        for(Testcase testcase : problem.getTestcases()) {
            testcase.setProblem(existing);  // Set the relationship
            testcase.setId(null);  // Ensure new testcases are created
            existing.getTestcases().add(testcase);
        }

        existing.getExamples().clear();
        for(Example example : problem.getExamples()) {
            example.setProblem(existing);
            example.setId(null);
            existing.getExamples().add(example);
        }

        existing.getHints().clear();
        for(Hint hint : problem.getHints()) {
            hint.setProblem(existing);
            hint.setId(null);
            existing.getHints().add(hint);
        }

        existing.getProblemConstraints().clear();
        for(ProblemConstraint problemConstraint : problem.getProblemConstraints()) {
            problemConstraint.setProblem(existing);
            problemConstraint.setId(null);
            existing.getProblemConstraints().add(problemConstraint);
        }
        Problem saved = problemRepository.save(existing);
        return new ProblemDto(saved);
    }

    public ProblemDto updateProblemParts(Long id, Problem problem) {
        Problem existing = problemRepository.findById(id)
                .orElseThrow(() -> new LeetException("Problem not found with id: " + id, HttpStatus.NOT_FOUND));

        if(problem.getTitle() != null)
            existing.setTitle(problem.getTitle());

        if(problem.getDescription() != null)
            existing.setDescription(problem.getDescription());

        if(problem.getDifficulty() != null)
            existing.setDifficulty(problem.getDifficulty());

        if(problem.getTopics() != null) {
            List<Topic> processedTopics = new ArrayList<>();

            for(Topic topic : problem.getTopics()) {
                if(topic.getName() == null || topic.getName().trim().isEmpty()) {
                    throw new LeetException("Topic name cannot be empty", HttpStatus.BAD_REQUEST);
                }

                Optional<Topic> existingTopic = topicRepository.findByName(topic.getName().trim());

                if(existingTopic.isPresent()) {
                    processedTopics.add(existingTopic.get());
                } else {
                    Topic newTopic = new Topic();
                    newTopic.setName(topic.getName().trim());
                    processedTopics.add(topicRepository.save(newTopic));
                }
            }



            existing.getTopics().clear();
            existing.setTopics(processedTopics);
        }

        if(problem.getTestcases() != null) {
            existing.getTestcases().clear();

            for(Testcase testcase : problem.getTestcases()) {
                testcase.setProblem(existing);
                testcase.setId(null);  // Create new testcases
                existing.getTestcases().add(testcase);
            }
        }
        if(problem.getProblemConstraints() != null) {
            existing.getProblemConstraints().clear();
            for(ProblemConstraint problemConstraint : problem.getProblemConstraints()) {
                problemConstraint.setProblem(existing);
                problemConstraint.setId(null);
                existing.getProblemConstraints().add(problemConstraint);
            }
        }
        if(problem.getExamples() != null) {
            existing.getExamples().clear();
            for(Example example : problem.getExamples()) {
                example.setProblem(existing);
                example.setId(null);
                existing.getExamples().add(example);
            }
        }
        if(problem.getHints() != null) {
            existing.getHints().clear();
            for(Hint hint : problem.getHints()) {
                hint.setProblem(existing);
                hint.setId(null);
                existing.getHints().add(hint);
            }
        }
        Problem saved = problemRepository.save(existing);
        return new ProblemDto(saved);
    }
}