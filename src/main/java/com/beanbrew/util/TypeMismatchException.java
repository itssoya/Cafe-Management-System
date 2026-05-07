package com.beanbrew.util;

public class TypeMismatchException extends RuntimeException{
	
	private static final long serialVersionUID = 1L;
	
	public TypeMismatchException (String message ) {
		super(message);
	}
}
