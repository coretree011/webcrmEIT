package com.coretree.defaultconfig.setting.mapper;

import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;

import com.coretree.defaultconfig.setting.model.SmsCategory;

@Mapper
public interface SmsCategoryMapper {

	public List<SmsCategory> selectSmsList();
	public SmsCategory selectSmsOne(SmsCategory smsCategory);
	public long insertSms(SmsCategory smsCategory);
	public long deleteSms(SmsCategory smsCategory);
	public long updateSms(SmsCategory smsCategory);
	public SmsCategory maxSms(SmsCategory smsCategory);
}
