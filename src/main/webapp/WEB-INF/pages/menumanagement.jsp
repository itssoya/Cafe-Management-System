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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/menuManagement.css">
<title>Menu — BrewBar</title>
</head>
<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="sidebar-top">
            <div class="brand-avatar">B</div>
            <div class="brand-info">
                <span class="brand-name">BrewBar</span>
                <span class="brand-sub">Management Portal</span>
                
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/addmenu" class="btn-new-entry">
            <i class="fa-solid fa-plus"></i> New Entry
        </a>

        <nav class="sidebar-nav">
            <a href="#" class="nav-item">
                <span class="material-icons">dashboard</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/menumanagement" class="nav-item active">
                <span class="material-icons">inventory_2</span> Inventory
            </a>
            <a href="#" class="nav-item">
                <span class="material-icons">receipt_long</span> Orders
            </a>
            <a href="#" class="nav-item">
                <span class="material-icons">account_box</span> User Management
            </a>
            <a href="#" class="nav-item">
                <span class="material-icons">settings</span> Settings
            </a>
        </nav>

        <a href="#" class="nav-item logout">
            <span class="material-icons">logout</span> Logout
        </a>
    </aside>

    <!-- MAIN -->
    <div class="main">

        <!-- TOP BAR -->
        <div class="topbar">
            <div class="topbar-left">
                <h1>Artisan Roast</h1>
                <p>Menu &amp; Inventory Management</p>
            </div>
            <div class="topbar-right">
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/menumanagement" method="get">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" name="search" value="${search}" placeholder="Find an item...">
                    </form>
                </div>
                <button class="icon-btn"><i class="fa-regular fa-bell"></i></button>
                <button class="icon-btn"><i class="fa-regular fa-circle-user"></i></button>
            </div>
        </div>

        <!-- FLASH MESSAGES -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i> ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
            </div>
        </c:if>

        <!-- STAT CARDS -->
        <div class="stat-cards">
            <div class="stat-card">
                <span class="stat-label">Total Items</span>
                <span class="stat-value">${totalItems}</span>
            </div>
            <div class="stat-card stat-alert">
                <span class="stat-label">Low Stock</span>
                <span class="stat-value">${lowStock}</span>
            </div>
            <div class="stat-card stat-dark">
                <span class="stat-label">Most Popular</span>
                <span class="stat-value-lg">Lavender Latte</span>
            </div>
            <div class="stat-card stat-pink">
                <span class="stat-label">Today's Special</span>
                <span class="stat-value-lg">Maple Pecan</span>
            </div>
        </div>

        <!-- MANAGE CATEGORIES -->
        <div class="section-card">
            <div class="section-header">
                <div>
                    <h2>Manage Categories</h2>
                    <p>Organise your menu items into distinct groups for easier navigation.</p>
                </div>
                <a href="${pageContext.request.contextPath}/addcategory" class="btn-add-category">
                    <i class="fa-solid fa-plus"></i> Add Category
                </a>
            </div>
            <div class="category-chips">
                <c:forEach var="cat" items="${categories}">
                    <div class="category-chip">
                        <span>${cat.categoryName}</span>
                        <div class="chip-actions">
                            <button class="chip-btn"><i class="fa-solid fa-pen"></i></button>
                            <button class="chip-btn chip-btn-delete"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- CATEGORY FILTER TABS -->
        <div class="filter-tabs">
            <button class="tab active" onclick="filterTab(this, 'all')">All Items</button>
            <c:forEach var="cat" items="${categories}">
                <button class="tab" onclick="filterTab(this, '${cat.categoryName}')">
                    ${cat.categoryName}
                </button>
            </c:forEach>
        </div>

        <!-- MENU TABLE -->
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Item Detail</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty menuItems}">
                            <c:forEach var="item" items="${menuItems}">
                                <tr class="menu-row" data-category="${item.categoryName}">

                                    <!-- Item Detail -->
                                    <td>
                                        <div class="item-cell">
                                            <div class="item-img">
                                                <c:choose>
                                                    <c:when test="${not empty item.imageUrl}">
                                                        <img src="${pageContext.request.contextPath}/uploads/menu_items/${item.imageUrl}"
                                                             alt="${item.itemName}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="img-placeholder">
                                                            <i class="fa-solid fa-mug-hot"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="item-info">
                                                <span class="item-name">${item.itemName}</span>
                                                <span class="item-desc">${item.description}</span>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Category -->
                                    <td>
                                        <span class="cat-badge">${item.categoryName}</span>
                                    </td>

                                    <!-- Price -->
                                    <td>
                                        <span class="price">
                                            $<fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </span>
                                    </td>

                                    <!-- Actions -->
                                    <td>
                                        <div class="action-btns">
                                            <a href="${pageContext.request.contextPath}/menumanagement?action=editMenu&id=${item.itemId}"
                                               class="btn-edit">
                                                <i class="fa-solid fa-pen"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/addrecipe?menuItemId=${item.itemId}"
												   class="btn-recipe" title="Add Recipe">
												    <i class="fa-solid fa-book-open"></i>
												</a>
                                            <form action="${pageContext.request.contextPath}/menumanagement"
                                                  method="post" style="display:inline"
                                                  onsubmit="return confirm('Delete ${item.itemName}?')">
                                                <input type="hidden" name="action" value="deleteMenu">
                                                <input type="hidden" name="id" value="${item.itemId}">
                                                <button type="submit" class="btn-delete">
                                                    <i class="fa-solid fa-trash"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>

                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="4" class="empty-state">
                                    <i class="fa-solid fa-mug-hot"></i>
                                    <p>No menu items found.</p>
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
                            <a href="${pageContext.request.contextPath}/menumanagement?page=${currentPage - 1}&search=${search}"
                               class="page-btn">
                                <i class="fa-solid fa-chevron-left"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn disabled"><i class="fa-solid fa-chevron-left"></i></span>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach begin="1" end="${totalPage}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="page-btn active">${i}</span>
                            </c:when>
                            <c:when test="${i == 1 || i == totalPage || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                <a href="${pageContext.request.contextPath}/menumanagement?page=${i}&search=${search}"
                                   class="page-btn">${i}</a>
                            </c:when>
                            <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                <span class="page-ellipsis">...</span>
                            </c:when>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPage}">
                            <a href="${pageContext.request.contextPath}/menumanagement?page=${currentPage + 1}&search=${search}"
                               class="page-btn">
                                <i class="fa-solid fa-chevron-right"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn disabled"><i class="fa-solid fa-chevron-right"></i></span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="pagination-info">
                    Showing page ${currentPage} of ${totalPage}
                </div>
            </c:if>
        </div>

    </div>
</div>

<script>
    function filterTab(btn, category) {
        document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('.menu-row').forEach(row => {
            if (category === 'all') {
                row.style.display = '';
            } else {
                const rowCat = row.getAttribute('data-category') || '';
                row.style.display = rowCat.toLowerCase() === category.toLowerCase() ? '' : 'none';
            }
        });
    }
</script>

</body>
</html>