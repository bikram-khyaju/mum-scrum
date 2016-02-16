package com.project.neon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.neon.entity.Employee;
import com.project.neon.service.EmployeeService;
import com.project.neon.service.RoleService;
import com.project.neon.subsystem.HRSubsystem;

@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private RoleService roleService;

	@Autowired
	private HRSubsystem hrSubsystem;

	@RequestMapping("/employee_detail/{id}")
	public String viewEmployeeDetails(@PathVariable int id, Model model) {
		model.addAttribute("employee", hrSubsystem.getEmployeeById(id));
		model.addAttribute("rolesList", roleService.findAll());
		return "employee_detail";
	}

	@RequestMapping("/addEmployee/availableUsername")
	@ResponseBody
	public String checkAvailableUsername(@RequestParam String username) {
		Boolean available = employeeService.findByUsername(username) == null;
		return available.toString();
	}

	@RequestMapping("/addEmployee/availableEmail")
	@ResponseBody
	public String checkAvailableEmail(@RequestParam String email) {
		Boolean available = employeeService.findByEmail(email) == null;
		return available.toString();
	}

	@RequestMapping("/editEmployee/availableUsername")
	@ResponseBody
	public String editAvailableUsername(@RequestParam String newUsername, @RequestParam String oldUsername) {
		if (newUsername.equals(oldUsername)) {
			return "true";
		} else {
			Boolean available = employeeService.findByUsername(newUsername) == null;
			return available.toString();
		}
	}

	@RequestMapping("/editEmployee/availableEmail")
	@ResponseBody
	public String editAvailableEmail(@RequestParam String newEmail, @RequestParam String oldEmail) {
		if (newEmail.equals(oldEmail)) {
			return "true";
		} else {
			Boolean available = employeeService.findByEmail(newEmail) == null;
			return available.toString();
		}
	}

	@RequestMapping("/delete/{id}")
	public String deleteEmployee(@PathVariable int id) {
		employeeService.deleteEmployee(id);
		return "redirect:/admin.html";
	}

}
