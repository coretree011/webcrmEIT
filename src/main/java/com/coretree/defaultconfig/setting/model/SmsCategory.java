package com.coretree.defaultconfig.setting.model;

public class SmsCategory {
	String cateCd; //유형코드
	String cateNm; //유형명
	String cateComment; //내용
	
	String customName; //고객명
	String[] cateCds;
	
	public String getCateCd() {
		return cateCd;
	}

	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}

	public String getCateNm() {
		return cateNm;
	}

	public void setCateNm(String cateNm) {
		this.cateNm = cateNm;
	}

	public String getCateComment() {
		return cateComment;
	}

	public void setCateComment(String cateComment) {
		this.cateComment = cateComment;
	}

	public String getCustomName() {
		return customName;
	}

	public void setCustomName(String customName) {
		this.customName = customName;
	}
	
	public String[] getCateCds() {
		return cateCds;
	}

	public void setCateCds(String[] cateCds) {
		this.cateCds = cateCds;
	}

	@Override
	public String toString() {
		return "SmsCategory [cateCd=" + cateCd + ", cateNm=" + cateNm + ", customName=" + customName
				+ ", cateComment=" + cateComment + "]";
	}
	
}
