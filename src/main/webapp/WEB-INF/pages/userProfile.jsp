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
			<a class="sidebar-link active" href="#">Edit Profile</a>
			<a class="sidebar-link" href="#">Product History</a>
			<div class="sidebar-note">
			</div>
		</aside>

		<main class="profile-content">


			<section class="profile-section-card">
				<div class="section-heading">
					<div>
						<p class="eyebrow">Profile Data</p>
						<h2 class="account-details-title">Account Details</h2>
					</div>
					<button type="button" class="action-button edit-toggle" aria-label="Edit profile (placeholder)">
						<img src="${pageContext.request.contextPath}/images/edit.svg" alt="Current profile picture placeholder">
					</button>
				</div>

				
				<form class="details-grid" action="/profile/update" method="post" enctype="multipart/form-data">
					<div class="detail-card profile-picture-card">
						<span>Profile Picture</span>
						<div class="picture-frame">
							<div class="picture-glow"></div>
							<img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg" alt="Current profile picture placeholder">
						</div>
						<label class="upload-button" for="profilePictureInput">
							Choose picture
						</label>
						<input type="file" id="profilePictureInput" name="profilePicture" accept="image/*" hidden>
					</div>
					<label class="detail-card">
						<span>Username</span>
						<input type="text" name="username" value="" placeholder="Assshaaa">
					</label>

					<label class="detail-card">
						<span>Email</span>
						<input type="email" name="email" value="" placeholder="Asssgaaa@gmail.com">
					</label>

					<div class="detail-card">
						<span>Account Status</span>
						<div class="status-static">
							<span class="status-chip verified">Verified</span>
						</div>
					</div>


					<div class="save-row form-save-row">
						<button type="submit" class="action-button primary">Save Profile</button>
					</div>
				</form>
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