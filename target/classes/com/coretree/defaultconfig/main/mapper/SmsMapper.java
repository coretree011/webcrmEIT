package com.coretree.defaultconfig.main.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.main.model.Sms;

@Mapper
public interface SmsMapper {
	public List<Sms> selectSms(Sms paramSms);
	public long insertSms(Sms paramSms);
	public long insertGrpSms(Map<String, Object> map);
}
