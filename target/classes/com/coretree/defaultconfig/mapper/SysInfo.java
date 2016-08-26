package com.coretree.defaultconfig.mapper;

public class SysInfo {
	private long diskspace;
	private long todaycall;
	private long weekcall;
	private long monthcall;
	  
	public long getDiskspace() { return diskspace; }
	public void setDiskspace(long diskspace) { this.diskspace = diskspace; }

	public long getTodaycall() { return todaycall; }
	public void setTodaycall(long todaycall) { this.todaycall = todaycall; }
	
	public long getWeekcall() { return weekcall; }
	public void setWeekcall(long weekcall) { this.weekcall = weekcall; }
	
	public long getMonthcall() { return monthcall; }
	public void setMonthcall(long monthcall) { this.monthcall = monthcall; }
}
