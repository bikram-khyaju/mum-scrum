package com.project.neon.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Estimation;
import com.project.neon.entity.Role;
import com.project.neon.entity.Sprint;
import com.project.neon.entity.UserStory;
import com.project.neon.repository.EmployeeRepository;
import com.project.neon.repository.EstimationRepository;
import com.project.neon.repository.RoleRepository;
import com.project.neon.repository.SprintRepository;
import com.project.neon.repository.UserStoryRepository;
import com.project.neon.utils.MyDate;
import com.project.neon.utils.MyRandom;

@Transactional
@Service
public class InitDbService {

	@Autowired
	private EmployeeRepository employeeRepository;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private SprintRepository sprintRepository;

	@Autowired
	private UserStoryRepository userstoryRepository;

	@Autowired
	private EstimationRepository estimationRopository;

	@PostConstruct
	public void initializeDB() {
		Role roleAdmin = new Role();
		roleAdmin.setName("HR Admin");
		roleAdmin.setRole("ROLE_ADMIN");
		roleRepository.save(roleAdmin);

		Role roleDev = new Role();
		roleDev.setName("Developer");
		roleDev.setRole("ROLE_DEV");
		roleRepository.save(roleDev);

		Role roleSM = new Role();
		roleSM.setName("Scrum Master");
		roleSM.setRole("ROLE_SM");
		roleRepository.save(roleSM);

		Role roleTest = new Role();
		roleTest.setName("Tester");
		roleTest.setRole("ROLE_TEST");
		roleRepository.save(roleTest);

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		Employee employee = new Employee();
		employee.setName("keshav");
		employee.setAddress("1000 N 4TH ST, IA, USA");
		employee.setContact("9876543210");
		employee.setEmail("keshav@neon.mumscrum");
		employee.setUsername("admin");
		employee.setPassword(encoder.encode("admin"));
		employee.setEnabled(true);
		List<Role> roles = new ArrayList<>();
		roles.add(roleAdmin);
		roles.add(roleDev);
		roles.add(roleSM);
		employee.setRoles(roles);
		employeeRepository.save(employee);

		// Initialize for testing burndown chart
		List<Employee> employees = new ArrayList<>();
		employees.add(employee);
		List<String> developers = new ArrayList<>();
		developers.add("thao");
		developers.add("sabeen");
		developers.add("prabin");
		developers.add("test");
		for (String name : developers) {
			Employee employee2 = new Employee();
			employee2.setName(name);
			employee2.setAddress("1000 N 4TH ST, IA, USA");
			employee2.setContact("9876543210");
			employee2.setEmail(name + "@neon.mumsrcum");
			employee2.setUsername(name);
			employee2.setPassword(encoder.encode(name));
			employee2.setEnabled(true);
			List<Role> roles2 = new ArrayList<>();
			if (name.equals("test"))
				roles2.add(roleTest);
			else
				roles2.add(roleDev);
			employee2.setRoles(roles2);
			employeeRepository.save(employee2);
			employees.add(employee2);
		}
		// Initialize data for burn down chart
		Sprint sprint = new Sprint();
		sprint.setName("mumscrum-sprint");
		sprint.setStartDate("02/01/2016");
		sprint.setEndDate("02/10/2016");
		sprint.setEnabled(true);
		sprintRepository.save(sprint);
		int index = 1;
		for (Employee e : employees) {
			UserStory us = new UserStory();
			us.setTitle("mumscrum-title " + index);
			us.setDescription("mumscrum-description " + index);
			us.setSprint(sprint);
			us.setEmployee(e);
			us.setEnabled(true);
			userstoryRepository.save(us);
			Calendar cal = MyDate.string2Calendar("02/01/2016");
			int amount = 50;
			int remaining = amount;
			for (int k = 0; k < 5; k++) {
				Estimation es = new Estimation();
				es.setUserstory(us);
				es.setEstimatedTime(amount);
				// es.setRemainingTime(remaining - k*8);
				if (k == 0)
					es.setRemainingTime(remaining);
				else {
					Integer ran = MyRandom.getIntRandom(10, 4);
					remaining = remaining - ran;
					es.setRemainingTime(remaining);
				}
				es.setSettingDate(MyDate.calendar2String(cal));
				estimationRopository.save(es);
				cal.add(Calendar.DATE, 1);
			}
			index++;
		}

	}

}
