package com.coretree.defaultconfig.bbs.model;

import org.springframework.web.multipart.MultipartFile;

import com.coretree.defaultconfig.EitStringUtil;

public class BbsMgt {
    private int num;
	private String bbsSeq;
    private String bbsSbj;
    private String regEmpNo; 
    private String regEmpNm;
    private String regDate; 
    private String regHms; 
    private String bbsNote;
    
    private String fileYN;
    private String commentYN;
    private String newYN;
    private String startDate; 
    private String endDate;
    
    private String search; 
    private String searchText;
    private String[] bbsSeqs;
    
    /*TBBS_FILE */
    private String fileBbsSeq;
    private String fileSeq;
    private String fileName;
    
    /*TBBS_MGT_READ*/
    private String readEmpNo;
    
    private MultipartFile uploadfile;
    
    
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getBbsSeq() {
		return bbsSeq;
	}
	public void setBbsSeq(String bbsSeq) {
		this.bbsSeq = bbsSeq;
	}
	public String getBbsSbj() {
		return bbsSbj;
	}
	public void setBbsSbj(String bbsSbj) {
		this.bbsSbj = bbsSbj;
	}
	public String getRegEmpNo() {
		return regEmpNo;
	}
	public void setRegEmpNo(String regEmpNo) {
		this.regEmpNo = regEmpNo;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getRegHms() {
		return regHms;
	}
	public void setRegHms(String regHms) {
		this.regHms = regHms;
	}
	public String getBbsNote() {
		return bbsNote;
	}
	public void setBbsNote(String bbsNote) {
		this.bbsNote = bbsNote;
	} 
	public String getRegEmpNm() {
		return EitStringUtil.isNullToString(regEmpNm);
	}
	
	public void setRegEmpNm(String regEmpNm) {
		this.regEmpNm = regEmpNm;
	}
	public String getFileYN() {
		return fileYN;
	}
	public void setFileYN(String fileYN) {
		this.fileYN = fileYN;
	}
	public String getCommentYN() {
		return commentYN;
	}
	public void setCommentYN(String commentYN) {
		this.commentYN = commentYN;
	}
	
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getNewYN() {
		return newYN;
	}
	public void setNewYN(String newYN) {
		this.newYN = newYN;
	}
	
	public String getFileBbsSeq() {
		return fileBbsSeq;
	}
	public void setFileBbsSeq(String fileBbsSeq) {
		this.fileBbsSeq = fileBbsSeq;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	public String getReadEmpNo() {
		return readEmpNo;
	}
	public void setReadEmpNo(String readEmpNo) {
		this.readEmpNo = readEmpNo;
	}
	
	public String[] getBbsSeqs() {
		return bbsSeqs;
	}
	public void setBbsSeqs(String[] bbsSeqs) {
		this.bbsSeqs = bbsSeqs;
	}
	
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	@Override
	public String toString() {
		return "BbsMgt [bbsSeq=" + bbsSeq + ", bbsSbj=" + bbsSbj
				+ ", regEmpNo=" + regEmpNo + ", regEmpNm=" + regEmpNm + ", regDate=" + regDate + ", regHms="
				+ regHms + ", bbsNote=" + bbsNote + ", search=" + search +", searchText=" + searchText 
				+ ", fileYN=" + fileYN + ", commentYN=" + commentYN +  ", newYN=" + newYN  +   ", fileName=" + fileName  + "]";
	}
}
