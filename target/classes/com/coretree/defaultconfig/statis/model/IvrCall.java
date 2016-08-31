package com.coretree.defaultconfig.statis.model;

public class IvrCall {
	String callId;
	String regDate; //인입일자
	String regHms; //인입시간
	String genDirNo; //대표번호
	String telNo; //인입전화번호
	String extensionNo; //내선번호
	String startDate;
	String endDate;
	
	
	public String getCallId() {
		return callId;
	}


	public void setCallId(String callId) {
		this.callId = callId;
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


	public String getGenDirNo() {
		return genDirNo;
	}


	public void setGenDirNo(String genDirNo) {
		this.genDirNo = genDirNo;
	}


	public String getTelNo() {
		return telNo;
	}


	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}


	public String getExtensionNo() {
		return extensionNo;
	}


	public void setExtensionNo(String extensionNo) {
		this.extensionNo = extensionNo;
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
		return "IvrCall [callId=" + callId + ", regDate=" + regDate
				+ ", regHms=" + regHms + ", genDirNo=" + genDirNo + ", telNo=" + telNo 
				+ ", extensionNo=" + extensionNo+ "]";
	}
	
}
