package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.Cart;
import com.beanbrew.model.User;
import com.beanbrew.service.OrderService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/CartServlet" })
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private OrderService orderService = new OrderService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
    	
    	List<Cart> cart = SessionUtil.getAttribute(request, "cart", List.class);
    	
        if (cart == null) cart = new ArrayList<>();

        double total = cart.stream().mapToDouble(c -> c.getSubtotal()).sum();

        request.setAttribute("cart",  cart);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
    	
    	String action = request.getParameter("action");
    	
        if ("addToCart".equals(action)) {

            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            String itemName = request.getParameter("itemName");
            double price = Double.parseDouble(request.getParameter("price"));
            String imageUrl = request.getParameter("imageUrl");
            int quantity   = Integer.parseInt(request.getParameter("quantity"));

            List<Cart> cart = SessionUtil.getAttribute(request, "cart", List.class);
            if (cart == null) cart = new ArrayList<>();
            
            boolean found = false;
            
            for (Cart c : cart) {
                if (c.getMenuItemId() == menuItemId) {
                    c.setQuantity(c.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }

            if (!found) {
                Cart item = new Cart();
                item.setMenuItemId(menuItemId);
                item.setItemName(itemName);
                item.setPrice(price);
                item.setQuantity(quantity);
                item.setImageUrl(imageUrl);
                cart.add(item);
            }

            SessionUtil.setAttribute(request, "cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        if ("removeFromCart".equals(action)) {

            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            List<Cart> cart = SessionUtil.getAttribute(request, "cart", List.class);

            if (cart != null) {
            	
                cart.removeIf(c -> c.getMenuItemId() == menuItemId);
                SessionUtil.setAttribute(request, "cart", cart);
                
            }

            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        if ("placeOrder".equals(action)) {

            User user = SessionUtil.getAttribute(request, "currentUser", User.class);

            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            List<Cart> cart = SessionUtil.getAttribute(request, "cart", List.class);

            try {
            	
                orderService.placeOrder(user.getUserId(), cart);
                SessionUtil.removeAttribute(request, "cart");
                response.sendRedirect(request.getContextPath() + "/menu");

            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                request.setAttribute("cart", cart);
                request.getRequestDispatcher("/WEB-INF/pages/cart.jsp")
                       .forward(request, response);
            }
            
            return;
        }

        response.sendRedirect(request.getContextPath() + "/cart");

	}

}

