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
<title>Orders — BrewBar</title>
<style>
    /* Status badges */
    .badge {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        border-radius: 99px;
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.03em;
    }
    .badge-pending    { background: #fef9c3; color: #854d0e; }
    .badge-completed  { background: #f0fdf4; color: #15803d; }
    .badge-cancelled  { background: #fef2f2; color: #b91c1c; }

    /* Action buttons */
    .btn-complete {
        background: #1a5c35;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 6px 13px;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    .btn-complete:hover { background: #14532d; }

    .btn-cancel-order {
        background: #fef2f2;
        color: #b91c1c;
        border: 1px solid #fecaca;
        border-radius: 8px;
        padding: 6px 13px;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }
    .btn-cancel-order:hover { background: #fee2e2; }

    /* Order stats */
    .stat-card.stat-warning {
        background: #fef9c3;
        border: 1px solid #fde047;
    }
    .stat-card.stat-green {
        background: #f0fdf4;
        border: 1px solid #bbf7d0;
    }
    .stat-card.stat-red {
        background: #fef2f2;
        border: 1px solid #fecaca;
    }

    /* Filter row */
    .filter-row {
        display: flex;
        gap: 10px;
        margin-bottom: 16px;
        align-items: center;
        flex-wrap: wrap;
    }
    .filter-select {
        background: #f5f0eb;
        border: none;
        border-radius: 10px;
        padding: 9px 14px;
        font-size: 0.875rem;
        color: #1e1208;
        outline: none;
        cursor: pointer;
        appearance: none;
        padding-right: 32px;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%233b2017' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 12px center;
    }

    /* Table tweaks */
    .order-id {
        font-size: 0.8rem;
        font-weight: 700;
        color: #9a8478;
        font-family: monospace;
    }
    .customer-name { font-size: 0.9rem; font-weight: 600; color: #1e1208; }
    .order-date    { font-size: 0.8rem; color: #9a8478; }
    .order-amount  { font-size: 0.95rem; font-weight: 700; color: #3b2017; }

    .action-group { display: flex; gap: 6px; align-items: center; }

    /* Empty */
    .empty-orders {
        text-align: center;
        padding: 60px 20px;
        color: #9a8478;
    }
    .empty-orders i { font-size: 2.5rem; margin-bottom: 12px; display: block; color: #d4c8c0; }
</style>
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

        <nav class="sidebar-nav">
            <a href="#" class="nav-item">
                <span class="material-icons">dashboard</span> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/menumanagement" class="nav-item">
                <span class="material-icons">inventory_2</span> Inventory
            </a>
            <a href="${pageContext.request.contextPath}/ordermanagement" class="nav-item active">
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
                <h1>Orders</h1>
                <p>Track and manage customer orders</p>
            </div>
            <div class="topbar-right">
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/ordermanagement" method="get">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" name="search"
                               value="${search}"
                               placeholder="Search by customer or order ID...">
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
                <span class="stat-label">Total Orders</span>
                <span class="stat-value">${totalOrders}</span>
            </div>
            <div class="stat-card stat-warning">
                <span class="stat-label">Pending</span>
                <span class="stat-value">${pendingOrders}</span>
            </div>
            <div class="stat-card stat-green">
                <span class="stat-label">Completed</span>
                <span class="stat-value">${completedOrders}</span>
            </div>
            <div class="stat-card stat-red">
                <span class="stat-label">Cancelled</span>
                <span class="stat-value">${cancelledOrders}</span>
            </div>
        </div>

        <!-- FILTER ROW -->
        <div class="filter-row">
            <form action="${pageContext.request.contextPath}/ordermanagement" method="get"
                  style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                <input type="hidden" name="search" value="${search}">
                <select name="status" class="filter-select"
                        onchange="this.form.submit()">
                    <option value="">All Statuses</option>
                    <option value="PENDING"   ${param.status == 'PENDING'   ? 'selected' : ''}>Pending</option>
                    <option value="COMPLETED" ${param.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
            </form>
        </div>

        <!-- ORDERS TABLE -->
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>
                                        <span class="order-id">#${order.orderId}</span>
                                    </td>
                                    <td>
                                        <span class="customer-name">
                                            <c:choose>
                                                <c:when test="${not empty order.username}">
                                                    ${order.username}
                                                </c:when>
                                                <c:otherwise>Guest</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td>
                                        <span class="order-amount">
                                            $<fmt:formatNumber value="${order.totalAmount}"
                                                minFractionDigits="2" maxFractionDigits="2"/>
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge badge-pending">
                                                    <i class="fa-solid fa-clock"></i> Pending
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'COMPLETED'}">
                                                <span class="badge badge-completed">
                                                    <i class="fa-solid fa-check"></i> Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="badge badge-cancelled">
                                                    <i class="fa-solid fa-xmark"></i> Cancelled
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="order-date">${order.createdAt}</span>
                                    </td>
                                    <td>
                                        <div class="action-group">
                                            <c:if test="${order.status == 'PENDING'}">
                                                <!-- Complete -->
                                                <form action="${pageContext.request.contextPath}/ordermanagement"
                                                      method="post" style="display:inline"
                                                      onsubmit="return confirm('Mark order #${order.orderId} as completed?')">
                                                    <input type="hidden" name="action"  value="complete">
                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                    <button type="submit" class="btn-complete">
                                                        <i class="fa-solid fa-check"></i> Complete
                                                    </button>
                                                </form>
                                                <!-- Cancel -->
                                                <form action="${pageContext.request.contextPath}/ordermanagement"
                                                      method="post" style="display:inline"
                                                      onsubmit="return confirm('Cancel order #${order.orderId}?')">
                                                    <input type="hidden" name="action"  value="cancel">
                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                    <button type="submit" class="btn-cancel-order">
                                                        <i class="fa-solid fa-xmark"></i> Cancel
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${order.status != 'PENDING'}">
                                                <span style="font-size:0.78rem; color:#9a8478;">—</span>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6">
                                    <div class="empty-orders">
                                        <i class="fa-solid fa-receipt"></i>
                                        <p>No orders found.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- PAGINATION -->
            <c:if test="${totalPage > 1}">
                <div class="pagination">
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/ordermanagement?page=${currentPage - 1}&search=${search}&status=${param.status}"
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
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/ordermanagement?page=${i}&search=${search}&status=${param.status}"
                                   class="page-btn">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPage}">
                            <a href="${pageContext.request.contextPath}/ordermanagement?page=${currentPage + 1}&search=${search}&status=${param.status}"
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

</body>
</html>