package com.beanbrew.model;

public class RecipeItem {

	private int stockItemId;      
	private int menuItemId; 
	private double quantityUsed;
	
	public int getStockItemId() {
		return stockItemId;
	}
	public void setStockItemId(int stockItemId) {
		this.stockItemId = stockItemId;
	}
	public int getMenuItemId() {
		return menuItemId;
	}
	public void setMenuItemId(int menuItemId) {
		this.menuItemId = menuItemId;
	}
	public double getQuantityUsed() {
		return quantityUsed;
	}
	public void setQuantityUsed(double quantityUsed) {
		this.quantityUsed = quantityUsed;
	}
	
}
