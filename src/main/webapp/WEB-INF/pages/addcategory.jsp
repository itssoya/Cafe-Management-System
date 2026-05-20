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
<title>Add Category — BrewBar</title>
<style>

.page-blur-bg {
    position: fixed;
    inset: 0;
    filter: blur(3px) brightness(0.6);
    pointer-events: none;
    z-index: 0;
    overflow: hidden;
}

/* ================= NAVBAR ================= */

.NavBar {
    position: fixed;
    top: 0;
    left: 240px;
    right: 0;
    height: 60px;
    background: #FFF8ED;
    border-bottom: 1px solid #e2ddd8;
    display: flex;
    align-items: center;
    padding: 0 32px;
    z-index: 90;
    box-shadow: 0 1px 4px rgba(22,49,158,0.08);
}

.search-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    background: #f0ede8;
    border: 1.5px solid #e2ddd8;
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
}

/* ================= SIDEBAR ================= */

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
}

.category,
.bottom {
    list-style: none;
    padding: 0.5rem;
}

.category {
    flex: 1;
}

.category li a,
.bottom li {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 1.1rem;
    text-decoration: none;
    color: #16319E;
    transition: 0.2s;
}

.category li a:hover,
.bottom li:hover {
    background: #eef2ff;
}

.icon {
    width: 1.5rem;
    height: 1.5rem;
}

/* ================= MAIN ================= */

.stock-registry-container {
    margin-left: 230px;
    padding: 36px 32px 52px;
}

.pageHeader-left h1 {
    font-family: 'DM Serif Display', serif;
    font-size: 2rem;
    font-weight: 400;
}

.pageHeader-left p {
    color: #5c658f;
    font-size: 0.875rem;
    margin-top: 5px;
}

/* ================= MODAL ================= */

.modal-overlay {
    position: fixed;
    inset: 0;
    z-index: 10;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal {
    background: #FFF8ED;
    border-radius: 20px;
    padding: 40px 44px;
    width: 100%;
    max-width: 480px;
    box-shadow: 0 24px 60px rgba(0,0,0,0.18);
    text-align: center;
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
    margin-bottom: 6px;
}

.modal-subtitle {
    font-size: 0.875rem;
    color: #7b86b2;
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

/* ================= FORM ================= */

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

.form-group input[type="text"],
.form-group textarea {
    width: 100%;
    background: #f5f7ff;
    border: 1px solid #dbe2ff;
    border-radius: 10px;
    padding: 12px 14px;
    font-size: 0.9rem;
    outline: none;
}

.form-group input::placeholder,
.form-group textarea::placeholder {
    color: #9aa7d6;
}

.form-group textarea {
    height: 90px;
    resize: none;
}

/* ================= TOGGLE ================= */

.toggle-group {
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: #f5f7ff;
    border: 1px solid #dbe2ff;
    border-radius: 10px;
    padding: 12px 14px;
}

.toggle-label-text {
    color: #16319E;
    font-size: 0.9rem;
    font-weight: 500;
}

.toggle-switch {
    position: relative;
    width: 44px;
    height: 24px;
}

.toggle-switch input {
    opacity: 0;
    width: 0;
    height: 0;
}

.toggle-slider {
    position: absolute;
    inset: 0;
    background: #c7d2fe;
    border-radius: 24px;
    cursor: pointer;
}

.toggle-slider::before {
    content: "";
    position: absolute;
    width: 18px;
    height: 18px;
    left: 3px;
    top: 3px;
    background: white;
    border-radius: 50%;
    transition: transform 0.2s;
}

.toggle-switch input:checked + .toggle-slider {
    background: #16319E;
}

.toggle-switch input:checked + .toggle-slider::before {
    transform: translateX(20px);
}

/* ================= ACTIONS ================= */

.modal-actions {
    display: flex;
    justify-content: flex-end;
    gap: 14px;
    margin-top: 28px;
}

.btn-cancel {
    color: #16319E;
    text-decoration: none;
    padding: 10px 18px;
    border-radius: 10px;
}

.btn-cancel:hover {
    background: #eef2ff;
}

.btn-submit {
    background: #16319E;
    color: white;
    border: none;
    border-radius: 10px;
    padding: 12px 24px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-submit:hover {
    background: #0f2578;
}
</style>
</style>
</head>
<body>

    <!-- BLURRED BACKGROUND -->
    <div class="page-blur-bg">
        <div class="NavBar">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Search..." disabled>
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
					<li><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></li>
				</ul>
				</div>

		</aside>
            <div class="stock-registry-container">
                <div class="pageHeader">
                    <div class="pageHeader-left">
                        <h1>Menu</h1>
                        <p>Manage your menu categories.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL -->
    <div class="modal-overlay">
        <div class="modal">

            <div class="modal-icon">
                <i class="fa-solid fa-tag"></i>
            </div>

            <h2>Add New Category</h2>
            <p class="modal-subtitle">Organise your menu with a new category</p>

            <c:if test="${not empty error}">
                <div class="modal-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/addcategory" method="post">

                <!-- Category Name -->
                <div class="form-group">
                    <label for="categoryName">CATEGORY NAME</label>
                    <input type="text" id="categoryName" name="categoryName"
                           placeholder="e.g., Hot Drinks" value="${param.categoryName}">
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label for="categoryDescription">DESCRIPTION</label>
                    <textarea id="categoryDescription" name="categoryDescription"
                              placeholder="Brief description of this category...">${param.categoryDescription}</textarea>
                </div>

                <!-- Active Status toggle -->
                <div class="form-group">
                    <label>STATUS</label>
                    <div class="toggle-group">
                        <span class="toggle-label-text">Active on menu</span>
                        <label class="toggle-switch">
                            <input type="checkbox" name="activeStatus" value="true"
                                   ${param.activeStatus == 'true' ? 'checked' : 'checked'}>
                            <span class="toggle-slider"></span>
                        </label>
                    </div>
                </div>

                <!-- Actions -->
                <div class="modal-actions">
                    <a href="${pageContext.request.contextPath}/menumanagement" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fa-solid fa-check"></i> Add Category
                    </button>
                </div>

            </form>
        </div>
    </div>

</body>
</html>