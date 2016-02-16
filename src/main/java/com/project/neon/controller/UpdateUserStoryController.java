package com.project.neon.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.neon.entity.Estimation;
import com.project.neon.entity.UserStory;
import com.project.neon.service.UserStoryService;
import com.project.neon.temp.UserStory_Estimation;
import com.project.neon.utils.MyDate;

@Controller
public class UpdateUserStoryController {
	@Autowired
	private UserStoryService userStoryService;

	@RequestMapping(value = "/dev_userstory", method = RequestMethod.GET)
	public String dev(Model model, Principal principal) {
		// Get all users story from current user.
		String username = principal.getName();
		List<UserStory> uss = userStoryService.getAllUserStoryForDev(username);
		List<UserStory_Estimation> us_ess = new ArrayList<>();

		for (UserStory us : uss) {
			Estimation es = userStoryService.getLatestEstimation(us);
			UserStory_Estimation us_es = new UserStory_Estimation(us.getTitle(), us.getDescription());
			if(es != null){
				us_es.setEstimatedTime(es.getEstimatedTime());
				us_es.setRemainingTime(es.getRemainingTime());
			}
			us_ess.add(us_es);
		}
		
		model.addAttribute("dev_userstorylist", us_ess);
		return "dev_userstory";
	}

	@ResponseBody
	@RequestMapping(value = "/updateUserStoryProgress")
	public String updateUserStoryProgress(@RequestBody String request) {
		String response = "";
		StringTokenizer tokenizer = new StringTokenizer(request, "~");
		UserStory us = null;
		Integer estimated = 0;
		Integer remaining = 0;
		int index = 0;
		while (tokenizer.hasMoreTokens()) {
			String item = tokenizer.nextToken();
			switch (index) {
			case 0: {
				us = userStoryService.getUserStoryByTitle(item);
			}
				break;
			case 1: {
				estimated = Integer.valueOf(item);
			}
				break;
			case 2: {
				remaining = Integer.valueOf(item);
			}
				break;
			}
			index++;
		}

		if (us != null) {
			userStoryService.updateEstimation(us, estimated, remaining);
		}
		return response;
	}

	@RequestMapping("/test_userstory")
	public String test(Model model, Principal principal) {
		// Get all users story from current user.
		String username = principal.getName();
		List<UserStory> uss = userStoryService.getAllUserStoryForDev(username);
		List<UserStory_Estimation> us_ess = new ArrayList<>();

		for (UserStory us : uss) {
			Estimation es = userStoryService.getLatestEstimation(us);
			UserStory_Estimation us_es = new UserStory_Estimation(us.getTitle(), us.getDescription());
			if(es != null){
				us_es.setEstimatedTime(es.getEstimatedTime());
				us_es.setRemainingTime(es.getRemainingTime());
			}
			us_ess.add(us_es);
		}
		model.addAttribute("dev_userstorylist", us_ess);
		return "test_userstory";
	}
}
