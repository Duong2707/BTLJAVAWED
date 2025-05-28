<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <title>Đăng Nhập</title>
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://navigates.vn/wp-content/uploads/2023/09/co-so-vat-chat-truong.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .login-container label {
            display: block;
            margin-bottom: 5px;
            text-align: left;
            color: #555;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 10px 35px 10px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .input-group .fa {
            position: absolute;
            right: 10px;
            top: 35%;
            transform: translateY(-50%);
            color: #888;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .login-container button {
            background-color: #5cb85c;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        .login-container button:hover {
            background-color: #449d44;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Đăng Nhập</h2>
        <form action="login" method="POST">
            <div class="input-group">
                <input type="text" id="username" name="username" placeholder="Tên đăng nhập" required>
                <i class="fa fa-user"></i>
            </div>
            <div class="input-group">
                <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
                <i class="fa fa-lock"></i>
            </div>
            <button type="submit">Đăng Nhập</button>
        </form>
        <c:if test="${not empty errorMessage}">
            <div class="error-msg">${errorMessage}</div>
        </c:if>
    </div>
</body>
</html>