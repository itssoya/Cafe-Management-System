package com.beanbrew.service;

import java.util.List;

import com.beanbrew.dao.DeleteMenuItemDAO;
import com.beanbrew.dao.FetchMenuBySearchFilter;
import com.beanbrew.model.MenuItem;
import com.beanbrew.util.ServiceExecutor;

public class MenuManagementService {
	
	private static final int stockPerPage = 10;
	private FetchMenuBySearchFilter fetchMenuBySearchFilter= new FetchMenuBySearchFilter();
	
	public int countPageForFilter (Integer category_id, String search) {
	    	
	    	int total = ServiceExecutor.execute(
	    			() -> fetchMenuBySearchFilter.countMenuForFilter(search, category_id), "Falied to Fetch Page Number");
	    	
	    	return (int) Math.ceil ((double) total/stockPerPage);
	    	
	    }
	
	public List <MenuItem> fetchMenuItem(Integer category_id, String search, int currentPage){
		
		return ServiceExecutor.execute(
				() -> fetchMenuBySearchFilter.fetchMenu(search, category_id, currentPage), "Failed to Fetch Menu Item");
	}
	
	public MenuItem getMenuById(int itemId) {
		
        return ServiceExecutor.execute(
                () -> fetchMenuBySearchFilter.getMenuById(itemId), "Failed to fetch menu item.");
    }
	
	public void deleteMenuItem(int itemId) {
		
        ServiceExecutor.execute(
                () -> DeleteMenuItemDAO.delete(itemId), "Failed to delete menu item.");
    }
	
	public int countAll() {
		
        return ServiceExecutor.execute(
                () -> fetchMenuBySearchFilter.countMenuForFilter(null, null), "Failed to count menu items.");
    }
}
