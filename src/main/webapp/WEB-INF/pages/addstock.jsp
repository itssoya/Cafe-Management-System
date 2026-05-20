<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stockManagement.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/addstock.css">
<title>Add Stock — BrewBar</title>
</head>
<body>

    <!-- BLURRED BACKGROUND (mirrors stockmanagement layout) -->
    <div class="page-blur-bg">
        <div class="NavBar">
		<form action="${pageContext.request.contextPath}/usermanagement"
			method="get">

			<input type="hidden" name="isVerified" value="${isVerified}">
			<input type="hidden" name="isAdmin" value="${isAdmin}">

			<div class="search-bar">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					name="search" value="${search}"
					placeholder="Search by username or email...">
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
						<li ><a href=""><img
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
					<li><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></li>
				</ul>
				</div>

		</aside>
            <div class="stock-registry-container">
                <div class="pageHeader">
                    <div class="pageHeader-left">
                        <h1>Inventory</h1>
                        <p>Keep your artisan brews flowing with real-time stock tracking.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL OVERLAY -->
    <div class="modal-overlay">
        <div class="modal">

            <!-- Icon -->
            <div class="modal-icon">
                <i class="fa-solid fa-box"></i>
            </div>

            <h2>Add New Stock Item</h2>
            <p class="modal-subtitle">Update your artisan pantry records</p>

            <!-- Error -->
            <c:if test="${not empty error}">
                <div class="modal-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/stockmanagement/addstock" method="post">

                <!-- Item Name -->
                <div class="form-group">
                    <label for="stockName">ITEM NAME</label>
                    <input type="text" id="stockName" name="stockName"
                           placeholder="e.g., Vanilla Syrup" value="${param.stockName}">
                </div>

                <!-- Quantity + Unit -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="quantity">INITIAL QUANTITY</label>
                        <div class="input-with-select">
                            <input type="number" id="quantity" name="quantity"
                                   placeholder="0" min="0" step="0.1" value="${param.quantity}">
                            <select name="unit">
                                <option value="kg"  ${param.unit == 'kg'  ? 'selected' : ''}>kg</option>
                                <option value="ltr" ${param.unit == 'ltr' ? 'selected' : ''}>ltr</option>
                                <option value="pcs" ${param.unit == 'pcs' ? 'selected' : ''}>pcs</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lowStockThreshold">MINIMUM THRESHOLD</label>
                        <input type="number" id="lowStockThreshold" name="lowStockThreshold"
                               placeholder="Low stock alert level" min="0" step="0.1"
                               value="${param.lowStockThreshold}">
                    </div>
                </div>

                <!-- Is Bakery -->
                <div class="form-group form-group--checkbox">
                    <label class="checkbox-label">
                        <input type="checkbox" name="isBakery" value="true"
                               ${param.isBakery == 'true' ? 'checked' : ''}>
                        <span>Bakery Item</span>
                    </label>
                </div>

                <!-- Actions -->
                <div class="modal-actions">
                    <a href="${pageContext.request.contextPath}/stockmanagement" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fa-solid fa-check"></i> Add to Inventory
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>