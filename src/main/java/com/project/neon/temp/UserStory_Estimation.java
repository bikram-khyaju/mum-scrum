package com.project.neon.temp;

public class UserStory_Estimation {
	private String title;
	private String description;
	private Integer estimatedTime;
	private Integer remainingTime;
	public UserStory_Estimation(String title, String description){
		this.title = title;
		this.description = description;
		this.estimatedTime = 0;
		this.remainingTime = 0;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getEstimatedTime() {
		return estimatedTime;
	}
	public void setEstimatedTime(Integer estimatedTime) {
		this.estimatedTime = estimatedTime;
	}
	public Integer getRemainingTime() {
		return remainingTime;
	}
	public void setRemainingTime(Integer remainingTime) {
		this.remainingTime = remainingTime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
