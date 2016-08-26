package com.coretree.defaultconfig.mapper;

public class Customer2 {
	private String cust_no;
	private String cust_nm;
	private String cust_cd;
	private String tel1_no;
	private String tel2_no;
	private String tel3_no;
	private String fax_no;
	private String post_cd;
	private String addr;
	private String emailid;
	private String reg_date;
	private String cust_note;
	
	public String getCust_no() { return this.cust_no; }
	public void setCust_no(String cust_no) { this.cust_no = cust_no; }
	
	public String getCust_nm() { return this.cust_nm; }
	public void setCust_nm(String cust_nm) { this.cust_nm = cust_nm; }
	
	public String getCust_cd() { return this.cust_cd; }
	public void setCust_cd(String cust_cd) { this.cust_cd = cust_cd; }
	
	public String getTel1_no() { return this.tel1_no; }
	public void setTel1_no(String tel1_no) { this.tel1_no = tel1_no; }
	
	public String getTel2_no() { return this.tel2_no; }
	public void setTel2_no(String tel2_no) { this.tel2_no = tel2_no; }
	
	public String getTel3_no() { return this.tel3_no; }
	public void setTel3_no(String tel3_no) { this.tel3_no = tel3_no; }

	public String getFax_no() { return this.fax_no; }
	public void setFax_no(String fax_no) { this.fax_no = fax_no; }
	
	public String getPost_cd() { return this.post_cd; }
	public void setPost_cd(String post_cd) { this.post_cd = post_cd; }
	
	public String getAddr() { return this.addr; }
	public void setAddr(String addr) { this.addr = addr; }
	
	public String getEmailid() { return this.emailid; }
	public void setEmailid(String emailid) { this.emailid = emailid; }
	
	public String getReg_date() { return this.reg_date; }
	public void setReg_date(String reg_date) { this.reg_date = reg_date; }
	
	public String getCust_note() { return this.cust_note; }
	public void setCust_note(String cust_note) { this.cust_note = cust_note; }
	
	@Override
	public String toString() {
		return "Customer [cust_no=" + cust_no + ", cust_nm=" + cust_nm + ", cust_cd=" + cust_cd + ", tel1_no=" + tel1_no
				+ ", tel2_no=" + tel2_no + ", tel3_no=" + tel3_no + ", fax_no=" + fax_no + ", post_cd=" + post_cd
				+ ", addr=" + addr + ", emailid=" + emailid + ", reg_date=" + reg_date + ", cust_note=" + cust_note + "]";
	}
}
