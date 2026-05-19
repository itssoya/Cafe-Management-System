package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.OrderItem;
import com.beanbrew.util.DBConnection;

public class FetchOrderItemsDAO {

    private static final String query = "SELECT * FROM order_items WHERE order_id = ?";

    public List<OrderItem> getItemsByOrderId(int orderId) throws SQLException {

        List<OrderItem> items = new ArrayList<>();

        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
            	
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setMenuItemId(rs.getInt("menu_item_id"));
                item.setQuantity(rs.getInt("quantity"));
                items.add(item);
            }
        }
        return items;
    }
}