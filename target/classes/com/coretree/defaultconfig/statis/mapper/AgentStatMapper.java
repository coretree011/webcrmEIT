package com.coretree.defaultconfig.statis.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.statis.model.AgentStat;

@Mapper
public interface AgentStatMapper {
	public List<AgentStat> selectAgentEmpNmList(AgentStat agentStat);
	public List<AgentStat> selectAgentStatList(AgentStat agentStat);
	public List<AgentStat> selectAgentStatListDay(AgentStat agentStat);
	public List<AgentStat> selectAgentStatListMonth(AgentStat agentStat);
	public List<AgentStat> selectAgentStatListYear(AgentStat agentStat);
}
