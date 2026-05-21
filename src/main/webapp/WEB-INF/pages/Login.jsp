<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Account</title>

    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

    

    <title>Login Page</title>
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
			<li><a href="${pageContext.request.contextPath}/contactUs">ContactUs</a></li>
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
    <div class="layout">
    <div class="form">
        <h2>Hopping Back !</h2>
        <c:if test="${not empty error}">
            <p style="color: red; text-align: center; margin-bottom: 12px;">
                ${error}
            </p>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">

            <!-- Username -->
            <div class="field">
                <label>Username</label>
                <div> 
                    <input type="text" name="username" placeholder="ILoveCoffee123@01" required>
                </div>
            </div>

            <!-- Password -->
            <div class="field passwordField">
                <label>Password</label>
                <div>
                    <input type="password" placeholder="***********" name="password" required>
                </div>
            </div>

            
            <button class="submitButton" type="submit">
                Login
            </button>
            
            
        </form>
        <div class="signUp">
            New here ? Proceed to 
            <a href="${pageContext.request.contextPath}/signup">SignUp</a>
        </div>
        <div class="forgotPass">
            	<a href="#">Forgot Password ?</a>
        </div>

    </div>
    <div class="backHome">
        Back to <a href="${pageContext.request.contextPath}/index">Home →</a>
    </div>
</div>
<div class = "checkboard">
    <img src="images/main_container/checkboard.svg" alt="BeanBrew logo">
</div>

</body>
</html>