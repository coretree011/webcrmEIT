package com.coretree.defaultconfig.main.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.coretree.defaultconfig.main.mapper.MonitoringMapper;
import com.coretree.defaultconfig.main.model.Monitoring;
import com.coretree.defaultconfig.main.model.Organization;


@RestController
public class MonitoringController{

	@Autowired
	MonitoringMapper monitoringMapper;
	
	/**
	 * customer counter 정보를 조회한다.
	 * 
	 * @param condition
	 * @return
	 */
	@RequestMapping(path = "/main/monitoringList", method = RequestMethod.POST)
	public  Monitoring monitoringList(@RequestBody Organization organization, HttpServletRequest request) throws Exception {
		
		Monitoring monitoring = monitoringMapper.selectMonitoringList(organization);
		
		return monitoring;
	}
}


















