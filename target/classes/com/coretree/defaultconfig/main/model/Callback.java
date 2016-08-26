package com.coretree.defaultconfig.main.model;

import com.coretree.defaultconfig.EitStringUtil;

public class Callback {
	private int num;
	private int cbSeq;
	private int resSeq;
	private String resTelNo;
	private String resDate;
	private String resDate2;
	private String resHms;
	private String counDate;
	private String counHms;
	private String counCd;
	private String counCdNm;
	private String extensionNo;
	private String empNo;
	private String empNm;
	private String custNo;
	private String custNm;
	private String resNote;
	private String genDirNo;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCbSeq() {
		return cbSeq;
	}
	public void setCbSeq(int cbSeq) {
		this.cbSeq = cbSeq;
	}
	public String getResTelNo() {
		return EitStringUtil.isNullToString(resTelNo);
	}
	public void setResTelNo(String resTelNo) {
		this.resTelNo = resTelNo;
	}
	public String getResDate() {
		return EitStringUtil.isNullToString(resDate);
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public String getResDate2() {
		return resDate2;
	}
	public void setResDate2(String resDate2) {
		this.resDate2 = resDate2;
	}
	public String getResHms() {
		return EitStringUtil.isNullToString(resHms);
	}
	public void setResHms(String resHms) {
		this.resHms = resHms;
	}
	public String getCounDate() {
		return EitStringUtil.isNullToString(counDate);
	}
	public void setCounDate(String counDate) {
		this.counDate = counDate;
	}
	public String getCounHms() {
		return EitStringUtil.isNullToString(counHms);
	}
	public void setCounHms(String counHms) {
		this.counHms = counHms;
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
	public String getExtensionNo() {
		return EitStringUtil.isNullToString(extensionNo);
	}
	public void setExtensionNo(String extensionNo) {
		this.extensionNo = extensionNo;
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
	public String getCustNo() {
		return EitStringUtil.isNullToString(custNo);
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public int getResSeq() {
		return resSeq;
	}
	public void setResSeq(int resSeq) {
		this.resSeq = resSeq;
	}
	public String getCustNm() {
		return EitStringUtil.isNullToString(custNm);
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getResNote() {
		return EitStringUtil.isNullToString(resNote);
	}
	public void setResNote(String resNote) {
		this.resNote = resNote;
	}
	public String getGenDirNo() {
		return EitStringUtil.isNullToString(genDirNo);
	}
	public void setGenDirNo(String genDirNo) {
		this.genDirNo = genDirNo;
	}
	@Override
	public String toString() {
		return "Callback [cbSeq=" + cbSeq + ", resSeq=" + resSeq
				+ ", resTelNo=" + resTelNo + ", resDate=" + resDate
				+ ", resDate2=" + resDate2 + ", resHms=" + resHms
				+ ", counDate=" + counDate + ", counHms=" + counHms
				+ ", counCd=" + counCd + ", counCdNm=" + counCdNm
				+ ", extensionNo=" + extensionNo + ", empNo=" + empNo
				+ ", empNm=" + empNm + ", custNo=" + custNo + ", custNm="
				+ custNm + ", resNote=" + resNote + ", genDirNo=" + genDirNo
				+ "]";
	}
}
