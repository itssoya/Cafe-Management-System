<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Account</title>

    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

    
</head>

<body>

<div class="layout">

    <!-- CENTER CARD -->
    <div class="form-card">
        <h2>Hopping Back !</h2>

        <!-- ERROR MESSAGE -->
        <c:if test="${not empty error}">
            <div id="errorPopup" class="error-container">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/login" method="post">

            <!-- USERNAME -->
            <div class="field">
                <label>Username</label>
                <div class="input-wrap">
                    
                    <input type="text" name="username" placeholder="ILoveCoffee123@01" value="${typedUser}" required>
                </div>
            </div>

            <!-- PASSWORD -->
            <div class="field">
                <label>Password</label>
                <div class="input-wrap">
                    
                    <input type="password" placeholder="***********" name="password" required>
                </div>
            </div>

            
            <button class="submit-btn" type="submit">
                Login
            </button>
        </form>

        <!-- FOOTER -->
        <div class="footer-text">
            New here? <a href="${pageContext.request.contextPath}/register">SignUp</a>
        </div>

        <div class="footer-text" style="margin-top:10px;">
            <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
        </div>

    </div>

</div>


<script>
document.addEventListener('DOMContentLoaded', function() {
    const errorPopup = document.getElementById('errorPopup');

    if (errorPopup) {
        setTimeout(() => {
            errorPopup.classList.add('fade-out');
            setTimeout(() => errorPopup.remove(), 500);
        }, 5000);
    }
});
</script>

</body>
</html>