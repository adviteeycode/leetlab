package com.adviteey.leetlab.repository;

import com.adviteey.leetlab.model.Difficulty;
import com.adviteey.leetlab.model.Problem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProblemRepository extends JpaRepository<Problem, Long> {
    Optional<List<Problem>> findProblemsByDifficulty(Difficulty difficulty);
    @Query("SELECT DISTINCT p FROM Problem p JOIN p.topics t WHERE t.name = :topicName")
    Optional<List<Problem>> findProblemsByTopicName(@Param("topicName") String topicName);
}
