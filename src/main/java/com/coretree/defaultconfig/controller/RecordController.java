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

import com.coretree.defaultconfig.main.model.Customer;
import com.coretree.defaultconfig.statis.mapper.RecordMgtMapper;
import com.coretree.defaultconfig.statis.model.RecordMgt;

@RestController
public class RecordController {

	@Autowired
	RecordMgtMapper recordMgtMapper;
	
	/**
	 * 녹취현황(팝업) - 조회 버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/recordList", method = RequestMethod.POST)
	public List<RecordMgt> recordList(@RequestBody RecordMgt searchVO, ModelMap model, HttpServletRequest request) {
 
		List<RecordMgt> recordMgt = recordMgtMapper.selectRecordList(searchVO);
		
		return recordMgt;
		
	}
	
	/*엑셀파일로 저장*/
	@RequestMapping(path = "/popup/redcordListExcel")
	public  ModelAndView recordListExcel(@RequestParam("startDate") String startDate,
										@RequestParam("endDate") String endDate,
										@RequestParam("callTypCd") String callTypCd,
										@RequestParam("extensionNo") String extensionNo,
										@RequestParam("telNo") String telNo,
										@RequestParam("empNm") String empNm,
			ModelMap model, HttpServletRequest request) throws Exception {
		
		RecordMgt searchVO = new RecordMgt();
		searchVO.setStartDate(startDate);
		searchVO.setEndDate(endDate);
		searchVO.setCallTypCd(callTypCd);
		searchVO.setExtensionNo(extensionNo);
		searchVO.setTelNo(telNo);
		
		List<RecordMgt> result = recordMgtMapper.selectRecordList(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", result);

		model.addAttribute("recordList", map.get("resultList"));
		model.addAttribute("empNm", empNm);
		
		return new ModelAndView("RecordListReportDownload", "recordListReportMap", model);
	}
}
