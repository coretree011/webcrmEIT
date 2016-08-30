package com.coretree.defaultconfig.main.model;

public class Ivr {
	private long cb_seq;
	private String res_tel_no;
	private String res_date;
	private String res_hms;
	private String coun_date;
	private String coun_hms;
	private String coun_cd;
	private String extension_no;
	private String emp_no;
	private String emp_nm;
	private String cust_no;
	private String gen_dir_no;
	
	public long getCb_seq() { return this.cb_seq; }
	public void setCb_seq(long cb_seq) { this.cb_seq = cb_seq; }
	
	public String getRes_tel_no() { return this.res_tel_no; }
	public void setRes_tel_no(String res_tel_no) { this.res_tel_no = res_tel_no; }
	
	public String getRes_date() { return this.res_date; }
	public void setRes_date(String res_date) { this.res_date = res_date; }
	
	public String getRes_hms() { return this.res_hms; }
	public void setRes_hms(String res_hms) { this.res_hms = res_hms; }
	
	public String getCoun_date() { return this.coun_date; }
	public void setCoun_date(String coun_date) { this.coun_date = coun_date; }
	
	public String getCoun_hms() { return this.coun_hms; }
	public void setCoun_hms(String coun_hms) { this.coun_date = coun_hms; }
	
	public String getCoun_cd() { return this.coun_cd; }
	public void setCoun_cd(String coun_cd) { this.coun_cd = coun_cd; }
	
	public String getExtension_no() { return this.extension_no; }
	public void setExtension_no(String extension_no) { this.extension_no = extension_no; }
	
	public String getEmp_no() { return this.emp_no; }
	public void setEmp_no(String emp_no) { this.emp_no = emp_no; }
	
	public String getEmp_nm() { return this.emp_nm; }
	public void setEmp_nm(String emp_nm) { this.emp_nm = emp_nm; }
	
	public String getCust_no() { return this.cust_no; }
	public void setCust_no(String cust_no) { this.cust_no = cust_no; }
	
	public String getGen_dir_no() { return this.gen_dir_no; }
	public void setGen_dir_no(String gen_dir_no) { this.gen_dir_no = gen_dir_no; }
	
	@Override
	public String toString() {
		return "Ivr [cb_seq=" + cb_seq + ", res_tel_no=" + res_tel_no + ", res_date=" + res_date + ", res_hms=" + res_hms
				+ ", coun_date=" + coun_date + ", coun_hms=" + coun_hms + ", coun_cd=" + coun_cd
				+ ", extension_no=" + extension_no + ", emp_no=" + emp_no + ", emp_nm=" + emp_nm
				+ ", cust_no=" + cust_no + ", gen_dir_no=" + gen_dir_no + "]";
	}
	
}
