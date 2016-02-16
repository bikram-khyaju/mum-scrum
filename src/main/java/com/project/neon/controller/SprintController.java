package com.project.neon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.neon.entity.Sprint;
import com.project.neon.entity.UserStory;
import com.project.neon.service.SprintService;
import com.project.neon.service.UserStoryService;

@Controller
public class SprintController {

	@Autowired
	private SprintService sprintService;

	@Autowired
	private UserStoryService userStoryService;

	// list the user stories
	@RequestMapping(value = "/master_sprint", method = RequestMethod.GET)
	public String master_sprint(Model model) {
		model.addAttribute("userStories", userStoryService.listAvailableUserStory());
		model.addAttribute("sprint", sprintService.findAllByEnabled());
		return "master_sprint";
	}

	// data from the form is set on the sprint object
	@ModelAttribute("addsprint")
	public Sprint addSprint() {
		return new Sprint();
	}

	@RequestMapping("/sprint_detail/{id}")
	public String viewSprintDetails(@PathVariable int id, Model model) {

		Sprint sprint = sprintService.findById(id);
		model.addAttribute("sprint", sprint);

		model.addAttribute("userStories", userStoryService.listAvailableUserStory());

		return "sprint_details";
	}

	// saves the form data into the service
	@RequestMapping(value = "/master_sprint", method = RequestMethod.POST)
	public String saveSprint(@ModelAttribute("addsprint") Sprint sprint) {
		sprintService.save(sprint);
		return "redirect:/master_sprint.html";

	}

	@InitBinder
	public void rolesBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(List.class, "userStories", new CustomCollectionEditor(List.class) {

			protected Object convertElement(Object element) {
				if (element != null) {
					Integer id = Integer.parseInt(element.toString());
					UserStory userStory = userStoryService.getUserStoryById(id);
					// Role role = roleService.getById(id);
					// System.out.println(userStory);
					return userStory;
				}
				return null;
			}
		});
	}

	// updates or saves
	@RequestMapping(value = "/sprint_detail/{id}", method = RequestMethod.POST)
	public String editEmployeeDetails(@PathVariable int id, @ModelAttribute("sprint") Sprint sprint) {
		sprintService.save(sprint);
		return "sprint_details";
	}

	// delete user story
	@RequestMapping(value = "/sprint_detail/delete/{id}", method = RequestMethod.GET)
	public String deleteSprint(@PathVariable("id") int id) {
		sprintService.delete(id);
		return "redirect:/master_sprint.html";
	}

}
