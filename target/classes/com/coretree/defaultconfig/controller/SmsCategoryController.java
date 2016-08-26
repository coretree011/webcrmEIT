/*작성자 : 송은미*/
package com.coretree.defaultconfig.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.coretree.defaultconfig.setting.mapper.SmsCategoryMapper;
import com.coretree.defaultconfig.setting.model.SmsCategory;


@RestController
public class SmsCategoryController {
	

	@Autowired
	SmsCategoryMapper smsCategoryMapper;
	
	/**
	 * SMS전송유형(팝업)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/smsList", method = RequestMethod.POST)
	public List<SmsCategory> noticeList(ModelMap model, HttpServletRequest request) throws Exception {
		List<SmsCategory> smsCategory = smsCategoryMapper.selectSmsList();
				
		return smsCategory;
		
	}
	
	/**
	 * SMS전송유형(팝업)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/smsOne", method = RequestMethod.POST)
	public SmsCategory smsOne(@RequestBody SmsCategory searchVO,
			ModelMap model, HttpServletRequest request) throws Exception {
		
		SmsCategory smsCategory = smsCategoryMapper.selectSmsOne(searchVO);
		
		return smsCategory;
		
	}
	
	/**
	 * SMS전송유형(팝업) - 저장
	 * @param workbook
	 * @param fileName
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(path="/popup/saveSms", method = RequestMethod.POST)
	public long saveSms(@RequestBody SmsCategory searchVO , HttpSession session) { 
		long result;
		try{
			result = smsCategoryMapper.insertSms(searchVO);			
		}catch(Exception e){
			result = 0;
		}		
		return result;
		
	} 
	
	/**
	 * SMS전송유형(팝업) - 삭제
	 * @param workbook
	 * @param fileName
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(path="/popup/smsDelete", method = RequestMethod.POST)
	public long deleteSms(@RequestBody SmsCategory searchVO, HttpSession session) {
		
		long result = 0;
    	String[] seq = searchVO.getCateCd().split(",");
    	SmsCategory sms = new SmsCategory();
    	sms.setCateCds(seq);
    	result = smsCategoryMapper.deleteSms(sms);
    	return result;
		
	}
	
	/**
	 * SMS전송유형(팝업) - 수정
	 * @param workbook
	 * @param fileName
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(path="/popup/updateSms", method = RequestMethod.POST)
	public long updateSms(@RequestBody SmsCategory searchVO, HttpSession session) {
		
		long result;
		try{
			result = smsCategoryMapper.updateSms(searchVO);			
		}catch(Exception e){
			result = 0;
		}		
		return result;
		
	}
	
	
	/**
	 * SMS전송유형(팝업) - 초기화버튼(유형코드 max값 가져오기)
	 * @param workbook
	 * @param fileName
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(path="/popup/smsInitialization", method = RequestMethod.POST)
	public SmsCategory maxSms(@RequestBody SmsCategory searchVO,
			ModelMap model, HttpServletRequest request) throws Exception {
		SmsCategory smsCategory = smsCategoryMapper.maxSms(searchVO);	
		
		return smsCategory;
	}
}
