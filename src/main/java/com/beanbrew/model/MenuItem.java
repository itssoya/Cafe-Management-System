package com.beanbrew.model;

import jakarta.servlet.http.Part;

public class MenuItem {
	
	private int itemId;
	private String itemName;
	private int categoryId;
	private double price;
	private String description;
	private Part image;
	private String imageUrl;
	private String fileExtension;
	private String createdDate;
	private String categoryName;
	
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	//Getter Methods 
	public int getItemId() {
		return itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	
	public int getCategoryId() {
		return categoryId;
	}

	public double getPrice() {
		return price;
	}
	
	public String getDescription() {
		return description;
	}
	
	public Part getImage() {
		return image;
	}
	
	public String getImageUrl() {
		return imageUrl;
	}
	
	public String getFileExtension() {
		return fileExtension;
	}
	
	//Setter Methods
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	
	public void setCategoryId(int  categoryId) {
		this.categoryId =categoryId;
	}
	
	public void setPrice(double price) {
		this.price = price;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public void setImage(Part image) {
		this.image = image;
	}
	
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
}