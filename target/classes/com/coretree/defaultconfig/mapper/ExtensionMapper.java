package com.coretree.defaultconfig.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.model.SearchConditions;

@Mapper
public interface ExtensionMapper {
	int count();
	List<Extension> selectAll(SearchConditions condition);
	Extension selectByIdx(@Param("ext") String ext);
	List<Extension> selectByTxt(@Param("txt") String txt);
	List<Extension> selectEmptyExt();
	int chkById(String ext);
	void add(Extension obj);
    void del(String ext);
    void modi(Extension obj);
}
