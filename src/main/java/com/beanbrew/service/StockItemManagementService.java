package com.beanbrew.service;

import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.AddStockItemDAO;
import com.beanbrew.dao.CheckStockItemDAO;
import com.beanbrew.dao.FetchStockBySearchFilter;
import com.beanbrew.dao.RestockItem;
import com.beanbrew.model.StockItem;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;

public class StockItemManagementService {
	
	private AddStockItemDAO dao = new AddStockItemDAO();
	private FetchStockBySearchFilter fetchUserBySearchFilter = new FetchStockBySearchFilter();
	private static final int stockPerPage = 10;
	
    public void addStockItem(StockItem item) {
    
  
        if (item.getName() == null || item.getName().trim().isEmpty())
            throw new ServiceException("Stock item name is required.");

        if (item.getUnit() == null || item.getUnit().trim().isEmpty())
            throw new ServiceException("Unit is required (e.g. kg, litre, pcs).");

        if (item.getQuantityInStock() < 0)
            throw new ServiceException("Quantity cannot be negative.");
        
        if (item.getLowStockThreshold() < 0)
            throw new ServiceException("Low Stock cannot be negative.");
        
        try{
        	
        	dao.addStockItem(item);
        	
        } catch (SQLException e){
        	
        	switch (e.getErrorCode()) {
			
				case 1062 ->{
		            	
					String msg = e.getMessage().toLowerCase();
		            		
		            		if(msg.contains("stock_name")) {
		            			throw new ServiceException ("Stock already exists", e);
		            		} 		
				}
	
		        case 1048 ->
		            throw new ServiceException(
		                "Required field missing", e);
	
		        case 1406 ->
		            throw new ServiceException(
		                "Input is too long", e);
	
		        default ->
		            throw new RuntimeException(
		                "Something went wrong", e);
				}
        	
        }
    }
    
    public void restock(Double newStockQuantity, int userId) {
    	
    	ServiceExecutor.execute(
    			() -> RestockItem.restockItem(newStockQuantity, userId), "Failed to restock Item");
    	
    }
    
    public int countPageForFilter (Boolean isBakery, String search) {
    	
    	int total = ServiceExecutor.execute(
    			() -> fetchUserBySearchFilter.countUserForFilter(isBakery, search), "Falied to Fetch Page Number");
    	
    	return (int) Math.ceil ((double) total/stockPerPage);
    	
    }
    
    public List<StockItem> getStockWithFilter(int currentPageNumber, Boolean isBakery, String search){
    	
    	return ServiceExecutor.execute(
    			() -> fetchUserBySearchFilter.getStock(currentPageNumber, isBakery, search), "Failed to Fetch Menu");
    }
    
    /*public StockItem checkStock (String stockName) {
    	
    	StockItem item = ServiceExecutor.execute(
    			() -> CheckStockItemDAO.checkStock(stockName), ); 
    } */
    
    
}