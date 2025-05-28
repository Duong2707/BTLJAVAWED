<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.addtintucsukien" %>
<%@ page import="model.mess" %>
<%
    List<addtintucsukien> infoList = (List<addtintucsukien>) request.getAttribute("infoList");

%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tin tức & Sự kiện</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(to right, #e0f7fa, #e1f5fe);
    }
    header {
        position: fixed;
        top: 0;
        left: 0;         /* Đảm bảo header bắt đầu từ bên trái */
        right: 0;        /* Mở rộng tới hết bên phải */
        width: 100%;     /* Đảm bảo full chiều ngang */
        background: #00796b;
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
        font-size: 1.5rem;
        white-space: nowrap;
    }

    header nav {
        margin-left: auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-end;
        align-items: center;
        gap: 1rem;

    }
    nav a {
      color: white;
      margin-left: 1rem;
      text-decoration: none;
      font-weight: bold;
    }
    .banner-slider {
      position: relative;
      width: 100%;
      height: 300px;
      overflow: hidden;
      margin-top: 0.3rem;
    }
    .slide {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .intro-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
      font-size: 3rem;
      font-weight: bold;
      -webkit-text-stroke: 3px black;
      text-decoration: none;
    }
    main {
      padding: 2rem;
      max-width: 1200px;
      margin: 80px auto;
    }
    h2 {
      font-size: 1.5rem;
      margin-bottom: 1rem;
      border-bottom: 2px solid #00796b;
      padding-bottom: 0.5rem;
    }
    .news-grid {
      display: flex;
      flex-wrap: wrap;
      gap: 1.5rem;
      justify-content: center;
    }
    .news-card {
        width: 100%;
        max-width: 700px; /* Giới hạn chiều rộng tối đa để không bị quá rộng */
        height: auto; /* Tự động theo nội dung bên trong */
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 1rem;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .news-card img {
        width: 100%; /* Ảnh sẽ đầy chiều rộng thẻ card */
        height: 100%; /* Tự điều chỉnh chiều cao để giữ tỷ lệ */
        object-fit: cover; /* Hiển thị đẹp, cắt ảnh cho vừa khung */
        border-radius: 6px;
        margin-bottom: 0.75rem;
    }

    .news-card h3 {
      font-size: 1rem;
      margin-bottom: 0.5rem;
    }
    .news-card p {
      font-size: 0.875rem;
      color: #666;
    }
    .news-card a {
      color: #00796b;
      text-decoration: none;
      font-weight: bold;
      font-size: 0.875rem;
    }
    .toggle-btn-container {
      text-align: center;
      margin-top: 1rem;
    }
    .hidden-row {
      display: none;
    }
    .news-card-row {
      display: flex;
      gap: 1.5rem;
      flex-wrap: wrap;
      justify-content: center;
      margin-bottom: 1.5rem;
    }
    footer {
      background-color: #004d40;
      color: white;
      padding: 2rem;
      text-align: center;

    }
    .footer-content {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      gap: 2rem;
    }
    footer img {
      height: 60px;
    }
    iframe {
      width: 100%;
      max-width: 600px;
      height: 300px;
      border: none;
    }
    .social-icons a {
      color: white;
      margin: 0 10px;
      font-size: 1.2rem;
    }
    /* Chatbox Container */
       .chat-container {
           position: fixed;
           bottom: 20px;
           right: 20px;
           width: 300px;
           height: 400px;
           background-color: white;
           border: 1px solid #ccc;
           box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
           z-index: 9999;
           display: flex;
           flex-direction: column;
       }

       /* Header của chat */
       .chat-header {
           background-color: #00796b;
           color: white;
           padding: 10px;
           text-align: center;
           font-weight: bold;
           cursor: pointer;
           border-radius: 8px 8px 0 0;
       }

       /* Phần nội dung chat */
       .chat-body {
           flex: 1;
           overflow-y: auto; /* Thanh cuộn khi tin nhắn vượt quá chiều cao */
           padding: 10px;
           background-color: #f9f9f9;
           max-height: 100%; /* Đảm bảo phần chat-body không vượt quá chiều cao container */
       }

       /* Tin nhắn của admin */
       .chat-body .message.admin {
           background-color: #00796b;
           color: white;
           text-align: left;
           padding: 10px;
           margin: 5px 0;
           border-radius: 8px;
       }

       /* Tin nhắn của user */
       .chat-body .message.user {
           background-color: #e0f7fa;
           color: #00796b;
           text-align: right;
           padding: 10px;
           margin: 5px 0;
           border-radius: 8px;
       }

       /* Footer của chat */
       .chat-footer {
           display: flex;
           padding: 10px;
           background-color: #f1f1f1;
           border-radius: 0 0 8px 8px;
       }

       /* Input message */
       .chat-footer input {
           flex: 1;
           padding: 10px;
           border: none;
           border-radius: 20px;
           margin-right: 10px;
       }

       /* Gửi tin nhắn */
       .chat-footer button {
           background-color: #00796b;
           color: white;
           padding: 10px;
           border: none;
           border-radius: 20px;
           cursor: pointer;
       }

       /* Khi hover vào button */
       .chat-footer button:hover {
           background-color: #004d40;
       }
  </style>
</head>
<body>
<header>
    <h1>Mạng lưới Cựu Sinh Viên</h1>
    <nav>
        <a href="User">Trang chủ</a>
        <a href="New">Tin Tức & Sự kiện</a>
        <a href="Profile">Thông tin cá nhân</a>
        <a href="Link">Liên kết sinh viên</a>
        <a href="#" id="contactLink">Liên hệ</a>
        <a href="index">Đăng xuất</a>
    </nav>
</header>



<main>
  <section>
    <h2>Thông tin bài viết</h2>

    <!-- Dòng 1 -->
    <div class="news-card-row">
      <%
           if (infoList != null && !infoList.isEmpty()) {
               for (addtintucsukien info : infoList) { %>
            <div class="news-card">
              <img src="uploads/<%= info.getHinhanh() %>" alt="Hình ảnh sự kiện" style="width: 100%; height: 300px; border-radius: 8px;">
                <h3><%= info.getTieude() %></h3>
              <p>Thời gian: <%= info.getThoigian() %></p>
              <p><%= info.getNoidung() %></p>
            </div>
            <%
                     }
                 } else { %>
                     <div style="background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 1rem;">
                         Chưa có dữ liệu
                     </div>
             <% } %>
    </div>


  </section>


</main>


<div class="chat-container" style="visibility: visible;">
      <div class="chat-header" onclick="toggleChat()">Liên Hệ với Admin</div>
      <div class="chat-body" id="chatBody">

      <%
          String ten = (String) request.getAttribute("ten");
          List<mess> showtinnhan = (List<mess>) request.getAttribute("chatmess");
          if (ten != null && !ten.isEmpty() && showtinnhan != null && !showtinnhan.isEmpty()) {
          for (mess info : showtinnhan) {
          if (info.getEmailgui().equals("admin") && info.getEmailnhan().equals(ten)) {
      %>

        <div class="message admin" ><%= info.getTinnhan() %></div>
        <%
        } else
        if (info.getEmailgui().equals(ten) && info.getEmailnhan().equals("admin")) {
        %>
        <div class="message user" ><%= info.getTinnhan() %></div>
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
      <form class="chat-footer" action="Tintuc" method="POST">
        <input type="text" id="messageInput" name="messageInput" required placeholder="Nhập tin nhắn..." />
        <button onclick="sendMessage()" name="mess" value="chat">Gửi</button>
      </form>

    </div>

<script>
    var chatBody = document.getElementById("chatBody");
    chatBody.scrollTop = chatBody.scrollHeight;


    document.getElementById('contactLink').addEventListener('click', function(e) {
        e.preventDefault();
        const chatContainer = document.querySelector('.chat-container');
        if (chatContainer.style.display === 'none' || chatContainer.style.display === '') {
            chatContainer.style.display = 'flex';
        } else {
            chatContainer.style.display = 'none';
        }
    });


</script>
<footer style="background-color: #00796b; color: white; padding: 40px 20px;">
    <div style="display: flex; justify-content: space-between; flex-wrap: wrap;">
        <div style="flex: 1; min-width: 300px;">
            <img src="https://upload.wikimedia.org/wikipedia/vi/thumb/5/5a/Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg/2560px-Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg.png" alt="VKU Logo" style="height: 60px;">
            <p style="margin-bottom: 20px;"><strong>MẠNG LƯỚI CỰU SINH VIÊN</strong><br>VKU Alumni Network</p>
            <p style="margin-bottom: 20px;">Văn phòng Mạng lưới Cựu sinh viên<br style="margin-bottom: 20px;">Trường Đại học Công nghệ Thông tin và Truyền thông Việt – Hàn (VKU)</p>
            <p style="margin-bottom:20px;">Địa chỉ: Số 470 Trần Đại Nghĩa, Quận Ngũ Hành Sơn, TP. Đà Nẵng</p>
            <p style="margin-bottom: 20px;">Điện thoại: 0236.6.552.688<br style="margin-bottom: 20px;">Email: alumni@vku.udn.vn</p>
        </div>
        <div style="flex: 1; min-width: 300px;">
           <iframe
               src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3834.190454951763!2d108.24982717598672!3d16.031491540827465!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31421837dd43c7c5%3A0xd269f3f2a53ef031!2zVmlldC1LYWhhbiBVbml2ZXJzaXR5IC0gVktV!5e0!3m2!1svi!2s!4v1715140581080!5m2!1svi!2s"
               width="600" height="300" style="border:0;" allowfullscreen="" loading="lazy"
               referrerpolicy="no-referrer-when-downgrade">
           </iframe>

        </div>
    </div >
        <div >
            <p style="margin: 10px 0;">Copyright © 2025 VKU Alumni Network. All rights reserved</p>
            <p style="margin: 5px 0;">Website đang trong giai đoạn thử nghiệm</p>
            <div style="margin-top: 10px;">
                <a href="#" style="color: white; font-weight: bold; margin: 0 15px; font-size: 18px;">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#" style="color: white; font-weight: bold; margin: 0 15px; font-size: 18px;">
                    <i class="fab fa-youtube"></i>
                </a>
                <a href="#" style="color: white; font-weight: bold; margin: 0 15px; font-size: 18px;">
                    <i class="fab fa-tiktok"></i>
                </a>
            </div>
        </div>
    </div>
</footer>

</body>
</html>
