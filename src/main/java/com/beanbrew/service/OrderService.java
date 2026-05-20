package com.beanbrew.service;

import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.AddOrderDAO;
import com.beanbrew.dao.AddOrderItems;
import com.beanbrew.dao.FetchAllOrdersDAO;
import com.beanbrew.dao.FetchOrderBySearchFilterDAO;
import com.beanbrew.dao.FetchOrderItemsDAO;
import com.beanbrew.dao.FetchRecipeDAO;
import com.beanbrew.dao.ReduceStockDAO;
import com.beanbrew.dao.UpdateOrderStatusDAO;
import com.beanbrew.model.Cart;
import com.beanbrew.model.Order;
import com.beanbrew.model.OrderItem;
import com.beanbrew.model.RecipeItem;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;

public class OrderService {
	
	private AddOrderDAO addOrderDAO = new AddOrderDAO();
    private AddOrderItems addOrderItems = new AddOrderItems();
    private FetchAllOrdersDAO fetchAllOrdersDAO = new FetchAllOrdersDAO();
    private FetchOrderItemsDAO fetchOrderItemsDAO = new FetchOrderItemsDAO();
    private FetchRecipeDAO fetchRecipeDAO = new FetchRecipeDAO();
    private ReduceStockDAO reduceStockDAO = new ReduceStockDAO();
    private UpdateOrderStatusDAO updateStatusDAO = new UpdateOrderStatusDAO();
    private FetchOrderBySearchFilterDAO fetchOrderBySearchFilter = new FetchOrderBySearchFilterDAO();
    
    private static final int stockPerPage = 10;
    
    public void placeOrder(int userId, List<Cart> cart) {
    	
    	if (cart== null || cart.isEmpty())
            throw new ServiceException("Cart is empty.");
    	
    	try {
            
    		double total = cart.stream().mapToDouble(c -> c.getSubtotal()).sum();

            Order order = new Order();
            order.setUserId(userId);
            order.setTotalAmount(total);
            order.setStatus("PENDING");

            int orderId = addOrderDAO.createOrder(order);

            List<OrderItem> items = cart.stream()
            		.map(c -> {
				                OrderItem orderItem = new OrderItem();
				                orderItem .setMenuItemId(c.getMenuItemId());
				                orderItem .setQuantity(c.getQuantity());
				                return orderItem ;
				            }).collect(java.util.stream.Collectors.toList());

            addOrderItems.addOrder(orderId, items);

        } catch (SQLException e) {
            throw new ServiceException("Failed to place order.");
        }
    
    }
    
    public void completeOrder(int orderId) {

        try {
        	
            List<OrderItem> orderItems = fetchOrderItemsDAO.getItemsByOrderId(orderId);

            for (OrderItem orderItem : orderItems) {

                List<RecipeItem> recipe = fetchRecipeDAO
                        .getRecipeByMenuItemId(orderItem.getMenuItemId());

                for (RecipeItem ingredient : recipe) {
                	
                    double toDeduct = ingredient.getQuantityUsed() * orderItem.getQuantity();
                    reduceStockDAO.reduceStock(toDeduct, ingredient.getStockItemId());
                }
            }

            updateStatusDAO.updateStatus(orderId, "COMPLETED");

        } catch (SQLException e) {
            throw new ServiceException("Failed to complete order.");
        }
    }
    
    public void cancelOrder(int orderId) {
    	
        ServiceExecutor.execute(() -> { updateStatusDAO.updateStatus(orderId, "CANCELLED");
            return null;
        }, "Failed to cancel order.");
        
    }

    public List<Order> getAllOrders() {
    	
        return ServiceExecutor.execute(() 
        		-> fetchAllOrdersDAO.getAllOrders(),  "Failed to fetch orders.");
    }
    
    public int countPageForFilter(String orderStatus, String search) {
    	
        int total = ServiceExecutor.execute(
                () -> fetchOrderBySearchFilter.countOrdersForFilter(orderStatus, search),
                "Failed to count Order items."
        );
        return (int) Math.ceil((double) total / stockPerPage);
    }

  
    public List<Order> fetchOrder(int currentPageNumber, String orderStatus, String search) {
    	
        return ServiceExecutor.execute(
                () -> fetchOrderBySearchFilter.getOrder(currentPageNumber, orderStatus, search),
                "Failed to fetch order items."
        );
    }
}
