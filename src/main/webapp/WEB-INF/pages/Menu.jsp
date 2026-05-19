<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeanBrew Coffee</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/landing.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
    /* ── MENU SECTION ── */
    .menu-section {
        background: #F7F1E8;
        padding: 60px 50px;
    }
    .menu-section-header { margin-bottom: 32px; }
    .menu-section-header h2 {
        font-size: 2rem;
        font-weight: 700;
        color: #1E34B7;
        margin-bottom: 6px;
    }
    .menu-section-header p { font-size: 0.95rem; color: #666; }

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

    /* CART NAV BUTTON */
    .cart-nav-btn {
        background: #1E34B7;
        color: #fff;
        border-radius: 10px;
        padding: 8px 18px;
        font-size: 0.85rem;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: background 0.2s;
    }
    .cart-nav-btn:hover { background: #1428a0; }
    .cart-badge {
        background: #ff3b3b;
        color: #fff;
        border-radius: 99px;
        font-size: 0.65rem;
        font-weight: 700;
        padding: 1px 6px;
        min-width: 18px;
        text-align: center;
    }

    /* MENU GRID */
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
        text-decoration: none;
        color: inherit;
        cursor: pointer;
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
    .card-view {
        font-size: 0.78rem;
        font-weight: 600;
        color: #1E34B7;
        display: flex;
        align-items: center;
        gap: 4px;
    }

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

    /* ── MODAL (CSS :target) ── */
    .modal-overlay {
        display: none;
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.5);
        z-index: 1000;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
    .modal-overlay:target { display: flex; }

    .modal-box {
        background: #fff;
        border-radius: 24px;
        border: 2px solid #e0daf0;
        width: 100%;
        max-width: 780px;
        display: grid;
        grid-template-columns: 1fr 1fr;
        overflow: hidden;
        position: relative;
        max-height: 90vh;
    }

    .modal-close {
        position: absolute;
        top: 14px;
        right: 14px;
        width: 36px;
        height: 36px;
        background: #F7F1E8;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        color: #1a1a2e;
        font-size: 0.95rem;
        font-weight: 700;
        z-index: 10;
        border: 1.5px solid #e0daf0;
        transition: background 0.2s;
    }
    .modal-close:hover { background: #eeeeff; color: #1E34B7; }

    .modal-img-wrap {
        background: #eeeeff;
        min-height: 360px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }
    .modal-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        inset: 0;
    }
    .modal-img-placeholder {
        font-size: 4.5rem;
        color: #1E34B7;
        opacity: 0.25;
    }

    .modal-cat-badge {
        position: absolute;
        bottom: 16px;
        left: 16px;
        background: #fff;
        border-radius: 10px;
        padding: 7px 14px;
        font-size: 0.68rem;
        font-weight: 700;
        letter-spacing: 0.08em;
        color: #1E34B7;
        text-transform: uppercase;
        border: 1.5px solid #e0daf0;
        display: flex;
        align-items: center;
        gap: 7px;
        z-index: 2;
    }
    .modal-cat-dot {
        width: 22px;
        height: 22px;
        background: #1E34B7;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .modal-cat-dot i { font-size: 0.6rem; color: #fff; }

    .modal-details {
        padding: 40px 36px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        overflow-y: auto;
    }

    .modal-tag {
        display: inline-block;
        background: #e8fff0;
        color: #15803d;
        border: 1px solid #bbf7d0;
        border-radius: 99px;
        font-size: 0.68rem;
        font-weight: 700;
        letter-spacing: 0.08em;
        text-transform: uppercase;
        padding: 4px 12px;
        margin-bottom: 14px;
        width: fit-content;
    }

    .modal-name {
        font-size: 1.7rem;
        font-weight: 700;
        color: #1a1a2e;
        line-height: 1.2;
        margin-bottom: 12px;
    }

    .modal-desc {
        font-size: 0.875rem;
        color: #666;
        line-height: 1.7;
        margin-bottom: 20px;
    }

    .modal-price {
        font-size: 1.7rem;
        font-weight: 700;
        color: #1E34B7;
        margin-bottom: 24px;
    }

    .modal-qty-label {
        font-size: 0.72rem;
        font-weight: 600;
        color: #aaa;
        letter-spacing: 0.06em;
        text-transform: uppercase;
        margin-bottom: 8px;
    }

    .modal-qty-row { margin-bottom: 20px; }

    .modal-qty-controls {
        display: flex;
        align-items: center;
        background: #F7F1E8;
        border-radius: 10px;
        border: 2px solid #e0daf0;
        overflow: hidden;
        width: fit-content;
    }
    .modal-qty-btn {
        background: none;
        border: none;
        padding: 9px 18px;
        font-size: 1.1rem;
        font-weight: 700;
        color: #1E34B7;
        cursor: pointer;
        font-family: 'Poppins', sans-serif;
        transition: background 0.15s;
    }
    .modal-qty-btn:hover { background: #eeeeff; }
    .modal-qty-input {
        width: 48px;
        text-align: center;
        font-family: 'Poppins', sans-serif;
        font-size: 1rem;
        font-weight: 700;
        color: #1a1a2e;
        border: none;
        background: transparent;
        outline: none;
        -moz-appearance: textfield;
    }
    .modal-qty-input::-webkit-outer-spin-button,
    .modal-qty-input::-webkit-inner-spin-button { -webkit-appearance: none; }

    .btn-modal-add {
        width: 100%;
        background: #1a1a2e;
        color: #fff;
        border: none;
        border-radius: 12px;
        padding: 15px;
        font-family: 'Poppins', sans-serif;
        font-size: 0.95rem;
        font-weight: 700;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: background 0.2s;
    }
    .btn-modal-add:hover { background: #1E34B7; }

    .modal-login-prompt {
        background: #eeeeff;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
    }
    .modal-login-prompt p {
        font-size: 0.82rem;
        color: #666;
        margin-bottom: 10px;
    }
    .btn-modal-login {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: #1E34B7;
        color: #fff;
        text-decoration: none;
        border-radius: 8px;
        padding: 9px 20px;
        font-size: 0.82rem;
        font-weight: 600;
        transition: background 0.2s;
    }
    .btn-modal-login:hover { background: #1428a0; }

    @media (max-width: 1100px) { .menu-grid { grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 768px)  { .menu-grid { grid-template-columns: repeat(2, 1fr); } .menu-section { padding: 40px 20px; } }
    @media (max-width: 640px)  { .modal-box { grid-template-columns: 1fr; } .modal-img-wrap { min-height: 200px; } .modal-details { padding: 24px 20px; } }
    @media (max-width: 480px)  { .menu-grid { grid-template-columns: 1fr; } }
</style>
</head>
<body>

	<!-- NAV — your existing code + cart button added -->
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
        <div style="display:flex; align-items:center; gap:12px;">
            <a href="${pageContext.request.contextPath}/cart" class="cart-nav-btn">
                <i class="fa-solid fa-bag-shopping"></i> Cart
                <c:if test="${cartCount > 0}">
                    <span class="cart-badge">${cartCount}</span>
                </c:if>
            </a>
            <div class="profile">
                <button type="button" class="profilePage" onclick="toggleSidebar()">
                    <main class="username">${username}</main>
                </button>
            </div>
        </div>
	</nav>

	<!-- HERO SECTION — UNCHANGED -->
	<section class="hero-section">
		<div class="hero-left">
			<div class="flower">✿</div>
			<h1>What's <span>Brewing</span><br> Today ?</h1>
			<p>Check our variety of freshly brewed Coffee and a wide range of Bakery items from BrewBakes</p>
			<a href="#menu" class="menu-btn">View Menu</a>
			<div class="search-box">
				<form action="${pageContext.request.contextPath}/menu" method="get">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" name="search" value="${search}" placeholder="Find an item...">
                </form>
			</div>
		</div>
		<div class="hero-right">
			<img src="images/menupage.png" alt="Coffee Machine">
		</div>
	</section>

	<!-- CHECKER — UNCHANGED -->
	<section class="checker">
		<br><br><br><br><br><br>
	</section>

	<!-- MENU SECTION -->
	<section class="menu-section" id="menu">

	    <div class="menu-section-header">
	        <h2>Our Menu</h2>
	        <p>Handcrafted with love — pick your favourite</p>
	    </div>

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
	        <button class="cat-tab active" onclick="filterCategory(this, 'all')">All Items</button>
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

	                    <!-- CARD — links to modal -->
	                    <a href="#modal-${item.itemId}"
	                       class="menu-card" data-category="${item.categoryName}">

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

	                        <div class="card-body">
	                            <span class="card-category">${item.categoryName}</span>
	                            <span class="card-name">${item.itemName}</span>
	                        </div>

	                        <div class="card-footer">
	                            <span class="card-price">
	                                $<fmt:formatNumber value="${item.price}"
	                                    minFractionDigits="2" maxFractionDigits="2"/>
	                            </span>
	                            <span class="card-view">
	                                View <i class="fa-solid fa-arrow-right" style="font-size:0.7rem;"></i>
	                            </span>
	                        </div>

	                    </a>

	                    <!-- MODAL for this item -->
	                    <div class="modal-overlay" id="modal-${item.itemId}">
	                        <div class="modal-box">

	                            <a href="#" class="modal-close" title="Close">
	                                <i class="fa-solid fa-xmark"></i>
	                            </a>

	                            <!-- Left: image -->
	                            <div class="modal-img-wrap">
	                                <c:choose>
	                                    <c:when test="${not empty item.imageUrl}">
	                                        <img class="modal-img"
	                                             src="${pageContext.request.contextPath}/uploads/menu_items/${item.imageUrl}"
	                                             alt="${item.itemName}">
	                                    </c:when>
	                                    <c:otherwise>
	                                        <i class="fa-solid fa-mug-hot modal-img-placeholder"></i>
	                                    </c:otherwise>
	                                </c:choose>
	                                <div class="modal-cat-badge">
	                                    <div class="modal-cat-dot">
	                                        <i class="fa-solid fa-mug-hot"></i>
	                                    </div>
	                                    ${item.categoryName}
	                                </div>
	                            </div>

	                            <!-- Right: details -->
	                            <div class="modal-details">
	                                <span class="modal-tag">${item.categoryName}</span>
	                                <h2 class="modal-name">${item.itemName}</h2>
	                                <c:if test="${not empty item.description}">
	                                    <p class="modal-desc">${item.description}</p>
	                                </c:if>
	                                <div class="modal-price">
	                                    $<fmt:formatNumber value="${item.price}"
	                                        minFractionDigits="2" maxFractionDigits="2"/>
	                                </div>

	                                <c:choose>
	                                    <c:when test="${not empty currentUser}">
	                                        <form action="${pageContext.request.contextPath}/cart" method="post">
	                                            <input type="hidden" name="action"     value="addToCart">
	                                            <input type="hidden" name="menuItemId" value="${item.itemId}">
	                                            <input type="hidden" name="itemName"   value="${item.itemName}">
	                                            <input type="hidden" name="price"      value="${item.price}">
	                                            <input type="hidden" name="imageUrl"   value="${item.imageUrl}">

	                                            <div class="modal-qty-label">Quantity</div>
	                                            <div class="modal-qty-row">
	                                                <div class="modal-qty-controls">
	                                                    <button type="button" class="modal-qty-btn"
	                                                            onclick="changeQty('qty-${item.itemId}',-1)">−</button>
	                                                    <input type="number"
	                                                           id="qty-${item.itemId}"
	                                                           name="quantity"
	                                                           value="1" min="1"
	                                                           class="modal-qty-input">
	                                                    <button type="button" class="modal-qty-btn"
	                                                            onclick="changeQty('qty-${item.itemId}',1)">+</button>
	                                                </div>
	                                            </div>

	                                            <button type="submit" class="btn-modal-add">
	                                                <i class="fa-solid fa-cart-shopping"></i> Add to Cart
	                                            </button>
	                                        </form>
	                                    </c:when>
	                                    <c:otherwise>
	                                        <div class="modal-login-prompt">
	                                            <p>You need to be logged in to place an order.</p>
	                                            <a href="${pageContext.request.contextPath}/login"
	                                               class="btn-modal-login">
	                                                <i class="fa-solid fa-lock"></i> Login to Order
	                                            </a>
	                                        </div>
	                                    </c:otherwise>
	                                </c:choose>
	                            </div>

	                        </div>
	                    </div>
	                    <!-- END MODAL -->

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
	                       class="pg-btn"><i class="fa-solid fa-chevron-left"></i></a>
	                </c:when>
	                <c:otherwise>
	                    <span class="pg-btn disabled"><i class="fa-solid fa-chevron-left"></i></span>
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
	                       class="pg-btn"><i class="fa-solid fa-chevron-right"></i></a>
	                </c:when>
	                <c:otherwise>
	                    <span class="pg-btn disabled"><i class="fa-solid fa-chevron-right"></i></span>
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

function changeQty(id, delta) {
    const input = document.getElementById(id);
    const next = Math.max(1, (parseInt(input.value) || 1) + delta);
    input.value = next;
}
</script>

</body>
</html>
