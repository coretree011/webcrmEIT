package com.coretree.defaultconfig.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.coretree.defaultconfig.main.mapper.CounselMapper;
import com.coretree.defaultconfig.main.model.Counsel;

/**
 * Test를 위한 컨트롤러 클래스
 * 
 * @author hsw
 *
 */
@RestController
public class CounselController{

	@Autowired
	CounselMapper counselMapper;

	/**
	 * customer counter 정보를 조회한다.
	 * 
	 * @param condition
	 * @return
	 */

    @RequestMapping(path = "/main/counselList", method = RequestMethod.POST)
    public  List<Counsel> customerList(@RequestBody Counsel searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
    	
		List<Counsel> counsel = counselMapper.counselList(searchVO);
    	
    	return counsel;
    }
    
    @RequestMapping(path = "/main/insertCounsel", method = RequestMethod.POST)
    public long insertCounsel(@RequestBody Counsel paramCounsel, HttpSession session) {
    	
    	long result = 0;
    	result = counselMapper.insertCounsel(paramCounsel);
    	result = counselMapper.updateCustomerCounDate(paramCounsel);
    	
    	return result;
    }

	@RequestMapping(path = "/main/updateCounsel", method = RequestMethod.POST)
	public long updateCounsel(@RequestBody Counsel paramCounsel, HttpSession session) {
		
		long result = 0;
		result = counselMapper.updateCounsel(paramCounsel);

		return result;
	}
}

















