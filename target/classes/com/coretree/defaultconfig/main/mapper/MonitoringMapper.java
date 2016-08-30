package com.coretree.defaultconfig.main.mapper;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.main.model.Monitoring;
import com.coretree.defaultconfig.main.model.Organization;

@Mapper
public interface MonitoringMapper {
	public Monitoring selectMonitoringList(Organization organization);
}
