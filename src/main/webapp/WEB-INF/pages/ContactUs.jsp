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
			<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/aboutus">About</a></li>
			<li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
			<li><a href="${pageContext.request.contextPath}/review">Rating</a></li>
			<li><a href="${pageContext.request.contextPath}/contactus">ContactUs</a></li>
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

						<!-- LOGGED IN AVATAR -->
						<c:if test="${not empty sessionScope.currentUser}">
							<c:choose>
								<c:when
									test="${not empty sessionScope.currentUser.profileImageURL}">
									<img
										src="${pageContext.request.contextPath}/uploads/user_img/${sessionScope.currentUser.profileImageURL}"
										class="profile-avatar">
								</c:when>
								<c:otherwise>
									<img
										src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg"
										class="profile-avatar">
								</c:otherwise>
							</c:choose>
						</c:if>

					</summary>

					<div class="profile-menu">

						<!-- NOT LOGGED IN -->
						<div class="profile-menu">

							<!-- NOT LOGGED IN -->
							<c:if test="${empty sessionScope.currentUser}">
								<a href="${pageContext.request.contextPath}/login">Login</a>
								<a href="${pageContext.request.contextPath}/signup">Get
									Started</a>
							</c:if>

							<!-- LOGGED IN -->
							<c:if test="${not empty sessionScope.currentUser}">
								<a href="${pageContext.request.contextPath}/userprofile">My Profile</a>
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