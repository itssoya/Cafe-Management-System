<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
</head>
<body>
    <nav>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.svg" alt="BeanBrew logo">
        </div>
        <div class="links">
            <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Menu</a></li>
            <li><a href="#">Rating</a></li>
        </div>
    </nav>

    <div class="card">
        <h2>Someone New !</h2>
        
     
        <!-- Error message block -->
	    <c:if test="${not empty error}">
	        <div class="error-message">${error}</div>
	    </c:if>
	    

        <div class="avatar">
            <label for="avatarUpload" style="cursor: pointer;" title="Upload Avatar">
                <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
                    <circle cx="20" cy="14" r="8" fill="#F5A623"/>
                    <path d="M4 38c0-8.837 7.163-16 16-16s16 7.163 16 16" fill="#F5A623"/>
                </svg>
            </label>
        </div>

        <form action="${pageContext.request.contextPath}/signup" method="post" enctype="multipart/form-data">
        
        	<input type="file" id="avatarUpload" name="profile_image" accept="image/*" style="display: none;" />
        	
            <label>Username</label>
            <input type="text" name="username" placeholder="ILoveCoffee123@01"/>

            <label>Email</label>
            <input type="text" name="email" placeholder="coooffeeeiielover@gmail.com"/>

            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••"/>

                <button type="submit">Sign Up</button>

        </form>

        <p>Been here before ? Proceed to <a href="${pageContext.request.contextPath}/login">Login</a> →</p>
    </div>

    <p class="back">Back to <a href="${pageContext.request.contextPath}/index.jsp">Home</a> →</p>
<div class = "checkboard">
   <img src="${pageContext.request.contextPath}/images/main_container/checkboard.svg" alt="BeanBrew logo">
</div>
</body>
</html>