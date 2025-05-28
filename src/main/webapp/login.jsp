<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
</head>
<body>
    <h1>Đăng Nhập</h1>
    <form action="login" method="post">
        Tên đăng nhập: <input type="text" name="username" required/><br/>
        Mật khẩu: <input type="password" name="password" required/><br/>
        <input type="submit" value="Đăng Nhập"/>
    </form>

    <c:if test="${not empty errorMessage}">
        <h2 style="color: red;">${errorMessage}</h2>
    </c:if>
</body>
</html>