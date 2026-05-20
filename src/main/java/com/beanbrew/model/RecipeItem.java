package com.beanbrew.model;

public class RecipeItem {

	private int stockItemId;      
	private int menuItemId; 
	private double quantityUsed;
	private String stockName;
	private String unit;
	
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
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
