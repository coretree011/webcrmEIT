package com.coretree.defaultconfig.main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.coretree.defaultconfig.main.mapper.OrganizationMapper;
import com.coretree.defaultconfig.main.model.Organization;

/**
 * Test를 위한 컨트롤러 클래스
 * 
 * @author hsw
 *
 */
@RestController
public class OrganizationController {

	@Autowired
	OrganizationMapper organizationMapper;

	/**
	 * customer counter 정보를 조회한다.
	 * 
	 * @param condition
	 * @return
	 */
/*	@RequestMapping(path = "/login/actionLogin", method = RequestMethod.POST)
	public @ResponseBody long checkLogin(@RequestBody Users paramUsers) {
		long result = 0;
		
		Users users = usersMapper.checkLogin(paramUsers);
		if(users != null){
			long nCount = users.getExistCount();
			String realPassword = users.getPassword();
			
			if(nCount == 0){
				result = 0;
			}else if(nCount == 1 && realPassword.equals(paramUsers.getPassword())){
				result = 1;
				
			}else if(nCount == 1 && !realPassword.equals(paramUsers.getPassword())){
				result = 2;
			}
		}
		return result;
	}*/
	
	@RequestMapping(path = "/login/actionLogin", method = RequestMethod.GET)
	public ModelAndView checkLogin(@RequestParam("userName") String test, HttpSession session) {
		long result = 0;
		Organization paramUsers = new Organization();
		paramUsers.setEmpNo(test);
		Organization users = organizationMapper.checkLogin(paramUsers);
		
		if(users != null){
			long nCount = users.getExistCount();
			String realPassword = users.getPassword();
			
			if(nCount == 0){
				result = 0;
			}else if(nCount == 1){
				session.setAttribute("empNo", users.getEmpNo());
				session.setAttribute("empNm", users.getEmpNm());
				session.setAttribute("extensionNo", users.getExtensionNo());
				result = 1;
			}else if(nCount == 1 && !realPassword.equals(paramUsers.getPassword())){
				result = 2;
			}
		}
		ModelAndView view = new ModelAndView();
        view.setViewName("/index");
		return view;
	}
	
	@RequestMapping(path = "/login/updatePwd", method = RequestMethod.POST)
	public String updatePwd(@RequestBody Organization paramUsers, HttpSession session) {
		session.setAttribute("test123", paramUsers);
		return "redirect:/login/updatePwd2";
	}
	
	
	@RequestMapping(path = "/login/updatePwd2", method = RequestMethod.POST)
	public long updatePwd2(HttpSession session) {
		long result = 0;
		Organization paramUsers = (Organization) session.getAttribute("test123");
		Organization users = organizationMapper.checkLogin(paramUsers);
		if(users != null){
			if(paramUsers.getPassword().equals(users.getPassword())){
				organizationMapper.updatePwd(paramUsers);
				result = 1;
			}else{
				result = 0;
			}
		}
		return result;
	}
	
	@RequestMapping(path = "/empList", method = RequestMethod.POST)
	public List<Organization> empList() throws Exception {
		
		List<Organization> emp = organizationMapper.empList();

		return emp;
	}
	
	@RequestMapping(path = "/main/usersState", method = RequestMethod.POST)
	public List<Organization> usersState() throws Exception {
		
		List<Organization> emp = organizationMapper.usersState2();
		
		return emp;
	}
}

















