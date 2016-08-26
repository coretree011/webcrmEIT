package com.coretree.defaultconfig.azure;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix="uc")
public class WebUcServiceConfig {
	private String pbxip;
	
	public void setPbxip(String pbxip) {
		System.err.println("set : " + pbxip);
		this.pbxip = pbxip;
	}
	
	public String getPbxip() {
		System.err.println("get : " + this.pbxip);
		return this.pbxip;
	}
}
