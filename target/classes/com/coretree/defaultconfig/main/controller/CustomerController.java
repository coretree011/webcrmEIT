package com.coretree.defaultconfig.main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.coretree.defaultconfig.main.mapper.CustomerMapper;
import com.coretree.defaultconfig.main.model.Customer;


@RestController
public class CustomerController{

	@Autowired
	CustomerMapper customerMapper;
	
	/**
	 * customer counter 정보를 조회한다.
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path = "/main/customerList", method = RequestMethod.POST)
	public  List<Customer> customerList(@RequestBody Customer searchVO,
			ModelMap model, HttpServletRequest request) throws Exception {
	
		List<Customer> customer = customerMapper.selectCustomerList(searchVO);

		for(int i=0; i<customer.size(); i++){
			customer.get(i).setNum(i+1);
		}
		
		return customer;
	}
	
	@RequestMapping(path = "/main/customerListExcel")
	public  ModelAndView customerListExcel(@RequestParam("telNo") String telNo,
															@RequestParam("custNm") String custNm,
															@RequestParam("empNm") String empNm,
															@RequestParam("coRegNo") String coRegNo,
															@RequestParam("sexCd") String sexCd,
															@RequestParam("regDate") String regDate,
															@RequestParam("regDate2") String regDate2,
															@RequestParam("lastCounDate") String lastCounDate,
															@RequestParam("lastCounDate2") String lastCounDate2,
															@RequestParam("gradeCd") String gradeCd,
															@RequestParam("custTypCd") String custTypCd,
															@RequestParam("recogTypCd") String recogTypCd,
			ModelMap model, HttpServletRequest request) throws Exception {
		
		Customer searchVO = new Customer();
		searchVO.setTelNo(telNo);
		searchVO.setCustNm(custNm);
		searchVO.setCoRegNo(coRegNo);
		searchVO.setSexCd(sexCd);
		searchVO.setRegDate(regDate);
		searchVO.setRegDate2(regDate2);
		searchVO.setLastCounDate(lastCounDate);
		searchVO.setLastCounDate2(lastCounDate2);
		searchVO.setGradeCd(gradeCd);
		searchVO.setCustTypCd(custTypCd);
		searchVO.setRecogTypCd(recogTypCd);
		
		List<Customer> result = customerMapper.selectCustomerListExcel(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);

		model.addAttribute("customerList", map.get("resultList"));
		model.addAttribute("empNm", empNm);
		
		return new ModelAndView("CustmoerListReportDownload", "custmoerListReportMap", model);
	}
	
	@RequestMapping(path = "/main/customerOne", method = RequestMethod.POST)
	public  Customer customerOne(@RequestBody Customer searchVO,
			ModelMap model, HttpServletRequest request) throws Exception {
		
		Customer customer = customerMapper.selectCustomerOne(searchVO);
		
		return customer;
	}
	
	@RequestMapping(path = "/main/existCntCustomer", method = RequestMethod.POST)
	public long existCntCustomer(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		Customer customer = new Customer();
		if(paramCustomer.getCustCd().equals("1001")){
	    	customer = customerMapper.selectExistCnt1001(paramCustomer);
	    	result = customer.getExistCnt();
		}else{
			customer = customerMapper.selectExistCnt1002(paramCustomer);
	    	result = customer.getExistCnt();
		}
		return result;
	}
	
	@RequestMapping(path = "/main/existCoustomer", method = RequestMethod.POST)
	public String existCoustomer(@RequestBody Customer paramCustomer, HttpSession session) {
		String result = "";
		long data = 0;
		String resultCode = customerMapper.selectExitCustomer(paramCustomer);
		if(resultCode.equals("1000")||resultCode.equals("2100")){
			data = customerMapper.updateCustomer(paramCustomer);
			result = "1000";
		}else if(resultCode.equals("1001")){
			//data = customerMapper.insertCustomer(paramCustomer);
			result = "1001";
		}else if(resultCode.equals("1100")){
			result = "1100";
	    }else if(resultCode.equals("1101")){
	    	result = "1101";
	    }else if(resultCode.equals("4100")){
	    	result = "4100";
	    }else if(resultCode.equals("2000")){
	    	data = customerMapper.insertCustomer(paramCustomer);
	    	result = "2000";
	    }
		return result;
	}
	
	@RequestMapping(path = "/main/insertCustomer", method = RequestMethod.POST)
	public String insertCustomer(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		String resultMsg = "0";
		String custNo = "";
		result = customerMapper.insertCustomer(paramCustomer);
		if(result == 1){
			custNo = customerMapper.selectCustomerCustNo(paramCustomer);
			resultMsg = custNo;
		}else{
			resultMsg = "0";
		}
		return resultMsg;
	}
	
	
	@RequestMapping(path = "/main/updateCustomer", method = RequestMethod.POST)
	public long updateCustomer(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		result = customerMapper.updateCustomer(paramCustomer);
		return result;
	}
	
	@RequestMapping(path = "/main/insertCustomer2", method = RequestMethod.POST)
	public long insertCustomer2(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		long exitCnt = 0;
		Customer customer = new Customer();
		customer = customerMapper.selectExistCnt1002(paramCustomer);
		exitCnt = customer.getExistCnt();
			if(exitCnt == 0){
				result = customerMapper.insertCustomer(paramCustomer);
			}else{
				customerMapper.updateCustomer(paramCustomer);
				result = 2;
			}
		return result;
	}
	
	@RequestMapping(path = "/main/deleteCustomer", method = RequestMethod.POST)
	public long deleteCustomer(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		String[] custNos = paramCustomer.getCustNo().split(",");
		Customer customer = new Customer();
		customer.setCustNos(custNos);
		result = customerMapper.deleteCustomer(customer);
		return result;
	}
    
	@RequestMapping(path = "/main/deleteCustomerOne", method = RequestMethod.POST)
	public long deleteCustomerOne(@RequestBody Customer paramCustomer, HttpSession session) {
		long result = 0;
		result = customerMapper.deleteCustomerOne(paramCustomer);
		return result;
	}
	
	/**
	 * 고객정보선택(팝업)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
    @RequestMapping(path = "/popup/customerList", method = RequestMethod.POST)
    public List<Customer> customerPopup(@RequestBody Customer searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
		List<Customer> customer = customerMapper.selectCustomer(searchVO);
    	return customer;
    }
    
	/**
	 * 엑셀로 고객정보 저장 - 저장 버튼(개인)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
    @SuppressWarnings("unchecked")
    @RequestMapping(path="/popup/insertCustomer", method = RequestMethod.POST)
	public ArrayList<String> saveCustomer(@RequestBody String searchVO, HttpServletRequest request) throws Exception {
    	long result = 0;
    	
    	List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
		resultMap = JSONArray.fromObject(searchVO); 
		
		ArrayList<String> t = new ArrayList<String>();
		String custCd = null;
		String custNumber = null;
		for(Map<String,Object> map : resultMap){
			map.get("custCd");
			map.get("custNo");
			map.get("custNm");
			map.get("tel1No");
			map.get("tel2No");
			map.get("tel3No");

			custCd = map.get("custCd").toString();
			if(custCd.equals("1001") || custCd == "1001"){
				result = customerMapper.insertCustomer3(map);
				if(result == 1){
					custNumber = customerMapper.selectCustomerCustNo2(map);
				}else{
					custNumber = "0";
				}
			}else if(custCd.equals("1002") || custCd == "1002"){
				result = customerMapper.insertCustomer4(map);
			}
			//System.out.println("고객번호  : " + custNumber);
			t.add(custNumber);
		}
		return t;
	}
}


















