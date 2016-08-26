package com.coretree.defaultconfig.azure;

import java.util.ArrayList;
import java.util.List;

import com.coretree.models.UcUser;

public class WebUcUsers {
	private static List<UcUser> userlist = new ArrayList<UcUser>();
	
	public static void add(UcUser user) {
		userlist.add(user);
	}
	
	public static List<UcUser> get() {
		return userlist;
	}
	
	public static int getIndex(UcUser user) {
		return userlist.indexOf(user);
	}
	
	public static void remove(UcUser user) {
		userlist.remove(user);
	}
	
	public static void remove(int index) {
		userlist.remove(index);
	}
	
	public static void remove(String username) {
		UcUser item = userlist.stream().filter(x -> x.getUsername().equals(username)).findFirst().get();
		userlist.remove(item);
	}
}
