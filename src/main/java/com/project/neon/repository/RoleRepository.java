package com.project.neon.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.neon.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {

	/*List<Role> findAllByEmployees(List<Employee> employees);*/
	
}
