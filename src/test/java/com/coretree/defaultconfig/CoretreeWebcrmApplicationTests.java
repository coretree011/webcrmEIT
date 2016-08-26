package com.coretree.defaultconfig;

import kr.re.nsri.aria.ARIA;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = CoretreeWebcrmApplication.class)
@WebAppConfiguration
public class CoretreeWebcrmApplicationTests {

	@Test
	public void contextLoads() {
	}
	
	/**
	 * ARIAEngine클래스의 샘플코드를 테스트 한다.
	 */
/*	@Test
	public void ariaTest() {
		System.out.println("ariaTest");
		ARIA.ariaTest();
	}*/

}
