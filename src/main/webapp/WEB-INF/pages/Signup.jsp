<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
</head>
<body>

    <h2>User Signup</h2>

    <form action="signup" method="post" enctype="multipart/form-data">
        
        <!-- Username -->
        <div>
            <label>username:</label>
            <input type="text" name="username" required>
        </div>

        <br>

        <!-- Email -->
        <div>
            <label>Email:</label>
            <input type="email" name="email_id" required>
        </div>

        <br>

        <!-- Password -->
        <div>
            <label>Password:</label>
            <input type="password" name="password" required>
        </div>

        <br>

        <!-- Admin -->
        <div>
            <label>Is Admin:</label>
            <select name="is_admin">
                <option value="false">No</option>
                <option value="true">Yes</option>
            </select>
        </div>

        <br>

        <!-- Profile Image -->
        <div>
            <label>Profile Image:</label>
            <input type="file" name="profile_image" accept="image/*">
        </div>

        <br>

        <!-- Submit -->
        <div>
            <button type="submit">Register</button>
        </div>

    </form>

</body>
</html>