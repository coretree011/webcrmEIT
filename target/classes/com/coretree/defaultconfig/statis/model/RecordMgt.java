package com.coretree.defaultconfig.statis.model;

public class RecordMgt {
	int recSeq; //녹취번호
	String extensionNo; //내선번호
	String empNo; //상담원번호
	String telNo; //전화번호
	String callTypCd; //콜유형코드
	String recStartDate; //녹취시작일
	String recStartHms; //녹취시작시간
	String recEndDate; //녹취종료일
	String recEndHms; //녹취종료시간
	int fileSize; //파일크기
	String fileName; //파일명
	String callId; //CALL ID - 교환기에서 발생하며 데이터 저장
	
	String startDate; //통화일자 날짜비교
	String endDate; //통화일자 날짜비교

	
	public int getRecSeq() {
		return recSeq;
	}


	public void setRecSeq(int recSeq) {
		this.recSeq = recSeq;
	}


	public String getExtensionNo() {
		return extensionNo;
	}


	public void setExtensionNo(String extensionNo) {
		this.extensionNo = extensionNo;
	}


	public String getEmpNo() {
		return empNo;
	}


	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}


	public String getTelNo() {
		return telNo;
	}


	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}


	public String getCallTypCd() {
		return callTypCd;
	}


	public void setCallTypCd(String callTypCd) {
		this.callTypCd = callTypCd;
	}


	public String getRecStartDate() {
		return recStartDate;
	}


	public void setRecStartDate(String recStartDate) {
		this.recStartDate = recStartDate;
	}


	public String getRecStartHms() {
		return recStartHms;
	}


	public void setRecStartHms(String recStartHms) {
		this.recStartHms = recStartHms;
	}


	public String getRecEndDate() {
		return recEndDate;
	}


	public void setRecEndDate(String recEndDate) {
		this.recEndDate = recEndDate;
	}


	public String getRecEndHms() {
		return recEndHms;
	}


	public void setRecEndHms(String recEndHms) {
		this.recEndHms = recEndHms;
	}


	public int getFileSize() {
		return fileSize;
	}


	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}


	public String getFileName() {
		return fileName;
	}


	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public String getCallId() {
		return callId;
	}


	public void setCallId(String callId) {
		this.callId = callId;
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


	@Override
	public String toString() {
		return "RecordMgt [recSeq=" + recSeq + ", extensionNo=" + extensionNo
				+ ", empNo=" + empNo + ", telNo=" + telNo + ", callTypCd=" + callTypCd 
				+ ", recStartDate=" + recStartDate + ", recStartHms=" + recStartHms + ", recEndDate=" + recEndDate 
				+ ", recEndHms=" + recEndHms + ", fileSize=" + fileSize + ", fileName=" + fileName + ", callId=" + callId + "]";
	}
	
}
