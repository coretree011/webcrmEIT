package com.coretree.defaultconfig.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.model.SearchConditions;

@Mapper
public interface MemberMapper {
	int count();
	List<Member> selectAll(@Param("curpage") int curpage, @Param("rowsperpage") int rowsperpage);
	Member selectByIdx(@Param("username") String username);
	Member selectByExt(@Param("ext") String ext);
	List<Member> selectByTxt(@Param("txt") String txt);
	List<Member> getUserState();
	int chkById(String username);
	void add(Member member);
    void del(String username);
    void delAll(@Param("list") ArrayList<Record> list);
    void modi(Member member);
}
