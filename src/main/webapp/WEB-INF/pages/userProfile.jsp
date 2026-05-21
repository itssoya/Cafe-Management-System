<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Homepage.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/userProfile.css">
	<title>BeanBrew : Edit Profile</title>
</head>
<body>
	<nav>
        <div class="logo">
            <img src ="${pageContext.request.contextPath}/images/logo.svg">
        </div>
        <div class="links">
        	<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/aboutUs">About</a></li>
			<li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
			<li><a href="${pageContext.request.contextPath}/rating">Rating</a></li>
			<li><a href="${pageContext.request.contextPath}/contactUs">Contact Us</a></li>
        </div>
        <div class="nav-actions">

			<a class="cart-link" href="${pageContext.request.contextPath}/cart">
                <img src="${pageContext.request.contextPath}/images/cart.svg">
			</a>

			<div class="profile">

				<details class="profile-dropdown">
					<summary class="profile-trigger">

						<!-- DEFAULT AVATAR -->
						<c:if test="${empty sessionScope.loggedInUser}">
							<img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg" class="profile-avatar">
						</c:if>

						<!-- LOGGED IN AVATAR -->
						<c:if test="${not empty sessionScope.loggedInUser}">
							<img src="${pageContext.request.contextPath}/getimage?email=${sessionScope.loggedInUser.email}" class="profile-avatar">
						</c:if>

					</summary>

					<div class="profile-menu">

						<!-- NOT LOGGED IN -->
						<c:if test="${empty sessionScope.loggedInUser}">
							<a href="${pageContext.request.contextPath}/login">Login</a>
							<a href="${pageContext.request.contextPath}/signup">Get Started</a>
						</c:if>

						<!-- LOGGED IN -->
						<c:if test="${not empty sessionScope.loggedInUser}">
							<a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
							<a href="${pageContext.request.contextPath}/cart">Cart</a>

							<form action="${pageContext.request.contextPath}/logout" method="post">
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
				<h1 class="greeting-name">Hi ! User</h1>
			</header>

			<section class="profile-grid">
				<div class="overview-card profile-section-card">
					<div class="overview-header">
						<p class="eyebrow">Your Profile</p>
						<button class="action-button edit-toggle" aria-label="Edit profile">
							<img src="${pageContext.request.contextPath}/edit.svg" alt="Edit">
						</button>
					</div>
					<div class="overview-body">
						<div class="overview-left">
							<div class="picture-frame compact-picture">
								<img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg" alt="Profile avatar">
							</div>
							<label class="upload-button action-button secondary" for="profilePictureInput">Edit Profile Picture</label>
							<input type="file" id="profilePictureInput" name="profilePicture" accept="image/*" hidden>
						</div>
						<div class="overview-fields">
							<label class="compact-field">
								<span>Username</span>
								<input class="compact-input" type="text" name="username" value="SSDJJSl" disabled>
							</label>
							<label class="compact-field">
								<span>Email</span>
								<input class="compact-input" type="email" name="email" value="pDAS.paS@gmail.com" disabled>
							</label>
							<span class="status-chip verified">Verified</span>
						</div>
					</div>
					<div class="overview-footer">
						<button class="action-button secondary save-button" disabled>Save Changes</button>
					</div>
				</div>

				<div class="history-card profile-section-card">
					<div class="overview-header">
						<p class="eyebrow">Account History</p>
					</div>
					<div class="history-body">
						<div class="history-row"><span>Account Created At</span><strong>10th Dec , 2024</strong></div>
						<div class="history-row"><span>Total Orders so far</span><strong>110</strong></div>
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
								<th>Coffee Order</th>
								<th>Quantity</th>
								<th>Price</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>#1123</td>
								<td>Vanilla Latte</td>
								<td>2</td>
								<td>NPR 860</td>
								<td><span class="status-chip delivered">Delivered</span></td>
							</tr>
						</tbody>
					</table>
				</div>
			</section>
		</main>
	</div>

	<footer>
		<div class="footer-logo">
			<img src="${pageContext.request.contextPath}/images/bigBrew.svg" alt="Bean Brew logo">
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