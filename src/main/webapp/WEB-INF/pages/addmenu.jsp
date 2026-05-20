<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/stockManagement.css">
<title>Add Menu Item — BrewBar</title>
<style>
.page-blur-bg {
    position: fixed;
    inset: 0;
    filter: blur(3px) brightness(0.6);
    pointer-events: none;
    z-index: 0;
    overflow: hidden;
}

/* ================= NAVBAR ================= */

.NavBar {
    position: fixed;
    top: 0;
    left: 240px;
    right: 0;
    height: 60px;
    background: #FFF8ED;
    border-bottom: 1px solid #dbe2ff;
    display: flex;
    align-items: center;
    padding: 0 32px;
    z-index: 90;
    box-shadow: 0 1px 4px rgba(22,49,158,0.08);
}

.search-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    background: #f5f7ff;
    border: 1.5px solid #dbe2ff;
    border-radius: 8px;
    padding: 0 14px;
}

.search-bar:focus-within {
    background: white;
    border-color: #16319E;
}

.search-bar i,
.search-bar input::placeholder {
    color: #7b86b2;
}

.search-bar input {
    flex: 1;
    border: none;
    outline: none;
    background: transparent;
    padding: 10px 0;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.875rem;
}

.search-bar button {
    background: #16319E;
    color: white;
    border: none;
    border-radius: 6px;
    padding: 6px 14px;
    font-family: 'DM Sans', sans-serif;
    font-size: 0.8rem;
    font-weight: 600;
}

.search-bar button:hover {
    background: #0f2578;
}

/* ================= SIDEBAR ================= */

.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    width: 240px;
    background: #FFF8ED;
    border-right: 1px solid #16319E;
    color: #16319E;
    display: flex;
    flex-direction: column;
}

.sidebar-content {
    display: flex;
    flex-direction: column;
    height: 100%;
}

.main-icon {
    width: 10rem;
    padding-left: 1.5rem;
    padding-top: 1rem;
}

.sidebar-content h1 {
    font-family: 'DM Sans', sans-serif;
    font-size: 2.5rem;
    padding-left: 1.5rem;
    padding-top: 0.25rem;
    line-height: 1;
}

.category,
.bottom {
    list-style: none;
    padding: 0.5rem;
}

.category {
    flex: 1;
}

.category li a,
.bottom li a {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1rem 1.5rem;
    border-radius: 0.5rem;
    font-size: 1.1rem;
    text-decoration: none;
    color: #16319E;
    transition: 0.2s;
}

.category li a:hover,
.bottom li a:hover {
    background: #eef2ff;
}

.icon {
    width: 1.5rem;
    height: 1.5rem;
}

/* ================= MODAL ================= */

.modal-overlay {
    position: fixed;
    inset: 0;
    z-index: 10;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.modal {
    background: #FFF8ED;
    border-radius: 20px;
    padding: 40px 44px;
    width: 100%;
    max-width: 560px;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 24px 60px rgba(0,0,0,0.18);
    text-align: center;
}

.modal-icon {
    width: 56px;
    height: 56px;
    background: #eef2ff;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 18px;
    font-size: 22px;
    color: #16319E;
}

.modal h2 {
    font-size: 1.4rem;
    font-weight: 700;
    color: #1e1208;
    margin-bottom: 6px;
}

.modal-subtitle {
    font-size: 0.875rem;
    color: #7b86b2;
    margin-bottom: 24px;
}

.modal-alert {
    background: #fef2f2;
    color: #b91c1c;
    border: 1px solid #fecaca;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 0.875rem;
    text-align: left;
    margin-bottom: 18px;
}

/* ================= FORM ================= */

.form-group {
    text-align: left;
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    font-size: 0.7rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    color: #16319E;
    margin-bottom: 6px;
}

.form-group input[type="text"],
.form-group input[type="number"],
.form-group select,
.form-group textarea {
    width: 100%;
    background: #f5f7ff;
    border: 1px solid #dbe2ff;
    border-radius: 10px;
    padding: 12px 14px;
    font-size: 0.9rem;
    color: #1e1208;
    outline: none;
    box-sizing: border-box;
}

.form-group input::placeholder,
.form-group textarea::placeholder {
    color: #9aa7d6;
}

.form-group textarea {
    height: 80px;
    resize: none;
}

.form-group select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%2316319E' d='M6 8L1 3h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 14px center;
    background-color: #f5f7ff;
    padding-right: 36px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
}

/* ================= IMAGE UPLOAD ================= */

.image-upload-area {
    background: #f5f7ff;
    border-radius: 10px;
    border: 2px dashed #c7d2fe;
    padding: 24px;
    text-align: center;
    cursor: pointer;
    transition: border-color 0.2s;
}

.image-upload-area:hover {
    border-color: #16319E;
}

.image-upload-area i {
    font-size: 28px;
    color: #7b86b2;
    margin-bottom: 8px;
    display: block;
}

.image-upload-area p {
    font-size: 0.8rem;
    color: #7b86b2;
    margin: 0;
}

#image-preview {
    display: none;
    width: 100%;
    max-height: 140px;
    object-fit: cover;
    border-radius: 8px;
    margin-top: 10px;
}

/* ================= ACTIONS ================= */

.modal-actions {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 14px;
    margin-top: 28px;
}

.btn-cancel {
    font-size: 0.9rem;
    color: #16319E;
    text-decoration: none;
    padding: 10px 18px;
    border-radius: 10px;
    transition: background 0.2s;
}

.btn-cancel:hover {
    background: #eef2ff;
}

.btn-submit {
    background: #16319E;
    color: white;
    border: none;
    border-radius: 10px;
    padding: 12px 24px;
    font-size: 0.9rem;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: background 0.2s;
}

.btn-submit:hover {
    background: #0f2578;
}
</style>
</head>
<body>

    <!-- BLURRED BACKGROUND -->
    <div class="page-blur-bg">
        <div class="NavBar">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" placeholder="Search menu items..." disabled>
                <button disabled>Search</button>
            </div>
        </div>
        <div class="container">
            <aside class="sidebar">
                <div class="sidebar-content">
					<img
						src="${pageContext.request.contextPath}/images/main_container/logo.svg"
						class="main-icon">
					<h1>BrewBar</h1>

					<ul class="category">
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/dashboard.svg"
							class="icon"> <span>Dashboard</span></a></li>
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/menu.svg"
							class="icon"> <span>Menu</span></a></li>
						<li ><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/users.svg"
							class="icon"> <span>Users</span></a></li>
						<li><a href="#"><img
							src="${pageContext.request.contextPath}/images/panel/inventory.svg"
							class="icon"> <span>Inventory</span></a></li>
						<li><a
						href="#"> <img
							src="${pageContext.request.contextPath}/images/panel/order.svg"
							class="icon"> <span>Orders</span>
					</a></li>
					</ul>

					<ul class="bottom">
					<li><img
						src="${pageContext.request.contextPath}/images/panel/logout.svg"
						class="icon"> <span>Logout</span></li>
				</ul>
				</div>

		</aside>
            <div class="stock-registry-container">
                <div class="pageHeader">
                    <div class="pageHeader-left">
                        <h1>Menu</h1>
                        <p>Manage your artisan menu items.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL -->
    <div class="modal-overlay">
        <div class="modal">

            <div class="modal-icon">
                <i class="fa-solid fa-mug-hot"></i>
            </div>

            <h2>Add Menu Item</h2>
            <p class="modal-subtitle">Add a new item to your artisan menu</p>

            <c:if test="${not empty error}">
                <div class="modal-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/addmenu" method="post"
                  enctype="multipart/form-data">

                <!-- Item Name -->
                <div class="form-group">
                    <label for="itemName">ITEM NAME</label>
                    <input type="text" id="itemName" name="itemName"
                           placeholder="e.g., Caramel Latte"
                           value="${param.itemName}">
                </div>

                <!-- Price + Category -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">PRICE</label>
                        <input type="number" id="price" name="price"
                               placeholder="0.00" min="0" step="0.01"
                               value="${param.price}">
                    </div>
                    <div class="form-group">
                        <label for="categoryId">CATEGORY</label>
                        <select id="categoryId" name="categoryId">
                            <option value="">Select category...</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryId}"
                                    ${param.categoryId == cat.categoryId ? 'selected' : ''}>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-group">
                    <label for="description">DESCRIPTION</label>
                    <textarea id="description" name="description"
                              placeholder="Brief description of this item...">${param.description}</textarea>
                </div>

                <!-- Image Upload -->
               <div class="form-group">
				    <label>IMAGE <span style="font-weight:400;color:#b0a09a;letter-spacing:0">(Optional)</span></label>
				
				    <!-- Clickable area — preview replaces icon inside here -->
				    <div class="image-upload-area" id="uploadArea"
				         onclick="document.getElementById('imageFile').click()">
				        <i class="fa-solid fa-image" id="uploadIcon"></i>
				        <p id="uploadText">Click to upload a photo of this item</p>
				        <img id="image-preview" alt="Preview"
				             style="display:none; width:100%; max-height:140px; 
				                    object-fit:cover; border-radius:8px; margin-top:8px;">
				    </div>
				
				    <!-- Hidden input outside -->
				    <input type="file" id="imageFile" name="imageFile"
				           accept="image/*"
				           onchange="previewImage(event)"
				           style="display:none">
				</div>

                <!-- Actions -->
                <div class="modal-actions">
                    <a href="${pageContext.request.contextPath}/menumanagement" class="btn-cancel">
                        Cancel
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fa-solid fa-check"></i> Add to Menu
                    </button>
                </div>

            </form>
        </div>
    </div>

<script>
function previewImage(event) {
    const preview = document.getElementById('image-preview');
    const icon    = document.getElementById('uploadIcon');
    const text    = document.getElementById('uploadText');
    const file    = event.target.files[0];

    if (file) {
        preview.src = URL.createObjectURL(file);
        preview.style.display = 'block';
        icon.style.display    = 'none';   // hide icon
        text.style.display    = 'none';   // hide text
    }
}
</script>

</body>
</html>
