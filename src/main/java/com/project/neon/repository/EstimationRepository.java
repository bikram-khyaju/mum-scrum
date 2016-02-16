package com.project.neon.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.neon.entity.Estimation;
import com.project.neon.entity.UserStory;

public interface EstimationRepository extends JpaRepository<Estimation, Integer>{

	List<Estimation> findAllByUserStory(UserStory us);
	
}
