<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
<title>Your Cart — BrewBar</title>
<style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
        --espresso:   #1e1208;
        --roast:      #3b2017;
        --caramel:    #c17f3a;
        --cream:      #f5f0eb;
        --latte:      #e8ddd4;
        --foam:       #faf7f4;
        --text-main:  #1e1208;
        --text-mid:   #6b5c52;
        --text-light: #9a8478;
        --border:     #e0d8d0;
        --success:    #15803d;
        --danger:     #b91c1c;
        --radius:     14px;
    }

    body {
        font-family: 'DM Sans', sans-serif;
        background: var(--cream);
        color: var(--text-main);
        min-height: 100vh;
    }

    /* NAV */
    nav{ 
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 9999;


    color: #16319E;
    background-color: #FFF0D8;
    padding: .75rem 3.75rem .75rem 3.75rem;
    display: flex;
    align-items: center;
    justify-content: space-between; 
}

nav>.links{ 
    display: flex;
    align-items: center;
    justify-content: space-between; 
    list-style-type: none;
    gap:4rem;
}
.links>li:hover{
    text-decoration: underline;
}
.links>li>a{
    text-decoration: none;
    color: #16319E;
}

.logo img{
    max-width: 20rem;
    height: auto;
}

.profile main{
    font-weight: 700;
}
.profile main::before{
    content: "Welcome,";
    font-weight: 500;
    margin-right: 0.5rem;
    font-size: 0.7em;
}
nav button{
    color: #16319E;
    background-color:#FFF0D8; 
    border-style: none;
    margin-top:0rem;
    padding: 0.5rem;
    border-radius: 0.2rem; 
}
nav button:hover , nav button:active{
    background-color: #ffe1b0;
}

    /* PAGE */
    .page {
        max-width: 1080px;
        margin: 0 auto;
        padding: 48px 24px;
    }

    .page-title {
        font-family: 'Playfair Display', serif;
        font-size: 2.2rem;
        font-weight: 700;
        color: var(--espresso);
        margin-bottom: 6px;
    }
    .page-subtitle {
        font-size: 0.875rem;
        color: var(--text-light);
        margin-bottom: 36px;
    }

    /* ALERT */
    .alert {
        border-radius: var(--radius);
        padding: 12px 16px;
        font-size: 0.875rem;
        margin-bottom: 24px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .alert-error   { background: #fef2f2; color: var(--danger); border: 1px solid #fecaca; }
    .alert-success { background: #f0fdf4; color: var(--success); border: 1px solid #bbf7d0; }

    /* GRID */
    .cart-grid {
        display: grid;
        grid-template-columns: 1fr 320px;
        gap: 24px;
        align-items: start;
    }

    /* SECTION HEADER */
    .section-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 14px;
    }
    .section-label {
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.08em;
        color: var(--text-light);
        text-transform: uppercase;
    }
    .continue-link {
        font-size: 0.8rem;
        color: var(--caramel);
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 4px;
        transition: gap 0.2s;
    }
    .continue-link:hover { gap: 8px; }

    /* CART ITEMS */
    .cart-items {
        background: var(--foam);
        border-radius: var(--radius);
        border: 1px solid var(--border);
        overflow: hidden;
    }

    .cart-item {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 16px 20px;
        border-bottom: 1px solid var(--latte);
        transition: background 0.15s;
    }
    .cart-item:last-child { border-bottom: none; }
    .cart-item:hover { background: var(--cream); }

    .item-img {
        width: 60px;
        height: 60px;
        border-radius: 10px;
        overflow: hidden;
        flex-shrink: 0;
        background: var(--latte);
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .item-img img { width: 100%; height: 100%; object-fit: cover; }
    .item-img i { color: var(--text-light); font-size: 1.3rem; }

    .item-details { flex: 1; min-width: 0; }
    .item-name {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--espresso);
        margin-bottom: 3px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .item-meta { font-size: 0.78rem; color: var(--text-light); }

    .item-price {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--roast);
        min-width: 60px;
        text-align: right;
    }

    .btn-remove {
        background: none;
        border: none;
        color: var(--text-light);
        cursor: pointer;
        font-size: 0.85rem;
        padding: 6px;
        border-radius: 6px;
        transition: color 0.2s, background 0.2s;
    }
    .btn-remove:hover { color: var(--danger); background: #fef2f2; }

    /* EMPTY STATE */
    .empty-cart {
        text-align: center;
        padding: 60px 20px;
    }
    .empty-cart i { font-size: 3rem; color: var(--latte); margin-bottom: 16px; display: block; }
    .empty-cart h3 {
        font-family: 'Playfair Display', serif;
        font-size: 1.2rem;
        color: var(--text-mid);
        margin-bottom: 8px;
    }
    .empty-cart p { font-size: 0.875rem; color: var(--text-light); margin-bottom: 20px; }
    .btn-browse {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: var(--roast);
        color: #fff;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 10px;
        font-size: 0.875rem;
        font-weight: 500;
        transition: background 0.2s;
    }
    .btn-browse:hover { background: var(--espresso); }

    /* NOTE */
    .cart-note {
        margin-top: 14px;
        background: var(--foam);
        border-radius: var(--radius);
        border: 1px solid var(--border);
        padding: 16px 20px;
    }
    .note-label {
        font-size: 0.78rem;
        color: var(--text-light);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .note-input {
        width: 100%;
        background: var(--cream);
        border: none;
        border-radius: 8px;
        padding: 10px 12px;
        font-size: 0.875rem;
        font-family: 'DM Sans', sans-serif;
        color: var(--text-main);
        resize: none;
        outline: none;
        height: 64px;
    }
    .note-input::placeholder { color: var(--text-light); }

    /* CHECKOUT CARD */
    .checkout-card {
        background: var(--foam);
        border-radius: var(--radius);
        border: 1px solid var(--border);
        padding: 22px;
        position: sticky;
        top: 76px;
    }
    .checkout-title {
        font-family: 'Playfair Display', serif;
        font-size: 1.1rem;
        font-weight: 700;
        color: var(--espresso);
        margin-bottom: 18px;
    }

    .summary-row {
        display: flex;
        justify-content: space-between;
        font-size: 0.875rem;
        color: var(--text-mid);
        margin-bottom: 10px;
    }
    .summary-divider { border: none; border-top: 1px solid var(--border); margin: 14px 0; }
    .summary-total {
        display: flex;
        justify-content: space-between;
        font-size: 1.05rem;
        font-weight: 700;
        color: var(--espresso);
        margin-bottom: 18px;
    }

    .btn-place-order {
        width: 100%;
        background: var(--roast);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 13px;
        font-family: 'DM Sans', sans-serif;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }
    .btn-place-order:hover { background: var(--espresso); }
    .btn-place-order:disabled {
        background: var(--latte);
        color: var(--text-light);
        cursor: not-allowed;
    }

    .order-note {
        font-size: 0.73rem;
        color: var(--text-light);
        text-align: center;
        margin-top: 10px;
        line-height: 1.5;
    }
    .order-note a { color: var(--caramel); text-decoration: none; }

    .payment-icons {
        display: flex;
        gap: 8px;
        justify-content: center;
        margin-top: 14px;
    }
    .payment-icons span {
        background: var(--latte);
        border-radius: 6px;
        padding: 4px 10px;
        font-size: 0.68rem;
        color: var(--text-mid);
        font-weight: 600;
        letter-spacing: 0.04em;
    }

    .eco-badge {
        margin-top: 14px;
        background: #f0fdf4;
        border: 1px solid #bbf7d0;
        border-radius: 10px;
        padding: 10px 12px;
        display: flex;
        align-items: flex-start;
        gap: 8px;
    }
    .eco-badge i { color: var(--success); margin-top: 2px; font-size: 0.85rem; flex-shrink: 0; }
    .eco-badge p { font-size: 0.73rem; color: #15803d; line-height: 1.5; }

    footer {
    background-color: #16319E;
    color: #FFF0D8;
    margin: 0;
    padding: 3rem 4rem 0rem 4rem;
}

.footer-logo {
    display: flex;
    justify-content: center;
    margin-bottom: 2.5rem;
}

.footer-logo img {
    max-width: 25rem;
    height: auto;
}
.footer-col{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.footer-columns {
    display: flex;
    justify-content: space-evenly;
    gap: 1.5rem;
    padding-bottom: 2.5rem;
}

.footer-col h3 {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 0.9rem;
    color: #FFF0D8;
}

.footer-col p {
    font-size: 0.9rem;
    font-weight: 300;
    line-height: 1.7;
    color: #d9e0ff;
}

.footer-bottom {
    border-top: 1px solid rgba(255, 240, 216, 0.25);
    text-align: center;
    padding: 1rem 0;
}

.footer-bottom span {
    font-size: 0.85rem;
    font-weight: 700;
    color: #FFF0D8;
    letter-spacing: 0.03em;
}

    @media (max-width: 768px) {
        .cart-grid { grid-template-columns: 1fr; }
        .checkout-card { position: static; }
        .page-title { font-size: 1.7rem; }
        .nav { padding: 0 20px; }
    }
</style>
</head>
<body>

	<nav>
        <div class="logo">
            <img src ="${pageContext.request.contextPath}/images/logo.svg">

        </div>
        <div class="links">
            <li><a href="#">Home</a></li>
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
                                        $<fmt:formatNumber value="${item.price}" minFractionDigits="2" maxFractionDigits="2"/>
                                        &nbsp;&times;&nbsp;${item.quantity}
                                    </div>
                                </div>
                                <div class="item-price">
                                    $<fmt:formatNumber value="${item.subtotal}" minFractionDigits="2" maxFractionDigits="2"/>
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
                <span>$<fmt:formatNumber value="${total * 0.08}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>
            <hr class="summary-divider">
            <div class="summary-total">
                <span>Total</span>
                <span>$<fmt:formatNumber value="${total * 1.08}" minFractionDigits="2" maxFractionDigits="2"/></span>
            </div>

            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="placeOrder">
                <button type="submit" class="btn-place-order"
                        ${empty cart ? 'disabled' : ''}>
                    <i class="fa-solid fa-check"></i> Place Order
                </button>
            </form>

            <p class="order-note">
                By placing your order you agree to our
                <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
            </p>    
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
