<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editmenu.css">
<title>Edit Menu Item — BrewBar</title>
<style>
   
</style>
</head>
<body>

    <!-- BLURRED BACKGROUND -->
    <div class="page-blur-bg">
        <div class="container">
            <aside class="sidebar">
                <div class="sidebar-content">
                    <h1>BrewBar</h1>
                    <ul class="category">
                        <li><span class="material-icons">dashboard</span> Dashboard</li>
                        <li class="active"><span class="material-icons">menu_book</span> Menu</li>
                        <li><span class="material-icons">account_box</span> Users</li>
                        <li><span class="material-icons">inventory_2</span> Inventory</li>
                        <li class="logout"><span class="material-icons">logout</span> Logout</li>
                    </ul>
                </div>
            </aside>
            <div class="main-content">
                <div class="pageHeader">
                    <h1>Menu</h1>
                    <p>Manage your artisan menu items.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL -->
    <div class="modal-overlay">
        <div class="modal">

            <div class="modal-icon">
                <i class="fa-solid fa-pen"></i>
            </div>

            <h2>Edit Menu Item</h2>
            <p class="modal-subtitle">Update the details for ${menuItem.itemName}</p>

            <c:if test="${not empty error}">
                <div class="modal-alert">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/editmenu"
                  method="post" enctype="multipart/form-data">

                <input type="hidden" name="itemId" value="${menuItem.itemId}">
                <input type="hidden" name="existingImageUrl" value="${menuItem.imageUrl}">
                <input type="hidden" name="existingFileExtension" value="${menuItem.fileExtension}">

                <!-- Item Name -->
                <div class="form-group">
                    <label for="itemName">ITEM NAME</label>
                    <input type="text" id="itemName" name="itemName"
                           placeholder="e.g., Caramel Latte"
                           value="${menuItem.itemName}" required>
                </div>

                <!-- Price + Category -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="price">PRICE</label>
                        <input type="number" id="price" name="price"
                               placeholder="0.00" min="0" step="0.01"
                               value="${menuItem.price}" required>
                    </div>
                    <div class="form-group">
                        <label for="categoryId">CATEGORY</label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">Select category...</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryId}"
                                    ${cat.categoryId == menuItem.categoryId ? 'selected' : ''}>
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
                              placeholder="Brief description of this item...">${menuItem.description}</textarea>
                </div>

                <!-- Current Image -->
                <div class="current-image">
                    <label>CURRENT IMAGE</label>
                    <div class="current-img-wrap">
                        <c:choose>
                            <c:when test="${not empty menuItem.imageUrl}">
                                <img src="${pageContext.request.contextPath}/uploads/menu_items/${menuItem.imageUrl}"
                                     alt="${menuItem.itemName}">
                            </c:when>
                            <c:otherwise>
                                <i class="fa-solid fa-mug-hot"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                </div>

                <!-- New Image Upload -->
                <div class="form-group">
                    <label>NEW IMAGE <span style="font-weight:400;color:#b0a09a;letter-spacing:0">(Optional)</span></label>
                    <div class="image-upload-area" id="uploadArea"
                         onclick="document.getElementById('imageFile').click()">
                        <i class="fa-solid fa-image" id="uploadIcon"></i>
                        <p id="uploadText">Click to upload a new photo</p>
                        <img id="new-image-preview" alt="New Preview"
                             style="display:none; width:100%; max-height:140px;
                                    object-fit:cover; border-radius:8px; margin-top:8px;">
                    </div>
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
                        <i class="fa-solid fa-floppy-disk"></i> Save Changes
                    </button>
                </div>

            </form>
        </div>
    </div>

<script>

function previewImage(event) {
    const preview = document.getElementById('new-image-preview');
    const icon    = document.getElementById('uploadIcon');
    const text    = document.getElementById('uploadText');
    const file    = event.target.files[0];
    if (file) {
        preview.src = URL.createObjectURL(file);
        preview.style.display = 'block';
        icon.style.display    = 'none';
        text.style.display    = 'none';
    }
}
</script>

</body>
</html>
