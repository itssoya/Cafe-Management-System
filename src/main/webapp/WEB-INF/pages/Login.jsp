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
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<nav>
     <div class="logo">
            <img src="images/logo.svg" alt="BeanBrew logo">
     </div>
        <div class="links">
            <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Menu</a></li>
        </div>
      
</nav>
    <div class="layout">
    <div class="form">
        <h2>Hopping Back !</h2>
        <c:if test="${not empty errorMessage}">
            <p style="color: red; text-align: center; margin-bottom: 12px;">
                ${errorMessage}
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