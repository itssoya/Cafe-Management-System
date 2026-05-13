package com.beanbrew.model;

public class RecipeItem {

	private int stockItemId;      
	private String stockItemName; 
	private double quantityUsed;
	
	public int getStockItemId() {
		return stockItemId;
	}
	public void setStockItemId(int stockItemId) {
		this.stockItemId = stockItemId;
	}
	public String getStockItemName() {
		return stockItemName;
	}
	public void setStockItemName(String stockItemName) {
		this.stockItemName = stockItemName;
	}
	public double getQuantityUsed() {
		return quantityUsed;
	}
	public void setQuantityUsed(double quantityUsed) {
		this.quantityUsed = quantityUsed;
	}
	
}
