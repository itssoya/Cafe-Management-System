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
<title>Recipe — BrewBar</title>
<style>
    body {
        background: #f5f0eb;
        padding: 40px 20px;
        font-family: 'Segoe UI', sans-serif;
        min-height: 100vh;
    }

    .wrapper {
        max-width: 700px;
        margin: 0 auto;
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #9a8478;
        font-size: 0.85rem;
        text-decoration: none;
        margin-bottom: 20px;
        transition: color 0.2s;
    }
    .back-link:hover { color: #3b2017; }

    .page-header { margin-bottom: 28px; }
    .page-header h1 {
        font-size: 1.6rem;
        font-weight: 700;
        color: #1e1208;
        margin: 0 0 4px;
    }
    .page-header p { color: #9a8478; font-size: 0.875rem; margin: 0; }

    /* Alerts */
    .alert {
        border-radius: 10px;
        padding: 12px 16px;
        font-size: 0.875rem;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .alert-error   { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
    .alert-success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }

    /* Cards */
    .card {
        background: #fff;
        border-radius: 16px;
        padding: 28px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.07);
        margin-bottom: 20px;
    }

    .card-title {
        font-size: 0.95rem;
        font-weight: 700;
        color: #1e1208;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    /* Search */
    .search-row { display: flex; gap: 10px; }
    .search-row input {
        flex: 1;
        background: #f5f0eb;
        border: none;
        border-radius: 10px;
        padding: 11px 14px;
        font-size: 0.9rem;
        color: #1e1208;
        outline: none;
    }
    .search-row input::placeholder { color: #b0a09a; }

    .btn-search {
        background: #3b2017;
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 11px 20px;
        font-size: 0.875rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        white-space: nowrap;
    }
    .btn-search:hover { background: #5a3020; }

    /* Search results */
    .result-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: #f5f0eb;
        border-radius: 10px;
        padding: 10px 14px;
        margin-top: 10px;
    }
    .result-name { font-size: 0.9rem; font-weight: 600; color: #1e1208; }
    .result-meta { font-size: 0.75rem; color: #9a8478; margin-top: 2px; }

    /* Add ingredient inline form */
    .add-form { display: flex; align-items: center; gap: 8px; }
    .add-form input[type="number"] {
        width: 80px;
        background: #fff;
        border: 1.5px solid #d4c8c0;
        border-radius: 8px;
        padding: 6px 10px;
        font-size: 0.875rem;
        color: #1e1208;
        outline: none;
        text-align: center;
    }
    .btn-add {
        background: #3b2017;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 7px 14px;
        font-size: 0.8rem;
        font-weight: 600;
        cursor: pointer;
        white-space: nowrap;
        transition: background 0.2s;
    }
    .btn-add:hover { background: #5a3020; }

    /* Ingredient list */
    .ingredient-row {
        display: flex;
        align-items: center;
        gap: 12px;
        background: #f5f0eb;
        border-radius: 10px;
        padding: 10px 14px;
        margin-bottom: 8px;
    }
    .ing-name { flex: 1; font-size: 0.9rem; font-weight: 600; color: #1e1208; }
    .ing-badge {
        font-size: 0.8rem;
        font-weight: 600;
        color: #3b2017;
        background: #f0e8e0;
        padding: 3px 10px;
        border-radius: 99px;
    }
    .ing-unit { font-size: 0.8rem; color: #9a8478; min-width: 30px; }

    .btn-remove {
        background: none;
        border: none;
        color: #e53935;
        cursor: pointer;
        font-size: 0.9rem;
        padding: 4px 6px;
        border-radius: 6px;
        transition: background 0.2s;
    }
    .btn-remove:hover { background: #fef2f2; }

    .empty-state {
        text-align: center;
        color: #b0a09a;
        font-size: 0.875rem;
        padding: 28px 0;
    }
    .empty-state i { font-size: 28px; display: block; margin-bottom: 8px; }

    .no-results {
        text-align: center;
        color: #9a8478;
        font-size: 0.875rem;
        padding: 12px 0;
    }

    /* Actions */
    .form-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #f0ebe5;
    }
    .btn-cancel {
        font-size: 0.9rem;
        color: #6b5c52;
        text-decoration: none;
        padding: 10px 18px;
        border-radius: 10px;
        border: 1px solid #e0d8d0;
        transition: background 0.2s;
    }
    .btn-cancel:hover { background: #f5f0eb; }

    .btn-save {
        background: #3b2017;
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 12px 28px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: background 0.2s;
    }
    .btn-save:hover { background: #5a3020; }

    .ing-count {
        font-size: 0.8rem;
        color: #9a8478;
        margin-left: auto;
        padding-right: 4px;
    }
</style>
</head>
<body>

<div class="wrapper">

    <a href="${pageContext.request.contextPath}/menumanagement" class="back-link">
        <i class="fa-solid fa-chevron-left"></i> Back to Menu
    </a>

    <div class="page-header">
        <h1>Recipe: ${menuItem.itemName}</h1>
        <p>Search stock ingredients and specify quantity needed per serving.</p>
    </div>

    <!-- Alerts -->
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

    <div class="card">
        <div class="card-title">
            <i class="fa-solid fa-magnifying-glass"></i> Search Ingredients
        </div>

        <form action="${pageContext.request.contextPath}/addrecipe" method="get">
            <input type="hidden" name="menuItemId" value="${menuItemId}">
            <div class="search-row">
                <input type="text" name="searchStock"
                       value="${searchStock}"
                       placeholder="e.g. Milk, Sugar, Lavender syrup...">
                <button type="submit" class="btn-search">
                    <i class="fa-solid fa-search"></i> Search
                </button>
            </div>
        </form>

        <c:if test="${not empty searchResults}">
            <c:forEach var="stock" items="${searchResults}">
                <div class="result-row">
                    <div>
                        <div class="result-name">${stock.name}</div>
                        <div class="result-meta">
                            Unit: ${stock.unit} &nbsp;|&nbsp;
                            In stock: <fmt:formatNumber value="${stock.quantityInStock}" maxFractionDigits="2"/>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/addrecipe"
                          method="post" class="add-form">
                        <input type="hidden" name="action"     value="addIngredient">
                        <input type="hidden" name="menuItemId" value="${menuItemId}">
                        <input type="hidden" name="stockId"    value="${stock.id}">
                        <input type="hidden" name="stockName"  value="${stock.name}">
                        <input type="hidden" name="unit"       value="${stock.unit}">
                        <input type="number" name="quantity"
                               placeholder="Qty" min="0.01" step="0.01" required>
                        <button type="submit" class="btn-add">
                            <i class="fa-solid fa-plus"></i> Add
                        </button>
                    </form>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${not empty searchStock && empty searchResults}">
            <p class="no-results">
                No stock items found for "<strong>${searchStock}</strong>". Try a different keyword.
            </p>
        </c:if>
    </div>

    <!-- RECIPE INGREDIENTS CARD -->
    <div class="card">
        <div class="card-title">
            <i class="fa-solid fa-list"></i> Recipe Ingredients
            <c:if test="${not empty ingredients}">
                <span class="ing-count">${ingredients.size()} item(s)</span>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty ingredients}">
                <c:forEach var="ing" items="${ingredients}">
                    <div class="ingredient-row">
                        <span class="ing-name">${ing.stockName}</span>
                        <span class="ing-badge">
                            <fmt:formatNumber value="${ing.quantityUsed}" maxFractionDigits="2"/>
                        </span>
                        <span class="ing-unit">${ing.unit}</span>
                        <form action="${pageContext.request.contextPath}/addrecipe"
                              method="post" style="display:inline">
                            <input type="hidden" name="action"     value="removeIngredient">
                            <input type="hidden" name="menuItemId" value="${menuItemId}">
                            <input type="hidden" name="stockId"    value="${ing.stockItemId}">
                            <button type="submit" class="btn-remove"
                                    title="Remove ${ing.stockName}">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fa-solid fa-bowl-food"></i>
                    No ingredients added yet. Search above to get started.
                </div>
            </c:otherwise>
        </c:choose>

        <form action="${pageContext.request.contextPath}/addrecipe" method="post">
            <input type="hidden" name="action"     value="saveRecipe">
            <input type="hidden" name="menuItemId" value="${menuItemId}">
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/menumanagement"
                   class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-save">
                    <i class="fa-solid fa-floppy-disk"></i> Save Recipe
                </button>
            </div>
        </form>
    </div>

</div>
</body>
</html>
