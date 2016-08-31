package com.coretree.defaultconfig;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

public class EitReportStyleUtil {

	/**
	* 헤더 폰트
	* 폰트 높이는 24, 폰트 종류는 Courier New, 이탈릭체로 설정한다
	*/
	public HSSFFont getFont(HSSFWorkbook wb, String fontName, short fontSize, short fontBold){
		
		HSSFFont font = wb.createFont();
		font.setFontHeightInPoints(fontSize);
		font.setFontName(fontName);
		font.setBoldweight(fontBold);
		
		return font;
	}
	
	
//	/**
//	* 본문 타이틀 폰트
//	*/
//	public HSSFFont getTitleFont(HSSFWorkbook wb, String fontName, short fontSize, short fontBold){
//		HSSFFont titleFont = wb.createFont();
//		titleFont.setFontHeightInPoints(fontSize);
//		titleFont.setFontName(fontName);
//		titleFont.setBoldweight(fontBold);
//		
//		return titleFont;
//	}
//	
//	
//	/**
//	* 본문 내용 폰트
//	*/
//	public HSSFFont getContentsFont(HSSFWorkbook wb, String fontName, short fontSize, short fontBold){
//		HSSFFont contentsFont = wb.createFont();
//		contentsFont.setFontHeightInPoints(fontSize);
//		contentsFont.setFontName(fontName);
//		contentsFont.setBoldweight(fontBold);
//		
//		return contentsFont;
//	}
	
	
	/**
	 * 본문 상세 스타일
	 */
	public HSSFFont getTailFont(HSSFWorkbook wb, String fontName, short fontSize, short fontBold){
		
		HSSFFont tailFont = wb.createFont();
		tailFont.setFontHeightInPoints(fontSize);
		tailFont.setFontName(fontName);
		tailFont.setBoldweight(fontBold);
		
		return tailFont;
	}

	
	/**
	* 헤더 셀스타일
	*/
	public HSSFCellStyle getHeaderStyle(HSSFWorkbook wb, HSSFFont font, short align, short valign, short top, short bottom, short left, short right, short fmt){

		HSSFCellStyle headerStyle = wb.createCellStyle();
		headerStyle.setFont(font);
		headerStyle.setVerticalAlignment(valign);
		headerStyle.setBottomBorderColor(HSSFColor.BLACK.index);
		
		headerStyle.setAlignment(align);
		headerStyle.setBorderBottom(bottom);
		headerStyle.setBorderTop(top);
		headerStyle.setBorderLeft(left);
		headerStyle.setBorderRight(right);
		headerStyle.setDataFormat(fmt);
		
		return headerStyle;
	}
	
	
	/**
	* 타이틀 _ 데이터 타입 : 텍스트(가운데정렬) 테두리 없음.
	*/
	public HSSFCellStyle getTitleStyle(HSSFWorkbook wb, HSSFFont font, short align, short valign, short top, short bottom, short left, short right, short fmt){
		
		HSSFCellStyle titleStyle = wb.createCellStyle();
		titleStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		titleStyle.setVerticalAlignment(valign);
		titleStyle.setBottomBorderColor(HSSFColor.BLACK.index);
		titleStyle.setFont(font);

		titleStyle.setAlignment(align);
		titleStyle.setBorderBottom(bottom);
		titleStyle.setBorderTop(top);
		titleStyle.setBorderLeft(left);
		titleStyle.setBorderRight(right);
		titleStyle.setDataFormat(fmt);
		
		return titleStyle;
	}
	
	
	/**
	* 본문 데이터 타입 텍스트(가운데정렬)
	*/
	public HSSFCellStyle getContentsStyle(HSSFWorkbook wb, HSSFFont font, short align, short valign, short top, short bottom, short left, short right, short fmt) {
		HSSFCellStyle contentsStyle = wb.createCellStyle();
		contentsStyle.setFont(font);
		contentsStyle.setVerticalAlignment(valign);
		contentsStyle.setBottomBorderColor(HSSFColor.BLACK.index);

		contentsStyle.setAlignment(align);
		contentsStyle.setBorderBottom(bottom);
		contentsStyle.setBorderTop(top);
		contentsStyle.setBorderLeft(left);
		contentsStyle.setBorderRight(right);
		contentsStyle.setDataFormat(fmt);
		
		return contentsStyle;
	}
	
	
	/**
	 * 본문 비고 데이터 타입 문자열(왼쪽정렬)
	 */
	public HSSFCellStyle getTailStyle(HSSFWorkbook wb, HSSFFont font, short align, short valign, short top, short bottom, short left, short right, short fmt) {
		HSSFCellStyle tailStyle = wb.createCellStyle();
		tailStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		tailStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		tailStyle.setFont(font);
		tailStyle.setVerticalAlignment(valign);
		tailStyle.setBottomBorderColor(HSSFColor.BLACK.index);

		tailStyle.setAlignment(align);
		tailStyle.setBorderBottom(bottom);
		tailStyle.setBorderTop(top);
		tailStyle.setBorderLeft(left);
		tailStyle.setBorderRight(right);
		tailStyle.setDataFormat(fmt);
		
		return tailStyle;
	}
	
	
//	/**
//	* 타이틀 _ 데이터 타입 : 텍스트(왼쪽정렬) 테두리 없음.
//	*/
//	HSSFCellStyle T_T_N_R_style = wb.createCellStyle();
//	T_T_N_R_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	T_T_N_R_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	T_T_N_R_style.setFont(Tfont);
//	T_T_N_R_style.setAlignment((short) 1);
//	T_T_N_R_style.setVerticalAlignment((short) 1);
//	T_T_N_R_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	T_T_N_R_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	T_T_N_R_style.setBottomBorderColor(HSSFColor.BLACK.index);
//
//	/**
//	* 타이틀 _ 데이터 타입 : 텍스트(가운데정렬) 테두리 있음.
//	*/
//	HSSFCellStyle T_T_style = wb.createCellStyle();
//	T_T_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	T_T_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	T_T_style.setFont(Tfont);
//	T_T_style.setAlignment((short) 2);
//	T_T_style.setVerticalAlignment((short) 1);
//	T_T_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	T_T_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	T_T_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	T_T_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	T_T_style.setBottomBorderColor(HSSFColor.BLACK.index);
//
//	/**
//	* 타이틀 _ 데이터 타입 : 텍스트(오른쪽정렬) 테두리 없음.
//	*/
//	HSSFCellStyle T_T_N_L_style = wb.createCellStyle();
//	T_T_N_L_style.setFont(Bfont);
//	T_T_N_L_style.setAlignment((short) 3);
//	T_T_N_L_style.setVerticalAlignment((short) 1);
//	T_T_N_L_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	T_T_N_L_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	T_T_N_L_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	T_T_N_L_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//
//	/**
//	* 타이틀 데이터 타입 숫자 (오른쪽정렬)
//	*/
//	HSSFCellStyle T_N_style = wb.createCellStyle();
//	T_N_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	T_N_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	T_N_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	T_N_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	T_N_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	T_N_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	T_N_style.setFont(Tfont);
//	T_N_style.setAlignment((short) 3);
//	T_N_style.setVerticalAlignment((short) 1);
//	T_N_style.setDataFormat(df.getFormat("1234"));
//
//	/**
//	* 타이틀 데이터 타입 회계(원) (오른쪽정렬)
//	*/
//	HSSFCellStyle T_AK_style = wb.createCellStyle();
//	T_AK_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	T_AK_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	T_AK_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	T_AK_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	T_AK_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	T_AK_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	T_AK_style.setFont(Tfont);
//	T_AK_style.setAlignment((short) 3);
//	T_AK_style.setVerticalAlignment((short) 1);
//	T_AK_style.setDataFormat(df.getFormat("###,###,##0"));
//

//
//	/**
//	 * 본문 데이터 타입 텍스트(왼쪽정렬)
//	 */
//	HSSFCellStyle B_T_N_style = wb.createCellStyle();
//	B_T_N_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	B_T_N_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	B_T_N_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	B_T_N_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	B_T_N_style.setFont(Bfont);
//	B_T_N_style.setAlignment((short) 1);
//	B_T_N_style.setVerticalAlignment((short) 1);
//
//	/**
//	 * 본문 데이터 타입 숫자
//	 */
//	HSSFCellStyle B_N_style = wb.createCellStyle();
//	B_N_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	B_N_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	B_N_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	B_N_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	B_N_style.setFont(Bfont);
//	B_N_style.setAlignment((short) 3);
//	B_N_style.setVerticalAlignment((short) 1);
//	B_N_style.setDataFormat(df.getFormat("1234"));
//
//	/**
//	 * 본문 데이터 타입 회계(원)
//	 */
//	HSSFCellStyle B_AK_style = wb.createCellStyle();
//	B_AK_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	B_AK_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	B_AK_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	B_AK_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	B_AK_style.setFont(Bfont);
//	B_AK_style.setAlignment((short) 3);
//	B_AK_style.setVerticalAlignment((short) 1);
//	B_AK_style.setDataFormat(df.getFormat("###,###,##0"));
//
//	/**
//	 * 본문 데이터 타입 회계(달러)
//	 */
//	HSSFCellStyle B_AU_style = wb.createCellStyle();
//	B_AU_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	B_AU_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	B_AU_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	B_AU_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	B_AU_style.setFont(Bfont);
//	B_AU_style.setAlignment((short) 3);
//	B_AU_style.setVerticalAlignment((short) 1);
//	B_AU_style.setDataFormat(df.getFormat("$#,##0"));
//
//	/**
//	 * 본문 데이터 타입 날짜
//	 */
//	HSSFCellStyle B_D_style = wb.createCellStyle();
//	B_D_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	B_D_style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
//	B_D_style.setBorderRight(HSSFCellStyle.BORDER_THIN);
//	B_D_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	B_D_style.setFont(Bfont);
//	B_D_style.setAlignment((short) 3);
//	B_D_style.setVerticalAlignment((short) 1);
//	B_D_style.setDataFormat(df.getBuiltinFormat("m-d-yy"));
//
//
//	/**
//	 * 본문 비고 데이터 타입 문자열(오른쪽정렬)
//	 */
//	HSSFCellStyle BT_T_N_style = wb.createCellStyle();
//	BT_T_N_style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
//	BT_T_N_style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//	BT_T_N_style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
//	BT_T_N_style.setBorderTop(HSSFCellStyle.BORDER_THIN);
//	BT_T_N_style.setFont(BTfont);
//	BT_T_N_style.setAlignment((short) 3);
//	BT_T_N_style.setVerticalAlignment((short) 1);

}
