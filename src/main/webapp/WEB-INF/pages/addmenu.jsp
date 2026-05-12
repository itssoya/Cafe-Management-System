<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Menu Item</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f5f5f5;
        }

        .container {
            width: 400px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }

        input, select, textarea {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
        }

        button {
            background: #333;
            color: white;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
        }

        button:hover {
            background: #555;
        }
    </style>

</head>
<body>

<div class="container">
    <h2>Add Menu Item</h2>

    <!-- IMPORTANT: enctype required for image upload -->
    <form action="addmenu" method="post" enctype="multipart/form-data">

        <label>Item Name:</label>
        <input type="text" name="itemName" required />

        <label>Category:</label>
        <select name="category" required>
            <option value="">-- Select Category --</option>
            <option value="coffee">Coffee</option>
            <option value="drinks">Drinks</option>
        </select>

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required />

        <label>Description:</label>
        <textarea name="description"></textarea>

        <label>Upload Image:</label>
        <input type="file" name="image" accept="image/*" required />

        <button type="submit">Add Item</button>

    </form>
</div>

</body>
</html>