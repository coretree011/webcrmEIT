package com.coretree.defaultconfig.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.model.CustSearchConditions;
import com.coretree.defaultconfig.model.Group;

@Mapper
public interface CustomerMapper_sample {
	long count(CustSearchConditions condition);
	List<Customer_sample> findAll(CustSearchConditions condition);
	List<Customer_sample> findByTxt(@Param("searchtxt") String searchtxt);
	Customer_sample findByIdx(@Param("idx") long idx);
	Customer_sample findByExt(@Param("telnum") String telnum);
	void add(Customer_sample cust);
	void del(long idx);
	void modi(Customer_sample obj);
	List<Group> getGroup();
	List<Group> getSubgroup(String maingroup);
}
