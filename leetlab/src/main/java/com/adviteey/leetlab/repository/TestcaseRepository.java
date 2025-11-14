package com.adviteey.leetlab.repository;

import com.adviteey.leetlab.model.Testcase;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TestcaseRepository extends JpaRepository<Testcase, Integer> {
    // Fetch all testcases for a given problem
    List<Testcase> findAllByProblemId(Long problemId);

    // Fetch only public (non-hidden) testcases for a given problem
    List<Testcase> findAllByProblemIdAndHiddenFalse(Long problemId);
}
