package com.beanbrew.util;

import java.util.Arrays;
import java.util.Optional;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtil {
	
	public static void addCookie(HttpServletResponse response, String name, String value, int ageMax ) {
		
		Cookie cookie = new Cookie(name, value);
		cookie.setPath("/");
		cookie.setMaxAge(ageMax);
		cookie.setHttpOnly(true);
		
	}
	
	public static void deleteCookie(HttpServletResponse response, String name) {
		
		addCookie(response, name, "", 0);
	}
	
	public static Optional<String> getCookieValue(HttpServletRequest request, String name){
		
		Cookie[] cookie = request.getCookies(); 
		
		if (cookie == null) {
	        return Optional.empty();
	    }
		
		return  Arrays.stream(cookie)
				.filter(c -> name.equals(c.getName()))
				.map(c-> c.getValue())
				.findFirst();
							
	}

}
