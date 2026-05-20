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
			<img src ="${pageContext.request.contextPath}/images/logo.svg">
			
		</div>
		<div class="links">
			<li><a href="#">Home</a></li>
			<li><a href="#">About</a></li>
			<li><a href="#">Menu</a></li>
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
					<img src ="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg">
					<h2>Welcome ${user.userName} </h2>
				</div>
				<div class="auth-buttons">
					 <button onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
					<button onclick="window.location.href='${pageContext.request.contextPath}/signup'">Sign Up</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Hero Section -->
	<section class="hero">
		<div class="imageframe">
			<img src ="${pageContext.request.contextPath}/images/gallery/Cafe_Bg.png">
		</div>
	</section>

	<!-- intro text -->
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
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">	
			</div>
			<h2>Sourav Yadav</h2>
			<p>Project Manager</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">	
			</div>
			<h2>Palden Lama</h2>
			<p>Backend Developer</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">	
			</div>
			<h2>Siddhartha Thapa</h2>
			<p>Frontend Developer</p>
		</div>
		
		<div class = "team-card">
			<div class = "team-photo">
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">
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
				<img src ="${pageContext.request.contextPath}/images/members/suhana.jpeg">
			</div>
			<h2>Roshan Jaiswal</h2>
			<p>Member</p>
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