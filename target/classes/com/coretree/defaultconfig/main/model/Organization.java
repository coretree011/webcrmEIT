package com.coretree.defaultconfig.main.model;

import com.coretree.defaultconfig.EitStringUtil;

public class Organization {
	private String empNo;
	private String empNm;
	private String password;
	private String grpCd;
	private String enterDate;
	private String authCd;
	private String mobilePhoneNo;
	private String emailId;
	private String extensionNo;
	private String note;
	private String agentStatCd;
	private String newPwd;
	private int existCount;

	private int tempval;
	private String tempstr;

	
	public String getEmpNo() { return EitStringUtil.isNullToString(empNo); }
	public void setEmpNo(String empNo) { this.empNo = empNo; }

	public String getEmpNm() { return EitStringUtil.isNullToString(empNm); }
	public void setEmpNm(String empNm) { this.empNm = empNm; }
	
	public String getPassword() { return EitStringUtil.isNullToString(password); }
	public void setPassword(String password) { this.password = password; }
	
	public String getGrpCd() { return EitStringUtil.isNullToString(grpCd); }
	public void setGrpCd(String grpCd) { this.grpCd = grpCd; }
	
	public String getEnterDate() { return EitStringUtil.isNullToString(enterDate); }
	public void setEnterDate(String enterDate) { this.enterDate = enterDate; }
	
	public String getAuthCd() { return EitStringUtil.isNullToString(authCd); }
	public void setAuthCd(String authCd) { this.authCd = authCd; }
	
	public String getMobilePhoneNo() { return EitStringUtil.isNullToString(mobilePhoneNo); }
	public void setMobilePhoneNo(String mobilePhoneNo) { this.mobilePhoneNo = mobilePhoneNo; }
	
	public String getEmailId() { return EitStringUtil.isNullToString(emailId); }
	public void setEmailId(String emailId) { this.emailId = emailId; }
	
	public String getExtensionNo() { return EitStringUtil.isNullToString(extensionNo); }
	public void setExtensionNo(String extensionNo) { this.extensionNo = extensionNo; }
	
	public String getNote() { return EitStringUtil.isNullToString(note); }
	public void setNote(String note) { this.note = note; }
	
	public String getAgentStatCd() { return this.agentStatCd; }
	public void setAgentStatCd(String agentStatCd) { this.agentStatCd = agentStatCd; }
	
	public String getNewPwd() { return EitStringUtil.isNullToString(newPwd); }
	public void setNewPwd(String newPwd) { this.newPwd = newPwd; }
	
	public int getExistCount() { return existCount; }
	public void setExistCount(int existCount) { this.existCount = existCount; }
	
	public int getTempval() { return tempval; }
	public void setTempval(int tempval) { this.tempval = tempval; }
	
	public String getTempstr() { return tempstr; }
	public void setTempstr(String tempstr) { this.tempstr = tempstr; }
	
	@Override
	public String toString() {
		return "Organization [empNo=" + empNo + ", empNm=" + empNm + ", password=" + password
				+ ", authCd=" + authCd + ", emailId=" + emailId + ", extensionNo=" + extensionNo
				+ ", note=" + note + ", agentStatCd=" + agentStatCd + ", newPwd=" + newPwd
				+ ", existCount=" + existCount + "]";
	}
}
