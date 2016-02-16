package com.project.neon.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Sprint;
import com.project.neon.entity.UserStory;

public interface UserStoryRepository extends JpaRepository<UserStory, Integer> {

	List<UserStory> findAllByEmployee(Employee dev);

	UserStory findOneByTitle(String item);

	List<UserStory> findAllBySprint(Sprint sprint);

	List<UserStory> findAllBySprintId(Integer id);

	List<UserStory> findAllByEnabled(boolean b);
}
