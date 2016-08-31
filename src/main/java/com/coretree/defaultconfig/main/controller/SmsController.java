package com.coretree.defaultconfig.main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.coretree.defaultconfig.main.mapper.SmsMapper;
import com.coretree.defaultconfig.main.model.Sms;

/**
 * Test를 위한 컨트롤러 클래스
 * 
 * @author hsw
 *
 */
@RestController
public class SmsController {

	@Autowired
	SmsMapper smsMapper;

	@RequestMapping(path = "/main/selectSms", method = RequestMethod.POST)
	public List<Sms> selectSms(@RequestBody Sms paramSms,HttpSession session) throws Exception {
    	
		List<Sms> sms = smsMapper.selectSms(paramSms);

		return sms;
	}

    @RequestMapping(path = "/main/insertSms", method = RequestMethod.POST)
	public long insertSms(@RequestBody Sms paramSms,HttpSession session) {
		long result = 0;
		result = smsMapper.insertSms(paramSms);

		return result;
	}
}

















