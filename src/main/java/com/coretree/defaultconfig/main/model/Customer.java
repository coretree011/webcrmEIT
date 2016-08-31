package com.coretree.defaultconfig.main.model;

import java.util.Arrays;

import com.coretree.defaultconfig.EitStringUtil;

public class Customer {
	private int num;
	private String custCd;
	private String custCdNm;
	private String custNo;
	private String[] custNos;
	private String custNm;
	private String telNo;
	private String tel1No;
	private String tel2No;
	private String tel3No;
	private String faxNo;
	private String addr;
	private String emailId;
	private String custNote;
	private String gradeCd;
	private String custTypCd;
	private String recogTypCd;
	private String sexCd;
	private String gradeNm;
	private String custTypNm;
	private String recogTypNm;
	private String sexNm;
	private String birthDate;
	private String coRegNo;
	private String lastCounDate;
	private String lastCounDate2;
	
	private long existCnt;
	private String existCode;
	private String regDate;
	private String regDate2;
	
	private String outValue;
	private String insertChk;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCustCd() {
		return EitStringUtil.isNullToString(custCd);
	}
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}
	public String getCustCdNm() {
		return EitStringUtil.isNullToString(custCdNm);
	}
	public void setCustCdNm(String custCdNm) {
		this.custCdNm = custCdNm;
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
	public String getTel1No() {
		return EitStringUtil.isNullToString(tel1No);
	}
	public void setTel1No(String tel1No) {
		this.tel1No = tel1No;
	}
	public String getTel2No() {
		return EitStringUtil.isNullToString(tel2No);
	}
	public void setTel2No(String tel2No) {
		this.tel2No = tel2No;
	}
	public String getTel3No() {
		return EitStringUtil.isNullToString(tel3No);
	}
	public void setTel3No(String tel3No) {
		this.tel3No = tel3No;
	}
	public String getFaxNo() {
		return EitStringUtil.isNullToString(faxNo);
	}
	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}
	public String getAddr() {
		return EitStringUtil.isNullToString(addr);
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getEmailId() {
		return EitStringUtil.isNullToString(emailId);
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getCustNote() {
		return EitStringUtil.isNullToString(custNote);
	}
	public void setCustNote(String custNote) {
		this.custNote = custNote;
	}
	public long getExistCnt() {
		return existCnt;
	}
	public void setExistCnt(long existCnt) {
		this.existCnt = existCnt;
	}
	public String getExistCode() {
		return existCode;
	}
	public void setExistCode(String existCode) {
		this.existCode = existCode;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String[] getCustNos() {
		return custNos;
	}
	public void setCustNos(String[] custNos) {
		this.custNos = custNos;
	}

	public String getOutValue() {
		return outValue;
	}
	public void setOutValue(String outValue) {
		this.outValue = outValue;
	}
	public String getInsertChk() {
		return insertChk;
	}
	public void setInsertChk(String insertChk) {
		this.insertChk = insertChk;
	}
	public String getGradeCd() {
		return EitStringUtil.isNullToString(gradeCd);
	}
	public void setGradeCd(String gradeCd) {
		this.gradeCd = gradeCd;
	}
	public String getCustTypCd() {
		return EitStringUtil.isNullToString(custTypCd);
	}
	public void setCustTypCd(String custTypCd) {
		this.custTypCd = custTypCd;
	}
	public String getRecogTypCd() {
		return EitStringUtil.isNullToString(recogTypCd);
	}
	public void setRecogTypCd(String recogTypCd) {
		this.recogTypCd = recogTypCd;
	}
	public String getSexCd() {
		return EitStringUtil.isNullToString(sexCd);
	}
	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}
	public String getGradeNm() {
		return EitStringUtil.isNullToString(gradeNm);
	}
	public void setGradeNm(String gradeNm) {
		this.gradeNm = gradeNm;
	}
	public String getCustTypNm() {
		return EitStringUtil.isNullToString(custTypNm);
	}
	public void setCustTypNm(String custTypNm) {
		this.custTypNm = custTypNm;
	}
	public String getRecogTypNm() {
		return EitStringUtil.isNullToString(recogTypNm);
	}
	public void setRecogTypNm(String recogTypNm) {
		this.recogTypNm = recogTypNm;
	}
	public String getSexNm() {
		return EitStringUtil.isNullToString(sexNm);
	}
	public void setSexNm(String sexNm) {
		this.sexNm = sexNm;
	}
	public String getBirthDate() {
		return EitStringUtil.isNullToString(birthDate);
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getCoRegNo() {
		return EitStringUtil.isNullToString(coRegNo);
	}
	public void setCoRegNo(String coRegNo) {
		this.coRegNo = coRegNo;
	}
	public String getLastCounDate() {
		return EitStringUtil.isNullToString(lastCounDate);
	}
	public void setLastCounDate(String lastCounDate) {
		this.lastCounDate = lastCounDate;
	}
	public String getLastCounDate2() {
		return EitStringUtil.isNullToString(lastCounDate2);
	}
	public void setLastCounDate2(String lastCounDate2) {
		this.lastCounDate2 = lastCounDate2;
	}
	public String getRegDate2() {
		return EitStringUtil.isNullToString(regDate2);
	}
	public void setRegDate2(String regDate2) {
		this.regDate2 = regDate2;
	}
	@Override
	public String toString() {
		return "Customer [custCd=" + custCd + ", custCdNm=" + custCdNm
				+ ", custNo=" + custNo + ", custNos="
				+ Arrays.toString(custNos) + ", custNm=" + custNm + ", telNo="
				+ telNo + ", tel1No=" + tel1No + ", tel2No=" + tel2No
				+ ", tel3No=" + tel3No + ", faxNo=" + faxNo + ", addr=" + addr
				+ ", emailId=" + emailId + ", custNote=" + custNote
				+ ", gradeCd=" + gradeCd + ", custTypCd=" + custTypCd
				+ ", recogTypCd=" + recogTypCd + ", sexCd=" + sexCd
				+ ", birthDate=" + birthDate + ", coRegNo=" + coRegNo
				+ ", lastCounDate=" + lastCounDate + ", existCnt=" + existCnt
				+ ", existCode=" + existCode + ", regDate=" + regDate
				+ ", outValue=" + outValue + ", insertChk=" + insertChk + "]";
	}
}