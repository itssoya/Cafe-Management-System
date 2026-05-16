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
    .page-blur-bg {
        position: fixed;
        inset: 0;
        filter: blur(3px) brightness(0.6);
        pointer-events: none;
        z-index: 0;
        overflow: hidden;
    }

    .modal-overlay {
        position: fixed;
        inset: 0;
        z-index: 10;
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
        box-shadow: 0 24px 60px rgba(0,0,0,0.18);
        text-align: center;
    }

    .modal-icon {
        width: 56px;
        height: 56px;
        background: #f5f0eb;
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 18px;
        font-size: 22px;
        color: #3b2017;
    }

    .modal h2 {
        font-size: 1.4rem;
        font-weight: 700;
        color: #1e1208;
        margin: 0 0 6px;
    }

    .modal-subtitle {
        font-size: 0.875rem;
        color: #9a8478;
        margin: 0 0 8px;
    }

    .modal-item-name {
        font-size: 1rem;
        font-weight: 600;
        color: #3b2017;
        background: #f5f0eb;
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
        color: #6b5c52;
        margin-bottom: 6px;
    }

    .input-with-unit {
        display: flex;
        background: #f5f0eb;
        border-radius: 10px;
        overflow: hidden;
    }

    .input-with-unit input {
        flex: 1;
        background: transparent;
        border: none;
        padding: 12px 14px;
        font-size: 0.9rem;
        color: #1e1208;
        outline: none;
        min-width: 0;
    }

    .input-with-unit input::placeholder {
        color: #b0a09a;
    }

    .unit-badge {
        background: #e8e0d8;
        padding: 0 16px;
        font-size: 0.875rem;
        font-weight: 600;
        color: #3b2017;
        display: flex;
        align-items: center;
    }

    .current-stock-info {
        font-size: 0.8rem;
        color: #9a8478;
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
        color: #6b5c52;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 10px;
        transition: background 0.2s;
    }

    .btn-cancel:hover { background: #f5f0eb; }

    .btn-submit {
        background: #3b2017;
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

    .btn-submit:hover { background: #5a3020; }
</style>
</head>
<body>

    <!-- BLURRED BACKGROUND -->
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
                    <h1>BrewBar</h1>
                    <ul class="category">
                        <li><span class="material-icons">dashboard</span> Dashboard</li>
                        <li><span class="material-icons">menu_book</span> Menu</li>
                        <li><span class="material-icons">account_box</span> Users</li>
                        <li class="active"><span class="material-icons">inventory_2</span> Inventory</li>
                        <li class="logout"><span class="material-icons">logout</span> Logout</li>
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