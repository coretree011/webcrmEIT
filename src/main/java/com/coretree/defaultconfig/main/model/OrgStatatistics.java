package com.coretree.defaultconfig.main.model;

public class OrgStatatistics {
	private int total = 0;
	private int logedin = 0;
	private int logedout = 0;
	private int ready = 0;
	private int after = 0;
	private int busy = 0;
	private int left = 0;
	private int rest = 0;
	private int edu = 0;
	
	public int getTotal() { return total; }
	public void setTotal(int total) { this.total = total; }
	
	public int getLogedin() { return logedin; }
	public void setLogedin(int logedin) { this.logedin = logedin; }
	
	public int getLogedout() { return logedout; }
	public void setLogedout(int logedout) { this.logedout = logedout; }
	
	public int getReady() { return ready; }
	public void setReady(int ready) { this.ready = ready; }
	
	public int getAfter() { return after; }
	public void setAfter(int after) { this.after = after; }
	
	public int getBusy() { return busy; }
	public void setBusy(int busy) { this.busy = busy; }
	
	public int getLeft() { return left; }
	public void setLeft(int left) { this.left = left; }
	
	public int getRest() { return rest; }
	public void setRest(int rest) { this.rest = rest; }
	
	public int getEdu() { return edu; }
	public void setEdu(int edu) { this.edu = edu; }
	
	@Override
	public String toString() {
		return "OrgStatatistics [total=" + total + ", logedin=" + logedin + ", logedout=" + logedout
				+ ", ready=" + ready + ", after=" + after + ", busy=" + busy
				+ ", left=" + left + ", rest=" + rest + ", edu=" + edu + "]";
	}
}
