package com.project.neon.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.neon.entity.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

	Employee findOneByName(String name);

	Employee findOneByUsername(String username);

	List<Employee> findAllByEnabled(boolean enabled);

	Employee findOneByEmail(String email);

}
