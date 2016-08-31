package com.coretree.defaultconfig.model;

public class CalltimePivot {
    private String timerange;
    private long totalnum;
    private long col30;
    private long col60;
    private long col180;
    private long col300;
    private long col600;
    private long col1800;
    private long col3600;
    private long colall;
    private long colavg;
    
    public void setTimerange(String timerange) { this.timerange = timerange; }
    public String getTimerange() { return this.timerange; }
    
    public void setTotalnum(long totalnum) { this.totalnum = totalnum; }
    public long getTotalnum() { return this.totalnum; }
    
    public void setCol30(long col30) { this.col30 = col30; }
    public long getCol30() { return this.col30; }
    
    public void setCol60(long col60) { this.col60 = col60; }
    public long getCol60() { return this.col60; }
    
    public void setCol180(long col180) { this.col180 = col180; }
    public long getCol180() { return this.col180; }
    
    public void setCol300(long col300) { this.col300 = col300; }
    public long getCol300() { return this.col300; }
    
    public void setCol600(long col600) { this.col600 = col600; }
    public long getCol600() { return this.col600; }
    
    public void setCol1800(long col1800) { this.col1800 = col1800; }
    public long getCol1800() { return this.col1800; }
    
    public void setCol3600(long col3600) { this.col3600 = col3600; }
    public long getCol3600() { return this.col3600; }
    
    public void setColall(long colall) { this.colall = colall; }
    public long getColall() { return this.colall; }
    
    public void setColavg(long colavg) { this.colavg = colavg; }
    public long getColavg() { return this.colavg; }
    
	@Override
	public String toString() {
		return "CalltimePivot [timerange=" + getTimerange() + ", totalnum=" + getTotalnum() + ", col30=" + getCol30() + ", col60=" + getCol60() 
				+ ", col180=" + getCol180() + ", col300=" + getCol300() + ", col600=" + getCol600() + ", col1800=" + getCol1800() + ", col3600=" + getCol3600()
				+ ", colall=" + getColall() + ", colall=" + getColavg() + "]";
	}
}
