/*작성자 : 송은미*/
package com.coretree.defaultconfig.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.coretree.defaultconfig.statis.mapper.CallStatMapper;
import com.coretree.defaultconfig.statis.model.CallStat;
import com.coretree.defaultconfig.statis.model.IvrCall;

@RestController
public class CallStatController {
	@Autowired
	CallStatMapper callStatMapper;

	/**
	 * 전체 통계 현황(팝업) - 조회 버튼(시간별)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/callStatSelect", method = RequestMethod.POST)
	public List<CallStat> callStatList(@RequestBody CallStat searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
		List<CallStat> callStat = callStatMapper.selectCallStatList(searchVO);
		return callStat;
	}
	
	/**
	 * 전체 통계 현황(팝업) - 조회 버튼(일별)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/callStatSelectDay", method = RequestMethod.POST)
	public List<CallStat> callStatListDay(@RequestBody CallStat searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
		List<CallStat> callStat = callStatMapper.selectCallStatListDay(searchVO);
		return callStat;
	}
	
	/**
	 * 전체 통계 현황(팝업) - 조회 버튼(월별)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/callStatSelectMonth", method = RequestMethod.POST)
	public List<CallStat> callStatListMonth(@RequestBody CallStat searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
		List<CallStat> callStat = callStatMapper.selectCallStatListMonth(searchVO);
		return callStat;
	}
	
	/**
	 * 전체 통계 현황(팝업) - 조회 버튼(연도별)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/callStatSelectYear", method = RequestMethod.POST)
	public List<CallStat> callStatListYear(@RequestBody CallStat searchVO,
    		ModelMap model, HttpServletRequest request) throws Exception {
		List<CallStat> callStat = callStatMapper.selectCallStatListYear(searchVO);
		return callStat;
	}
	
	/*엑셀 다운로드*/
	@RequestMapping(path = "/popup/callcenterListExcel")
	public  ModelAndView callcenterListExcel(@RequestParam("startDate") String startDate,
										@RequestParam("endDate") String endDate,
										@RequestParam("empNm") String empNm,
										@RequestParam("radioValue") int radioValue,
			ModelMap model, HttpServletRequest request) throws Exception {
		
		CallStat searchVO = new CallStat();
		searchVO.setStartDate(startDate);
		searchVO.setEndDate(endDate);
		
		List<CallStat> result = null;
		if(radioValue == 1){
			result = callStatMapper.selectCallStatList(searchVO);
		}else if(radioValue == 2){
			result = callStatMapper.selectCallStatListDay(searchVO);
		}else if(radioValue == 3){
			result = callStatMapper.selectCallStatListMonth(searchVO);
		}else if(radioValue == 4){
			result = callStatMapper.selectCallStatListYear(searchVO);
		}
		

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);

		model.addAttribute("callcenterList", map.get("resultList"));
		model.addAttribute("empNm", empNm);
		
		return new ModelAndView("CallStatListReportDownload", "callStatListReportMap", model);
	}
	
}
