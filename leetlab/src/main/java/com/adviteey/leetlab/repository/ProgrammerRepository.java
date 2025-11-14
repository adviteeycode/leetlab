package com.adviteey.leetlab.repository;

import com.adviteey.leetlab.model.Programmer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProgrammerRepository extends JpaRepository<Programmer, Long> {
    Optional<Programmer> findByEmail(String email);
}