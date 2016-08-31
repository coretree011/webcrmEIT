package com.coretree.defaultconfig.statis.model;

public class AgentStat {
	String agentStatCd; //상담원상태
	String startDate; //녹취시작일
	String startHms; //시작시간
	String endDate; //녹취종료일
	String endHms; //종료시간
	String agentStatSec; //상담원상태지속시간
	String empNo; //사번
	String empNm;//이름

	int totIbAgTransCount;
	int totIbAgTransTime;
	int totOutCount;
	int totOutTime;
	int totExtCount;
	int totExtTime;
	int agtStat1001Time;
	int agtStat1002Time;
	int agtStat1003Time;
	int agtStat1004Time;
	int agtStat1005Time;
	
	String leadStartDate;
	String leadEndDate;
	
	
	public String getAgentStatCd() {
		return agentStatCd;
	}


	public void setAgentStatCd(String agentStatCd) {
		this.agentStatCd = agentStatCd;
	}


	public String getStartDate() {
		return startDate;
	}


	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}


	public String getStartHms() {
		return startHms;
	}


	public void setStartHms(String startHms) {
		this.startHms = startHms;
	}


	public String getEndDate() {
		return endDate;
	}


	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}


	public String getEndHms() {
		return endHms;
	}


	public void setEndHms(String endHms) {
		this.endHms = endHms;
	}


	public String getAgentStatSec() {
		return agentStatSec;
	}


	public void setAgentStatSec(String agentStatSec) {
		this.agentStatSec = agentStatSec;
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

	public int getTotIbAgTransCount() {
		return totIbAgTransCount;
	}


	public void setTotIbAgTransCount(int totIbAgTransCount) {
		this.totIbAgTransCount = totIbAgTransCount;
	}


	public int getTotIbAgTransTime() {
		return totIbAgTransTime;
	}


	public void setTotIbAgTransTime(int totIbAgTransTime) {
		this.totIbAgTransTime = totIbAgTransTime;
	}


	public int getTotOutCount() {
		return totOutCount;
	}


	public void setTotOutCount(int totOutCount) {
		this.totOutCount = totOutCount;
	}


	public int getTotOutTime() {
		return totOutTime;
	}


	public void setTotOutTime(int totOutTime) {
		this.totOutTime = totOutTime;
	}


	public int getTotExtCount() {
		return totExtCount;
	}


	public void setTotExtCount(int totExtCount) {
		this.totExtCount = totExtCount;
	}


	public int getTotExtTime() {
		return totExtTime;
	}


	public void setTotExtTime(int totExtTime) {
		this.totExtTime = totExtTime;
	}


	public int getAgtStat1001Time() {
		return agtStat1001Time;
	}


	public void setAgtStat1001Time(int agtStat1001Time) {
		this.agtStat1001Time = agtStat1001Time;
	}


	public int getAgtStat1002Time() {
		return agtStat1002Time;
	}


	public void setAgtStat1002Time(int agtStat1002Time) {
		this.agtStat1002Time = agtStat1002Time;
	}


	public int getAgtStat1003Time() {
		return agtStat1003Time;
	}


	public void setAgtStat1003Time(int agtStat1003Time) {
		this.agtStat1003Time = agtStat1003Time;
	}


	public int getAgtStat1004Time() {
		return agtStat1004Time;
	}


	public void setAgtStat1004Time(int agtStat1004Time) {
		this.agtStat1004Time = agtStat1004Time;
	}


	public int getAgtStat1005Time() {
		return agtStat1005Time;
	}


	public void setAgtStat1005Time(int agtStat1005Time) {
		this.agtStat1005Time = agtStat1005Time;
	}


	public String getLeadStartDate() {
		return leadStartDate;
	}


	public void setLeadStartDate(String leadStartDate) {
		this.leadStartDate = leadStartDate;
	}


	public String getLeadEndDate() {
		return leadEndDate;
	}


	public void setLeadEndDate(String leadEndDate) {
		this.leadEndDate = leadEndDate;
	}


	@Override
	public String toString() {
		return "AgentStat [agentStatCd=" + agentStatCd + ", startDate=" + startDate
				+ ", startHms=" + startHms + ", endDate=" + endDate + ", endHms=" + endHms 
				+ ", agentStatSec=" + agentStatSec+ ", empNo=" + empNo + ", empNm=" + empNm+ "]";
	}
	
}
