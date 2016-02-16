package com.project.neon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.neon.entity.Employee;
import com.project.neon.service.EmployeeService;

@Controller
public class TestController {

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/test")
	public String test() {
		return "test";
	}

	@RequestMapping("/testModal")
	public String testModal(Model model) {
		Employee emp = employeeService.findByUsername("admin");
		model.addAttribute("emp", emp);
		return "testModal";
	}

}
