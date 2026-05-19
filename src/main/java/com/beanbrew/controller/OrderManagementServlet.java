package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.beanbrew.model.Order;
import com.beanbrew.service.OrderService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class OrderManagementServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/ordermanagement" })
public class OrderManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderService orderService = new OrderService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderManagementServlet() {
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
            List<Order> orders = orderService.getAllOrders();
            request.setAttribute("orders", orders);

            long pending   = orders.stream().filter(o -> "PENDING".equals(o.getStatus())).count();
            long completed = orders.stream().filter(o -> "COMPLETED".equals(o.getStatus())).count();
            long cancelled = orders.stream().filter(o -> "CANCELLED".equals(o.getStatus())).count();

            request.setAttribute("totalOrders",     orders.size());
            request.setAttribute("pendingOrders",   pending);
            request.setAttribute("completedOrders", completed);
            request.setAttribute("cancelledOrders", cancelled);

        } catch (ServiceException e) {
        	
            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/Ordermanagement.jsp")
               .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String action  = request.getParameter("action");
        String idParam = request.getParameter("orderId");
        

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ordermanagement");
            return;
        }

        int orderId = Integer.parseInt(idParam);

        try {
            if ("complete".equals(action)) {
                orderService.completeOrder(orderId);

            } else if ("cancel".equals(action)) {
                orderService.cancelOrder(orderId);
            }

        } catch (ServiceException e) {
            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/ordermanagement");
	}

}
