<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
	<title>BeanBrew : Error</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/errorPage.css">
</head>
<body>
	<nav>
		<div class="logo">
			<img src="${pageContext.request.contextPath}/public/logo.svg" alt="BeanBrew logo">
		</div>
		<div class="links">
			<li><a href="#">Home</a></li>
			<li><a href="#">About</a></li>
			<li><a href="#">Menu</a></li>
			<li><a href="#">Rating</a></li>
		</div>
		<div class="profile">
			<button type="button" class="profilePage" onclick="toggleSidebar()">
				<main class="username">UserName</main>
			</button>
		</div>
	</nav>

	<section class="main404">
		<img src="${pageContext.request.contextPath}/images/ErrorPage/opps.svg" alt="opps"> 
		<p><b>Something went wrong</b></p>
		<p>Go to <a href="${pageContext.request.contextPath}/index">Home</a></p> 
	</section>

	<div class="beanbear">
		<img src="${pageContext.request.contextPath}/images/ErrorPage/errorbear.svg" alt="errorbear">
	</div>
		<!-- Sidebar -->
	<div id="sidebar" class="sidebar">
		<div class="sidebar-content">
			<!-- Logged Out View -->
			<div id="loggedOutView">
				<div class="guest-header">
					<img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg" alt="guest-placeholder" class="profile-pic">
					<h2>Welcome Guest</h2>
				</div>
				<div class="auth-buttons">
					<button onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
					<button onclick="window.location.href='${pageContext.request.contextPath}/signup'">Sign Up</button>
				</div>
			</div>
		</div>
	</div>

	<section class="checker bottom" >
		<br><br><br><br><br><br>
	</section>
	<script src="${pageContext.request.contextPath}/javascript/main.js"></script>
</body>
</html>