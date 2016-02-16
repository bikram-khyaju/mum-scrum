package com.project.neon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Role;
import com.project.neon.repository.RoleRepository;

@Service
@Transactional
public class RoleService {

	@Autowired
	private RoleRepository roleRepository;
	
	public List<Role> findAll() {
		return roleRepository.findAll();
	}

	public Role getById(Integer id) {
		return roleRepository.findOne(id);
	}

}
