package com.beanbrew.model;

public class User {
	
	 private int userId;
	 private String username;
	 private String email;
	 private String password;
	 private String createdAt;
	 private boolean isAdmin;
	 
	 
	 //Getter methods
	 public int getUserId() {
		 return userId;
	 }
	 
	 public String getUsername() {
		 return username;
	 }

	 public String getEmail() {
		 return email;
	 }
	 
	 public String getPassword() {
		 return password;
	 }
	 
	 public String getcreatedAt() {
		 return createdAt;
	 }
	 
	 public boolean getIsAdmin() {
		 return isAdmin;
	 }
	 
	 //Setter Methods
	 public void setUserId(int userId) {
		 this.userId = userId;
	 }
	 
	 public void setUsername(String username) {
		 this.username = username;
	 }
	 
	 public void setEmail(String email) {
		 this.email = email;
	 }
	 
	 public void setPassword(String password) {
		 this.password = password;
	 }
	 
	 public void setCreatedAt(String createdAt) {
		 this.createdAt = createdAt;
	 }
	 
	 public void setIsAdmin(boolean isAdmin) {
		 this.isAdmin = isAdmin;
	 }

	 
}
