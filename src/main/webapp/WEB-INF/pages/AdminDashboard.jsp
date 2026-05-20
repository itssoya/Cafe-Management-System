<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> Admin Dashboard </title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminDashboard.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
    </head>

    <body>
        <div class="sidebar">
            <div class="sidebar-content">
                <img src="${pageContext.request.contextPath}/images/main_container/logo.svg" class="main-icon">
                <h1>BrewBar</h1>
                <ul class="category">
                    <li>
                    
                        <img src="${pageContext.request.contextPath}/images/panel/dashboard.svg" class="icon">
                        <span>Dashboard</span>
                    </li>
                    <li>
                        <img src="${pageContext.request.contextPath}/images/panel/menu.svg" class="icon">
                        <span>Menu</span>
                    </li>
                    <li>
                        <img src="${pageContext.request.contextPath}/images/panel/users.svg" class="icon">
                        <span>Users</span>
                    </li>
                    <li>
                        <img src="${pageContext.request.contextPath}/images/panel/inventory.svg" class="icon">
                        <span>Inventory</span>
                    </li>
                </ul>
                <ul class="bottom">
                    <li>
                        <img src="${pageContext.request.contextPath}/images/panel/settings.png" class="icon">
                        <span>Settings</span>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-container">
            <div class="header">
                <h1>Dashboard</h1>
                <img src="${pageContext.request.contextPath}/images/main_container/flower.svg" class="header-icon">
            </div>
            <div class="flex-containers">
                <div class="flex-container" style="color:#FFF8ED; background-color: #16319E;">
                    <p> Total Earnings Today </p>
                    <h1>${totalEarnings}</h1>
                </div>

                <div class="flex-container" style="border-color: #16319E; border-style:solid;">
                    <p> Total Orders Today </p>
                    <h1>${pendingOrders}</h1>
                </div>
                <div class="flex-container" style="color:#000000; background-color: #F6C251;">
                    <div class="stock-top">
                        <p> Low Stock Items </p>
                        <p style="text-decoration: underline;">View Stock</p>
                    </div>
                    <div class="stock-bottom">
                        <h1>${lowStockCount}</h1>
                        <img src="${pageContext.request.contextPath}/images/main_container/stock.svg"
                            class="stock-icon">
                    </div>
                </div>
            </div>


            <div class="active-order">
                <h2 style="color:#16319E; padding-top:2rem;">Active Orders</h2>
                <table>
                    <thead>
                        <tr>
                            <th> Order ID </th>
                            <th> Customer </th>
                            <th> Items </th>
                            <th> Amount </th>
                            <th> Status </th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td> #ORD-1 </td>
                            <td> David G. </td>
                            <td> Iced Cafe Latte </td>
                            <td> Rs.260 </td>
                            <td>
                                <div class="status-action">
                                	<select class = "status-select">
                                		<option value = "processing">Processing</option>
                                		<option value = "completed">Completed</option>
                                		<option value = "cancelled">Cancelled</option>
                                	</select>
                                    <button class = "cancel-btn">
                                    <img src="${pageContext.request.contextPath}/images/main_container/button.svg" class="cancel-icon">
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>

    </html>
