package com.project.neon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.neon.entity.UserStory;
import com.project.neon.entity.Sprint;
import com.project.neon.repository.EstimationRepository;
import com.project.neon.repository.SprintRepository;
import com.project.neon.repository.UserStoryRepository;

@Service
public class BurndownChartService {
	@Autowired
	private SprintRepository sprintRepository;
	
	@Autowired
	private UserStoryRepository userstoryRepository;
	
	@Autowired
	private EstimationRepository estimationRepository;
	
	public Sprint getSprint(String name){
		Sprint s = sprintRepository.findOneByName(name);
		return s;
	}

	public List<Sprint> getAllSprints() {
		// TODO Auto-generated method stub
		return sprintRepository.findAll();
	}

	public List<UserStory> getAllUserStoryBySprint(Sprint sprint) {
		// TODO Auto-generated method stub
		return userstoryRepository.findAllBySprint(sprint);
	}
}
