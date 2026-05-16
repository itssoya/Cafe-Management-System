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
        max-width: 480px;
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
        margin: 0 0 24px;
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

    .form-group input[type="text"],
    .form-group textarea {
        width: 100%;
        background: #f5f0eb;
        border: none;
        border-radius: 10px;
        padding: 12px 14px;
        font-size: 0.9rem;
        color: #1e1208;
        outline: none;
        box-sizing: border-box;
    }

    .form-group input::placeholder,
    .form-group textarea::placeholder {
        color: #b0a09a;
    }

    .form-group textarea {
        height: 90px;
        resize: none;
    }

    /* ── Toggle switch ── */
    .toggle-group {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: #f5f0eb;
        border-radius: 10px;
        padding: 12px 14px;
    }

    .toggle-label-text {
        font-size: 0.9rem;
        color: #3b2017;
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
        background: #d4c8c0;
        border-radius: 24px;
        cursor: pointer;
        transition: background 0.2s;
    }

    .toggle-slider::before {
        content: "";
        position: absolute;
        width: 18px;
        height: 18px;
        left: 3px;
        top: 3px;
        background: #fff;
        border-radius: 50%;
        transition: transform 0.2s;
    }

    .toggle-switch input:checked + .toggle-slider {
        background: #3b2017;
    }

    .toggle-switch input:checked + .toggle-slider::before {
        transform: translateX(20px);
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
                <input type="text" placeholder="Search..." disabled>
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
                    <a href="${pageContext.request.contextPath}/menu" class="btn-cancel">
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