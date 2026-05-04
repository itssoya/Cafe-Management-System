<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration Form</title>
</head>
<body>
    <h2>Register New User</h2>
    <form action="${pageContext.request.contextPath}/signup" method="post">
        <table>
            <tr>
                <td>Username:</td>
                <td><input type="text" name="username" maxlength="150" required></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email_id" maxlength="100" required></td>
            </tr>
            <tr>
                <td>Password:</td>
                <td><input type="password" name="password" maxlength="255" required></td>
            </tr>
            <tr>
                <td>Is Admin:</td>
                <td>
                    <input type="checkbox" name="is_admin" value="true">
                </td>
            </tr>
        </table>
        <input type="submit" value="Register">
    </form>
</body>
</html>