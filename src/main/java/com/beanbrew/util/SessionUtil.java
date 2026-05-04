package com.beanbrew.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
	
	public static <T> void setAttribute(HttpServletRequest request, String name, T value, int seconds) {
		
		HttpSession session = request.getSession(true);
		session.setAttribute(name, value);
		session.setMaxInactiveInterval(seconds);
	}
	
	public static <T> T getAttribute(HttpServletRequest request, String name, Class<T> type){
		
		HttpSession session = request.getSession(false);
		if(session != null) {
			Object obj =  session.getAttribute(name);
			if(type.isInstance(obj)) {
				return type.cast(obj);
			}
			
		}
		return null;
	}
	
	public static void removeAttribute(HttpServletRequest request, String name) {
		
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.removeAttribute(name);
		}
	}
	
	public static void invalidateSession(HttpServletRequest request) {
		
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
	}

}
