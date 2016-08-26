package com.coretree.defaultconfig.mapper;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.mybatis.autoconfigure.Mapper;
import com.coretree.defaultconfig.model.SmsSearchConditions;

@Mapper
public interface SmsMapper_sample {
	long count(SmsSearchConditions condition);
	List<Sms_sample> getAll(SmsSearchConditions condition);
	// Sms getByIdx(@Param("idx") long idx);
	List<Sms_sample> getView(SmsSearchConditions condition);
    void del(long idx);
    // void delAll(ArrayList<Sms> list);
    long add(Sms_sample data);
    void setresult(Sms_sample sms);
}
