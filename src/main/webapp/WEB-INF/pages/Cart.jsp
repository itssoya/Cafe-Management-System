<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.0/css/all.min.css" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
<title>Your Cart — BrewBar</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>
	<!-- NAVBAR -->
	<nav>
		<div class="logo">
			<img src="${pageContext.request.contextPath}/images/logo.svg">
		</div>
		<div class="links">
			<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/aboutUs">About</a></li>
			<li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
			<li><a href="${pageContext.request.contextPath}/rating">Rating</a></li>
			<li><a href="${pageContext.request.contextPath}/contactus">ContactUs</a></li>
		</div>
		<div class="nav-actions">

			<a class="cart-link" href="${pageContext.request.contextPath}/cart">
				<img src="${pageContext.request.contextPath}/images/cart.svg">
			</a>

			<div class="profile">

				<details class="profile-dropdown">
					<summary class="profile-trigger">

						<c:if test="${empty sessionScope.currentUser}">
							<img
								src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg"
								class="profile-avatar">
						</c:if>

						<!-- LOGGED IN AVATAR -->
						<c:if test="${not empty sessionScope.currentUser}">
							<c:choose>
								<c:when
									test="${not empty sessionScope.currentUser.profileImageURL}">
									<img
										src="${pageContext.request.contextPath}/uploads/user_img/${sessionScope.currentUser.profileImageURL}"
										class="profile-avatar">
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg"
										class="profile-avatar">
								</c:otherwise>
							</c:choose>
						</c:if>

					</summary>

					<div class="profile-menu">

						<!-- NOT LOGGED IN -->
						<div class="profile-menu">

							<!-- NOT LOGGED IN -->
							<c:if test="${empty sessionScope.currentUser}">
								<a href="${pageContext.request.contextPath}/login">Login</a>
								<a href="${pageContext.request.contextPath}/signup">Get
									Started</a>
							</c:if>

							<!-- LOGGED IN -->
							<c:if test="${not empty sessionScope.currentUser}">
								<a href="${pageContext.request.contextPath}/userprofile">My Profile</a>
								<form action="${pageContext.request.contextPath}/logout"
									method="post">
									<button type="submit">Logout</button>
								</form>
							</c:if>

						</div>
				</details>
			</div>

		</div>
	</nav>

<div class="page">

    <h1 class="page-title">Your Selection</h1>
    <p class="page-subtitle">Refine your morning ritual. Every roast is handled with care and delivered with the precision of a Modern Maitre D'.</p>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fa-solid fa-circle-check"></i> ${success}
        </div>
    </c:if>

    <div class="cart-grid">

        <!-- LEFT: CART ITEMS -->
        <div>
            <div class="section-header">
                <span class="section-label">Order Summary</span>
                <a href="${pageContext.request.contextPath}/menu" class="continue-link">
                    Continue shopping <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <div class="cart-items">
                <c:choose>
                    <c:when test="${not empty cart}">
                        <c:forEach var="item" items="${cart}">
                            <div class="cart-item">
                                <div class="item-img">
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/uploads/menu_items/${item.imageUrl}"
                                                 alt="${item.itemName}">
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-mug-hot"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="item-details">
                                    <div class="item-name">${item.itemName}</div>
                                    <div class="item-meta">
                                        Rs. <fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                        &nbsp;&times;&nbsp;${item.quantity}
                                    </div>
                                </div>
                                <div class="item-price">
                                    Rs. <fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/>
                                </div>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action"     value="removeFromCart">
                                    <input type="hidden" name="menuItemId" value="${item.menuItemId}">
                                    <button type="submit" class="btn-remove" title="Remove">
                                        <i class="fa-solid fa-xmark"></i>
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-cart">
                            <i class="fa-solid fa-mug-hot"></i>
                            <h3>Your cart is empty</h3>
                            <p>Looks like you haven't added anything yet.</p>
                            <a href="${pageContext.request.contextPath}/menu" class="btn-browse">
                                <i class="fa-solid fa-arrow-left"></i> Browse Menu
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <c:if test="${not empty cart}">
                <div class="cart-note">
                    <div class="note-label">
                        <i class="fa-regular fa-note-sticky"></i> Add a note for the barista
                    </div>
                    <textarea class="note-input"
                              placeholder="e.g. Extra hot, oat milk, less sugar..."></textarea>
                </div>
            </c:if>
        </div>

        <!-- RIGHT: CHECKOUT -->
        <div class="checkout-card">
            <div class="checkout-title">Checkout</div>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>$<fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>
            <div class="summary-row">
                <span>Estimated Tax (8%)</span>
                <span>Rs.<fmt:formatNumber value="${total * 0.08}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>
            <hr class="summary-divider">
            <div class="summary-total">
                <span>Total</span>
                <span>Rs.<fmt:formatNumber value="${total * 1.08}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>

            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="placeOrder">
                <button type="submit" class="btn-place-order"
                        ${empty cart ? 'disabled' : ''}>
                    <i class="fa-solid fa-check"></i> Place Order
                </button>
            </form>
  
        </div>

    </div>
</div>

<footer>
        <div class="footer-logo">
            <img src ="${pageContext.request.contextPath}/images/bigBrew.svg">
        </div>

        <div class="footer-columns">
            <div class="footer-col">
                <h3>Opening Hours</h3>
                <strong>Weekdays :</strong>
                <p>7:00 AM - 8:00 PM</p>
                <br>
                <strong>Weekends :</strong>
                <p>9:00 AM - 9:00 PM</p>
            </div>

            <div class="footer-col">
                <h3>Find Us At</h3>
                <strong>Instagram:</strong>
                <p>@beanbrew</p>
                <br>
                <strong>Facebook:</strong>
                <p>@beanbrewcoffee</p>
            </div>

            <div class="footer-col">
                <h3>Contact</h3>
                <strong>Phone:</strong>
                <p>+977 - 974 800 0000</p>
                <strong>Email:</strong>
                <p>beanbrewsales@gmail.com</p>
            </div>
        </div>

        <div class="footer-bottom">
            <span>@beanbrewcoffee , 2026</span>
        </div>
    </footer>

</body>
</html>