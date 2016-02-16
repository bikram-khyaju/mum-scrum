package com.project.neon.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

@Entity
public class UserStory {
	@Id
	@GeneratedValue
	private Integer id;

	@NotNull(message = "Cannot be empty")
	@Column(unique = true)
	private String title;

	@NotNull(message = "Cannot be empty")
	private String description;

	@ManyToOne
	@JoinColumn(name = "sprint_id")
	private Sprint sprint;

	@OneToMany(mappedBy = "userStory")
	private List<Estimation> estimations;

	private boolean assignedAsDev;

	@ManyToOne
	@JoinColumn
	private Employee employee;

	private Priority priority;
	private Status status;
	private Boolean enabled;

	public boolean isAssignedAsDev() {
		return assignedAsDev;
	}

	public void setAssignedAsDev(boolean assignedAsDev) {
		this.assignedAsDev = assignedAsDev;
	}

	public Boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public Priority getPriority() {
		return priority;
	}

	public void setPriority(Priority priority) {
		this.priority = priority;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Sprint getSprint() {
		return sprint;
	}

	public void setSprint(Sprint sprint) {
		this.sprint = sprint;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public List<Estimation> getEstimations() {
		return estimations;
	}

	public void setEstimations(List<Estimation> estimations) {
		this.estimations = estimations;
	}

}
