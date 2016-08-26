package com.coretree.defaultconfig.main.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.main.model.Organization;

@Mapper
public interface OrganizationMapper {
	public Organization checkLogin(Organization user);
	public List<Organization> selectLoginUser();
	public List<com.coretree.models.Organization> getUsers();
	public void updatePwd(Organization organization);
	public List<Organization> empList();
	public List<Organization> usersState();
	public List<Organization> usersState2();
}
