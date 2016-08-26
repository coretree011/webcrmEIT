package com.coretree.defaultconfig.mapper;

import java.sql.Timestamp;

public class Call {
	private long idx;
	private long custs_idx;
	private String cust_name;
	private String cust_tel;
	//private Timestamp startdate = new Timestamp(System.currentTimeMillis());
	private Timestamp startdate;
	private Timestamp enddate;
	private int diff;
	private String memo;
	private Timestamp regdate;
	private byte status;
	private String statustxt;
	private int count = 0;
	private String extension;
	private byte direct;
	private String username;
	
	public long getIdx() { return this.idx; }
	public void setIdx(long idx) { this.idx = idx; }
	
	public String getCust_name() { return this.cust_name; }
	public void setCust_name(String cust_name) { this.cust_name = cust_name; }
	
	public long getCusts_idx() { return this.custs_idx; }
	public void setCusts_idx(long custs_idx) { this.custs_idx = custs_idx; }

	public String getCust_tel() { return this.cust_tel; }
	public void setCust_tel(String cust_tel) { this.cust_tel = cust_tel; }
	
	public Timestamp getStartdate() { return this.startdate; }
	public void setStartdate(Timestamp startdate) { this.startdate = startdate; }
	
	public Timestamp getEnddate() { return this.enddate; }
	public void setEnddate(Timestamp enddate) { this.enddate = enddate; }
	
	public int getDiff() { return this.diff; }
	public void setDiff(int diff) { this.diff = diff; }
	
	public String getMemo() { return this.memo; }
	public void setMemo(String memo) { this.memo = memo; }
	
	public Timestamp getRegdate() { return this.regdate; }
	public void setRegdate(Timestamp regdate) { this.regdate = regdate; }
	
	public byte getStatus() { return this.status; }
	public void setStatus(byte status) { this.status = status; }
	
	public String getStatustxt() { return this.statustxt; }
	public void setStatustxt(String statustxt) { this.statustxt = statustxt; }
	
	public long getCount() { return this.count; }
	public void setCount(int count) { this.count = count; }
	public void addCount() { this.count++; }
	public void resetCount() { this.count = 0; }
	
	public String getExtension() { return this.extension; }
	public void setExtension(String extension) { this.extension = extension; }
	
	public byte getDirect() { return this.direct; }
	public void setDirect(byte direct) { this.direct = direct; }
	
	public String getUsername() { return this.username; }
	public void setUsername(String username) { this.username = username; }
	
	
	@Override
	public String toString() {
		return "Call [idx=" + idx + ", custs_idx=" + custs_idx + ", cust_tel=" + cust_tel
				+ ", startdate=" + startdate + ", enddate=" + enddate
				+ ", memo=" + memo + "]";
	}
}
