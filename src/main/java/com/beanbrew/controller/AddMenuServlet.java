package com.beanbrew.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.FetchCategory;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.service.AddMenuService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.TypeMismatchException;

/**
 * Servlet implementation class AddMenuServlet
 */
@MultipartConfig
@WebServlet(asyncSupported = true, urlPatterns = { "/addmenu" })
public class AddMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		try {
			
			List<Category> categories = FetchCategory.getAllActive();
			request.setAttribute("categories", categories);
			
		} catch (SQLException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, "Falied to load Categories");
			return;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/addmenu.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String itemName    = request.getParameter("itemName");
        String category    = request.getParameter("categoryId");
        String priceParam  = request.getParameter("price");
        String description = request.getParameter("description");
        Part imagePart     = request.getPart("imageFile");
        
        if (itemName == null || itemName.trim().isEmpty()
            || category == null || category.trim().isEmpty()
            || priceParam == null || priceParam.trim().isEmpty()) {

                request.setAttribute(MessageKeysUtil.ERROR, "Item name, category and price are required.");
                doGet(request, response);
                return;
            }
        
        try{
        	
        	double price = Double.parseDouble(priceParam);
        	
        	if(price <0) {
        		request.setAttribute(MessageKeysUtil.ERROR, "Price cannot be negative.");
        		doGet(request, response);
        		return;
        	}
        	
        	MenuItem menuItem = new MenuItem();
    		
    		menuItem.setItemName(itemName.trim());
    		menuItem.setPrice(price);
    		menuItem.setDescription(description != null ? description.trim() : "");
    		
    		AddMenuService service = new AddMenuService();
            service.addItem(menuItem, imagePart, category.trim());

            response.sendRedirect(request.getContextPath() + "/menumanagement"); 
            
        } catch (NumberFormatException e) {
        	
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