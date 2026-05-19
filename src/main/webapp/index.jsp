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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Homepage.css">
	<title>BeanBrew</title>  
</head>
<body>
	
	<nav>
		<div class="logo">
			<img src ="${pageContext.request.contextPath}/images/logo.svg">
			
		</div>
		<div class="links">
			<li><a href="#">Home</a></li>
			<li><a href="#">About</a></li>
			<li><a href="#">Menu</a></li>
			<li><button onclick="window.location.href='${pageContext.request.contextPath}/review'">Rating</button></li>
		</div>
		<div class="profile">
			<button type="button" class="profilePage" onclick="toggleSidebar()">
				<main class="username">${username}</main>
			</button>
		</div>
	</nav>

	
	<div id="sidebar" class="sidebar">
		<div class="sidebar-content">
			<div id="loggedOutView">
				<div class="guest-header">
					<img src ="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg">
					<h2>Welcome ${username}</h2>
				</div>
				<div class="auth-buttons">
					 <button onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
					<button onclick="window.location.href='${pageContext.request.contextPath}/signup'">Sign Up</button>
				</div>
			</div>
		</div>
	</div>


	
	<section class="hero">
		<main>
			<div>
				<div class="herotext">
					<div>Beyond Coffee & Food,</div>			
					<div>
						<img src ="${pageContext.request.contextPath}/images/simplelogo.svg">
					</div>		
					<div>is Where Moments</div>			
					<div>Happen</div>	
				</div>
				<button class="ctaButton">View Menu</button>
			</div> 
		</main>
		<div class="imageframe">
			<img src ="${pageContext.request.contextPath}/images/heropic.jpg">
		</div>
	</section>

	
	<section class="intro">'
		<p>Welcome to Bean Brew, where every cup tells a story and every visit feels like a little escape from the everyday rush. We’re all about serving freshly brewed coffee, handcrafted drinks, and delicious bites in a space filled with cozy energy, good music, and even better company. Whether you’re stopping by for your morning caffeine boost or settling in for a long catch-up session, Bean Brew is the kind of place that makes you want to stay awhile.</p><br>
		<p>At Bean Brew, we believe coffee is more than just a drink, it’s a moment to slow down, connect, and enjoy life’s simple pleasures. From smooth lattes and bold espressos to sweet pastries baked fresh daily, everything we serve is made with care and a whole lot of love. So grab your favorite mug, find your perfect seat, and let the comforting aroma of freshly brewed coffee welcome you home.</p>
	</section>

	<section class="checker">
		<br><br><br><br><br><br><br>
	</section>
	
	
	<section class="menu">
		<h1>We Recommend...</h1>
		<header>Coffee Brew</header>
		<section class="coffee">
			<div class="menuBox">
				<header>
					<h1>Capuccino</h1>
					<h3>350</h3>
				</header>
				<p>A rich espresso topped with perfectly steamed milk and a thick, velvety foam.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Americano</h1>
					<h3>250</h3>
				</header>
				<p>Smooth espresso blended with hot water for a bold yet mellow flavor.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Espresso</h1>
					<h3>200</h3>
				</header>
				<p>A bold and concentrated coffee shot packed with deep, rich flavor.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Latte</h1>
					<h3>300</h3>
				</header>
				<p>Creamy steamed milk mixed with espresso for a soft and comforting coffee experience.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Cold Brew</h1>
					<h3>280</h3>
				</header>
				<p>Slow-steeped coffee served chilled for a smooth, refreshing, and naturally sweet taste.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Mocha</h1>
					<h3>380</h3>
				</header>
				<p>A delicious mix of espresso, chocolate, and steamed milk topped with indulgent sweetness.</p>
			</div>
		</section> 
		<button class="orderButton">Order Now</button>
	</section>	

	<!-- moments -->
	<section class="moments">
		<h1>Make <span style="color:#F6C251; font-size: 2rem;">Moments</span> With Us</h1>
		<div class="gallery">
			<div class="frame">
				<img src ="${pageContext.request.contextPath}/images/gallery/Cafe.jpg">
			</div>
			<div class="frame">
				<img src ="${pageContext.request.contextPath}/images/gallery/Coffee_aesthetic_photo_____.jpg">
			</div>
			<div class="frame">
				<img src ="${pageContext.request.contextPath}/images/gallery/download_17.jpg">
			</div>
			<div class="frame">
				<img src ="${pageContext.request.contextPath}/images/gallery/download_18.jpg">
			</div>
			<div class="frame">
				<img src ="${pageContext.request.contextPath}/images/gallery/download_20.jpg">
		</div>

	</section>

	
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