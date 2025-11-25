package com.adviteey.leetlab.repository;

import com.adviteey.leetlab.model.Submission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubmissionRepository extends JpaRepository<Submission, Long> {
    List<Submission> findByProgrammerId(Long programmerId);

    List<Submission> findByProgrammerIdAndProblemId(Long programmerId,Long problemId);
}
