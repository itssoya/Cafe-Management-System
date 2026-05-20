<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Ordermanagement.css">
<title>Orders — BrewBar</title>
</head>
<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="sidebar-content">
            <img src="${pageContext.request.contextPath}/images/main_container/logo.svg" class="main-icon">
            <h1>BrewBar</h1>

            <ul class="category">
                <li><a href="#">
                    <img src="${pageContext.request.contextPath}/images/panel/dashboard.svg" class="icon">
                    <span>Dashboard</span>
                </a></li>
                <li><a href="${pageContext.request.contextPath}/menumanagement">
                    <img src="${pageContext.request.contextPath}/images/panel/menu.svg" class="icon">
                    <span>Menu</span>
                </a></li>
                
                <li><a href="${pageContext.request.contextPath}/usermanagement">
                    <img src="${pageContext.request.contextPath}/images/panel/users.svg" class="icon">
                    <span>Users</span>
                </a></li>
                <li><a href="${pageContext.request.contextPath}/stockmanagement">
                    <img src="${pageContext.request.contextPath}/images/panel/inventory.svg" class="icon">
                    <span>Inventory</span>
                </a></li>
                <li ><a href="${pageContext.request.contextPath}/ordermanagement">
                    <img src="${pageContext.request.contextPath}/images/panel/order.svg" class="icon">
                    <span>Orders</span>
                </a></li>
            </ul>

            <ul class="bottom">
					<li><a href="${pageContext.request.contextPath}/logout"><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></a></li>
				</ul>
        </div>
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
                         <button type="submit">Search</button>
                    </form>
                </div>
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
                <select name="status" class="filter-select" onchange="this.form.submit()">
                    <option value="">All Status</option>
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
                                                <c:when test="${not empty order.username}">${order.username}</c:when>
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
                                                <form action="${pageContext.request.contextPath}/ordermanagement"
                                                      method="post" style="display:inline"
                                                      onsubmit="return confirm('Mark order #${order.orderId} as completed?')">
                                                    <input type="hidden" name="action"  value="complete">
                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                    <button type="submit" class="btn-complete">
                                                        <i class="fa-solid fa-check"></i> Complete
                                                    </button>
                                                </form>
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
                                                <span style="font-size:0.78rem; color:#7b86b2;">—</span>
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
                               class="page-btn"><i class="fa-solid fa-chevron-left"></i></a>
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
                               class="page-btn"><i class="fa-solid fa-chevron-right"></i></a>
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