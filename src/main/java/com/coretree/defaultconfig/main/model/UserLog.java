package com.coretree.defaultconfig.main.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class UserLog {
	private String agentStatCd;
	private String empNo;
	private String empNm;
	private LocalDateTime startTimestamp;
	private String startDate;
	private String startHms;
	private LocalDateTime endTimestamp;
	private String endDate;
	private String endHms;
	private long agentStatSec;
	

	public String getAgentStatCd() { return this.agentStatCd; }
	public void setAgentStatCd(String agentStatCd) { this.agentStatCd = agentStatCd; }
	
	public String getEmpNo() { return this.empNo; }
	public void setEmpNo(String empNo) { this.empNo = empNo; }
	
	public String getEmpNm() { return this.empNm; }
	public void setEmpNm(String empNm) { this.empNm = empNm; }
	
	public LocalDateTime getStartTimestamp() { return this.startTimestamp; }
	public void setStartTimestamp(LocalDateTime startTimestamp) {
		this.startTimestamp = startTimestamp;
		
		DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyyMMdd");
		this.setStartDate(this.startTimestamp.format(df));
		df = DateTimeFormatter.ofPattern("HHmmss");
		this.setStartHms(this.startTimestamp.format(df));
	}
	
	public String getStartDate() { return this.startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	
	public String getStartHms() { return this.startHms; }
	public void setStartHms(String startHms) { this.startHms = startHms; }
	
	public LocalDateTime getEndTimestamp() { return this.endTimestamp; }
	public void setEndTimestamp() {
		this.endTimestamp = LocalDateTime.now();

		DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyyMMdd");
		this.setEndDate(this.endTimestamp.format(df));
		df = DateTimeFormatter.ofPattern("HHmmss");
		this.setEndHms(this.endTimestamp.format(df));
	}
	
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
