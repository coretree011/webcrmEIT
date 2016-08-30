package com.coretree.defaultconfig.bbs.model;

import com.coretree.defaultconfig.EitStringUtil;

public class BbsComment {
   private String bbsSeq;
   private String commentSeq;
   private String regDate;
   private String regHms;
   private String regEmpNo;
   private String regEmpNm;
   private String commentNote;
   private String[] bbsSeqs;
   

public String getBbsSeq() {
	return bbsSeq;
}


public void setBbsSeq(String bbsSeq) {
	this.bbsSeq = bbsSeq;
}


public String getCommentSeq() {
	return commentSeq;
}


public void setCommentSeq(String commentSeq) {
	this.commentSeq = commentSeq;
}


public String getRegDate() {
	return regDate;
}


public void setRegDate(String regDate) {
	this.regDate = regDate;
}


public String getRegHms() {
	return regHms;
}


public void setRegHms(String regHms) {
	this.regHms = regHms;
}


public String getRegEmpNo() {
	return regEmpNo;
}


public void setRegEmpNo(String regEmpNo) {
	this.regEmpNo = regEmpNo;
}


public String getRegEmpNm() {
	return EitStringUtil.isNullToString(regEmpNm);
}


public void setRegEmpNm(String regEmpNm) {
	this.regEmpNm = regEmpNm;
}


public String getCommentNote() {
	return commentNote;
}


public void setCommentNote(String commentNote) {
	this.commentNote = commentNote;
}

public String[] getBbsSeqs() {
	return bbsSeqs;
}


public void setBbsSeqs(String[] bbsSeqs) {
	this.bbsSeqs = bbsSeqs;
}


	@Override
	public String toString() {
		return "BbsComment [bbsSeq=" + bbsSeq + ", commentSeq=" + commentSeq
				+ ", regDate=" + regDate + ", regHms=" + regHms + ", regEmpNo=" + regEmpNo + ", commentNote=" + regEmpNm + ", regEmpNm="
				+ commentNote + "]";
	}

}
