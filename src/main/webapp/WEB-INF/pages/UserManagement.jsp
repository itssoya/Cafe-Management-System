<%@ page contentType="text/html;charset=UTF-8" language="java"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/UserManagement.css">

<title>Document</title>
</head>
<body>

	<div class="NavBar">
		<form action="${pageContext.request.contextPath}/usermanagement"
			method="get">

			<input type="hidden" name="isVerified" value="${isVerified}">
			<input type="hidden" name="isAdmin" value="${isAdmin}">

			<div class="search-bar">
				<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
					name="search" value="${search}"
					placeholder="Search by username or email..."></input>
				<button type="submit">Search</button>
			</div>
		</form>

	</div>

	<div class="container">
		<!-- SIDEBAR -->
		<aside class="sidebar">


			<div class="sidebar-content">
				<img
					src="${pageContext.request.contextPath}/images/main_container/logo.svg"
					class="main-icon">
				<h1>BrewBar</h1>

				<ul class="category">
					<li><a href=""><img
							src="${pageContext.request.contextPath}/images/panel/dashboard.svg"
							class="icon"> <span>Dashboard</span></a></li>
					<li><a
						href="${pageContext.request.contextPath}/menumanagement"><img
							src="${pageContext.request.contextPath}/images/panel/menu.svg"
							class="icon"> <span>Menu</span></a></li>
					<li><a href=""><img
							src="${pageContext.request.contextPath}/images/panel/users.svg"
							class="icon"> <span>Users</span></a></li>
					<li><a
						href="${pageContext.request.contextPath}/stockmanagement"><img
							src="${pageContext.request.contextPath}/images/panel/inventory.svg"
							class="icon"> <span>Inventory</span></a></li>
					<li><a
						href="${pageContext.request.contextPath}/ordermanagement"> <img
							src="${pageContext.request.contextPath}/images/panel/order.svg"
							class="icon"> <span>Orders</span>
					</a></li>
				</ul>

				<ul class="bottom">
					<li><a href="#"><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></a></li>
				</ul>
			</div>

		</aside>

		<div class="user-registry-container">

			<div class="pageHeader">
				<h1>User Management</h1>
			</div>
			<c:if test="${not empty sessionScope.success}">
				<div class="successMsg" id="successMsg">
					${sessionScope.success}</div>

				<c:remove var="success" scope="session" />
			</c:if>

			<c:if test="${not empty sessionScope.error}">
				<div class="errorMsg" id="errorMsg">${sessionScope.error}</div>

				<c:remove var="error" scope="session" />
			</c:if>
			<div class="registryStats">

				<div class="statTotalUser">
					<span class="totalUserLabel">Total Users</span> <span
						class="total-user-data">${totalUsers}</span>
				</div>

				<div class="stat-verified">
					<span class="verified-label">Verified Users</span> <span
						class="verified-data">${verifiedUser}</span>
				</div>

				<div class="stat-pending-percentage">
					<span class="pending-percentage-label">Pending Verification</span>
					<span class="pending-percentage-data">${pendingPercent} %</span>
				</div>

				<div class="stat-total-admin">
					<span class="total-admin-label">Staff Admins</span> <span
						class="total-admin-data">${totalAdmin}</span>
				</div>
			</div>

			<div class="filter">
				<form action="${pageContext.request.contextPath}/usermanagement"
					method="get">
					<input type="hidden" name="search" value="${search}"> <select
						name="isVerified" class="filter-select"
						onchange="this.form.submit()">
						<option value="">All Status</option>
						<option value="true"
							${filterVerified == 'true'  ? 'selected' : ''}>Verified</option>
						<option value="false"
							${filterVerified == 'false' ? 'selected' : ''}>Unverified</option>
					</select> <select name="isAdmin" class="filter-select"
						onchange="this.form.submit()">
						<option value="">All Roles</option>
						<option value="true" ${filterAdmin == 'true' ? 'selected' : ''}>Admin</option>
						<option value="false" ${filterAdmin == 'false' ? 'selected' : ''}>Member</option>
					</select>

				</form>
			</div>
			<div class="table-wrapper">
				<table>
					<thead>
						<tr>
							<th>User ID</th>
							<th>User</th>
							<th>Created Date</th>
							<th>Role</th>
							<th>Status</th>
							<th>Role Management</th>
							<th>Manage Status</th>


						</tr>
					</thead>

					<tbody>
						<c:forEach var="u" items="${Users}">
							<tr>
								<td><span class="user-id">${u.userId}</span></td>
								<td>
									<div class="profile">
										<div class="avatar">
											<i class="fa-solid fa-user"></i>
										</div>

										<div class="user-info">
											<span class="user-id">${u.username}</span> <span
												class="email">${u.email}</span>
										</div>
									</div>
								</td>

								<td><span class="created-at"> ${u.createdAt} </span></td>
								<td><span> <c:choose>
											<c:when test="${u.admin == false }">
											User
										</c:when>

											<c:when test="${u.admin == true }">
											Admin
										</c:when>
										</c:choose>
								</span></td>

								<td><span class="status"> <c:choose>
											<c:when test="${u.verified == false}">
												<form
													action="${pageContext.request.contextPath}/usermanagement"
													method="post">
													<input type="hidden" name="action" value="verify"></input>
													<input type="hidden" name="userId" value="${u.userId}"></input>
													<button class="verify-btn">Verify</button>
												</form>
											</c:when>

											<c:otherwise>
                                                verified
                                         </c:otherwise>
										</c:choose>
								</span></td>
								<td><span class="role"> <c:choose>
											<c:when test="${u.admin == false}">
												<form
													action="${pageContext.request.contextPath}/usermanagement"
													method="post">
													<input type="hidden" name="action" value="makeAdmin" /> <input
														type="hidden" name="userId" value="${u.userId}" />
													<button class="makeAdmin-btn">Make Admin</button>
												</form>
											</c:when>

											<c:when test="${u.admin == true}">
												<form
													action="${pageContext.request.contextPath}/usermanagement"
													method="post">
													<input type="hidden" name="action" value="removeAdmin" />
													<input type="hidden" name="userId" value="${u.userId}" />
													<button class="removeAdmin-btn">Remove Admin</button>
												</form>
											</c:when>
										</c:choose>
								</span></td>
								<td><span class="activeStatus"> <c:choose>
											<c:when test="${u.active == false }">
												<form
													action="${pageContext.request.contextPath}/usermanagement"
													method="post">
													<input type="hidden" name="action" value="makeActive" /> <input
														type="hidden" name="userId" value="${u.userId}" />
													<button class="activateUser-btn">Activate</button>
												</form>
											</c:when>

											<c:when test="${u.active == true }">
												<form
													action="${pageContext.request.contextPath }/usermanagement"
													method="post">
													<input type="hidden" name="action" value="removeActive" />
													<input type="hidden" name="userId" value="${u.userId}">
													<button class="deactivateUser-btn">Deactivate</button>
												</form>
											</c:when>
										</c:choose>
								</span></td>

							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
			<!-- Pagination -->
			<c:if test="${totalPages > 0}">
				<div class="pagination">

					<%-- Previous Button --%>
					<c:choose>
						<c:when test="${currentPage > 1}">
							<a
								href="${pageContext.request.contextPath}/usermanagement?page=${currentPage - 1}&search=${search}&isVerified=${filterVerified}&isAdmin=${filterAdmin}"
								class="page-btn prev-btn"> <i
								class="fa-solid fa-chevron-left"></i> Prev
							</a>
						</c:when>
						<c:otherwise>

							<span class="page-btn prev-btn disabled"> <i
								class="fa-solid fa-chevron-left"></i> Prev
							</span>
						</c:otherwise>
					</c:choose>


					<c:forEach begin="1" end="${totalPages}" var="i">
						<c:choose>

							<c:when test="${i == currentPage}">
								<span class="page-btn page-number active">${i}</span>
							</c:when>


							<c:when
								test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
								<a
									href="${pageContext.request.contextPath}/usermanagement?page=${i}&search=${search}&isVerified=${filterVerified}&isAdmin=${filterAdmin}"
									class="page-btn page-number"> ${i} </a>
							</c:when>


							<c:when test="${i == currentPage - 3 || i == currentPage + 3}">
								<span class="page-ellipsis">...</span>
							</c:when>
						</c:choose>
					</c:forEach>


					<c:choose>
						<c:when test="${currentPage < totalPages}">
							<a
								href="${pageContext.request.contextPath}/usermanagement?page=${currentPage + 1}&search=${search}&isVerified=${filterVerified}&isAdmin=${filterAdmin}"
								class="page-btn next-btn"> Next <i
								class="fa-solid fa-chevron-right"></i>
							</a>
						</c:when>
						<c:otherwise>

							<span class="page-btn next-btn disabled"> Next <i
								class="fa-solid fa-chevron-right"></i>
							</span>
						</c:otherwise>
					</c:choose>

				</div>


				<div class="paginationInfo">Showing page ${currentPage} of
					${totalPages}</div>
			</c:if>


			<c:if test="${totalPages == 0}">
				<div class="paginationInfo">No results found</div>
			</c:if>

		</div>

	</div>
</body>
</html>