package com.coretree.defaultconfig.model;

import java.util.ArrayList;
import java.util.List;

public class WorkTimes {
	private List<WorkTime> worktimes;
	
	public WorkTimes() {
		worktimes = new ArrayList<WorkTime>();
		for (int i = 0 ; i < 24 ; i++) {
			WorkTime wt = new WorkTime();
			wt.setWtime(i);
			wt.setTxt(String.format("%1$02d ~ %2$02d", i, i + 1));
			worktimes.add(wt);
		}
	}
	
	public List<WorkTime> Get() {
		return worktimes;
	}
}
