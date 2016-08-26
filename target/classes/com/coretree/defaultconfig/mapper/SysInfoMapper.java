package com.coretree.defaultconfig.mapper;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

@Mapper
public interface SysInfoMapper {
	SysInfo getCallInfo();
}
