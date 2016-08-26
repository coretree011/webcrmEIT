package com.coretree.defaultconfig.azure;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.coretree.defaultconfig.main.mapper.OrganizationMapper;

@Component
public class LoginHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private OrganizationMapper organizationMapper;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		System.out.println(":::::::::::::::::::::::Authentication success : " + request.getContextPath());

		response.sendRedirect("/login/actionLogin?userName="+auth.getName());
	}
}
