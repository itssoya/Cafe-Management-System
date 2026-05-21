<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — BeanBrew</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ContactUs.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
</head>
<body>

    <!-- NAVBAR -->
    <nav>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.svg" alt="BeanBrew">
        </div>
        <div class="links">
            <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/aboutus">About</a></li>
            <li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
            <li><a href="${pageContext.request.contextPath}/review">Rating</a></li>
            <li><a href="${pageContext.request.contextPath}/contactus">Contact Us</a></li>
        </div>
        <div class="nav-actions">
            <a class="cart-link" href="${pageContext.request.contextPath}/cart">
                <img src="${pageContext.request.contextPath}/images/cart.svg" alt="Cart">
            </a>
            <div class="profile">
                <details class="profile-dropdown">
                    <summary class="profile-trigger">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser and not empty sessionScope.currentUser.profileImageURL}">
                                <img src="${pageContext.request.contextPath}/uploads/user_img/${sessionScope.currentUser.profileImageURL}" class="profile-avatar" alt="Profile">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg" class="profile-avatar" alt="Guest">
                            </c:otherwise>
                        </c:choose>
                    </summary>
                    <div class="profile-menu">
                        <c:choose>
                            <c:when test="${empty sessionScope.currentUser}">
                                <a href="${pageContext.request.contextPath}/login">Login</a>
                                <a href="${pageContext.request.contextPath}/signup">Get Started</a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/userprofile">My Profile</a>
                                <form action="${pageContext.request.contextPath}/logout" method="post">
                                    <button type="submit">Logout</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </details>
            </div>
        </div>
    </nav>

    <!-- MAIN -->
    <div class="contact">
        <h2>Connect With BeanBrew!</h2>

        <div class="card">

            <c:if test="${param.success == 'true'}">
                <p style="color:#16a34a; font-weight:700; text-align:center; margin-bottom:1rem;">
                    ✓ Your message has been sent! We'll get back to you soon.
                </p>
            </c:if>
            <c:if test="${not empty error}">
                <p style="color:#dc2626; font-weight:700; text-align:center; margin-bottom:1rem;">
                    ✕ ${error}
                </p>
            </c:if>

            <form action="${pageContext.request.contextPath}/contactus" method="post">

                <div class="form-input">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name"
                           placeholder="Your full name" required>
                </div>

                <div class="form-input">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email"
                           placeholder="coffeeelover@gmail.com" required>
                </div>

                <div class="form-input">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject"
                           placeholder="What's this about?" required>
                </div>

                <div class="form-input">
                    <label for="message">Message</label>
                    <textarea id="message" name="message"
                              placeholder="Leave your message here..." required></textarea>
                </div>

                <button type="submit">Send Message</button>

            </form>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="footer-logo">
            <img src="${pageContext.request.contextPath}/images/bigBrew.svg" alt="Bean Brew logo">
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

</body>
</html>