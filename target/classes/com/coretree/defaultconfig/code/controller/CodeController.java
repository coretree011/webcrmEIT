package com.coretree.defaultconfig.code.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.coretree.defaultconfig.bbs.model.BbsMgt;
import com.coretree.defaultconfig.code.mapper.CodeMapper;
import com.coretree.defaultconfig.code.model.Code;
import com.coretree.defaultconfig.code.model.CodeLarge;
import com.coretree.defaultconfig.setting.model.SmsCategory;

/**
 * Test를 위한 컨트롤러 클래스
 * 
 * @author hsw
 *
 */
@RestController
public class CodeController {

	@Autowired
	CodeMapper codeMapper;

	/**
	 * customer counter 정보를 조회한다.
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path = "/code/selecCodeList", method = RequestMethod.POST)
	public List<Code> selecCode(@RequestBody Code param, HttpServletRequest request) throws Exception {
		
		List<Code> code = codeMapper.selectCode(param);

		return code;
	}
	
	/**
	 * 팝업 내선관리에서 내선관리를 삭제한다.
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path="/code/deleteExtensionCode", method = RequestMethod.POST)
	public long extensionDelete(@RequestBody Code param, HttpSession session) {
		
		long result = 0;
    	String[] test = param.getScd().split(",");
    	Code code = new Code();
    	code.setScds(test);
    	result = codeMapper.deleteExtension(code);
    	return result;
	}
	
	/**
	 * 팝업 내선관리에서 내선관리를 저장한다.
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path="/code/insertExtensionCode", method = RequestMethod.POST)
	public long extensionInsert(@RequestBody Code param,
    		ModelMap model, HttpServletRequest request) {
 
		long result;
		try{
			result = codeMapper.insertExtension(param);	
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	/**
	 * 팝업 내선관리에서 내선관리 내용을 수정한다.
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path="/code/updateExtension", method = RequestMethod.POST)
	public long extensionUpdate(@RequestBody Code param,
    		ModelMap model, HttpServletRequest request) {
 
		long result;
		try{
			result = codeMapper.updateExtension(param);	
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	
	//=========================================================
	//기타 코드관리 팝업페이지
	//=========================================================
	
	/**
	 * TCODE_LARGE LIST
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path = "/popup/codeLargeList", method = RequestMethod.POST)
	public List<CodeLarge> codeLargeList(@RequestBody CodeLarge param, HttpServletRequest request) throws Exception {
		List<CodeLarge> code = codeMapper.selectCodeLarge(param);
		return code;
	}
	
	/**
	 * TCODE_SMALL LIST
	 * 
	 * @param condition
	 * @return
	 */
	
	@RequestMapping(path = "/popup/codeSmallList", method = RequestMethod.POST)
	public List<Code> codeSmallList(@RequestBody Code param, HttpServletRequest request) throws Exception {
		List<Code> code = codeMapper.selectCodeSmall(param);
		return code;
	}
	
	//TCODE_SMALL 에서 코드 MAX값 가져오기
	@RequestMapping(path="/popup/codeSmallMax", method = RequestMethod.POST)
	public Code maxCode(@RequestBody Code searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		Code code = codeMapper.maxCode(searchVO);	
		
		return code;
	}
	
	//TCODE_SMALL 저장
	@RequestMapping(path="/popup/codeSmallInsert", method = RequestMethod.POST)
	public long codeInsert(@RequestBody Code searchVO, HttpSession session) {
		long result;
		try{
			result = codeMapper.codeInsert(searchVO);	
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	//TCODE_SMALL 수정
	@RequestMapping(path="/popup/codeSmallModify", method = RequestMethod.POST)
	public long codeModify(@RequestBody Code searchVO, HttpSession session) {
		long result;
		try{
			result = codeMapper.codeModify(searchVO);	
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	
	
	
	
}

















