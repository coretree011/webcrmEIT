package com.coretree.defaultconfig.main.model;

import com.coretree.defaultconfig.EitStringUtil;

public class Counsel {
	private int counSeq;
	private String custNo;
	private String custNm;
	private String telNo;
	private String callTypCd;
	private String callTypCdNm;
	private String counStartDate;
	private String counStartHms;
	private String counEndDate;
	private String counEndHms;
	private String counCd;
	private String counCdNm;
	private String empNo;
	private String empNm;
	private String counNote;
	private String callId;
	public int getCounSeq() {
		return counSeq;
	}
	public void setCounSeq(int counSeq) {
		this.counSeq = counSeq;
	}
	public String getCustNo() {
		return EitStringUtil.isNullToString(custNo);
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getCustNm() {
		return EitStringUtil.isNullToString(custNm);
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getTelNo() {
		return EitStringUtil.isNullToString(telNo);
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getCallTypCd() {
		return EitStringUtil.isNullToString(callTypCd);
	}
	public void setCallTypCd(String callTypCd) {
		this.callTypCd = callTypCd;
	}
	public String getCallTypCdNm() {
		return EitStringUtil.isNullToString(callTypCdNm);
	}
	public void setCallTypCdNm(String callTypCdNm) {
		this.callTypCdNm = callTypCdNm;
	}
	public String getCounStartDate() {
		return EitStringUtil.isNullToString(counStartDate);
	}
	public void setCounStartDate(String counStartDate) {
		this.counStartDate = counStartDate;
	}
	public String getCounStartHms() {
		return EitStringUtil.isNullToString(counStartHms);
	}
	public void setCounStartHms(String counStartHms) {
		this.counStartHms = counStartHms;
	}
	public String getCounEndDate() {
		return EitStringUtil.isNullToString(counEndDate);
	}
	public void setCounEndDate(String counEndDate) {
		this.counEndDate = counEndDate;
	}
	public String getCounEndHms() {
		return EitStringUtil.isNullToString(counEndHms);
	}
	public void setCounEndHms(String counEndHms) {
		this.counEndHms = counEndHms;
	}
	public String getCounCd() {
		return EitStringUtil.isNullToString(counCd);
	}
	public void setCounCd(String counCd) {
		this.counCd = counCd;
	}
	public String getCounCdNm() {
		return EitStringUtil.isNullToString(counCdNm);
	}
	public void setCounCdNm(String counCdNm) {
		this.counCdNm = counCdNm;
	}
	public String getEmpNo() {
		return EitStringUtil.isNullToString(empNo);
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getEmpNm() {
		return EitStringUtil.isNullToString(empNm);
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}
	public String getCounNote() {
		return EitStringUtil.isNullToString(counNote);
	}
	public void setCounNote(String counNote) {
		this.counNote = counNote;
	}
	public String getCallId() {
		return EitStringUtil.isNullToString(callId);
	}
	public void setCallId(String callId) {
		this.callId = callId;
	}
	@Override
	public String toString() {
		return "Counsel [counSeq=" + counSeq + ", custNo=" + custNo
				+ ", custNm=" + custNm + ", telNo=" + telNo + ", callTypCd="
				+ callTypCd + ", callTypCdNm=" + callTypCdNm
				+ ", counStartDate=" + counStartDate + ", counStartHms="
				+ counStartHms + ", counEndDate=" + counEndDate
				+ ", counEndHms=" + counEndHms + ", counCd=" + counCd
				+ ", counCdNm=" + counCdNm + ", empNo=" + empNo + ", empNm="
				+ empNm + ", counNote=" + counNote + ", callId=" + callId + "]";
	}
	
	
	
}
