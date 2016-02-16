package com.project.neon.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.neon.repository.EmployeeRepository;

@Controller
public class IndexController {

	@Autowired
	private EmployeeRepository employeeRepository;
	
	@RequestMapping("/index")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/dev")
	public String dev() {
		return "dev";
	}
	
	@RequestMapping("/profile")
	public String profile(Principal principal, Model model) {
		String username = principal.getName();
		model.addAttribute("employee", employeeRepository.findOneByUsername(username));
		return "profile";
	}
	
}
