package com.beanbrew.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.FetchCategory;
import com.beanbrew.dao.FetchMenuBySearchFilter;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.service.UpdateMenuService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.TypeMismatchException;

/**
 * Servlet implementation class EditMenu
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/editmenu" })
public class EditMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UpdateMenuService updateMenuService = new UpdateMenuService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String idParam = request.getParameter("id");
		 
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/menumanagement");
            return;
        }
 
        try {
            int itemId = Integer.parseInt(idParam);
            FetchMenuBySearchFilter dao = new FetchMenuBySearchFilter();
            MenuItem item = dao.getMenuById(itemId);
 
            if (item == null) {
                response.sendRedirect(request.getContextPath() + "/menumanagement");
                return;
            }
 
            List<Category> categories = FetchCategory.getAllcategory();
            request.setAttribute("menuItem",   item);
            request.setAttribute("categories", categories);
 
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/menumanagement");
            return;
        } catch (SQLException e) {
            request.setAttribute(MessageKeysUtil.ERROR, "Failed to load item.");
        }
 
        request.getRequestDispatcher("/WEB-INF/pages/editmenu.jsp") .forward(request, response);
	}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String itemIdParam = request.getParameter("itemId");
        String itemName = request.getParameter("itemName");
        String categoryIdParam = request.getParameter("categoryId");
        String priceParam = request.getParameter("price");
        String description = request.getParameter("description");
        String existingImageUrl = request.getParameter("existingImageUrl");
        String existingExtension = request.getParameter("existingFileExtension");
        Part imagePart = request.getPart("imageFile");
        
        if (itemName == null || itemName.trim().isEmpty()
                || categoryIdParam == null || categoryIdParam.trim().isEmpty()
                || priceParam == null || priceParam.trim().isEmpty()) {
 
        	request.setAttribute(MessageKeysUtil.ERROR, "Item name, category and price are required.");
            doGet(request, response);
            return;
        }
        
        try {
            int itemId = Integer.parseInt(itemIdParam);
            int categoryId = Integer.parseInt(categoryIdParam);
            double price = Double.parseDouble(priceParam);
 
            if (price < 0) {
            	request.setAttribute(MessageKeysUtil.ERROR, "Price cannot be negative.");
        		doGet(request, response);
        		return;
            }
 
            MenuItem item = new MenuItem();
            item.setItemId(itemId);
            item.setItemName(itemName.trim());
            item.setCategoryId(categoryId);
            item.setPrice(price);
            item.setDescription(description != null ? description.trim() : "");
            item.setImageUrl(existingImageUrl);
            item.setFileExtension(existingExtension);
 
            updateMenuService.updateItem(item, imagePart);
 
            response.sendRedirect(request.getContextPath() + "/menumanagement");
 
            }catch (NumberFormatException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, "Price must be a valid number.");
                doGet(request, response);
                return;
                
            }catch (TypeMismatchException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, "Only image files are allowed (jpg, png, gif, webp).");
                doGet(request, response);
                return;

            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                doGet(request, response);
                return;
            }
	}
    	

}
