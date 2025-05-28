<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.chat" %>
<%@ page import="model.addsinhvien" %>
<%@ page import="model.mess" %>
<%
    List<addsinhvien> infoList1 = (List<addsinhvien>) request.getAttribute("infoList1");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin Cựu Sinh Viên</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(to right, #ffffff, #ffffff);
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        header {
            position: fixed;
            top: 0;
            left: 0;         /* Đảm bảo header bắt đầu từ bên trái */
            right: 0;        /* Mở rộng tới hết bên phải */
            width: 100%;     /* Đảm bảo full chiều ngang */
            background: #000000;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 800;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            box-sizing: border-box; /* Đảm bảo padding không làm lệch */
        }
        header h1 {
            margin: 0;
        }


        nav a {
            color: white;
            margin-left: 1rem;
            text-decoration: none;
            font-weight: bold;
        }


        .chat-container {
            display: flex;
            flex: 1;
            margin: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 4rem;
        }

        .contact-list {
            width: 30%;
            background-color: #f9f9f9;
            border-right: 1px solid #ccc;
            overflow-y: auto;
        }

        .contact-item {
            display: block;
            width: 100%;
            padding: 10px;
            cursor: pointer;
            transition: background 0.3s;
            text-align: left;

        }

        .contact-item.active {
            background-color: #d0f0f0;
            font-weight: bold;
        }
        .contact-container {
            max-width: 500px;
            min-height: 700px;
            margin: 30px auto;
            padding: 20px;
            background-color: #f9fafb;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .contact-container h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        .contact-item {
            display: block;
            width: 100%;
            padding: 12px 20px;
            margin-bottom: 10px;
            background-color: #00796b;
            color: white;
            border: none;
            border-radius: 8px;
            text-align: left;
            font-size: 16px;
            transition: background-color 0.2s ease;
            cursor: pointer;
        }

        .contact-item:hover {
            background-color: #0f7a3b;
        }
        .message-area {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

        .chat-header {
            padding: 10px;
            background-color: #00796b;
            color: white;
            text-align: center;
            font-weight: bold;
        }
        .messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
            background: #fff;
            border-radius: 8px;
            display: flex;
            flex-direction: column; /* Giữ chiều dọc cho các tin nhắn */
        }

        .message {
            margin: 5px 0;
            padding: 10px;
            border-radius: 8px;
            width: fit-content; /* Chiều rộng tự động theo nội dung */
            max-width: 70%; /* Giới hạn chiều rộng tối đa */
        }

        .message.admin {
            background-color: #C0C0C0;
            align-self: flex-start; /* Căn trái */
            text-align: left;
        }

        .message.user {
            background-color: #d1ffd6;
            align-self: flex-end; /* Căn phải */
            text-align: right;
        }

        .chat-footer {
            display: flex;
            padding: 10px;
            background-color: #f1f1f1;
            border-radius: 0 0 8px 8px;
        }
        footer {
            background-color: #000000;
            color: white;
            padding: 40px 20px;
            text-align: center;
        }


        .chat-footer input {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 20px;
            margin-right: 10px;
        }

        .chat-footer button {
            background-color: #00796b;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        .chat-footer button:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>

<header>
    <h1>Mạng lưới Cựu Sinh Viên</h1>
    <nav>
        <a href="Controller">Trang chủ</a>
        <a href="ProfileController">Quản lý cựu sinh viên</a>
        <a href="NewController">Quản lý Tin Tức & Sự Kiện</a>
        <a href="LinkController">Quản lý kết nối</a>
        <a href="ContactLinkController">Quản lý liên hệ</a>
        <a href="index" style="float:right">Đăng xuất</a>
    </nav>
</header>

<div class="chat-container" style="flex: 1;min-height: 700px; padding: 20px;background: #f9f9f9;">
    <form class="contact-list" action="ContactLinkController" method="POST">
        <div class="contact-container">
            <h2>Danh sách liên hệ</h2>

            <% if (infoList1 != null && !infoList1.isEmpty()) {
                for (addsinhvien info : infoList1) { %>

            <button class="contact-item" id="idchat"
                    value="<%= info.getEmail() %>"
                    name="action">
                <%= info.getEmail() %>
            </button>
            <% } } else { %>
            <p>Không có sinh viên nào.</p>
            <% } %>
        </div>
    </form>

    <div class="message-area">
        <%
            chat infoList = (chat) request.getAttribute("infoList");
            if (infoList != null) {
        %>
                <div class="chat-header" id="chatHeader" >Đang nhắn với: <%= infoList.getTen() %></div>
        <%
            } else {
        %>
                <div class="chat-header" id="chatHeader">Chưa chọn người để nhắn tin</div>
        <%
            }
        %>
        <div class="messages" id="messageArea">
            <!-- Tin nhắn sẽ được hiển thị ở đây -->
            <%
                String tenNguoi1 = (infoList != null) ? infoList.getTen() : "";
                List<mess> showtinnhan = (List<mess>) request.getAttribute("chatmess");
                if (tenNguoi1 != null && !tenNguoi1.isEmpty() && showtinnhan != null && !showtinnhan.isEmpty()) {
                for (mess info : showtinnhan) {
                if (info.getEmailgui().equals("admin") && info.getEmailnhan().equals(tenNguoi1)) {
            %>
            <div class="message user"><%= info.getTinnhan() %></div>
            <%
            } else
            if (info.getEmailgui().equals(tenNguoi1) && info.getEmailnhan().equals("admin")) {
            %>
            <div class="message admin"><%= info.getTinnhan() %></div>

            <%
            }
            }
            } else {
            %>
                <p>Hãy chọn đối tượng nhắn tin.</p>
            <%
            }
            %>
        </div>
            <form class="chat-footer" action="ContactLinkController" method="POST">
                <%
                    String tenNguoi = (infoList != null) ? infoList.getTen() : "";
                %>
                <input type="hidden" name="taikhoansinhvien" value="<%= tenNguoi %>"/>
                <%
                if (tenNguoi != null && !tenNguoi.isEmpty()) {
                %>
                    <input type="text" id="messageInput" name="messageInput" required placeholder="Nhập tin nhắn..." />
                    <button onclick="sendMessage()" name="mess" value="chat">Gửi</button>
                <%
                } else {
                %>
                    <p>Hãy tạo liên hệ.</p>
                <%
                }
                %>
            </form>
    </div>
</div>
<footer style="background-color: #000000;; color: white; padding: 40px 20px; text-align: center">
    <div style="display: flex; justify-content: space-between; flex-wrap: wrap;">
        <div style="flex: 1; min-width: 300px;">
            <img src="https://upload.wikimedia.org/wikipedia/vi/thumb/5/5a/Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg/2560px-Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg.png" alt="VKU Logo" style="height: 60px;">
            <p><strong>MẠNG LƯỚI CỰU SINH VIÊN</strong><br>VKU Alumni Network</p>
            <p>Văn phòng Mạng lưới Cựu sinh viên<br>Trường Đại học Công nghệ Thông tin và Truyền thông Việt – Hàn (VKU)</p>
            <p>Địa chỉ: Số 470 Trần Đại Nghĩa, Quận Ngũ Hành Sơn, TP. Đà Nẵng</p>
            <p>Điện thoại: 0236.6.552.688<br>Email: alumni@vku.udn.vn</p>
        </div>
        <div style="flex: 1; min-width: 300px;">
            <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.190454951763!2d108.24982717598672!3d16.031491540827465!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31421837dd43c7c5%3A0xd269f3f2a53ef031!2zVmlldC1LYWhhbiBVbml2ZXJzaXR5IC0gVktV!5e0!3m2!1svi!2s!4v1715140581080!5m2!1svi!2s"
                    width="600" height="300" style="border:0;" allowfullscreen="" loading="lazy"
                    referrerpolicy="no-referrer-when-downgrade">
            </iframe>

        </div>
    </div>
</footer>
<script>

    var chatBody = document.getElementById("messageArea");
    chatBody.scrollTop = chatBody.scrollHeight;



        function sendMessage() {
            const messageInput = document.getElementById('messageInput');
            const messageText = messageInput.value;

            if (messageText.trim() === '') return;

            const messageArea = document.getElementById('messageArea');
            const messageDiv = document.createElement('div');
            messageDiv.className = 'message user';
            messageDiv.innerText = messageText;
            messageArea.appendChild(messageDiv);

            //messageInput.value = '';
            messageArea.scrollTop = messageArea.scrollHeight;
            setTimeout(() => {
                    const replyDiv = document.createElement('div');
                    replyDiv.className = 'message bot';  // class 'bot' để phân biệt tin nhắn trả lời
                    replyDiv.innerText = 'Tin nhắn trả lời tự động';
                    messageArea.appendChild(replyDiv);
                    messageArea.scrollTop = messageArea.scrollHeight;
                }, 2000);
        }
</script>




</body>
</html>
