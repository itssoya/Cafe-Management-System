<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
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
		</div>
		<div class="profile">
			<button type="button" class="profilePage" onclick="toggleSidebar()">
				<main class="username">${username}</main>
			</button>
		</div>
	</nav>
	<div class="profile-layout">
		<aside class="profile-sidebar-left">
			<div class="sidebar-badge">Member Portal</div>
			<a class="sidebar-link" href="#">Edit Profile</a>
			<a class="sidebar-link active" href="#">Product History</a>
			<div class="sidebar-note">
				<p>Review what you ordered, how many cups you bought, and where every order stands.</p>
			</div>
		</aside>

		<main class="profile-content">
			<section class="profile-hero-card history-hero-card">
				<div>
					<p class="eyebrow">Order Summary</p>
					<h1>Product History</h1>
				</div>
				<div class="history-stats">
					<div class="stat-card-light">
						<span>Orders</span>
						<strong>12</strong>
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