package com.coretree.defaultconfig.mapper;

public class Counsellor {
	private String username;
	private String password;
	private String uname;
	private String posi;
	private String tel;
	private String cellular;
	private String extension;
	private String role;
	private int state;
	private short enabled = 1;
	private int tempval = 0;
	private String tempstr;
	
	public String getUsername() { return username; }
	public void setUsername(String username) { this.username = username; }
	
	public String getPassword() { return password; }
	public void setPassword(String password) { this.password = password; }
	
	public String getUname() { return uname; }
	public void setUname(String uname) { this.uname = uname; }
	
	public String getPosi() { return posi; }
	public void setPosi(String posi) { this.posi = posi; }
	
	public String getTel() { return tel; }
	public void setTel(String tel) { this.tel = tel; }
	
	public String getCellular() { return cellular; }
	public void setCellular(String cellular) { this.cellular = cellular; }
	
	public String getExtension() { return extension; }
	public void setExtension(String extension) { this.extension = extension; }
	
	public String getRole() { return role; }
	public void setRole(String role) { this.role = role; }
	
	public int getState() { return state; }
	public void setState(int state) { this.state = state; }
	
	public short getEnabled() { return enabled; }
	public void setEnabled(short enabled) { this.enabled = enabled; }
	
	public int getTempval() { return tempval; }
	public void setTempval(int tempval) { this.tempval = tempval; }
	
	public String getTempstr() { return this.tempstr; }
	public void setTempstr(String tempstr) { this.tempstr = tempstr; }
	
	@Override
	public String toString() {
		return "Member [username=" + username + ", uname=" + uname + ", posi=" + posi + ", tel=" + tel + ""
				+ ", cellular=" + cellular + ", extension=" + extension + ", role=" + role + ", state=" + state + ", enabled=" + enabled + "]";
	}
}
