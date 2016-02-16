package com.project.neon.temp;

import java.util.List;

public class BurndownChartData {
	private List<String> duration;
	private Integer totalAmount;
	private List<Integer> actualRemaining;
	private List<Integer> velocity;
	
	public Integer getDurationLenth() {
		return duration.size();
	}
	public List<String> getDuration() {
		return duration;
	}
	public void setDuration(List<String> duration) {
		this.duration = duration;
	}
	public Integer getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}
	public List<Integer> getActualRemaining() {
		return actualRemaining;
	}
	public void setActualRemaining(List<Integer> actualRemaining) {
		this.actualRemaining = actualRemaining;
	}
	public List<Integer> getVelocity() {
		return velocity;
	}
	public void setVelocity(List<Integer> velocity) {
		this.velocity = velocity;
	}
}
