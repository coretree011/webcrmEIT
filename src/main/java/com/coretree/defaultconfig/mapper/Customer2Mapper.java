package com.coretree.defaultconfig.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.model.CustSearchConditions;
import com.coretree.defaultconfig.model.Group;

@Mapper
public interface Customer2Mapper {
	long count(CustSearchConditions condition);
	List<Customer2> findAll(CustSearchConditions condition);
	List<Customer2> findByTxt(@Param("searchtxt") String searchtxt);
	Customer2 findByIdx(@Param("idx") long idx);
	Customer2 findByExt(@Param("telnum") String telnum);
	void add(Customer2 cust);
	void del(long idx);
	void modi(Customer2 obj);
	List<Group> getGroup();
	List<Group> getSubgroup(String maingroup);
}
