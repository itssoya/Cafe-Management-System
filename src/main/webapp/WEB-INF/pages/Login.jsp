<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Account</title>

    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	
    <title>Login Page</title>
</head>
<body>
<i class="fa-solid fa-mug-hot bgCup"></i>

<i class="fa-solid fa-utensils bgFood"></i>
<div class="page">

    <!-- HEADER -->
    <div class="topLogo">

    <div class="logoBox">
       <a href ="${pageContext.request.contextPath}/index"> <i class="fa-solid fa-mug-hot"></i></a>
    </div>

    <h2>BeanBrew</h2>

	</div>

    <!-- LOGIN CARD -->
    <div class="loginCard">

        <h3>Sign In</h3>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/login"
        method="post">

            <!-- USERNAME -->
            <label>Username</label>

            <div class="inputBox">
				<i class="fa-solid fa-user"></i>
                <input
                type="text"
                name="username"
                placeholder="Enter your username"
                required>

            </div>

            <!-- PASSWORD HEADER -->
            <div class="passHeader">

                <label>Password</label>

                <a href="#">Forgot Password?</a>

            </div>

            <!-- PASSWORD -->
            <div class="inputBox">

                <i class="fa-solid fa-lock"></i>

                <input
                type="password"
                name="password"
                placeholder="********"
                required>

            </div>

            <!-- REMEMBER -->
            <div class="remember">
                <input type="checkbox">
                Remember Me
            </div>

            <button type="submit">

                Sign In

            </button>

        </form>

        <div class="bottomText">

            NEW HERE?

            <a href="${pageContext.request.contextPath}/signup">
                SIGNUP
            </a>

        </div>

    </div>

    <!-- FOOTER ICONS -->
    <div class="footerMenu">
		<div>
           <a href="${pageContext.request.contextPath}/index"> HOME </a>
        </div>
		
        <div>
           <a href="#"> MENU </a>
        </div>
        
    </div>

</div>

</body>
</html>