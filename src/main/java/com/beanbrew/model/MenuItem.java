package com.beanbrew.model;

import jakarta.servlet.http.Part;

public class MenuItem {
	
	private String itemName;
	private String category;
	private double price;
	private String description;
	private Part image;
	private String imageUrl;
	private String fileExtension;
	
	//Getter Methods 
	public String getItemName() {
		return itemName;
	}
	
	public String getCategory() {
		return category;
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
	
	public void setCategory(String category) {
		this.category =category;
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