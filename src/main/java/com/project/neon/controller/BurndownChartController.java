package com.project.neon.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.neon.entity.Estimation;
import com.project.neon.entity.Sprint;
import com.project.neon.entity.UserStory;
import com.project.neon.service.BurndownChartService;
import com.project.neon.service.UserStoryService;
import com.project.neon.temp.BurndownChartData;
import com.project.neon.utils.MyDate;

@Controller
public class BurndownChartController {
	@Autowired
	private BurndownChartService bdService;
	@Autowired
	private UserStoryService userStoryService;
	
	@RequestMapping(value="/master_burndownChart", method = RequestMethod.GET)
	public String loadBurndownPage(Model model) {
		List<Sprint> sprints = bdService.getAllSprints();
		model.addAttribute("sprints", sprints);
		return "master_burndownChart";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getBurndownChartData")
	public String getBurndownChartData(@RequestBody String sprintName) {
		String response = "";
		BurndownChartData bdData = calculateBurndownChartData(sprintName);
		List<String> duration = bdData.getDuration();
		List<Integer> actualRemaining = bdData.getActualRemaining();
		List<Integer> velocity = bdData.getVelocity();
		int totalAmount = bdData.getTotalAmount();
		if(duration.size() == 0){
			System.out.println("There is no duration for this sprint");
			return response;
		}
		
		if(actualRemaining.size() == 0){
			System.out.println("There is no estimation for this sprint");
			return response;
		}
		
		response = "{\"BDChartData\" : {";
		//create X axis data
		int i = 0;
		int len = duration.size();
		response += "\"duration\":[";
		for(; i < len - 1; i++){
			response += "{\"value\":\"" + duration.get(i) + "\" },";
		}
		response += "{\"value\":\"" + duration.get(i) + "\" }],";
		
		i = 0;
		response += "\"idealRemaining\":[";
		for(; i < len - 1; i++){
			int remain = totalAmount * (len - i) / len;
			response += "{ \"value\":" + remain + " },";
		}
		response += "{ \"value\":" +  0 + " }],";
		
		i = 0;
		response += "\"actualRemaining\":[";
		for(; i < actualRemaining.size() - 1; i++){
			response += "{ \"value\":" + actualRemaining.get(i) + " },";
		}
		response += "{ \"value\":" +  actualRemaining.get(i) + " }],";
		
		response += "\"velocity\":[";
		i = 0;
		for(; i < velocity.size() - 1; i++){
			response += "{ \"value\":" + velocity.get(i) + " },";
		}
		response += "{ \"value\":" +  velocity.get(i) + " }]}}";
		
		return response;
	}
	
	private List<String> calculateDuration(String sprintName){
		Sprint sprint = bdService.getSprint(sprintName);
		Calendar startCal, endCal;
		startCal = MyDate.string2Calendar(sprint.getStartDate());
		endCal = MyDate.string2Calendar(sprint.getEndDate());
		List<String> duration = new ArrayList<>();
		while(startCal.compareTo(endCal) <= 0){
			duration.add(MyDate.calendar2String(startCal, "MM-dd-yyyy"));
			startCal.add(Calendar.DATE, 1);
		}
		
		return duration;
	}
	private Integer calculateTotalAmount(String sprintName){
		Sprint sprint = bdService.getSprint(sprintName);
		List<UserStory> uss = bdService.getAllUserStoryBySprint(sprint);
		Integer amount = 0;
		for(UserStory us: uss){
			Estimation es = userStoryService.getLatestEstimation(us);
			if(es != null){
				amount += es.getEstimatedTime();
			}
		}
		return amount;
	}
	private List<Integer> calculateActualRemaining(String sprintName){
		List<Integer> actualRemaining = new ArrayList<>();
		Sprint sprint = bdService.getSprint(sprintName);
		List<UserStory> uss = bdService.getAllUserStoryBySprint(sprint);
		//initialize map container
		List<ArrayList<Integer>> listOfRemaining = new ArrayList<ArrayList<Integer>>();
		int max = 0;
		for(UserStory us: uss){
			List<Estimation> ess = userStoryService.getAllEstimationOfUS(us);
			ArrayList<Integer> list = new ArrayList<>();
			for(Estimation es: ess){
				list.add(es.getRemainingTime());
			}
			if(max < list.size())
				max = list.size();
			listOfRemaining.add(list);
		}
		
		//Compensate to the list
		for(ArrayList<Integer> list: listOfRemaining){
			while(list.size() < max){
				list.add(list.get(list.size() - 1));
			}
		}
		
		for(int i = 0; i < max; i++ ){
			Integer amount = 0; 
			for(ArrayList<Integer> list: listOfRemaining){
				amount += list.get(i);
			}
			actualRemaining.add(amount);
		}
		
		return actualRemaining;
	}
	private List<Integer> calculateVelocity(List<Integer> actualRemaining){
		List<Integer> velocity = new ArrayList<>();
		velocity.add(0);
		for(int i = 0; i < actualRemaining.size() - 1; i++){
			velocity.add(actualRemaining.get(i) - actualRemaining.get(i + 1));
		}
		return velocity;
	}
	
	private BurndownChartData calculateBurndownChartData(String sprintName){
		BurndownChartData bdData = new BurndownChartData();
		String response = "";
		Sprint sprint = bdService.getSprint(sprintName);
		List<UserStory> uss = bdService.getAllUserStoryBySprint(sprint);
		if(sprint != null){
			List<String> duration = calculateDuration(sprintName);
			bdData.setDuration(duration);
			bdData.setTotalAmount(calculateTotalAmount(sprintName));
			List<Integer> actualRemaining = calculateActualRemaining(sprintName);
			bdData.setActualRemaining(actualRemaining);
			List<Integer> velocity = calculateVelocity(actualRemaining);
			bdData.setVelocity(velocity);
		}
		return bdData;
	}
	
	@SuppressWarnings("unused")
	private String createSampleChart(){
		String response;
		response = "{\"BDChartData\" : {";
		//create X axis data
		Integer durationArr [] = new Integer[10];
		for(int i = 0; i < durationArr.length; i++) durationArr[i] = i+1;
		response += "\"duration\":[";
		int i = 1;
		int len = durationArr.length;
		for(; i < len; i++){
			response += "{\"value\":" + i + " },";
		}
		response += "{\"value\":" + i + " }],";
		
		response += "\"idealRemaining\":[";
		int max = 200;
		i = 0;
		for(; i < len - 1; i++){
			int remain = max * (len - i) / len;
			response += "{ \"value\":" + remain + " },";
		}
		response += "{ \"value\":" +  0 + " }],";
		
		response += "\"actualRemaining\":[";
		Integer actualRemaining[] = {200, 175, 150, 180, 130};
		i = 0;
		for(; i < actualRemaining.length - 1; i++){
			response += "{ \"value\":" + actualRemaining[i] + " },";
		}
		response += "{ \"value\":" +  actualRemaining[i] + " }],";
		
		Integer velocity[] = {0, 25, 25, 25, 50};
		response += "\"velocity\":[";
		i = 0;
		for(; i < velocity.length - 1; i++){
			response += "{ \"value\":" + velocity[i] + " },";
		}
		response += "{ \"value\":" +  velocity[i] + " }]}}";
		
		return response;
	}
}
