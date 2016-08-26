package com.coretree.defaultconfig.statis.model;

import com.coretree.defaultconfig.EitStringUtil;

public class CallStat {
	String callId;
	String regDate;
	String regHms;
	String genDirNo;
	String telNo;
	String callTypCd;
	String agentTransYn;
	String empNo;
	String empNm;
	String callStatSec;
	
	int totIbCount; //총인입건수
	int totIbAgTransCount; //상담원 연결건수
	int totCbCount; //콜백건수
	int totAbnCount; //포기건수
	int totOutCount; //아웃바운드
	int totExtCount; //내선건수
	int totResCount; //상담예약건수
	String answer; //응답율
	
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
		return EitStringUtil.isNullToString(genDirNo);
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


	public String getCallTypCd() {
		return callTypCd;
	}


	public void setCallTypCd(String callTypCd) {
		this.callTypCd = callTypCd;
	}


	public String getAgentTransYn() {
		return agentTransYn;
	}


	public void setAgentTransYn(String agentTransYn) {
		this.agentTransYn = agentTransYn;
	}


	public String getEmpNo() {
		return empNo;
	}


	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}


	public String getEmpNm() {
		return empNm;
	}


	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}


	public String getCalStatSec() {
		return callStatSec;
	}


	public void setCalStatSec(String callStatSec) {
		this.callStatSec = callStatSec;
	}


	

	public String getCallStatSec() {
		return callStatSec;
	}


	public void setCallStatSec(String callStatSec) {
		this.callStatSec = callStatSec;
	}


	public int getTotIbCount() {
		return totIbCount;
	}


	public void setTotIbCount(int totIbCount) {
		this.totIbCount = totIbCount;
	}


	public int getTotIbAgTransCount() {
		return totIbAgTransCount;
	}


	public void setTotIbAgTransCount(int totIbAgTransCount) {
		this.totIbAgTransCount = totIbAgTransCount;
	}


	public int getTotCbCount() {
		return totCbCount;
	}


	public void setTotCbCount(int totCbCount) {
		this.totCbCount = totCbCount;
	}


	public int getTotAbnCount() {
		return totAbnCount;
	}


	public void setTotAbnCount(int totAbnCount) {
		this.totAbnCount = totAbnCount;
	}


	public int getTotOutCount() {
		return totOutCount;
	}


	public void setTotOutCount(int totOutCount) {
		this.totOutCount = totOutCount;
	}


	public int getTotExtCount() {
		return totExtCount;
	}


	public void setTotExtCount(int totExtCount) {
		this.totExtCount = totExtCount;
	}


	public int getTotResCount() {
		return totResCount;
	}


	public void setTotResCount(int totResCount) {
		this.totResCount = totResCount;
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


	public String getAnswer() {
		return EitStringUtil.isNullToString(answer);
	}


	public void setAnswer(String answer) {
		this.answer = answer;
	}


	@Override
	public String toString() {
		return "CallStat [callId=" + callId + ", regDate=" + regDate
				+ ", regHms=" + regHms + ", genDirNo=" + genDirNo + ", telNo=" + telNo 
				+ ", callTypCd=" + callTypCd + ", agentTransYn=" + agentTransYn + ", empNo=" + empNo 
				+ ", empNm=" + empNm + ", callStatSec=" + callStatSec + "]";
	}
	
}
