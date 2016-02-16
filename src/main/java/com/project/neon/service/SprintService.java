package com.project.neon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Sprint;
import com.project.neon.entity.UserStory;
import com.project.neon.repository.SprintRepository;
import com.project.neon.repository.UserStoryRepository;

@Service
@Transactional
public class SprintService {

	@Autowired
	private SprintRepository sprintRepository;

	@Autowired
	private UserStoryRepository userStoryRepository;

	public void save(Sprint sprint) {
		if (!sprint.getUserStories().isEmpty()) {
			for (UserStory us : sprint.getUserStories()) {
				us.setSprint(sprint);
				userStoryRepository.save(us);
			}
		}
		sprint.setEnabled(true);
		sprintRepository.save(sprint);
	}

	public List<Sprint> findAllByEnabled() {
		return sprintRepository.findAllByEnabled(true);
	}

	public void delete(int id) {
		Sprint sprint = sprintRepository.getOne(id);
		sprint.setEnabled(false);
		sprintRepository.save(sprint);
	}

	public Sprint findById(int id) {
		return sprintRepository.findOne(id);
	}

}
