package com.project.neon.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Estimation {
	@Id
	@GeneratedValue
	private Integer estimationId;
	private String settingDate;
	private int estimatedTime;
	private int remainingTime;
	@ManyToOne
	@JoinColumn
	private UserStory userStory;
	
	public Integer getEstimationId() {
		return estimationId;
	}
	public void setEstimationId(Integer estimationId) {
		this.estimationId = estimationId;
	}
	public String getSettingDate() {
		return settingDate;
	}
	public void setSettingDate(String settingDate) {
		this.settingDate = settingDate;
	}
	public int getEstimatedTime() {
		return estimatedTime;
	}
	public void setEstimatedTime(int estimatedTime) {
		this.estimatedTime = estimatedTime;
	}
	public int getRemainingTime() {
		return remainingTime;
	}
	public void setRemainingTime(int remainingTime) {
		this.remainingTime = remainingTime;
	}
	public UserStory getUserstory() {
		return userStory;
	}
	public void setUserstory(UserStory userstory) {
		this.userStory = userstory;
	}
	
}
