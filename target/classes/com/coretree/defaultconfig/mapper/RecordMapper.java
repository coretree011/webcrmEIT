package com.coretree.defaultconfig.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

@Mapper
public interface RecordMapper {
	long count();
	List<Record> selectAll(@Param("curpage") int curpage, @Param("rowsperpage") int rowsperpage);
	Record selectByIdx(@Param("idx") long idx);
	List<Record> selectByTxt(@Param("txt") String txt);
    void del(long idx);
    void delAll(@Param("list") ArrayList<Record> list);
}
