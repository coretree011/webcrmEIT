package com.coretree.defaultconfig.code.model;

public class Code {
	private String lcd;
	private String scd;
	private String scdNm;
	private String useYn;
	private String note;
	
	private String[] scds;
	
	public String getLcd() {
		return lcd;
	}
	public void setLcd(String lcd) {
		this.lcd = lcd;
	}
	
	public String getScd() {
		return scd;
	}
	public void setScd(String scd) {
		this.scd = scd;
	}
	public String getScdNm() {
		return scdNm;
	}
	public void setScdNm(String scdNm) {
		this.scdNm = scdNm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	public String[] getScds() {
		return scds;
	}
	public void setScds(String[] scds) {
		this.scds = scds;
	}
	@Override
	public String toString() {
		return "Code [lcd=" + lcd + ", scd=" + scd
				+ ", scdNm=" + scdNm + ", useYn=" + useYn + ", note=" + note + "]";
	}
	
}
