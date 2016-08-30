package com.coretree.defaultconfig.main.model;

public class UserLog {
	private String agentStatCd;
	private String empNo;
	private String empNm;
	private String startDate;
	private String startHms;
	private String endDate;
	private String endHms;
	private long agentStatSec;
	

	public String getAgentStatCd() { return this.agentStatCd; }
	public void setAgentStatCd(String agentStatCd) { this.agentStatCd = agentStatCd; }
	
	public String getEmpNo() { return this.empNo; }
	public void setEmpNo(String empNo) { this.empNo = empNo; }
	
	public String getEmpNm() { return this.empNm; }
	public void setEmpNm(String empNm) { this.empNm = empNm; }
	
	public String getStartDate() { return this.startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	
	public String getStartHms() { return this.startHms; }
	public void setStartHms(String startHms) { this.startHms = startHms; }
	
	public String getEndDate() { return this.endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	
	public String getEndHms() { return this.endHms; }
	public void setEndHms(String endHms) { this.endHms = endHms; }
	
	public long getAgentStatSec() { return this.agentStatSec; }
	public void setAgentStatSec(long agentStatSec) { this.agentStatSec = agentStatSec; }
	
	
	@Override
	public String toString() {
		return "Ivr [agentStatCd=" + agentStatCd + ", empNo=" + empNo + ", empNm=" + empNm
				+ ", startDate=" + startDate + ", startHms=" + startHms + ", endDate=" + endDate + ", endHms=" + endHms
				+ ", agentStatSec=" + agentStatSec + "]";
	}
	
}
