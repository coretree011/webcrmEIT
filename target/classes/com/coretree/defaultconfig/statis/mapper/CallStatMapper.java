package com.coretree.defaultconfig.statis.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.statis.model.CallStat;

@Mapper
public interface CallStatMapper {
	public List<CallStat> selectCallStatList(CallStat callStat);
	public List<CallStat> selectCallStatListDay(CallStat callStat);
	public List<CallStat> selectCallStatListMonth(CallStat callStat);
	public List<CallStat> selectCallStatListYear(CallStat callstat);
	public void insertCallStat(CallStat callstat);
	public void updateCallStatMid(CallStat callstat);
	public void updateCallStatEnd(CallStat callstat);
}
