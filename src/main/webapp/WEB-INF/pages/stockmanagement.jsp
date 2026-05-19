<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stockManagement.css">

<title>Inventory — BrewBar</title>
</head>
<body>

	<div class="NavBar">
		<form action="${pageContext.request.contextPath}/stockmanagement" method="post">
			<input type="hidden" name="page" value="1">
			<input type="hidden" name="isbakery" value="${param.isbakery}">
			<div class="search-bar">
				<i class="fa-solid fa-magnifying-glass"></i>
				<input type="text" name="search" value="${search}" placeholder="Search inventory items...">
				<button type="submit">Search</button>
			</div>
		</form>
	</div>

	<div class="container">

		<!-- SIDEBAR -->
		<aside class="sidebar">
			
				<div class="sidebar-content">
					<img
						src="${pageContext.request.contextPath}/images/main_container/logo.svg"
						class="main-icon">
					<h1>BrewBar</h1>

					<ul class="category">
						<li><a href=""><img
							src="${pageContext.request.contextPath}/images/panel/dashboard.svg"
							class="icon"> <span>Dashboard</span></a></li>
						<li><a href="${pageContext.request.contextPath}/menumanagement"><img
							src="${pageContext.request.contextPath}/images/panel/menu.svg"
							class="icon"> <span>Menu</span></a></li>
						<li><a href="${pageContext.request.contextPath}/usermanagement"><img
							src="${pageContext.request.contextPath}/images/panel/users.svg"
							class="icon"> <span>Users</span></a></li>
						<li><a href="${pageContext.request.contextPath}/stockmanagement"><img
							src="${pageContext.request.contextPath}/images/panel/inventory.svg"
							class="icon"> <span>Inventory</span></a></li>
						<li><a
						href="${pageContext.request.contextPath}/ordermanagement"> <img
							src="${pageContext.request.contextPath}/images/panel/order.svg"
							class="icon"> <span>Orders</span>
					</a></li>
					</ul>

					<ul class="bottom">
					<li><a href="${pageContext.request.contextPath}/logout"><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></a></li>
				</ul>
				</div>
		</aside>

		<!-- MAIN CONTENT -->
		<div class="stock-registry-container">

			<!-- PAGE HEADER -->
			<div class="pageHeader">
				<div class="pageHeader-left">
					<h1>Inventory</h1>
					<p>Keep your artisan brews flowing with real-time stock tracking.</p>
				</div>
				<a href="${pageContext.request.contextPath}/stockmanagement?action=addstock" class="btn-add">
					<i class="fa-solid fa-plus"></i> Add Stock Item
				</a>
			</div>

			<!-- FLASH MESSAGES -->
			<c:if test="${not empty sessionScope.error}">
				<div class="alert alert-error">
					<i class="fa-solid fa-circle-exclamation"></i>
					${sessionScope.error}
				</div>
				<c:remove var="error" scope="session"/>
			</c:if>
			<c:if test="${not empty sessionScope.success}">
				<div class="alert alert-success">
					<i class="fa-solid fa-circle-check"></i>
					${sessionScope.success}
				</div>
				<c:remove var="success" scope="session"/>
			</c:if>

			<!-- STAT CARDS -->
			<div class="registryStats">
				<div class="stat-card">
					<span class="stat-label">Total Items</span>
					<span class="stat-data">${totalStock}</span>
				</div>
				<div class="stat-card">
					<span class="stat-label">Bakery Items</span>
					<span class="stat-data">${bakeryTotal}</span>
				</div>
				<div class="stat-card stat-alert">
					<span class="stat-label">Low Stock Alerts</span>
					<span class="stat-data">${lowStockItem}</span>
				</div>
			</div>

			<!-- FILTER -->
			<div class="filter">
				<form action="${pageContext.request.contextPath}/stockmanagement" method="post">
					<input type="hidden" name="page" value="1">
					<input type="hidden" name="search" value="${search}">
					<select name="isbakery" class="filter-select" onchange="this.form.submit()">
						<option value="">All Items</option>
						<option value="false" ${param.isbakery == 'false' ? 'selected' : ''}>Non-Bakery</option>
						<option value="true"  ${param.isbakery == 'true'  ? 'selected' : ''}>Bakery</option>
					</select>
				</form>
			</div>

			<!-- TABLE -->
			<table>
				<thead>
					<tr>
						<th>Item Name</th>
						<th>Quantity</th>
						<th>Min. Threshold</th>
						<th>Status</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty fetchStockUser}">
							<c:forEach var="item" items="${fetchStockUser}">
								<tr>

									<!-- Item Name -->
									<td>
										<div class="item-cell">
											<div class="item-icon">
												<i class="fa-solid fa-box"></i>
											</div>
											<div class="item-info">
												<span class="item-name">${item.name}</span>
											</div>
										</div>
									</td>

									<!-- Quantity -->
									<td>
										<c:choose>
											<c:when test="${item.quantityInStock <= item.lowStockThreshold}">
												<span class="qty-low">
													<fmt:formatNumber value="${item.quantityInStock}" maxFractionDigits="1"/> ${item.unit}
												</span>
											</c:when>
											<c:otherwise>
												<span class="qty-ok">
													<fmt:formatNumber value="${item.quantityInStock}" maxFractionDigits="1"/> ${item.unit}
												</span>
											</c:otherwise>
										</c:choose>
									</td>

									<!-- Min Threshold -->
									<td>
										<fmt:formatNumber value="${item.lowStockThreshold}" maxFractionDigits="1"/> ${item.unit}
									</td>

									<!-- Status Badge -->
									<td>
										<c:choose>
											<c:when test="${item.quantityInStock <= 0}">
												<span class="badge badge-out">Out of Stock</span>
											</c:when>
											<c:when test="${item.quantityInStock <= item.lowStockThreshold}">
												<span class="badge badge-low">Low Stock</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-in">In Stock</span>
											</c:otherwise>
										</c:choose>
									</td>

									<!-- Actions -->
									<td>
										<div class="action-btns">

											<a href="${pageContext.request.contextPath}/stockmanagement?action=edit&id=${item.id}"
											   class="btn-edit">
												<i class="fa-solid fa-pen"></i> Edit
											</a>

											<c:choose>
												<c:when test="${item.quantityInStock <= 0}">
													<a href="${pageContext.request.contextPath}/stockmanagement?action=restock&id=${item.id}"
													   class="btn-order">
														<i class="fa-solid fa-cart-shopping"></i> Order Now
													</a>
												</c:when>
												<c:when test="${item.quantityInStock <= item.lowStockThreshold}">
													<a href="${pageContext.request.contextPath}/stockmanagement?action=restock&id=${item.id}"
													   class="btn-restock-now">
														<i class="fa-solid fa-rotate-left"></i> Restock Now
													</a>
												</c:when>
												<c:otherwise>
													<a href="${pageContext.request.contextPath}/stockmanagement?action=restock&id=${item.id}"
													   class="btn-restock">
														Restock
													</a>
												</c:otherwise>
											</c:choose>

										</div>
									</td>

								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5" class="empty-state">
									<i class="fa-solid fa-box-open"></i>
									<p>No stock items found.</p>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>

			<!-- PAGINATION -->
			<c:if test="${totalPage > 0}">
				<div class="pagination">

					<c:choose>
						<c:when test="${currentPage > 1}">
							<a href="${pageContext.request.contextPath}/stockmanagement?page=${currentPage - 1}&search=${search}&isbakery=${param.isbakery}"
							   class="page-btn prev-btn">
								<i class="fa-solid fa-chevron-left"></i> Prev
							</a>
						</c:when>
						<c:otherwise>
							<span class="page-btn prev-btn disabled">
								<i class="fa-solid fa-chevron-left"></i> Prev
							</span>
						</c:otherwise>
					</c:choose>

					<c:forEach begin="1" end="${totalPage}" var="i">
						<c:choose>
							<c:when test="${i == currentPage}">
								<span class="page-btn page-number active">${i}</span>
							</c:when>
							<c:when test="${i == 1 || i == totalPage || (i >= currentPage - 2 && i <= currentPage + 2)}">
								<a href="${pageContext.request.contextPath}/stockmanagement?page=${i}&search=${search}&isbakery=${param.isbakery}"
								   class="page-btn page-number">${i}</a>
							</c:when>
							<c:when test="${i == currentPage - 3 || i == currentPage + 3}">
								<span class="page-ellipsis">...</span>
							</c:when>
						</c:choose>
					</c:forEach>

					<c:choose>
						<c:when test="${currentPage < totalPage}">
							<a href="${pageContext.request.contextPath}/stockmanagement?page=${currentPage + 1}&search=${search}&isbakery=${param.isbakery}"
							   class="page-btn next-btn">
								Next <i class="fa-solid fa-chevron-right"></i>
							</a>
						</c:when>
						<c:otherwise>
							<span class="page-btn next-btn disabled">
								Next <i class="fa-solid fa-chevron-right"></i>
							</span>
						</c:otherwise>
					</c:choose>

				</div>

				<div class="paginationInfo">Showing page ${currentPage} of ${totalPage}</div>
			</c:if>

			<c:if test="${totalPage == 0}">
				<div class="paginationInfo">No results found</div>
			</c:if>

		</div>

	</div>

</body>
</html>