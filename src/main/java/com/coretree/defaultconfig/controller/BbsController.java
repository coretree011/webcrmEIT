/*작성자 : 송은미*/
package com.coretree.defaultconfig.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.coretree.defaultconfig.bbs.mapper.BbsMapper;
import com.coretree.defaultconfig.bbs.model.BbsComment;
import com.coretree.defaultconfig.bbs.model.BbsMgt;
import com.coretree.defaultconfig.code.mapper.CodeMapper;


@RestController
public class BbsController {
	

	@Autowired
	BbsMapper bbsMapper;

	@Autowired
	CodeMapper codeMapper;
	
	private final String NoticeUploadPath = "/opt/webcrm/file/";
	//private final String NoticeUploadPath = "D:\\";
	
	/**
	 * 공지사항 조회(팝업)
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/notice", method = RequestMethod.POST)
	public List<BbsMgt> noticeList(@RequestBody BbsMgt searchVO, ModelMap model, HttpServletRequest request) {
		List<BbsMgt> bbsmgt = bbsMapper.selectNoticeList(searchVO);
		
		for(int i=0; i<bbsmgt.size(); i++){
			bbsmgt.get(i).setNum(i+1);
		}
		
		return bbsmgt;
	}

	/**
	 * 공지사항(팝업) - 삭제버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeDelete", method = RequestMethod.POST)
	public long noticeDelete(@RequestBody BbsMgt paramBbs, HttpSession session) {
		long result = 0;
    	String[] seq = paramBbs.getBbsSeq().split(",");
    	BbsMgt bbs = new BbsMgt();
    	bbs.setBbsSeqs(seq);
    	result = bbsMapper.deleteNotice(bbs);
    	
    	return result;
	} 
	
	/**
	 * 공지사항(팝업) - 삭제버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeCommentDelete", method = RequestMethod.POST)
	public long noticeCommentDelete(@RequestBody BbsComment paramBbs, HttpSession session) {
		long result = 0;
    	String[] seq = paramBbs.getBbsSeq().split(",");
    	BbsComment bbs = new BbsComment();
    	bbs.setBbsSeqs(seq);
    	result = bbsMapper.deleteNoticeComment(bbs);
    	
    	return result;
	}
	
	/**
	 * 공지사항(팝업) - 등록버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeInsert")
	public long noticeInsert(@RequestBody BbsMgt searchVO, HttpSession session) {
		long result;
		String name, ext, newfname = null;
		try{
			result = bbsMapper.insertNotice(searchVO);
			if(searchVO.getFileName() != ""){
				String fileName = searchVO.getFileName();
				
				Calendar cal = Calendar.getInstance();
				//현재 년도, 월, 일
				int year = cal.get ( cal.YEAR );
				int month = cal.get ( cal.MONTH ) + 1 ;
				int date = cal.get ( cal.DATE ) ;
				//현재 (시,분,초)
				int hour = cal.get ( cal.HOUR_OF_DAY ) ;
				int min = cal.get ( cal.MINUTE );
				int sec = cal.get ( cal.SECOND );
				
				String today = year + "" + month + "" + date + "" + hour + "" + min + "" + sec;
		        
		        //파일명에서 파일명과 확장자를 분리
		        int index = fileName.lastIndexOf(".");
		        if (index != -1) {
		            name = fileName.substring(0, index);
		            ext  = fileName.substring(index + 1);
		            newfname = name + "_" + today + "." + ext;
		        }
				searchVO.setFileName(newfname);
				bbsMapper.insertNoticeFile(searchVO);
			}
		}catch(Exception e){
			result = 0;
		}
		
		return result;
	}
	
	/**
	 * 공지사항(팝업) - 새글 컬럼 업데이트
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeNewUpdate", method = RequestMethod.POST)
	public long noticeNewUpdate(@RequestBody BbsMgt searchVO, HttpSession session) {
		long result;
		try{
			result = bbsMapper.updateNotice(searchVO);	
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	/**
	 * 공지사항 조회(팝업) - 수정버튼
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeModify", method = RequestMethod.POST)
	public long noticeUpdate(@RequestBody BbsMgt searchVO, HttpSession session){
		long result;
		try{
			result = bbsMapper.selectNoticeModify(searchVO);
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	/**
	 * 공지사항 댓글(팝업) - 조회
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/selectCommentReplyList", method = RequestMethod.POST)
	public List<BbsComment> noticeCommentList(@RequestBody BbsComment searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		List<BbsComment> bbsComment = bbsMapper.selectCommentList(searchVO);
		return bbsComment;
	}
	
	/**
	 * 공지사항 조회(팝업) - 파일이름
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/fileName", method = RequestMethod.POST)
	public List<BbsMgt> noticeFileList(@RequestBody BbsMgt searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		List<BbsMgt> bbsMgt = bbsMapper.selectFileName(searchVO);
		/*ModelMap bbsMgt = bbsMapper.selectFileName(searchVO);*/
		
		return bbsMgt;
	}
	
	/**
	 * 공지사항 조회(팝업) - 게시글 상세보기
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeCommentDetails", method = RequestMethod.POST)
	public List<BbsMgt> noticeCommentDetails(@RequestBody BbsMgt searchVO, ModelMap model, HttpServletRequest request) {
		List<BbsMgt> bbsMgt = bbsMapper.selectDetails(searchVO);
		return bbsMgt;
	}
	
	/**
	 * 공지사항 조회(팝업) - 댓글 저장
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeReplyInsert", method = RequestMethod.POST)
	public long replyInsert(@RequestBody BbsComment searchVO, HttpSession session) {
		long result;
		try{
			result = bbsMapper.insertReply(searchVO);	
		}catch(Exception e){
			result = 0;
			e.printStackTrace();
		}
		return result;
	}
	

	/**
	 * 공지사항 등록 - 파일 업로드
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path = "/popup/noticeFileUpload",method = RequestMethod.POST)
	public ResponseEntity<?> noticeFileUpload(@RequestParam("noticeUploadFile") MultipartFile noticeUploadFile) {
		String name, ext, newfname = null; //파일명, 확장자, 새 파일명 변수
		
	    try {
			Calendar cal = Calendar.getInstance();
			//현재 년도, 월, 일
			int year = cal.get ( cal.YEAR );
			int month = cal.get ( cal.MONTH ) + 1 ;
			int date = cal.get ( cal.DATE ) ;
			//현재 (시,분,초)
			int hour = cal.get ( cal.HOUR_OF_DAY ) ;
			int min = cal.get ( cal.MINUTE );
			int sec = cal.get ( cal.SECOND );
			
			String today = year + "" + month + "" + date + "" + hour + "" + min + "" + sec;
	        String fileNm = noticeUploadFile.getOriginalFilename();
	        
	        //파일명에서 파일명과 확장자를 분리
	        int index = fileNm.lastIndexOf(".");
	        if (index != -1) {
	            name = fileNm.substring(0, index);
	            ext  = fileNm.substring(index + 1);
	            newfname = name + "_" + today + "." + ext;
	        }

	    	String filePath = NoticeUploadPath + File.separator + newfname;

	        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(filePath)));
	        stream.write(noticeUploadFile.getBytes());
	        stream.close();
	        
	    } catch (Exception e) {
	    	System.out.println(e.getMessage());
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	/**
	 * 공지사항 수정 - 파일 업로드
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path = "/popup/noticeFileUpload2",method = RequestMethod.POST)
	public ResponseEntity<?> noticeFileUpload2(@RequestParam("noticeModifyFileUpload") MultipartFile noticeUploadFile) {
		String name, ext, newfname = null; //파일명, 확장자, 새 파일명 변수
		
	    try {
	    	Calendar cal = Calendar.getInstance();
			//현재 년도, 월, 일
			int year = cal.get ( cal.YEAR );
			int month = cal.get ( cal.MONTH ) + 1 ;
			int date = cal.get ( cal.DATE ) ;
			//현재 (시,분,초)
			int hour = cal.get ( cal.HOUR_OF_DAY ) ;
			int min = cal.get ( cal.MINUTE );
			int sec = cal.get ( cal.SECOND );
			
			String today = year + "" + month + "" + date + "" + hour + "" + min + "" + sec;
	        String fileNm = noticeUploadFile.getOriginalFilename();
	        
	        //파일명에서 파일명과 확장자를 분리
	        int index = fileNm.lastIndexOf(".");
	        if (index != -1) {
	            name = fileNm.substring(0, index);
	            ext  = fileNm.substring(index + 1);
	            newfname = name + "_" + today + "." + ext;
	        }
	        
	    	String filePath = NoticeUploadPath + File.separator + newfname;
	        
	        BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(filePath)));
	        stream.write(noticeUploadFile.getBytes());
	        stream.close();
	        
	    } catch (Exception e) {
	    	System.out.println(e.getMessage());
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return new ResponseEntity<>(HttpStatus.OK);
	}
	
	/**
	 * 공지사항 의견달기 - 파일 다운로드
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(value="/popup/noticeFileDownload/{fileName}/{fileExtension}",  method = {RequestMethod.GET, RequestMethod.POST})
	public void getFile(@PathVariable("fileName") String fileName, @PathVariable("fileExtension") String fileExtension, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String root = NoticeUploadPath + fileName + "." + fileExtension;
		File file = new File(root);
        InputStream is = new FileInputStream(file);

        // MIME Type 을 application/octet-stream 타입으로 변경
        // 무조건 팝업(다운로드창)이 뜨게 된다.
        response.setContentType("application/octet-stream");
        
        //한글깨짐처리
        String header = request.getHeader("User-Agent");
        if (header.contains("MSIE") || header.contains("Trident")) {
               String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
               response.setHeader("Content-Disposition", "attachment;filename=" + docName +"." + fileExtension + ";");
        } else if (header.contains("Firefox")) {
               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName +"." + fileExtension+ "\"");
        } else if (header.contains("Opera")) {
               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName +"." + fileExtension + "\"");
        } else if (header.contains("Chrome")) {
               String docName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
               response.setHeader("Content-Disposition", "attachment; filename=\"" + docName +"." + fileExtension + "\"");
        }
        response.setContentLength((int) file.length());
        response.setHeader("Content-Type", "application/octet-stream");
        response.setHeader("Content-Transfer-Encoding", "binary;");
        response.setHeader("Pragma", "no-cache;");
        response.setHeader("Expires", "-1;");

        // Read from the file and write into the response
        OutputStream os = response.getOutputStream();
        
        byte[] buffer = new byte[1024];
        int len;
        while ((len = is.read(buffer)) != -1) {
            os.write(buffer, 0, len);
        }
        os.flush();
        os.close();
        is.close();
    }
	
	/**
	 * 공지사항 수정(팝업) - 파일삭제 
	 * @param workbook
	 * @param 
	 * @return
	 */
	@RequestMapping(path="/popup/noticeFileDelete", method = RequestMethod.POST)
	public long noticeFileDelete(@RequestBody BbsMgt searchVO, HttpSession session){
		long result;
		try{
			result = bbsMapper.fileDelete(searchVO);
			File file = new File(NoticeUploadPath + searchVO.getFileName());
			file.delete();
		}catch(Exception e){
			result = 0;
		}
		return result;
	}
	
	/**
	 * 공지사항 수정(팝업) - 파일 등록 
	 * @param workbook
	 * @param fileName
	 * @return
	 */
	@RequestMapping(path="/popup/noticeModifyFileInsert")
	public long noticeModifyFileInsert(@RequestBody BbsMgt searchVO, HttpSession session) {
		String name, ext, newfname = null; //파일명, 확장자, 새 파일명 변수
		long result;
		try{
				String fileName = searchVO.getFileName();
				
				Calendar cal = Calendar.getInstance();
				//현재 년도, 월, 일
				int year = cal.get ( cal.YEAR );
				int month = cal.get ( cal.MONTH ) + 1 ;
				int date = cal.get ( cal.DATE ) ;
				//현재 (시,분,초)
				int hour = cal.get ( cal.HOUR_OF_DAY ) ;
				int min = cal.get ( cal.MINUTE );
				int sec = cal.get ( cal.SECOND );
				
				String today = year + "" + month + "" + date + "" + hour + "" + min + "" + sec;
		        
		        //파일명에서 파일명과 확장자를 분리
		        int index = fileName.lastIndexOf(".");
		        if (index != -1) {
		            name = fileName.substring(0, index);
		            ext  = fileName.substring(index + 1);
		            newfname = name + "_" + today + "." + ext;
		        }
				searchVO.setFileName(newfname);
				
				result = bbsMapper.insertNoticeFile2(searchVO);
		}catch(Exception e){
			result = 0;
		}
		
		return result;
	}
	
}
