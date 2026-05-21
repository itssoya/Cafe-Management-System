<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Fustat:wght@200..800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/review.css">
</head>
<body>
    <nav>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/images/logo.svg">
        </div>
        <div class="links">
            <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Menu</a></li>
            <li><a href="${pageContext.request.contextPath}/review">Rating</a></li>
        </div>
        <div class="profile">
            <button type="button" class="profilePage" onclick="toggleSidebar()">
            </button>
        </div>
    </nav>

    <div id="sidebar" class="sidebar">
        <div class="sidebar-content">
            <div id="loggedOutView">
                <div class="guest-header">
                    <img src="${pageContext.request.contextPath}/images/sidebar/GuestUser.svg">
                    <h2>Welcome ${sessionScope.currentUser.username}</h2>
                </div>
                <div class="auth-buttons">
                    <button onclick="window.location.href='${pageContext.request.contextPath}/login'">Login</button>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/signup'">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    <div class="review-heading">
        <h1>Coffee may taste bitter,<br>
            <img src="${pageContext.request.contextPath}/images/gallery/Sweet.svg" class="sweet">
        </h1>
    </div>

    <c:if test="${not empty success}">
        <p style="text-align:center; color:green; font-family:Fustat; font-weight:600;">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="text-align:center; color:red; font-family:Fustat; font-weight:600;">${error}</p>
    </c:if>

    <c:choose>
        <c:when test="${not empty reviews}">
            <div class="reviews-grid">
                <c:forEach var="r" items="${reviews}">
                    <div class="review-card">
                        <div class="card-top">
                            <span class="username">${r.username}</span>
                            <span class="stars">
                                <c:forEach begin="1" end="${r.rating}" var="s">★</c:forEach>
                            </span>
                        </div>
                        <p>${r.message}</p>
                        <c:if test="${not empty sessionScope.currentUser
                                      and sessionScope.currentUser.userId == r.userId}">
                            <form action="${pageContext.request.contextPath}/review" method="post"
                                  style="text-align:right;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="reviewId" value="${r.reviewId}">
                                <button type="submit" class="btn-delete-review"
                                    onclick="return confirm('Delete your review?')">Delete</button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${totalPages > 0}">
                <div class="pagination">
                    <c:choose>
                        <c:when test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/review?page=${currentPage - 1}"
                               class="page-btn prev-btn">&#8249; Prev</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn prev-btn disabled">&#8249; Prev</span>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="page-btn page-number active">${i}</span>
                            </c:when>
                            <c:when test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                                <a href="${pageContext.request.contextPath}/review?page=${i}"
                                   class="page-btn page-number">${i}</a>
                            </c:when>
                            <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                <span class="page-ellipsis">...</span>
                            </c:when>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/review?page=${currentPage + 1}"
                               class="page-btn next-btn">Next &#8250;</a>
                        </c:when>
                        <c:otherwise>
                            <span class="page-btn next-btn disabled">Next &#8250;</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="paginationInfo">Showing page ${currentPage} of ${totalPages}</div>
            </c:if>
        </c:when>
        <c:otherwise>
            <p style="text-align:center; color:#16319E; font-family:Fustat; margin:40px 0;">
                No reviews yet. Be the first to share your experience!
            </p>
        </c:otherwise>
    </c:choose>

    <div class="form-section">
        <h2>Tell Us Your Experience</h2>
        <c:choose>
            <c:when test="${not empty sessionScope.currentUser}">
                <form action="${pageContext.request.contextPath}/review" method="post">
                    <input type="hidden" name="rating" id="ratingValue" value="0">
                    <label>Leave a Message*</label>
                    <textarea name="message" placeholder="Tell us how you felt at BeanBrew..."></textarea>
                    <c:if test="${not empty errorMessage}">
                        <p class="field-error">${errorMessage}</p>
                    </c:if>
                    <div class="rating-row">
                        <label>Rate BeanBrew*</label>
                        <div>
                            <div class="stars-input">
                                <span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
                            </div>
                            <c:if test="${not empty errorRating}">
                                <p class="field-error" style="text-align:right;">${errorRating}</p>
                            </c:if>
                        </div>
                    </div>
                    <div class="bottom-row">
                        <p class="note">*Your Reviews help us shape our business and grow in the days to come.<br>
                            Honest Reviews are much appreciated.</p>
                        <div style="display:flex; flex-direction:column; align-items:flex-end;">
                            <button type="submit">Submit</button>
                            <c:if test="${not empty errorBoth}">
                                <p class="field-error" style="margin-top:6px;">${errorBoth}</p>
                            </c:if>
                        </div>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <p style="text-align:center; color:#16319E; font-family:Fustat; margin:20px 0;">
                    Please <a href="${pageContext.request.contextPath}/login">login</a> to leave a review.
                </p>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        const stars = document.querySelectorAll('.stars-input span');
        let selected = 0;
        stars.forEach((star, i) => {
            star.addEventListener('mouseover', () => {
                stars.forEach((s, j) => s.style.color = j <= i ? '#F6C251' : '#ccc');
            });
            star.addEventListener('mouseout', () => {
                stars.forEach((s, j) => s.style.color = j < selected ? '#F6C251' : '#ccc');
            });
            star.addEventListener('click', () => {
                selected = i + 1;
                document.getElementById('ratingValue').value = selected;
                stars.forEach((s, j) => s.style.color = j < selected ? '#F6C251' : '#ccc');
            });
        });
    </script>
    <script src="${pageContext.request.contextPath}/javascript/main.js"></script>
</body>
</html>