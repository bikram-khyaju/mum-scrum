package com.project.neon.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.neon.entity.Employee;
import com.project.neon.entity.Estimation;
import com.project.neon.entity.UserStory;
import com.project.neon.repository.EmployeeRepository;
import com.project.neon.repository.EstimationRepository;
import com.project.neon.repository.UserStoryRepository;
import com.project.neon.utils.MyDate;

@Service
@Transactional
public class UserStoryService {

	@Autowired
	private UserStoryRepository userStoryRepository;
	@Autowired
	private EmployeeRepository employeeRepository;

	@Autowired
	private EstimationRepository estimationRepository;

	public void saveUserStory(UserStory userStory) {
		userStory.setEnabled(true);
		userStoryRepository.save(userStory);
	}

	public boolean deleteUserStoryById(Integer id) {
		UserStory userStory = userStoryRepository.findOne(id);
		userStory.setEnabled(false);
		userStoryRepository.save(userStory);
		return true;

	}

	public List<UserStory> listUserStory() {

		return userStoryRepository.findAllByEnabled(true);
	}

	public UserStory getUserStoryById(Integer id) {
		UserStory userStory = userStoryRepository.findOne(id);

		return userStory;
	}

	public List<UserStory> getAllUserStoryForDev(String username) {
		// TODO Auto-generated method stub
		Employee dev = employeeRepository.findOneByUsername(username);
		return userStoryRepository.findAllByEmployee(dev);
	}

	public List<Estimation> getAllEstimationOfUS(UserStory us) {
		// TODO Auto-generated method stub
		return estimationRepository.findAllByUserStory(us);
	}

	public UserStory getUserStoryByTitle(String item) {
		// TODO Auto-generated method stub
		return userStoryRepository.findOneByTitle(item);
	}

	public Boolean updateEstimation(UserStory us, Integer estimated, Integer remaining) {
		// TODO Auto-generated method stub
		Estimation latestEs = getLatestEstimation(us);
		String strSettingDate = "02/01/2016";
		if (latestEs != null) {
			String strLatestDate = latestEs.getSettingDate();
			Calendar cal = MyDate.string2Calendar(strLatestDate);
			cal.add(Calendar.DATE, 1);
			strSettingDate = MyDate.calendar2String(cal);
		}
		Estimation es = new Estimation();
		es.setUserstory(us);
		es.setEstimatedTime(estimated);
		es.setRemainingTime(remaining);
		es.setSettingDate(strSettingDate);
		estimationRepository.save(es);
		return true;
	}

	public Estimation getLatestEstimation(UserStory us) {
		List<Estimation> ess = getAllEstimationOfUS(us);
		if (ess.size() == 0)
			return null;
		Estimation es = ess.get(0);
		Calendar cal = MyDate.string2Calendar(es.getSettingDate());
		for (Estimation item : ess) {
			Calendar temp = MyDate.string2Calendar(item.getSettingDate());
			if (cal.compareTo(temp) < 0) {
				es = item;
				cal = MyDate.string2Calendar(es.getSettingDate());
			}
		}
		return es;
	}

	public List<UserStory> listAvailableUserStory() {
		return userStoryRepository.findAllBySprintId(null);
	}

}
