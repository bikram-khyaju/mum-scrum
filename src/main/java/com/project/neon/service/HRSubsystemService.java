package com.project.neon.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Role;
import com.project.neon.repository.EmployeeRepository;
import com.project.neon.subsystem.HRSubsystem;

@Transactional
@Service
public class HRSubsystemService implements HRSubsystem {

	@Autowired
	private EmployeeRepository employeeRepository;

	@Override
	public List<Employee> getEmployeeList() {
		return employeeRepository.findAllByEnabled(true);
	}

	@Override
	public void updateEmployeeProfile(Employee employee) {
		employeeRepository.save(employee);
	}

	@Override
	public Employee getEmployeeById(int id) {
		return employeeRepository.findOne(id);
	}

	@Override
	public List<Employee> listEmployeeByRole(String role) {
		List<Employee> employees = employeeRepository.findAll();
		List<Employee> empToReturn = new ArrayList<>();
		for (Employee emp : employees) {
			for (Role roles : emp.getRoles()) {
				if (roles.getRole().equals(role))
					empToReturn.add(emp);
			}
		}
		return empToReturn;
	}

}
