package com.coretree.defaultconfig.mapper;

public class Customer_sample {
	private long idx;
	private String depthorder;
	private String maingroup;
	private String subgroup;
	private String username;
	private String uname;
	private String firm;
	private String posi;
	private String tel;
	private String cellular;
	private String extension;
	private String email;
	
	public long getIdx() { return this.idx; }
	public void setIdx(long idx) { this.idx = idx; }
	
	public String getDepthorder() { return this.depthorder; }
	public void setDepthorder(String depthorder) { this.depthorder = depthorder; }
	
	public String getMaingroup() { return this.maingroup; }
	public void setMaingroup(String maingroup) { this.maingroup = maingroup; }
	
	public String getSubgroup() { return this.subgroup; }
	public void setSubgroup(String subgroup) { this.subgroup = subgroup; }
	
	public String getUsername() { return this.username; }
	public void setUsername(String username) { this.username = username; }
	
	public String getUname() { return this.uname; }
	public void setUname(String uname) { this.uname = uname; }

	public String getFirm() { return this.firm; }
	public void setFirm(String firm) { this.firm = firm; }
	
	public String getPosi() { return this.posi; }
	public void setPosi(String posi) { this.posi = posi; }
	
	public String getTel() { return this.tel; }
	public void setTel(String tel) { this.tel = tel; }
	
	public String getCellular() { return this.cellular; }
	public void setCellular(String cellular) { this.cellular = cellular; }
	
	public String getExtension() { return this.extension; }
	public void setExtension(String extension) { this.extension = extension; }
	
	public String getEmail() { return this.email; }
	public void setEmail(String email) { this.email = email; }
	
	@Override
	public String toString() {
		return "Customer [idx=" + idx + ", depthorder=" + depthorder + ", username=" + username + ", uname=" + uname
				+ ", firm=" + firm + ", posi=" + posi + ", tel=" + tel + ", cellular=" + cellular
				+ ", extension=" + extension + ", email=" + email + "]";
	}
}
