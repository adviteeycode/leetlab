package com.adviteey.leetlab.controller;

import com.adviteey.leetlab.dto.ProblemDto;
import com.adviteey.leetlab.dto.ProblemListDto;
import com.adviteey.leetlab.model.Difficulty;
import com.adviteey.leetlab.model.Problem;
import com.adviteey.leetlab.service.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/problems")
@CrossOrigin("*")
public class ProblemController {

    @Autowired
    private ProblemService problemService;

    @GetMapping
    public ResponseEntity<List<ProblemListDto>> getProblems(){
        return ResponseEntity.ok(problemService.getAll());
    }

    @PostMapping
    public ResponseEntity<ProblemDto> createProblem(@RequestBody Problem problem){
        return ResponseEntity.ok(problemService.createProblem(problem));
    }

    @GetMapping("/{id}")
    public ProblemDto getProblemById(@PathVariable Long id){
        return problemService.getProblemById(id);
    }

    @GetMapping("/difficulty/{difficulty}")
    public ResponseEntity<List<ProblemListDto>> getByDifficulty(@PathVariable Difficulty difficulty){
        return ResponseEntity.ok(problemService.getProblemsByDifficulty(difficulty));
    }

    @GetMapping("/topic/{topicName}")
    public ResponseEntity<List<ProblemListDto>> getByTopic(@PathVariable String topicName){
        return ResponseEntity.ok(problemService.getProblemsByTopic(topicName));
    }

    @PutMapping("/{id}")
    public ProblemDto updateProblem(@PathVariable Long id, @RequestBody Problem problem){
        return problemService.updateProblem(id,problem);
    }

    @PatchMapping("/{id}")
    public ProblemDto patchProblem(@PathVariable Long id, @RequestBody Problem problem){
        return problemService.updateProblemParts(id, problem);
    }
}
