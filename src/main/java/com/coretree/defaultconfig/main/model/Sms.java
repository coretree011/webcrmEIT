package com.coretree.defaultconfig.main.model;

import com.coretree.defaultconfig.EitStringUtil;

public class Sms {
	private long smsSendSeq;
	private String custNo;
	private String custNm;
	private String sendTelNo;
	private String sendTypCd;
	private String sendTypCdNm;
	private String cateCd;
	private String cateCdNm;
	private String sendResDate;
	private String sendResHms;
	private String sendDate;
	private String sendDate2;
	private String sendHms;
	private String sendCd;
	private String sendCdNm;
	private String empNo;
	private String empNm;
	private String sendComment;
	
	public long getSmsSendSeq() {
		return smsSendSeq;
	}
	public void setSmsSendSeq(long smsSendSeq) {
		this.smsSendSeq = smsSendSeq;
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
	public String getSendTelNo() {
		return EitStringUtil.isNullToString(sendTelNo);
	}
	public void setSendTelNo(String sendTelNo) {
		this.sendTelNo = sendTelNo;
	}
	public String getSendTypCd() {
		return EitStringUtil.isNullToString(sendTypCd);
	}
	public void setSendTypCd(String sendTypCd) {
		this.sendTypCd = sendTypCd;
	}
	public String getSendTypCdNm() {
		return EitStringUtil.isNullToString(sendTypCdNm);
	}
	public void setSendTypCdNm(String sendTypCdNm) {
		this.sendTypCdNm = sendTypCdNm;
	}
	public String getCateCd() {
		return EitStringUtil.isNullToString(cateCd);
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getCateCdNm() {
		return EitStringUtil.isNullToString(cateCdNm);
	}
	public void setCateCdNm(String cateCdNm) {
		this.cateCdNm = cateCdNm;
	}
	public String getSendResDate() {
		return EitStringUtil.isNullToString(sendResDate);
	}
	public void setSendResDate(String sendResDate) {
		this.sendResDate = sendResDate;
	}
	public String getSendResHms() {
		return EitStringUtil.isNullToString(sendResHms);
	}
	public void setSendResHms(String sendResHms) {
		this.sendResHms = sendResHms;
	}
	public String getSendDate() {
		return EitStringUtil.isNullToString(sendDate);
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getSendHms() {
		return EitStringUtil.isNullToString(sendHms);
	}
	public void setSendHms(String sendHms) {
		this.sendHms = sendHms;
	}
	public String getSendCd() {
		return EitStringUtil.isNullToString(sendCd);
	}
	public void setSendCd(String sendCd) {
		this.sendCd = sendCd;
	}
	public String getSendCdNm() {
		return EitStringUtil.isNullToString(sendCdNm);
	}
	public void setSendCdNm(String sendCdNm) {
		this.sendCdNm = sendCdNm;
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
	public String getSednComment() {
		return EitStringUtil.isNullToString(sendComment);
	}
	public void setSednComment(String sendComment) {
		this.sendComment = sendComment;
	}
	public String getSendDate2() {
		return EitStringUtil.isNullToString(sendDate2);
	}
	public void setSendDate2(String sendDate2) {
		this.sendDate2 = sendDate2;
	}
	@Override
	public String toString() {
		return "SMS [smsSendSeq=" + smsSendSeq + ", custNo=" + custNo
				+ ", custNm=" + custNm + ", sendTelNo=" + sendTelNo
				+ ", sendTypCd=" + sendTypCd + ", sendTypCdNm=" + sendTypCdNm
				+ ", cateCd=" + cateCd + ", cateCdNm=" + cateCdNm
				+ ", sendResDate=" + sendResDate + ", sendResHms=" + sendResHms
				+ ", sendDate=" + sendDate + ", sendHms=" + sendHms
				+ ", sendCd=" + sendCd + ", sendCdNm=" + sendCdNm + ", empNo="
				+ empNo + ", empNm=" + empNm + ", sendComment=" + sendComment
				+ "]";
	}
	
}
