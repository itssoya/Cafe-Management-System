package com.beanbrew.service;

import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.FetchCategory;
import com.beanbrew.dao.FetchMenuBySearchFilter;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.util.ServiceException;

public class MenuService {

    private static final int ITEMS_PER_PAGE = 8;
    private FetchMenuBySearchFilter fetchMenuDAO = new FetchMenuBySearchFilter();

    public List<MenuItem> getMenuItems(Integer categoryId, String search, int currentPage) {
        try {
            return fetchMenuDAO.fetchMenu(search, categoryId, currentPage);
        } catch (SQLException e) {
            throw new ServiceException("Failed to load menu items.");
        }
    }

    public int getTotalPages(Integer categoryId, String search) {
        try {
            int total = fetchMenuDAO.countMenuForFilter(search, categoryId);
            return (int) Math.ceil((double) total / ITEMS_PER_PAGE);
        } catch (SQLException e) {
            throw new ServiceException("Failed to count menu items.");
        }
    }

    public List<Category> getActiveCategories() {
        try {
            return FetchCategory.getAllActive();
        } catch (SQLException e) {
            throw new ServiceException("Failed to load categories.");
        }
    }
}