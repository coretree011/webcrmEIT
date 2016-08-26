package com.coretree.defaultconfig.mapper;

public class Extension {
	private String extension;
	private String username;
	private String uname;
	private String state;
	private String newext;
	
	public String getExtension() { return this.extension; }
	public void setExtension(String extension) { this.extension = extension; }
	
	public String getUsername() { return this.username; }
	public void setUsername(String username) { this.username = username; }
	
	public String getUname() { return this.uname; }
	public void setUname(String uname) { this.uname = uname; }
	
	public String getState() { return this.state; }
	public void setState(String state) { this.state = state; }
	
	public String getNewext() { return this.newext; }
	public void setNewext(String newext) { this.newext = newext; }
	
	@Override
	public String toString() {
		return "Extension [extension=" + extension + ", username=" + username + ", state=" + state + "]";
	}
}
