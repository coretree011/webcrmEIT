package com.coretree.defaultconfig.main.controller;

import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPalette;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.coretree.defaultconfig.EitDateUtil;
import com.coretree.defaultconfig.EitReportStyleUtil;

public class CustmoerListReportDownload extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook wb, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		try {
			/**
			 * 현재 컨드롤 되어지는 행번호
			 */
			int rownum = 0;
			/**
			 * 지금까지 총 컨트롤한 행수
			 */
			int rowcnt = 0;
			/**
			 * 합계가 들어갈 행번호
			 */
			int sum_rownum = 0;
			/**
			 * 셀병합시(세로병합)에서 시작되는 행번호
			 */
			int mer_st_rownum = 0;

			EitReportStyleUtil style = new EitReportStyleUtil();

			JSONArray customerList = JSONArray.fromObject(model.get("customerList"));
			String empNm = model.get("empNm").toString();
	
			// GREY_25_PERCENT의 인텍스 값에 대한 REG속성 값을 변경
			HSSFPalette palette = wb.getCustomPalette();
			palette.setColorAtIndex(HSSFColor.GREY_25_PERCENT.index,
					(byte) 242, (byte) 242, (byte) 242);
	
			HSSFSheet sheet = wb.createSheet("고객리스트");

			for (int i = 0; i <= 1; i++) {
				sheet.setColumnWidth((short) i, (short) 8 * 300);
			}
			for (int i = 2; i <= 3; i++) {
				sheet.setColumnWidth((short) i, (short) 10 * 300);
			}
	
			for (int i = 4; i <= 8; i++) {
				sheet.setColumnWidth((short) i, (short) 15 * 300);
			}
			
			sheet.setColumnWidth((short) 9, (short) 40 * 300);
			
			sheet.setColumnWidth((short) 10, (short) 12 * 300);
			
			for (int i = 11; i <= 13; i++) {
				sheet.setColumnWidth((short) i, (short) 10 * 300);
			}
			
			sheet.setColumnWidth((short) 14, (short) 10 * 300);
			
			sheet.setColumnWidth((short) 15, (short) 5 * 300);

			for (int i = 16; i <= 17; i++) {
				sheet.setColumnWidth((short) i, (short) 10 * 300);
			} 
			
			sheet.setColumnWidth((short) 18, (short) 18 * 300);
			/**
			* 헤더 폰트
			* 폰트 높이는 24, 폰트 종류는 Courier New, 이탈릭체로 설정한다
			*/
	
			HSSFDataFormat df = wb.createDataFormat();
			
			HSSFFont hFont = style.getFont(wb, "맑은 고딕", (short) 20, HSSFFont.BOLDWEIGHT_BOLD);
			
			/**
			* 본문 타이틀 폰트
			*/
			HSSFFont tiFont = style.getFont(wb, "맑은 고딕", (short) 10, HSSFFont.BOLDWEIGHT_BOLD);
	
			/**
			* 본문 내용 폰트
			*/
			HSSFFont cFont = style.getFont(wb, "맑은 고딕", (short) 10, HSSFFont.BOLDWEIGHT_NORMAL);
	
			/**
			 * 본문 상세 스타일
			 */
			HSSFFont taFont = style.getFont(wb, "맑은 고딕", (short) 8, HSSFFont.BOLDWEIGHT_NORMAL);
			
			/**
			* 헤더 셀스타일
			*/
			HSSFCellStyle hStyle = style.getHeaderStyle(wb, hFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE));
			
			/**
			* 타이틀 _텍스트_가운데정렬_테두리위아래
			*/
			HSSFCellStyle Ti_T_C_Ttb_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_NONE, HSSFCellStyle.BORDER_NONE, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
			
			/**
			* 타이틀 _텍스트_가운데정렬_테두리위아래, 왼쪽테두리 굵은선
			*/
			HSSFCellStyle Ti_T_C_Ml_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_NONE, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 타이틀 _텍스트_수직정렬위_테두리위아래, 왼쪽테두리 굵은선
			*/
			HSSFCellStyle Ti_T_T_Ml_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_TOP, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_NONE, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
			
			/**
			* 타이틀 _텍스트_가운데정렬_테두리위아래, 오른쪽테두리 굵은선
			*/
			HSSFCellStyle Ti_T_C_Mr_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_NONE, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
			
			/**
			* 타이틀 _텍스트_가운데정렬_테두리전체, 굵은선
			*/
			HSSFCellStyle Ti_T_C_M_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
			
			/**
			* 타이틀 _텍스트_왼쪽정렬_테두리 위아래
			*/
			HSSFCellStyle Ti_T_L_Ttbl_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_NONE, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 타이틀 _텍스트_가운데정렬_테두리 전체
			*/
			HSSFCellStyle Ti_T_C_T_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) ); 
	
			/**
			* 타이틀(본문폰트) _텍스트_오른쪽정렬_테두리 위아래.
			*/
			HSSFCellStyle Ti_T_R_Ttb_style = style.getTitleStyle(wb, cFont, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_NONE, HSSFCellStyle.BORDER_NONE, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 타이틀_숫자_오른쪽정렬_테두리전체
			*/
			HSSFCellStyle Ti_N_R_Mr_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat("####.##%") );
	
			/**
			* 타이틀_회(원)_오른쪽정렬_테두리전체
			*/
			HSSFCellStyle Ti_AK_R_T_style = style.getTitleStyle(wb, tiFont, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat("###,###,##0") );
	
			/**
			* 본문_텍스트_가운데정렬_테두리전체
			*/
			HSSFCellStyle C_T_C_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
			
			/**
			 * 본문_텍스트_가운데정렬_테두리전체
			 */
			HSSFCellStyle C_T_L_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 본문_텍스트_가운데정렬_테두리전체, 오른쪽 굵은선
			*/
			HSSFCellStyle C_T_C_Mr_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 본문_텍스트_가운데정렬_테두리전체, 왼쪽 굵은선
			*/
			HSSFCellStyle C_T_C_Ml_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 본문_텍스트_가운데정렬_테두리전체, 위아래가는선, 오른쪽왼쪽 굵은선
			*/
			HSSFCellStyle C_T_C_Mlr_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			* 본문_텍스트_가운데정렬_테두리전체, 위,오른쪽가는선, 왼쪽,아래 굵은선
			*/
			HSSFCellStyle C_T_C_Mblr_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			 * 본문_텍스트_왼쪽정렬_테두리전체, 오른쪽굵은선
			 */
			HSSFCellStyle C_T_L_Mr_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			 * 본문_텍스트_왼쪽정렬_테두리전체, 아래, 왼쪽 굵은선
			 */
			HSSFCellStyle C_T_C_Mbl_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			 * 본문_텍스트_왼쪽정렬_테두리전체, 아래, 오른쪽 굵은선
			 */
			HSSFCellStyle C_T_C_Mbr_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			/**
			 * 본문_텍스트_왼쪽정렬_테두리전체, 아래 굵은선
			 */
			HSSFCellStyle C_T_C_Mb_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_LEFT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_MEDIUM, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
	
			/**
			 * 본문_숫자_오른쪽정렬_테두리전체
			 */
			HSSFCellStyle C_N_R_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE));
	
			/**s
			 * 본문_회계(원)_오른쪽정렬_테두리전체
			 */
			HSSFCellStyle C_AK_R_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat("###,###,##0") ); 
	
			/**
			 * 본문_회계(달러)_오른쪽정렬_테두리전체
			 */
			HSSFCellStyle C_AU_R_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat("$#,##0.##") );
	
			/**
			 * 본문_날짜_가운데정렬_테두리전체
			 */
			HSSFCellStyle C_D_C_T_style = style.getContentsStyle(wb, cFont, HSSFCellStyle.ALIGN_CENTER, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat("yyyy-mm-dd") );
	
			/**
			 * 꼬리말(본문비고)_텍스트_가운데정렬_테두리전체
			 */
			HSSFCellStyle Ta_T_R_T_style = style.getTailStyle(wb, taFont, HSSFCellStyle.ALIGN_RIGHT, HSSFCellStyle.VERTICAL_CENTER, 
					HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, HSSFCellStyle.BORDER_THIN, 
					df.getFormat(DEFAULT_CONTENT_TYPE) );
	
			HSSFRow row = null;
			HSSFCell cell = null;
			rownum = 0;

			/*************** 헤더 ***************/
			// 설정한 폰트를 스타일에 적용한다
			row = sheet.createRow(rownum);
			row.setHeight((short) (7 * 25));

			rownum = rownum + 1;
			
			row = sheet.createRow(rownum);
			cell = row.createCell(0);
			row.setHeight((short) (32.35 * 25));

			for (int c = 0; c <= 18; c++) {
				cell = row.createCell(c);
				cell.setCellValue("고객리스트");
				cell.setCellStyle(hStyle);
			}
			sheet.addMergedRegion(new Region((short) rownum, (short) 0, (short) rownum, (short) 18));

			rownum = rownum + 1;
			
			row = sheet.createRow(rownum);

			for (int c = 0; c <= 1; c++) {
				cell = row.createCell(c);
				cell.setCellValue("출력일");
				cell.setCellStyle(C_D_C_T_style);
			}
			sheet.addMergedRegion(new Region((short) rownum, (short) 0, (short) rownum, (short) 1));

			for (int c = 2; c <= 4; c++) {
				cell = row.createCell(c);
				cell.setCellStyle(C_D_C_T_style);
				cell.setCellValue(EitDateUtil.formatDate(EitDateUtil.getToday(),"-") +" "+EitDateUtil.formatTime2(EitDateUtil.getTotime(),":"));
			}
			sheet.addMergedRegion(new Region((short) rownum, (short) 2, (short) rownum, (short) 4));

			rownum = rownum + 1;
			
			row = sheet.createRow(rownum);
			
			for (int c = 0; c <= 1; c++) {
				cell = row.createCell(c);
				cell.setCellValue("출력자");
				cell.setCellStyle(C_D_C_T_style);
			}
			sheet.addMergedRegion(new Region((short) rownum, (short) 0, (short) rownum, (short) 1));

			for (int c = 2; c <= 4; c++) {
				cell = row.createCell(c);
				cell.setCellStyle(C_D_C_T_style);
				cell.setCellValue(empNm);
			}
			sheet.addMergedRegion(new Region((short) rownum, (short) 2, (short) rownum, (short) 4));
			
			row = sheet.createRow(5);
			
			cell = row.createCell(0);
			cell.setCellValue("SEQ");
			cell.setCellStyle(Ti_T_C_T_style);

			cell = row.createCell(1);
			cell.setCellValue("유형");
			cell.setCellStyle(Ti_T_C_T_style);

			cell = row.createCell(2);
			cell.setCellValue("고객번호");
			cell.setCellStyle(Ti_T_C_T_style);

			cell = row.createCell(3);
			cell.setCellValue("고객명");
			cell.setCellStyle(Ti_T_C_T_style);

			cell = row.createCell(4);
			cell.setCellValue("핸드폰");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(5);
			cell.setCellValue("직장");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(6);
			cell.setCellValue("자택");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(7);
			cell.setCellValue("e-Mail");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(8);
			cell.setCellValue("FAX");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(9);
			cell.setCellValue("주소");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(10);
			cell.setCellValue("사업자번호");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(11);
			cell.setCellValue("최종상담일");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(12);
			cell.setCellValue("고객등급");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(13);
			cell.setCellValue("고객유형");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(14);
			cell.setCellValue("인지경로");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(15);
			cell.setCellValue("성별");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(16);
			cell.setCellValue("생년월일");
			cell.setCellStyle(Ti_T_C_T_style);
			
			
			cell = row.createCell(17);
			cell.setCellValue("등록일");
			cell.setCellStyle(Ti_T_C_T_style);
			
			cell = row.createCell(18);
			cell.setCellValue("비고");
			cell.setCellStyle(Ti_T_C_T_style);

			rownum = 6;

			int j = 1;
			for (int i = 0; i < customerList.size(); i++) {
			row = sheet.createRow(rownum);
			
			cell = row.createCell(0);
			cell.setCellValue(j);
			cell.setCellStyle(C_N_R_T_style);
			
			cell = row.createCell(1);
			cell.setCellValue(customerList.getJSONObject(i).getString("custCdNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(2);
			cell.setCellValue(customerList.getJSONObject(i).getString("custNo"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(3);
			cell.setCellValue(customerList.getJSONObject(i).getString("custNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(4);
			cell.setCellValue(customerList.getJSONObject(i).getString("tel1No"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(5);
			cell.setCellValue(customerList.getJSONObject(i).getString("tel2No"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(6);
			cell.setCellValue(customerList.getJSONObject(i).getString("tel3No"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(7);
			cell.setCellValue(customerList.getJSONObject(i).getString("emailId"));
			cell.setCellStyle(C_T_L_T_style);
			
			cell = row.createCell(8);
			cell.setCellValue(customerList.getJSONObject(i).getString("faxNo"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(9);
			cell.setCellValue(customerList.getJSONObject(i).getString("addr"));
			cell.setCellStyle(C_T_L_T_style);
			
			cell = row.createCell(10);
			cell.setCellValue(customerList.getJSONObject(i).getString("coRegNo"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(11);
			cell.setCellValue(customerList.getJSONObject(i).getString("lastCounDate"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(12);
			cell.setCellValue(customerList.getJSONObject(i).getString("gradeNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(13);
			cell.setCellValue(customerList.getJSONObject(i).getString("custTypNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(14);
			cell.setCellValue(customerList.getJSONObject(i).getString("recogTypNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(15);
			cell.setCellValue(customerList.getJSONObject(i).getString("sexNm"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(16);
			cell.setCellValue(customerList.getJSONObject(i).getString("birthDate"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(17);
			cell.setCellValue(customerList.getJSONObject(i).getString("regDate"));
			cell.setCellStyle(C_D_C_T_style);
			
			cell = row.createCell(18);
			cell.setCellValue(customerList.getJSONObject(i).getString("custNote"));
			cell.setCellStyle(C_T_L_T_style);
			
			rownum = rownum + 1;
			j = j + 1;
			}
			/**
			 * 파일 다운로드 시작.
			 **/
			
			logger.debug("customerList 다운로드 완료.");
			
			String fileName = EitDateUtil.getToday()
					+ EitDateUtil.getTotime() + "_고객리스트.xls";
			response.setContentType("application/x-download");
			response.setHeader("Content-Disposition", "attachment; filename="
					+URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20"));
					//+ new String(fileName.getBytes(), "euc-kr"));
			
		}catch(Exception e){
			e.printStackTrace();
		}
	} 
}
