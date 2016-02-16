package com.project.neon.controller;

import java.beans.PropertyEditorSupport;
import java.util.Arrays;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Priority;
import com.project.neon.entity.Status;
import com.project.neon.entity.UserStory;
import com.project.neon.service.EmployeeService;
import com.project.neon.service.UserStoryService;
import com.project.neon.subsystem.HRSubsystem;

@Controller
public class UserStoryController {

	@Autowired
	private UserStoryService userStoryService;

	@Autowired
	private HRSubsystem hRSubsystem;
	@Autowired
	private EmployeeService employeeService;

	@ModelAttribute("userStory")
	public UserStory getUserStory() {
		return new UserStory();
	}

	@RequestMapping("/master_userstory")
	public String master() {
		return "master_userstory";
	}

	@RequestMapping(value = "/master_userstory", method = RequestMethod.GET)
	public String listUserStory(Model model) {
		model.addAttribute("listUserStory", userStoryService.listUserStory());
		model.addAttribute("listDeveloper", hRSubsystem.listEmployeeByRole("ROLE_DEV"));
		model.addAttribute("listTester", hRSubsystem.listEmployeeByRole("ROLE_TEST"));
		return "master_userstory";
	}

	@RequestMapping(value = "/master_userstory", method = RequestMethod.POST)
	public String saveUserStory(@Valid @ModelAttribute("userStory") UserStory userStory, BindingResult result) {
		if (result.hasErrors()) {
			return "master_userstory";
		}
		userStoryService.saveUserStory(userStory);
		return "redirect:/master_userstory.html";
	}

	@RequestMapping(value = "/user_story_detail/delete/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable("id") int id, Model model) {
		if (userStoryService.deleteUserStoryById(id)) {
			return "redirect:/master_userstory.html";
		} else {
			return "redirect:/master_userstory.html";
		}

	}

	@RequestMapping("/user_story_detail/{id}")
	public String viewEmployeeDetails(@PathVariable int id, Model model) {

		UserStory userStory = userStoryService.getUserStoryById(id);

		List<Status> status = Arrays.asList(Status.values());
		List<Priority> priority = Arrays.asList(Priority.values());

		model.addAttribute("userstory", userStory);
		model.addAttribute("listDeveloper", hRSubsystem.listEmployeeByRole("ROLE_DEV"));
		model.addAttribute("listTester", hRSubsystem.listEmployeeByRole("ROLE_TEST"));

		model.addAttribute("listPriority", priority);
		model.addAttribute("listStatus", status);

		return "user_story_detail";
	}

	@RequestMapping("/dev_userstory")
	public String dev() {
		return "dev_userstory";
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Employee.class, new EmployeeEditor(employeeService));
	}

	public class EmployeeEditor extends PropertyEditorSupport {

		private final EmployeeService employeeService;

		public EmployeeEditor(EmployeeService employeeService) {
			this.employeeService = employeeService;
		}

		@Override
		public void setAsText(String text) throws IllegalArgumentException {
			try {
				Employee employee = hRSubsystem.getEmployeeById(Integer.parseInt(text));
				setValue(employee);
			} catch (NumberFormatException e) {
				setValue(null);
			}

		}
	}

	@RequestMapping("/unique")
	@ResponseBody
	public String uniqueValidation(@RequestParam String title) {
		Boolean isUnique = userStoryService.getUserStoryByTitle(title) == null;
		return isUnique.toString();

	}

	@RequestMapping("/uniqueEdit")
	@ResponseBody
	public String uniqueEditValidation(@RequestParam String newtitle, @RequestParam String oldtitle) {
		if (newtitle.equals(oldtitle)) {
			return "true";
		} else {
			Boolean available = userStoryService.getUserStoryByTitle(newtitle) == null;
			return available.toString();
		}

	}

}
