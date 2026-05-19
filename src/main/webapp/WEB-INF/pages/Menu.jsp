<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeanBrew Coffee</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/landing.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    /* ── MENU SECTION ONLY — no changes to existing styles ── */

    .menu-section {
        background: #F7F1E8;
        padding: 60px 50px;
    }

    .menu-section-header {
        margin-bottom: 32px;
    }

    .menu-section-header h2 {
        font-size: 2rem;
        font-weight: 700;
        color: #1E34B7;
        margin-bottom: 6px;
    }

    .menu-section-header p {
        font-size: 0.95rem;
        color: #666;
    }

    /* ALERTS */
    .menu-alert {
        border-radius: 12px;
        padding: 12px 16px;
        font-size: 0.875rem;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .menu-alert.success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }
    .menu-alert.error   { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }

    /* CATEGORY TABS */
    .category-tabs {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
        margin-bottom: 32px;
    }

    .cat-tab {
        background: #fff;
        border: 2px solid #1E34B7;
        border-radius: 99px;
        padding: 7px 20px;
        font-family: 'Poppins', sans-serif;
        font-size: 0.82rem;
        font-weight: 600;
        color: #1E34B7;
        cursor: pointer;
        transition: background 0.2s, color 0.2s;
    }
    .cat-tab:hover  { background: #1E34B7; color: #fff; }
    .cat-tab.active { background: #1E34B7; color: #fff; }

    /* MENU GRID — 4 per row */
    .menu-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 22px;
    }

    /* MENU CARD */
    .menu-card {
        background: #fff;
        border-radius: 16px;
        overflow: hidden;
        border: 2px solid #e0daf0;
        display: flex;
        flex-direction: column;
        transition: transform 0.2s, box-shadow 0.2s;
    }
    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 14px 36px rgba(30, 52, 183, 0.13);
    }

    .card-img {
        width: 100%;
        height: 170px;
        object-fit: cover;
        display: block;
    }

    .card-img-placeholder {
        width: 100%;
        height: 170px;
        background: #eeeeff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.8rem;
        color: #1E34B7;
    }

    .card-body {
        padding: 14px 16px 8px;
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    .card-category {
        font-size: 0.68rem;
        font-weight: 700;
        letter-spacing: 0.08em;
        color: #1E34B7;
        text-transform: uppercase;
    }

    .card-name {
        font-size: 1rem;
        font-weight: 700;
        color: #1a1a2e;
        line-height: 1.3;
    }

    .card-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 16px 16px;
    }

    .card-price {
        font-size: 1.05rem;
        font-weight: 700;
        color: #1E34B7;
    }

    .btn-add-cart {
        background: #1E34B7;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 8px 16px;
        font-family: 'Poppins', sans-serif;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: background 0.2s;
    }
    .btn-add-cart:hover { background: #1428a0; }

    .btn-login-to-order {
        background: #eeeeff;
        color: #1E34B7;
        border: none;
        border-radius: 8px;
        padding: 8px 14px;
        font-family: 'Poppins', sans-serif;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        transition: background 0.2s, color 0.2s;
    }
    .btn-login-to-order:hover { background: #1E34B7; color: #fff; }

    /* EMPTY STATE */
    .empty-menu {
        grid-column: 1 / -1;
        text-align: center;
        padding: 60px 20px;
        color: #aaa;
    }
    .empty-menu i { font-size: 2.8rem; margin-bottom: 14px; display: block; color: #ddd; }

    /* PAGINATION */
    .menu-pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-top: 40px;
    }
    .pg-btn {
        background: #fff;
        border: 2px solid #1E34B7;
        border-radius: 8px;
        padding: 7px 14px;
        font-family: 'Poppins', sans-serif;
        font-size: 0.85rem;
        font-weight: 600;
        color: #1E34B7;
        text-decoration: none;
        transition: background 0.2s, color 0.2s;
    }
    .pg-btn:hover   { background: #1E34B7; color: #fff; }
    .pg-btn.active  { background: #1E34B7; color: #fff; }
    .pg-btn.disabled{ opacity: 0.4; pointer-events: none; }

    @media (max-width: 1100px) { .menu-grid { grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 768px)  { .menu-grid { grid-template-columns: repeat(2, 1fr); } .menu-section { padding: 40px 20px; } }
    @media (max-width: 480px)  { .menu-grid { grid-template-columns: 1fr; } }
</style>
</head>
<body>

	<nav>
     <div class="logo">
            <img src="images/logo.svg" alt="BeanBrew logo">
     </div>
        <div class="links">
            <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Menu</a></li>
            <li><a href="#">Rating</a></li>
        </div>
         <div class="profile">
            <button type="button" class="profilePage" onclick="toggleSidebar()">
                <main class="username">${username}</main>
            </button>
        </div>
	</nav>

	<!-- HERO SECTION — UNCHANGED -->
	<section class="hero-section">

		<!-- LEFT -->
		<div class="hero-left">

			<div class="flower">✿</div>

			<h1>
				What's <span>Brewing</span><br> Today ?
			</h1>

			<p>
				Check our variety of freshly brewed Coffee and a
				wide range of Bakery items from BrewBakes
			</p>

			<a href="#menu" class="menu-btn">View Menu</a>

			<div class="search-box">
				<form action="${pageContext.request.contextPath}/menu" method="get">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" name="search" value="${search}" placeholder="Find an item...">
                </form>
			</div>

		</div>

		<!-- RIGHT -->
		<div class="hero-right">

			<img
				src="images/menupage.png"
				alt="Coffee Machine">

		</div>

	</section>

	<!-- CHECKER — UNCHANGED -->
	<section class="checker">
		<br><br><br><br><br><br>
	</section>

	<!-- ── NEW: MENU SECTION ── -->
	<section class="menu-section" id="menu">

	    <div class="menu-section-header">
	        <h2>Our Menu</h2>
	        <p>Handcrafted with love — pick your favourite</p>
	    </div>

	    <!-- Alerts -->
	    <c:if test="${not empty success}">
	        <div class="menu-alert success">
	            <i class="fa-solid fa-circle-check"></i> ${success}
	        </div>
	    </c:if>
	    <c:if test="${not empty error}">
	        <div class="menu-alert error">
	            <i class="fa-solid fa-circle-exclamation"></i> ${error}
	        </div>
	    </c:if>

	    <!-- Category Filter Tabs -->
	    <div class="category-tabs">
	        <button class="cat-tab active" onclick="filterCategory(this, 'all')">
	            All Items
	        </button>
	        <c:forEach var="cat" items="${categories}">
	            <button class="cat-tab" onclick="filterCategory(this, '${cat.categoryName}')">
	                ${cat.categoryName}
	            </button>
	        </c:forEach>
	    </div>

	    <!-- Menu Grid -->
	    <div class="menu-grid" id="menuGrid">
	        <c:choose>
	            <c:when test="${not empty menuItems}">
	                <c:forEach var="item" items="${menuItems}">
	                    <div class="menu-card" data-category="${item.categoryName}">

	                        <!-- Image -->
	                        <c:choose>
	                            <c:when test="${not empty item.imageUrl}">
	                                <img class="card-img"
	                                     src="${pageContext.request.contextPath}/uploads/menu_items/${item.imageUrl}"
	                                     alt="${item.itemName}">
	                            </c:when>
	                            <c:otherwise>
	                                <div class="card-img-placeholder">
	                                    <i class="fa-solid fa-mug-hot"></i>
	                                </div>
	                            </c:otherwise>
	                        </c:choose>

	                        <!-- Body -->
	                        <div class="card-body">
	                            <span class="card-category">${item.categoryName}</span>
	                            <span class="card-name">${item.itemName}</span>
	                        </div>

	                        <!-- Footer -->
	                        <div class="card-footer">
	                            <span class="card-price">
	                                $<fmt:formatNumber value="${item.price}"
	                                    minFractionDigits="2" maxFractionDigits="2"/>
	                            </span>

	                            <c:choose>
	                                <c:when test="${not empty currentUser}">
	                                    <form action="${pageContext.request.contextPath}/cart"
	                                          method="post">
	                                        <input type="hidden" name="action"     value="addToCart">
	                                        <input type="hidden" name="menuItemId" value="${item.itemId}">
	                                        <input type="hidden" name="itemName"   value="${item.itemName}">
	                                        <input type="hidden" name="price"      value="${item.price}">
	                                        <input type="hidden" name="imageUrl"   value="${item.imageUrl}">
	                                        <input type="hidden" name="quantity"   value="1">
	                                        <button type="submit" class="btn-add-cart">
	                                            <i class="fa-solid fa-plus"></i> Add
	                                        </button>
	                                    </form>
	                                </c:when>
	                                <c:otherwise>
	                                    <a href="${pageContext.request.contextPath}/login"
	                                       class="btn-login-to-order">
	                                        <i class="fa-solid fa-lock"></i> Login
	                                    </a>
	                                </c:otherwise>
	                            </c:choose>
	                        </div>

	                    </div>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <div class="empty-menu">
	                    <i class="fa-solid fa-mug-hot"></i>
	                    <p>No items found. Try a different search.</p>
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>

	    <!-- Pagination -->
	    <c:if test="${totalPage > 1}">
	        <div class="menu-pagination">
	            <c:choose>
	                <c:when test="${currentPage > 1}">
	                    <a href="${pageContext.request.contextPath}/menu?page=${currentPage - 1}&search=${search}"
	                       class="pg-btn">
	                        <i class="fa-solid fa-chevron-left"></i>
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <span class="pg-btn disabled">
	                        <i class="fa-solid fa-chevron-left"></i>
	                    </span>
	                </c:otherwise>
	            </c:choose>

	            <c:forEach begin="1" end="${totalPage}" var="i">
	                <c:choose>
	                    <c:when test="${i == currentPage}">
	                        <span class="pg-btn active">${i}</span>
	                    </c:when>
	                    <c:otherwise>
	                        <a href="${pageContext.request.contextPath}/menu?page=${i}&search=${search}"
	                           class="pg-btn">${i}</a>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>

	            <c:choose>
	                <c:when test="${currentPage < totalPage}">
	                    <a href="${pageContext.request.contextPath}/menu?page=${currentPage + 1}&search=${search}"
	                       class="pg-btn">
	                        <i class="fa-solid fa-chevron-right"></i>
	                    </a>
	                </c:when>
	                <c:otherwise>
	                    <span class="pg-btn disabled">
	                        <i class="fa-solid fa-chevron-right"></i>
	                    </span>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </c:if>

	</section>

<script>
function filterCategory(btn, category) {
    document.querySelectorAll('.cat-tab').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.querySelectorAll('.menu-card').forEach(card => {
        if (category === 'all') {
            card.style.display = '';
        } else {
            const cardCat = card.getAttribute('data-category') || '';
            card.style.display =
                cardCat.toLowerCase() === category.toLowerCase() ? '' : 'none';
        }
    });
}
</script>

</body>
</html>
