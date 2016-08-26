package com.coretree.defaultconfig.model;

public class Group {
	private String depthorder;
	private String maingroup;
	private String subgroup;
	private String txt;
	
	public String getDepthorder() { return this.depthorder; }
	public void setDepthorder(String depthorder) { this.depthorder = depthorder; }
	
	public String getMaingroup() { return this.maingroup; }
	public void setMaingroup(String maingroup) { this.maingroup = maingroup; }
	
	public String getSubgroup() { return this.subgroup; }
	public void setSubgroup(String subgroup) { this.subgroup = subgroup; }
	
	public String getTxt() { return txt; }
	public void setTxt(String txt) { this.txt = txt; }
	
	@Override
	public String toString() {
		return "Group [depthorder=" + depthorder + ", txt=" + txt + "]";
	}
}
