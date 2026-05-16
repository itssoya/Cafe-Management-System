package com.beanbrew.model;

public class StockItem {
	
	private int id;
    private String name;
    private String unit;
    private double quantityInStock;
    private String lastUpdatedDate;
    private double lowStockThreshold;
    private boolean isBakery;
    
	public boolean isBakery() {
		return isBakery;
	}
	public void setBakery(boolean isBakery) {
		this.isBakery = isBakery;
	}
	public double getLowStockThreshold() {
		return lowStockThreshold;
	}
	public void setLowStockThreshold(double lowStockThreshold) {
		this.lowStockThreshold = lowStockThreshold;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public double getQuantityInStock() {
		return quantityInStock;
	}
	public void setQuantityInStock(double quantityInStock) {
		this.quantityInStock = quantityInStock;
	}
	public String getLastUpdatedDate() {
		return lastUpdatedDate;
	}
	public void setLastUpdatedDate(String lastUpdatedDate) {
		this.lastUpdatedDate = lastUpdatedDate;
	}
    

}
