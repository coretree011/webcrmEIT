//
//  ARIA.java
//  
//  A pure Java implementation of ARIA 
//  following the official ARIA specification at
//  http://www.nsri.re.kr/ARIA/
//
//  
//  Created by Aaram Yun on 2005. 11. 30.
//  Copyright 2005 NSRI. All rights reserved.
//

package kr.re.nsri.aria;

import java.security.InvalidKeyException;

/*
 * Frontend class ARIA
 * Currently, it provides only a simple text.*/

/**
 * ARIA 알고리즘을 사용하여 암호화와 복호화를 수행한다.
 * @author hsw <br>
 *
 */
public class ARIA {
	/*public static void main(String args[]) {
		try {
			ARIAEngine.ARIA_test();
		} catch (Exception e) {
		}
	}*/
	
	/**
	 * ARIAEngine클래스의 샘플코드를 테스트 한다.
	 */
	public static void ariaTest() {
		try {
			ARIAEngine.ARIA_test();
		} catch (Exception e) {
		}
	}

	/**
	 * 암호화
	 * @param plaintext 평문
	 * @param mk 마스터 키
	 * @return 암호화 된 값
	 * @throws InvalidKeyException
	 */
	public static String getCipherText(String plaintext, byte[] mk) throws InvalidKeyException {
		
		return ARIAEngine.getCipherText(plaintext, mk);
		
	}
	
	/**
	 * 복호화
	 * @param ciphertext 암호화 된 값
	 * @param mk 마스터 키
	 * @return 평문
	 * @throws InvalidKeyException
	 */
	public static String getDecrypted(String ciphertext, byte[] mk) throws InvalidKeyException {
		
		return ARIAEngine.getDecrypted(ciphertext, mk);
		
	}
}
