package com.project.neon.entity;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;

@Entity
public class Employee {

	@Id
	@GeneratedValue
	private Integer id;

	@Size(min = 1, message = "Name is required!")
	private String name;

	@Size(min = 1, message = "Address cannot be empty!")
	private String address;

	@Size(min = 6, max = 10, message = "Contact number must be of atleast 6 to 10 digits!")
	private String contact;

	@Email
	@Size(min = 1, message = "Email is required!")
	private String email;

	@Size(min = 1, message = "Username is required!")
	@Column(unique = true)
	private String username;

	@Size(min = 5, message = "Password must be of atleast 5 characters!")
	private String password;

	private boolean enabled;

	@ManyToMany
	@JoinTable
	private List<Role> roles;

	@OneToMany(mappedBy = "employee")
	private List<UserStory> userStories;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<UserStory> getUserStories() {
		return userStories;
	}

	public void setUserStories(List<UserStory> userStories) {
		this.userStories = userStories;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
