package com.beanbrew.model;

public class User {
	
	 private int userId;
	 private String username;
	 private String email;
	 private String password;
	 private String createdAt;
	 private boolean isAdmin;
	 private boolean isVerified;
	 private boolean isActive;
	 private String profileImageURL;
	 
	 
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
	 
	 public String getCreatedAt() {
		 return createdAt;
	 }
	 
	 public boolean isAdmin() {
		 return isAdmin;
	 }
	 
	 public boolean isVerified() {
		 return isVerified;
	 }
	 
	 public boolean isActive() {
		 return isActive;
	 }
	 public String getProfileImageURL() {
		 return profileImageURL;
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
	 
	 public void setIsVerified(boolean isVerified) {
		 this.isVerified = isVerified;
	 }

	 public void setIsActive(boolean isActive) {
		 this.isActive = isActive;
	 }
	 
	 public void setProfileImageURL(String profileImageURL) {
		 this.profileImageURL = profileImageURL;
	 }
}
