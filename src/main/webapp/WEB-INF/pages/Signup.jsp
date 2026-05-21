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
    <!-- NAVBAR -->
	<nav>
		<div class="logo">
			<img src="${pageContext.request.contextPath}/images/logo.svg">
		</div>
		<div class="links">
			<li><a href="${pageContext.request.contextPath}/index">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/aboutus">About</a></li>
			<li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
			<li><a href="${pageContext.request.contextPath}/rating">Rating</a></li>
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