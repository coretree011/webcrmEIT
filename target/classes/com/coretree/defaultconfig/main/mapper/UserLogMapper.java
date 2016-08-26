package com.coretree.defaultconfig.main.mapper;

import java.util.List;
import org.springframework.boot.mybatis.autoconfigure.Mapper;
import com.coretree.defaultconfig.main.model.Ivr;
import com.coretree.defaultconfig.main.model.UserLog;

@Mapper
public interface UserLogMapper {
	public List<UserLog> selectAllUserLogs();
	public void addUserLog(UserLog userlog);
}
