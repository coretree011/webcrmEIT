package com.coretree.defaultconfig.azure;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

//테스트용입니다. 사용하지마세요

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private LoginHandler loginSuccessHandler;
	
	@Autowired
	private AuthFailureHandler authFailureHandler;
	
	@Autowired
	private DataSource dataSrc;
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
/*
		
		auth.inMemoryAuthentication().withUser("100001").password("1").roles("USER");		
		auth.inMemoryAuthentication().withUser("test11").password("1234").roles("USER");
		auth.inMemoryAuthentication().withUser("test12").password("1234").roles("USER");
		auth.inMemoryAuthentication().withUser("test13").password("1234").roles("USER");*/

		/*System.out.println("::::::::::::::::::::::::::::::");
		String getUser = "select username, password, enabled from users where username=?";
		String getAuth = "select username, password, role from users where username=?";

		auth
        .jdbcAuthentication()
        	.dataSource(dataSrc)
            .usersByUsernameQuery(getUser)
            .authoritiesByUsernameQuery(getAuth);
		*/
		auth.inMemoryAuthentication().withUser("1000001").password("1").roles("USER");		
		auth.inMemoryAuthentication().withUser("1000002").password("1").roles("USER");		
		auth.inMemoryAuthentication().withUser("1000003").password("1").roles("USER");		
		auth.inMemoryAuthentication().withUser("1000004").password("1").roles("USER");		
		auth.inMemoryAuthentication().withUser("1000005").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000006").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000007").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000008").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000009").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000010").password("1").roles("USER");
		auth.inMemoryAuthentication().withUser("1000011").password("1").roles("USER");
		// System.err.println("Progress authenticate");
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable() //간단처리
		.authorizeRequests()
		.antMatchers("/resources/**").permitAll() //권장사항
		.anyRequest().authenticated()
		.and()
		.formLogin()
		.loginPage("/")
        .loginProcessingUrl("/j_spring_security_check")
		.defaultSuccessUrl("/index")
		.usernameParameter("j_username")
		.passwordParameter("j_password")
		.failureHandler(authFailureHandler)
		.successHandler(loginSuccessHandler)
		.permitAll()
		.and()
		.logout()
        .logoutUrl("/logout")
		.logoutSuccessUrl("/")
		.permitAll();
	}
} 