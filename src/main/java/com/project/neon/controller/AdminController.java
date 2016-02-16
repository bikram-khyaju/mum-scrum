package com.project.neon.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Role;
import com.project.neon.service.EmployeeService;
import com.project.neon.service.RoleService;
import com.project.neon.subsystem.HRSubsystem;

@Controller
public class AdminController {

	@Autowired
	private RoleService roleService;

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private HRSubsystem hrSubsystem;

	@ModelAttribute("employee")
	public Employee createEmployee() {
		return new Employee();
	}

	@RequestMapping("/admin")
	public String admin(Model model) {
		model.addAttribute("rolesList", roleService.findAll());
		model.addAttribute("employeesList", hrSubsystem.getEmployeeList());
		return "admin";
	}

	@RequestMapping(value = "/admin", method = RequestMethod.POST)
	public String addEmployee(@Valid @ModelAttribute("employee") Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			return "redirect:/admin.html";
		}
		employeeService.saveEmployee(employee);
		return "redirect:/admin.html";
	}

	@RequestMapping(value = "/employee_detail/{id}", method = RequestMethod.POST)
	public String editEmployeeDetails(@PathVariable int id, @Valid @ModelAttribute("employee") Employee employee,
			BindingResult result) {
		if (result.hasErrors()) {
			return "redirect:/employee_detail/" + id + ".html";
		}
		hrSubsystem.updateEmployeeProfile(employee);
		return "redirect:/employee_detail/" + id + ".html";
	}

	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String updateProfile(@Valid @ModelAttribute("employee") Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			return "redirect:/profile.html";
		}
		hrSubsystem.updateEmployeeProfile(employee);
		return "redirect:/profile.html";
	}

	@InitBinder
	public void rolesBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(List.class, "roles", new CustomCollectionEditor(List.class) {

			protected Object convertElement(Object element) {
				if (element != null) {
					Integer id = Integer.parseInt(element.toString());
					Role role = roleService.getById(id);
					return role;
				}
				return null;
			}
		});
	}

}
