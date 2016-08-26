package com.coretree.defaultconfig.mapper;

import java.util.Date;

public class Record {
	private long idx;
	private String ext;
	private String extension;
	private String peernum;
	private String filename;
	private Date regdate;
	
	public long getIdx() { return this.idx; }
	public void setIdx(long idx) { this.idx = idx; }
	
	public String getExt() { return this.ext; }
	public void setExt(String ext) { this.ext = ext; }

	public String getExtension() { return this.extension; }
	public void setExtension(String extension) { this.extension = extension; }
	
	public String getPeernum() { return this.peernum; }
	public void setPeernum(String peernum) { this.peernum = peernum; }
	
	public String getFilename() { return this.filename; }
	public void setFilename(String filename) { this.filename = filename; }
	
	public Date getRegdate() { return this.regdate; }
	public void setRegdate(Date regdate) { this.regdate = regdate; }
	
	@Override
	public String toString() {
		return "Record [idx=" + idx + ", ext=" + ext + ", extension=" + extension + ", peernum=" + peernum
				+ ", filename=" + filename + ", regdate=" + regdate + "]";
	}
}
