package com.project.neon.subsystem;

import java.util.List;

import com.project.neon.entity.Employee;

public interface HRSubsystem {

	List<Employee> getEmployeeList();

	void updateEmployeeProfile(Employee employee);

	Employee getEmployeeById(int id);

	List<Employee> listEmployeeByRole(String role);

}
