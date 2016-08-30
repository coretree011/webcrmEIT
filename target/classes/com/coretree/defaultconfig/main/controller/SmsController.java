package com.coretree.defaultconfig.main.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

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
    
    @SuppressWarnings("unchecked")
    @RequestMapping(path="/main/insertGrpSms", method = RequestMethod.POST)
	public long insertGrpSms(@RequestBody String searchVO, HttpServletRequest request) throws Exception {
    	long result = 0;
    	
    	List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
		resultMap = JSONArray.fromObject(searchVO); 
		
		for(Map<String,Object> map : resultMap){
			map.get("custNo");
			map.get("custNm");
			map.get("sendTelNo");
			map.get("cateCd");
			map.get("sendTypCd");
			map.get("sendResDate");
			map.get("sendResHms");
			map.get("sendCd");
			map.get("empNo");
			map.get("empNm");
			map.get("sendComment");
			
			result = smsMapper.insertGrpSms(map);
		}
		return result;
	}
}


