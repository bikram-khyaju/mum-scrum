package com.project.neon.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.neon.entity.Sprint;

public interface SprintRepository extends JpaRepository<Sprint, Integer> {
	Sprint findOneByName(String name);

	List<Sprint> findAllByEnabled(boolean b);
}
