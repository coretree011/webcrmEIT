package com.coretree.defaultconfig.mapper;

import java.sql.Timestamp;

public class Sms {
	private long idx;
	private String username;
	private String ext;
	private String custs_tel;
	private String contents;
	private int result;
	private String resultTxt;
	private Timestamp regdate;
	private String sdate;
	private String edate;
	private int curpage;
	private int rowsperpage;
	
	public long getIdx() { return this.idx; }
	public void setIdx(long idx) { this.idx = idx; }
	
	public String getUsername() { return this.username; }
	public void setUsername(String username) { this.username = username; }
	
	public String getExt() { return this.ext; }
	public void setExt(String ext) { this.ext = ext; }

	public String getCusts_tel() { return this.custs_tel; }
	public void setCusts_tel(String custs_tel) { this.custs_tel = custs_tel; }
	
	public String getContents() { return this.contents; }
	public void setContents(String contents) { this.contents = contents; }
	
	public int getResult() { return this.result; }
	public void setResult(int result) { this.result = result; }
	
	public String getResultTxt() { return this.resultTxt; }
	public void setResultTxt(String resultTxt) { this.resultTxt = resultTxt; }
	
	public Timestamp getRegdate() { return this.regdate; }
	public void setRegdate(Timestamp regdate) { this.regdate = regdate; }
	
	public String getSdate() { return this.sdate; }
	public void setSdate(String sdate) { this.sdate = sdate; }
	
	public String getEdate() { return this.edate; }
	public void setEdate(String edate) { this.edate = edate; }
	
	public int getCurpage() { return this.curpage; }
	public void setCurpage(int curpage) { this.curpage = curpage; }
	
	public int getRowsperpage() { return this.rowsperpage; }
	public void setRowsperpage(int rowsperpage) { this.rowsperpage = rowsperpage; }
	
	@Override
	public String toString() {
		return "Sms [idx=" + idx + ", username=" + username + ", ext=" + ext  +", custs_tel=" + custs_tel + ", contents=" + contents
				+ ", result=" + result + ", regdate=" + regdate + "]";
	}
}
