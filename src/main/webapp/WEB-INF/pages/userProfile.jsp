<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/Homepage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/userProfile.css">
<title>BeanBrew : Edit Profile</title>
</head>
<body>
	<nav>
		<div class="logo">
			<img src="${pageContext.request.contextPath}/images/logo.svg">
		</div>
		<div class="links">
			<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/aboutUs">About</a></li>
			<li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
			<li><a href="${pageContext.request.contextPath}/rating">Rating</a></li>
			<li><a href="${pageContext.request.contextPath}/contactUs">Contact
					Us</a></li>
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
						<c:if test="${not empty sessionScope.currentUser}">
							<img
								src="${pageContext.request.contextPath}/getimage?email=${sessionScope.currentUser.email}"
								class="profile-avatar">
						</c:if>
					</summary>
					<div class="profile-menu">
						<c:if test="${empty sessionScope.currentUser}">
							<a href="${pageContext.request.contextPath}/login">Login</a>
							<a href="${pageContext.request.contextPath}/signup">Get
								Started</a>
						</c:if>
						<c:if test="${not empty sessionScope.currentUser}">
							<a href="${pageContext.request.contextPath}/userprofile">Dashboard</a>
							<a href="${pageContext.request.contextPath}/cart">Cart</a>
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

	<div class="profile-layout">
		<main class="profile-content">

			<header class="profile-greeting">
				<p class="eyebrow">Account Overview</p>
				<h1 class="greeting-name">Hi, ${currentUser.username}!</h1>
			</header>

			<section class="profile-grid">
				<div class="overview-card profile-section-card">
					<div class="overview-header">
						<p class="eyebrow">Your Profile</p>
						<button class="action-button edit-toggle"
							aria-label="Edit profile">
							<img src="${pageContext.request.contextPath}/images/edit.svg"
								alt="Edit">
						</button>
					</div>

					<form action="${pageContext.request.contextPath}/userprofile"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="action" value="updateProfile">
						<input type="hidden" name="existingImageUrl"
							value="${currentUser.profileImageURL}">

						<div class="overview-body">
							<div class="overview-left">
								<div class="picture-frame compact-picture">
									<c:choose>
										<c:when test="${not empty currentUser.profileImageURL}">
											<img
												src="${pageContext.request.contextPath}/uploads/user_img/${currentUser.profileImageURL}"
												alt="Profile avatar">
										</c:when>
										<c:otherwise>
											<img
												src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg"
												alt="Profile avatar">
										</c:otherwise>
									</c:choose>
								</div>
								<label class="upload-button action-button secondary"
									for="profilePictureInput">Edit Profile Picture</label> <input
									type="file" id="profilePictureInput" name="profileImage"
									accept="image/*" hidden>
							</div>

							<div class="overview-fields">
								<label class="compact-field"> <span>Username</span> <input
									class="compact-input" type="text" name="username"
									value="${currentUser.username}" disabled>
								</label> <label class="compact-field"> <span>Email</span> <input
									class="compact-input" type="email" name="email"
									value="${currentUser.email}" disabled>
								</label>
								<c:choose>
									<c:when test="${currentUser.isVerified()}">
										<span class="status-chip verified">Verified</span>
									</c:when>
									<c:otherwise>
										<span class="status-chip">Unverified</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="overview-footer">
							<button class="action-button secondary save-button" type="submit"
								disabled>Save Changes</button>
						</div>
					</form>
				</div>

				<div class="history-card profile-section-card">
					<div class="overview-header">
						<p class="eyebrow">Account History</p>
					</div>
					<div class="history-body">
						<div class="history-row">
							<span>Account Created At</span> <strong>${currentUser.createdAt}</strong>
						</div>
						<div class="history-row">
							<span>Total Orders so far</span> <strong>${orders.size()}</strong>
						</div>
					</div>
				</div>
			</section>

			<section class="profile-section-card">
				<div class="section-heading">
					<div>
						<p class="eyebrow">Past Orders</p>
						<h2>Coffee Order History</h2>
					</div>
				</div>

				<div class="table-shell-light">
					<table class="orders-table-light">
						<thead>
							<tr>
								<th>Order #</th>
								<th>Amount</th>
								<th>Status</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty orders}">
									<c:forEach var="order" items="${orders}">
										<tr>
											<td>#${order.orderId}</td>
											<td>NPR <fmt:formatNumber value="${order.totalAmount}"
													minFractionDigits="2" maxFractionDigits="2" /></td>
											<td><c:choose>
													<c:when test="${order.status == 'COMPLETED'}">
														<span class="status-chip delivered">Completed</span>
													</c:when>
													<c:when test="${order.status == 'PENDING'}">
														<span class="status-chip">Pending</span>
													</c:when>
													<c:when test="${order.status == 'CANCELLED'}">
														<span class="status-chip">Cancelled</span>
													</c:when>
												</c:choose></td>
											<td>${order.createdAt}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4"
											style="text-align: center; color: #aaa; padding: 20px;">
											No orders yet.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

				<!-- PAGINATION -->
				<c:if test="${totalPage > 1}">
					<div
						style="display: flex; justify-content: center; gap: 8px; margin-top: 20px;">
						<c:choose>
							<c:when test="${currentPage > 1}">
								<a
									href="${pageContext.request.contextPath}/userprofile?page=${currentPage - 1}"
									style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">&laquo;</a>
							</c:when>
							<c:otherwise>
								<span
									style="padding: 6px 12px; border: 2px solid #ccc; border-radius: 8px; color: #ccc; font-weight: 600;">&laquo;</span>
							</c:otherwise>
						</c:choose>

						<c:forEach begin="1" end="${totalPage}" var="i">
							<c:choose>
								<c:when test="${i == currentPage}">
									<span
										style="padding: 6px 12px; background: #16319E; color: #fff; border-radius: 8px; font-weight: 600;">${i}</span>
								</c:when>
								<c:otherwise>
									<a
										href="${pageContext.request.contextPath}/userprofile?page=${i}"
										style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:choose>
							<c:when test="${currentPage < totalPage}">
								<a
									href="${pageContext.request.contextPath}/userprofile?page=${currentPage + 1}"
									style="padding: 6px 12px; border: 2px solid #16319E; border-radius: 8px; color: #16319E; text-decoration: none; font-weight: 600;">&raquo;</a>
							</c:when>
							<c:otherwise>
								<span
									style="padding: 6px 12px; border: 2px solid #ccc; border-radius: 8px; color: #ccc; font-weight: 600;">&raquo;</span>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
			</section>

		</main>
	</div>

	<footer>
		<div class="footer-logo">
			<img src="${pageContext.request.contextPath}/images/bigBrew.svg"
				alt="Bean Brew logo">
		</div>
		<div class="footer-columns">
			<div class="footer-col">
				<h3>Opening Hours</h3>
				<strong>Weekdays :</strong>
				<p>7:00 AM - 8:00 PM</p>
				<br> <strong>Weekends :</strong>
				<p>9:00 AM - 9:00 PM</p>
			</div>
			<div class="footer-col">
				<h3>Find Us At</h3>
				<strong>Instagram:</strong>
				<p>@beanbrew</p>
				<br> <strong>Facebook:</strong>
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
	<script>
    const editBtn   = document.querySelector('.edit-toggle');
    const inputs    = document.querySelectorAll('.compact-input');
    const saveBtn   = document.querySelector('.save-button');

    editBtn.addEventListener('click', function () {
        const isEditing = saveBtn.disabled;

        inputs.forEach(input => {
            input.disabled = !isEditing;
        });

        saveBtn.disabled = !isEditing;

        editBtn.title = isEditing ? 'Cancel edit' : 'Edit profile';
    });
</script>

</body>
</html>