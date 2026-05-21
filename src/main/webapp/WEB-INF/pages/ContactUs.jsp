<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title> Contact Us </title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ContactUs.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
    </head>
    <body>
			<!-- NAVBAR -->
		<nav>
			<div class="logo">
				<img src="${pageContext.request.contextPath}/images/logo.svg">

			</div>
			<div class="links">
				<li><a href="#">Home</a></li>
				<li><a href="#">About</a></li>
				<li><a href="${pageContext.request.contextPath}/menu">Menu</a>
				<li><a href="#">Rating</a></li>
			</div>
			<div class="profile">
				<button type="button" class="profilePage" onclick="toggleSidebar()">
					<main class="username">${username}</main>
				</button>
			</div>
		</nav>

		<!-- Sidebar -->
		<div id="sidebar" class="sidebar">
			<div class="sidebar-content">
				<!-- Logged Out View -->
				<div id="loggedOutView">
					<div class="guest-header">
						<img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg">
						<h2>Welcome ${username}</h2>
					</div>
					<div class="auth-buttons">
						<button onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
						<button onclick="window.location.href='${pageContext.request.contextPath}/signup'">Sign Up</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class = "contact">
		<h2>Connect With BeanBrew !</h2>

			<div class="card">

	<form action="${pageContext.request.contextPath}/ContactUsServlet" method="post">

		<div class="form-inputs">

			<div class="form-input">
				<label>First Name</label>
				<input type="text" name="firstName" placeholder="First Name" />
			</div>

			<div class="form-input">
				<label>Last Name</label>
				<input type="text" name="lastName" placeholder="Last Name" />
			</div>

		</div>

		<div class="form-input">
			<label>Email</label>
			<input type="text" name="email"
				placeholder="coffeeelover@gmail.com" />
		</div>

		<div class="form-input">
			<label>Phone Number</label>
			<input type="text" name="phoneNumber"
				placeholder="+977 9876543210" />
		</div>

		<div class="form-input">
			<label>Message</label>
			<textarea name="message"
				placeholder="Leave your message here..."></textarea>
		</div>

		<button type="submit">Send Message</button>

		<p class="back">Back to<a href="${pageContext.request.contextPath}/index.jsp">Home</a> →
		</p>

	</form>
</div><br><br>
		</div>
		
		
			<!-- footer -->
		<footer>
			<div class="footer-logo">
				<img src="${pageContext.request.contextPath}/images/bigBrew.svg">
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
		<script src="${pageContext.request.contextPath}/javascript/main.js"></script>
		</body>

		</html>