<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/AdminDashboard.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap"
	rel="stylesheet">
</head>

<body>
	<!-- SIDEBAR -->
	<aside class="sidebar">
		<div class="sidebar-content">
			<img
				src="${pageContext.request.contextPath}/images/main_container/logo.svg"
				class="main-icon">
			<h1>BrewBar</h1>

			<ul class="category">
				<li><a href="${pageContext.request.contextPath}/admindashboard">
						<img
						src="${pageContext.request.contextPath}/images/panel/dashboard.svg"
						class="icon"> <span>Dashboard</span>
				</a></li>
				<li><a href="${pageContext.request.contextPath}/menumanagement">
						<img
						src="${pageContext.request.contextPath}/images/panel/menu.svg"
						class="icon"> <span>Menu</span>
				</a></li>
				<li><a href="${pageContext.request.contextPath}/usermanagement">
						<img
						src="${pageContext.request.contextPath}/images/panel/users.svg"
						class="icon"> <span>Users</span>
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/stockmanagement"> <img
						src="${pageContext.request.contextPath}/images/panel/inventory.svg"
						class="icon"> <span>Inventory</span>
				</a></li>
				<li><a
					href="${pageContext.request.contextPath}/ordermanagement"> <img
						src="${pageContext.request.contextPath}/images/panel/order.svg"
						class="icon"> <span>Orders</span>
				</a></li>

			</ul>

			<ul class="bottom">
				<li><a href="${pageContext.request.contextPath}/index"> <i
						class="fa fa-home icon"></i> <span>Home</span>
				</a></li>
				<li><a href="${pageContext.request.contextPath}/logout"><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></a></li>
				
			</ul>
		</div>
	</aside>

	<div class="main-container">
		<div class="header">
			<h1>Dashboard</h1>
			<img
				src="${pageContext.request.contextPath}/images/main_container/flower.svg"
				class="header-icon">
		</div>
		<div class="flex-containers">
			<div class="flex-container"
				style="color: #FFF8ED; background-color: #16319E;">
				<p>Total Earnings Today</p>
				<h1>${totalEarnings}</h1>
			</div>

			<div class="flex-container"
				style="border-color: #16319E; border-style: solid;">
				<p>Total Orders Today</p>
				<h1>${pendingOrdersCount}</h1>
			</div>
			<div class="flex-container"
				style="color: #000000; background-color: #F6C251;">
				<div class="stock-top">
					<p>Low Stock Items</p>
					<p style="text-decoration: underline;">View Stock</p>
				</div>
				<div class="stock-bottom">
					<h1>${lowStockCount}</h1>
					<img
						src="${pageContext.request.contextPath}/images/main_container/stock.svg"
						class="stock-icon">
				</div>
			</div>
		</div>


		<div class="active-order">
			<h2 style="color: #16319E; padding-top: 2rem;">Active Orders</h2>
			<table>
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Customer</th>
						<th>Items</th>
						<th>Amount</th>
						<th>Status</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${not empty pendingOrders}">
							<c:forEach var="order" items="${pendingOrders}">
								<tr>
									<td>#ORD-${order.orderId}</td>
									<td>${order.username}</td>
									<td>—</td>
									<td>Rs.<fmt:formatNumber value="${order.totalAmount}"
											minFractionDigits="2" maxFractionDigits="2" /></td>
									<td>
										<div class="status-action">
											<form
												action="${pageContext.request.contextPath}/ordermanagement"
												method="post" style="display: inline">
												<input type="hidden" name="action" value="complete">
												<input type="hidden" name="orderId" value="${order.orderId}">
												<button type="submit" class="cancel-btn"
													onclick="return confirm('Complete order #${order.orderId}?')">
													Complete</button>
											</form>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5"
									style="text-align: center; color: #aaa; padding: 20px;">
									No pending orders.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<c:if test="${totalPage > 1}">
				<div
					style="display: flex; justify-content: center; gap: 8px; margin-top: 20px;">
					<c:choose>
						<c:when test="${currentPage > 1}">
							<a
								href="${pageContext.request.contextPath}/dashboard?page=${currentPage - 1}"
								style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">
								&laquo; </a>
						</c:when>
						<c:otherwise>
							<span
								style="padding: 6px 12px; border: 2px solid #ccc; border-radius: 8px; color: #ccc; font-weight: 600;">&laquo;</span>
						</c:otherwise>
					</c:choose>

					<c:forEach begin="1" end="${totalPage}" var="i">
						<c:choose>
							<c:when test="${i == currentPage}">
								<span
									style="padding: 6px 12px; background: #16319E; color: #fff; border-radius: 8px; font-weight: 600;">${i}</span>
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath}/dashboard?page=${i}"
									style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${currentPage < totalPage}">
							<a
								href="${pageContext.request.contextPath}/dashboard?page=${currentPage + 1}"
								style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">
								&raquo; </a>
						</c:when>
						<c:otherwise>
							<span
								style="padding: 6px 12px; border: 2px solid #ccc; border-radius: 8px; color: #ccc; font-weight: 600;">&raquo;</span>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
	</div>
</body>

</html>
