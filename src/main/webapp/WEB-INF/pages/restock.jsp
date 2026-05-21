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
<title>Restock — BrewBar</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'DM Sans', sans-serif;
    background: #FFF8ED;
    color: #16319E;
}


.page-blur-bg {
    position: fixed;
    inset: 0;
    filter: blur(3px) brightness(0.6);
    pointer-events: none;
    z-index: 0;
    overflow: hidden;
}

.NavBar {
    position: fixed;
    top: 0;
    left: 240px;
    right: 0;
    height: 60px;
    background: #FFF8ED;
    border-bottom: 1px solid #dbe2ff;
    display: flex;
    align-items: center;
    padding: 0 32px;
    z-index: 90;
    box-shadow: 0 1px 4px rgba(22, 49, 158, 0.08);
}

.search-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    background: #f5f7ff;
    border: 1.5px solid #dbe2ff;
    border-radius: 8px;
    padding: 0 14px;
}

.search-bar:focus-within {
    background: white;
    border-color: #16319E;
}

.search-bar i,
.search-bar input::placeholder {
    color: #7b86b2;
}

.search-bar input {
    flex: 1;
    border: none;
    outline: none;
    background: transparent;
    padding: 10px 0;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.875rem;
}

.search-bar button {
    background: #16319E;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 6px 14px;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.8rem;
    font-weight: 600;
    cursor: pointer;
    transition: 0.2s;
}

.search-bar button:hover {
    background: #0f2578;
}


.container {
    display: flex;
    min-height: 100vh;
}


.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    width: 240px;
    background: #FFF8ED;
    border-right: 1px solid #16319E;
    color: #16319E;
    display: flex;
    flex-direction: column;
    z-index: 100;
}

.sidebar-content {
    display: flex;
    flex-direction: column;
    height: 100%;
}

.main-icon {
    width: 10rem;
    padding-left: 1.5rem;
    padding-top: 1rem;
}

.sidebar-content h1 {
    font-family: 'DM Sans', sans-serif;
    font-size: 2.5rem;
    padding-left: 1.5rem;
    padding-top: 0.25rem;
    line-height: 1;
    color: #16319E;
}

.category,
.bottom {
    list-style: none;
    padding: 0.5rem;
}

.category {
    flex: 1;
}

.category li,
.bottom li {
    margin-bottom: 0.3rem;
}

.category li a,
.bottom li a {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 1.05rem;
    text-decoration: none;
    color: #16319E;
    transition: 0.2s ease;
    font-weight: 500;
}

.category li a:hover,
.bottom li a:hover {
    background: #eef2ff;
}

.icon {
    width: 1.5rem;
    height: 1.5rem;
}


.stock-registry-container {
    margin-left: 240px;
    padding: 100px 40px 40px;
    width: 100%;
}

.pageHeader {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.pageHeader-left h1 {
    font-size: 2rem;
    font-weight: 700;
    color: #16319E;
    margin-bottom: 8px;
}

.pageHeader-left p {
    font-size: 0.95rem;
    color: #6b7ac7;
}

/* ================= MODAL ================= */

.modal-overlay {
    position: fixed;
    inset: 0;
    z-index: 999;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal {
    background: #fff;
    border-radius: 20px;
    padding: 40px 44px;
    width: 100%;
    max-width: 420px;
    box-shadow: 0 24px 60px rgba(0, 0, 0, 0.18);
    text-align: center;
    z-index: 1000;
}


.modal-icon {
    width: 56px;
    height: 56px;
    background: #eef2ff;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 18px;
    font-size: 22px;
    color: #16319E;
}

.modal h2 {
    font-size: 1.4rem;
    font-weight: 700;
    color: #16319E;
    margin: 0 0 6px;
}

.modal-subtitle {
    font-size: 0.875rem;
    color: #6b7ac7;
    margin: 0 0 8px;
}

.modal-item-name {
    font-size: 1rem;
    font-weight: 600;
    color: #16319E;
    background: #eef2ff;
    border-radius: 8px;
    padding: 6px 14px;
    display: inline-block;
    margin-bottom: 24px;
}


.modal-alert {
    background: #fef2f2;
    color: #b91c1c;
    border: 1px solid #fecaca;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 0.875rem;
    text-align: left;
    margin-bottom: 18px;
}


.form-group {
    text-align: left;
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-size: 0.7rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    color: #16319E;
    margin-bottom: 6px;
}

.input-with-unit {
    display: flex;
    background: #f5f7ff;
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #dbe2ff;
}

.input-with-unit input {
    flex: 1;
    background: transparent;
    border: none;
    padding: 12px 14px;
    font-size: 0.9rem;
    color: #16319E;
    outline: none;
    min-width: 0;
    font-family: 'DM Sans', sans-serif;
}

.input-with-unit input::placeholder {
    color: #9aa7d6;
}

.unit-badge {
    background: #dbe2ff;
    padding: 0 16px;
    font-size: 0.875rem;
    font-weight: 600;
    color: #16319E;
    display: flex;
    align-items: center;
}

.current-stock-info {
    font-size: 0.8rem;
    color: #6b7ac7;
    margin-top: 6px;
}

.modal-actions {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 14px;
    margin-top: 28px;
}

.btn-cancel {
    font-size: 0.9rem;
    color: #16319E;
    text-decoration: none;
    padding: 10px 18px;
    border-radius: 10px;
    transition: background 0.2s;
}

.btn-cancel:hover {
    background: #eef2ff;
}

.btn-submit {
    background: #16319E;
    color: #fff;
    border: none;
    border-radius: 10px;
    padding: 12px 24px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #0f2578;
}

@media (max-width: 768px) {

    .sidebar {
        width: 80px;
    }

    .sidebar-content h1,
    .category li a span,
    .bottom li a span {
        display: none;
    }

    .NavBar {
        left: 80px;
    }

    .stock-registry-container {
        margin-left: 80px;
        padding: 90px 20px 20px;
    }

    .category li a,
    .bottom li a {
        justify-content: center;
        gap: 0;
    }

    .modal {
        margin: 20px;
        padding: 32px 24px;
    }
}
</style>
</head>
<body>

    <div class="page-blur-bg">
        <div class="NavBar">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Search inventory items..." disabled>
                <button disabled>Search</button>
            </div>
        </div>
        <div class="container">
            <aside class="sidebar">
                <div class="sidebar-content">
					<img
						src="${pageContext.request.contextPath}/images/main_container/logo.svg"
						class="main-icon">
					<h1>BrewBar</h1>

					<ul class="category">
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/dashboard.svg"
							class="icon"> <span>Dashboard</span></a></li>
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/menu.svg"
							class="icon"> <span>Menu</span></a></li>
						<li ><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/users.svg"
							class="icon"> <span>Users</span></a></li>
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/inventory.svg"
							class="icon"> <span>Inventory</span></a></li>
						<li><a
						href="#"> <img
							src="${pageContext.request.contextPath}/images/panel/order.svg"
							class="icon"> <span>Orders</span>
					</a></li>
					</ul>

					<ul class="bottom">
					<li><a href="#">
            <img
                src="${pageContext.request.contextPath}/images/panel/logout.svg"
                class="icon">
            <span>Logout</span>
        </a>
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

    <!-- MODAL -->
    <div class="modal-overlay">
        <div class="modal">

            <div class="modal-icon">
                <i class="fa-solid fa-rotate-left"></i>
            </div>

            <h2>Restock Item</h2>
            <p class="modal-subtitle">Adding stock for</p>
            <span class="modal-item-name">${stockItem.name}</span>

            <c:if test="${not empty error}">
                <div class="modal-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/stockmanagement/restockitem" method="post">

                <!-- Pass the item ID through -->
                <input type="hidden" name="stockId" value="${stockItem.id}">

                <div class="form-group">
                    <label>QUANTITY TO ADD</label>
                    <div class="input-with-unit">
                        <input type="number" name="newQuantity"
                               placeholder="0" min="0.1" step="0.1"
                               value="${param.newQuantity}" autofocus>
                        <span class="unit-badge">${stockItem.unit}</span>
                    </div>
                    <p class="current-stock-info">
                        Current stock:
                        <strong>${stockItem.quantityInStock} ${stockItem.unit}</strong>
                    </p>
                </div>

                <div class="modal-actions">
                    <a href="${pageContext.request.contextPath}/stockmanagement" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fa-solid fa-rotate-left"></i> Restock
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>