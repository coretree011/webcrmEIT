/*작성자 : 송은미*/
package com.coretree.defaultconfig.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.coretree.defaultconfig.main.mapper.CustomerMapper;
import com.coretree.defaultconfig.main.model.Customer;



@RestController
public class ExcelController {
	@Autowired
	CustomerMapper customerMapper;
	
	/**
	 * 엑셀로 고객정보 저장 - 엑셀 선택 버튼(팝업)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	
	private final String UPLOADPATH = "/opt/webcrm/file/";
	//private final String UPLOADPATH = "D:\\";
	String filePath = "";
	
	/**
	 * 엑셀파일 업로드
	 * 
	 * @param uploadfile
	 * @return
	 */
	@RequestMapping(path = "/popup/read_xlsx",method = RequestMethod.POST)
	public ResponseEntity<?> fileUpload(@RequestParam("uploadFile") MultipartFile uploadFile) {

	    try {
	    	String fileNm = uploadFile.getOriginalFilename();
	        filePath = UPLOADPATH + File.separator + fileNm;
	        
	        // 해당 경로 폴더 없을 떄 폴더 생성.
	        String uploadDir = UPLOADPATH + File.separator;
            new File(uploadDir).mkdir();
            
	        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(filePath)));
	        stream.write(uploadFile.getBytes());
	        stream.close();
	    } catch (Exception e) {
	    	//System.out.println(e.getMessage());
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }

	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping(path = "/popup/read_xlsx2",method = RequestMethod.POST)
	public List<Customer> readXlsx() {
		
		/*String rootlength = excelroot;
		String root = rootlength.substring(1, rootlength.length()-1);

		root = root.replace("\\\\", "/");
		System.out.println("==============================root : " + root);*/
		
		String root = filePath;
		List<Customer> cutomer = null;
		
		// 워크북 생성
		Workbook workbook = null;
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(new File(root).getAbsoluteFile());
			workbook = new XSSFWorkbook(fis);
			cutomer = readExcelFile(workbook);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null) fis.close();
				File file = new File(filePath);
				file.delete();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return cutomer;
	}

	/**
	 * 엑셀파일로 저장
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	
	@RequestMapping(path = "/popup/excelListExport")
	public ModelAndView excelListExport(@RequestParam("jsonEncode") String jsonEncode, @RequestParam("empNm") String empNm, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("resultList", jsonEncode);
		model.addAttribute("excelList", map.get("resultList"));
		model.addAttribute("empNm", empNm);
		
		return new ModelAndView("ExcelListReportDownload", "excelListReportMap", model);
	}
	
	/**
	 * 엑셀에 저장된 데이터를 읽어온다.
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	public List<Customer> readExcelFile(Workbook workbook) {
		
		List<Customer> customer = new ArrayList<Customer>();
		
		// 워크시트
		Sheet curSheet;
		// 행
		Row curRow;
		// 셀
		Cell curCell;
		
		int numberOfSheets = workbook.getNumberOfSheets();
		//System.out.println("numberOfSheets = " + numberOfSheets);
		
		for (int sheetIndex = 0; sheetIndex < numberOfSheets; sheetIndex++) {
			curSheet = workbook.getSheetAt(sheetIndex);
			
			int physicalNumberOfRows = curSheet.getPhysicalNumberOfRows();
			//System.out.println("physicalNumberOfRows = " + physicalNumberOfRows);
			for (int rowIndex = 1; rowIndex < physicalNumberOfRows; rowIndex++) {
				curRow = curSheet.getRow(rowIndex);
				Customer cus = new Customer();
				String value;
				
				if (!"".equals(curRow.getCell(0).getStringCellValue()) || !"".equals(null)) {
					int physicalNumberOfCells = curRow.getPhysicalNumberOfCells();
					/*System.out.println("physicalNumberOfCells = " + physicalNumberOfCells);*/
					for (int cellIndex = 0; cellIndex < physicalNumberOfCells; cellIndex++) {
						curCell = curRow.getCell(cellIndex);
						if (curCell == null) continue;
						
						value = "";
						
						switch (curCell.getCellType()) {
						case XSSFCell.CELL_TYPE_FORMULA:
							value = curCell.getCellFormula();
							break;
						case XSSFCell.CELL_TYPE_NUMERIC:
							value = ((int)curCell.getNumericCellValue())+"";
							break;
						case XSSFCell.CELL_TYPE_STRING:
							value = curCell.getStringCellValue()+"";
							break;
						case XSSFCell.CELL_TYPE_BLANK:
							value = curCell.getBooleanCellValue()+"";
							break;
						case XSSFCell.CELL_TYPE_ERROR:
							value = curCell.getErrorCellValue()+"";
							break;
						default:
							value = new String();
							break;
						}
						
						switch (cellIndex) {
						case 0:
							cus.setCustCdNm(value);
							break;
						case 1:
							cus.setCustNo(value);
							break;
						case 2:
							cus.setCustNm(value);
							break;
						case 3:
							cus.setTel1No(value);
							break;
						case 4:
							cus.setTel2No(value);
							break;
						case 5:
							cus.setTel3No(value);
							break;
						case 6:
							cus.setEmailId(value);
							break;
						case 7:
							cus.setFaxNo(value);
							break;
						case 8:
							cus.setAddr(value);
							break;
						case 9:
							cus.setCustNote(value);
							break;
						}
					}
					customer.add(cus);
					//System.out.println("===================excel data cus : " + cus);
				}
			}
		}
		
		return customer;
	}
	
	/**
	 * 엑셀로 고객정보 저장 - 데이터검증 버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(path="/popup/excelData", method = RequestMethod.POST)
	public ArrayList<String> excelData(@RequestBody String searchVO, HttpServletRequest request) throws Exception  {
		
		List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
		resultMap = JSONArray.fromObject(searchVO); 
		
		ArrayList<String> t = new ArrayList<String>();
		String dataChk = null;
		for(Map<String,Object> map : resultMap){
			map.get("custCd");
			map.get("custNo");
			map.get("custNm");
			map.get("tel1No");
			map.get("tel2No");
			map.get("tel3No");

			dataChk = customerMapper.excelData(map);			
			t.add(dataChk);
			
			//System.out.println(dataChk);
		}
		return t;
	}
	
}
