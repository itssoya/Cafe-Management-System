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
	<!-- NAVBAR -->
	<nav>
		<div class="logo">
			<img src ="${pageContext.request.contextPath}/images/logo.svg">
			
		</div>
		<div class="links">
			<li><a href="#">Home</a></li>
			<li><a href="#">About</a></li>
			<li><a href="#">Menu</a></li>
		</div>
		<div class="profile">
			<button type="button" class="profilePage" onclick="toggleSidebar()">
				<main class="username">UserName</main>
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
					<h2>Welcome Guest</h2>
				</div>
				<div class="auth-buttons">
					<button onclick="">Login</button>
					<button onclick="">Sign Up</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Hero Section -->
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

	<!-- intro text -->
	<section class="intro">
		<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Est magni, eaque perferendis culpa iusto incidunt pariatur asperiores amet! Magni officia optio, iste minus aliquam eaque quos debitis velit expedita ipsam excepturi corporis earum ut, quia similique id veritatis. Atque tenetur vitae illo officia ea ducimus error. Eaque corrupti aperiam magni asperiores consectetur ullam dolore, temporibus molestias placeat labore quia veritatis. Fugiat exercitationem doloribus velit. Provident natus assumenda, id corporis earum ut soluta sapiente necessitatibus quibusdam recusandae. Minima incidunt, quam deleniti adipisci voluptatibus nihil repellat suscipit iure mollitia tenetur cupiditate voluptatem, id esse iste nostrum. Veniam exercitationem eaque voluptatibus at rerum!</p><br>
		<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Perspiciatis officiis nisi consequatur ratione fugit illo, pariatur aut, esse nulla temporibus necessitatibus minus iure corporis mollitia hic, cumque error voluptatum ipsa. At incidunt laudantium suscipit officiis repellat et mollitia sunt natus quam, hic non adipisci perferendis nihil facilis fugit libero. Molestias.</p>
	</section>

	<section class="checker">
		<br><br><br><br><br><br><br>
	</section>
	
	<!-- menu section -->
	<section class="menu">
		<h1>We Recommend...</h1>
		<header>Coffee Brew</header>
		<section class="coffee">
			<div class="menuBox">
				<header>
					<h1>Capuccino</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Americano</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Espresso</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Latte</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Cold Brew</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
			</div>
			<div class="menuBox">
				<header>
					<h1>Mocha</h1>
					<h3>250</h3>
				</header>
				<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Libero ipsa illum accusamus beatae a voluptatem alias culpa odit fugiat dolorem.</p>
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