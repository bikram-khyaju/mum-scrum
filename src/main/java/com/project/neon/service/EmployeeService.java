package com.project.neon.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Employee;
import com.project.neon.repository.EmployeeRepository;

@Service
@Transactional
public class EmployeeService {

	@Autowired
	private EmployeeRepository employeeRepository;

	public void saveEmployee(Employee employee) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		employee.setEnabled(true);
		employee.setPassword(encoder.encode(employee.getPassword()));
		employeeRepository.save(employee);
	}

	public Employee findByUsername(String username) {
		return employeeRepository.findOneByUsername(username);
	}

	public void deleteEmployee(int id) {
		Employee employee = employeeRepository.findOne(id);
		employee.setEnabled(false);
		employeeRepository.save(employee);
	}

	public Employee findByEmail(String email) {
		return employeeRepository.findOneByEmail(email);
	}

}
