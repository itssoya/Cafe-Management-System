<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored = "false"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/AboutUs.css">
	<title>About Us</title>  
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

	<!-- Hero Section -->
	<section class="hero">
		<div class="imageframe">
			<img src ="${pageContext.request.contextPath}/images/gallery/Cafe_Bg.png">
		</div>
			<img src ="${pageContext.request.contextPath}/images/gallery/image_title.svg" class = "image-title">
	</section>

	<section class="intro">
		<p>At BeanBrew, we don’t just serve coffee—we celebrate it. As one of Nepal’s leading specialty coffee bars, we’re dedicated to redefining how coffee is experienced. Bean-Brew is a space where passion meets precision—where every sip tells a story of origin, quality, and care. Come explore what coffee can truly be.</p><br><br>
	</section>

	<section class="checker">
		<br><br><br><br><br><br><br>
	</section>
	
	<section class="team-intro">
		<h1>Meet the Team</h1><br><br>
		<p>We’re a team of passionate creatives committed to bringing ideas to life through coffee, design, and experience. With a shared love for quality and craft, we work together to build spaces that feel thoughtful, welcoming, and uniquely BeanBrew.</p><br>
	</section>
	
	<div class="team">
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/sourav.jpg">	
			</div>
			<h2>Sourav Yadav</h2>
			<p>Project Manager</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/palden.jpg">	
			</div>
			<h2>Palden Lama</h2>
			<p>Backend Developer</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/siddharth.png">	
			</div>
			<h2>Siddhartha Thapa</h2>
			<p>System Tester</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/shaleen.jpg">
			</div>
			<h2>Shaleen Thapa</h2>
			<p>UI/UX Designer</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">
			</div>
			<h2>Suhana Shrestha</h2>
			<p>Frontend Developer</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/roshan.jpg">
			</div>
			<h2>Roshan Jaiswal</h2>
			<p>Intern</p>
		</div>
	</div>
	
	
	
	<!-- footer --> 
	<footer>
		<div class="footer-logo">
			<img src ="${pageContext.request.contextPath}/images/bigBrew.svg">
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