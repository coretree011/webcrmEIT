package com.coretree.defaultconfig.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.model.SearchConditions;

@Mapper
public interface CallMapper {
	long count(SearchConditions conditions);
	List<Call> selectAll(SearchConditions conditions);
	List<Call> selectByIdx(@Param("idx") int idx);
	List<Call> selectByTxt(@Param("txt") String txt);
    void add(Call call);
    void modiStatus(Call call);
    void modiEnd(Call call);
    void del(long idx);
    void memo(Call call);
}
