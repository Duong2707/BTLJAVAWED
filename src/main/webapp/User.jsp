<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.mess" %>
<%@ page import="model.addtintucsukien" %>
<%
    List<addtintucsukien> infoList = (List<addtintucsukien>) request.getAttribute("infoList1");
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
            padding-top: 65px;
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
            text-decoration: none;
            font-weight: bold;
        }


        .banner-slider {
            position: relative;
            width: 100%;
            height: 600px;
            overflow: hidden;

        }

        .slide {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        .slide.active {
            opacity: 1;
            z-index: 2;
        }

        .intro-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 700;
            display: flex;
            justify-content: center;
            align-items: center;
            pointer-events: none;
            margin-top: 0.3rem;
        }

        .intro-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 1.5rem;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            width: 90%;
            max-width: 600px;
            text-align: center;
            pointer-events: auto;
        }

        .intro-box .logo {
            width: 200px;
            margin-bottom: 1rem;
        }

        .intro-box h2 {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: #003366;
        }

        .intro-box p {
            color: #333;
            font-size: 1rem;
            line-height: 1.5;
        }

        .events-section {
            position: relative;
            margin-top: 0.3rem;
            background-image: url('https://img.freepik.com/free-photo/audience-concert-night_23-2149892259.jpg');
            background-size: cover;
            background-position: center;
            padding: 4rem 2rem;
            color: white;
            text-align: center;
            z-index: 1;
        }

        .events-section::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .events-section > * {
            position: relative;
            z-index: 1;
        }

        .section-title {
            font-size: 2rem;
            margin-bottom: 2rem;
            font-weight: bold;
        }

        .event-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .event-card {
            background: white;
            color: black;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            width: 300px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .event-card:hover {
            transform: translateY(-5px);
        }

        .event-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .event-info {
            padding: 1rem;
            text-align: left;
        }

        .event-info h3 {
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }

        .event-info p {
            color: #777;
            font-size: 0.9rem;
            margin: 0;
        }

        .event-button {
            text-align: center;
        }

        .see-more-btn {
            background-color: transparent;
            color: white;
            border: 2px solid white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            font-weight: bold;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .see-more-btn:hover {
            background-color: white;
            color: #ff512f;
        }

        footer {
            background-color: #004d40;
            color: white;
            text-align: center;
            padding: 1rem;
        }

        .core-values {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            gap: 10rem;
            padding: 3rem 2rem;
            text-align: center;
            background-color: #f9f9f9;
            flex-wrap: wrap;
        }

        .value-item {
            flex: 0 0 auto;
            width: 200px;
        }

        .value-item i {
            font-size: 3rem;
            color: #00796b;
            margin-bottom: 1rem;
        }
        .student-network {
            background: #ffffff;
            padding: 4rem 2rem;
            text-align: center;
        }
        .student-network-title {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            color: #00796b;
            margin-bottom: 2rem;
        }

        .student-cards {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
            margin-top: 2rem;
        }

        .student-card {
            background: #e0f2f1;
            border-radius: 1rem;
            padding: 2rem;
            width: 280px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .student-card:hover {
            transform: translateY(-5px);
        }

        .student-card i {
            font-size: 3rem;
            color: #00796b;
            margin-bottom: 1rem;
        }

        .student-card h3 {
            margin: 0.5rem 0;
            font-size: 1.2rem;
            color: #004d40;
        }

        .student-card p {
            font-size: 0.95rem;
            color: #333;
            margin-bottom: 1.5rem;
        }

        .join-btn {
            background-color: #00796b;
            color: white;
            padding: 0.5rem 1.2rem;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .join-btn:hover {
            background-color: #004d40;
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

<div class="banner-slider">
    <img src="https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img/https://vku.udn.vn//wp-content/uploads/2023/11/Campus-VKU.png" class="slide active">
    <img src="https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_2560,h_1216/https://vku.udn.vn/wp-content/uploads/2023/11/Goc-phai-scaled.jpg" class="slide">
    <img src="https://navigates.vn/wp-content/uploads/2023/09/co-so-vat-chat-truong.jpg" class="slide">
</div>

<div class="intro-overlay">
    <div class="intro-box">
        <img src="https://pfst.cf2.poecdn.net/base/image/5d0d7ec82cb03979edab10c36cc1167047739b84a6601c66986605cde16a64a2?w=1024&h=768&pmaid=370375412" class="logo" alt="logo">
        <h2>TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN VÀ TRUYỀN THÔNG VIỆT - HÀN</h2>
        <p>
            Là một trường đại học công lập hàng đầu về công nghệ thông tin và truyền thông tại khu vực miền Trung Việt Nam.
            VKU cam kết đào tạo nguồn nhân lực chất lượng cao, nghiên cứu khoa học và chuyển giao công nghệ tiên tiến trong lĩnh vực CNTT&TT, góp phần vào sự phát triển kinh tế - xã hội của đất nước.
        </p>
        <p>
            Nơi đây không chỉ là nơi đào tạo nguồn nhân lực chất lượng cao mà còn là ngôi nhà thứ hai của hàng trăm ngàn sinh viên, học viên và nghiên cứu sinh.
        </p>
    </div>
</div>

<section class="core-values">
    <div class="value-item">
        <i class="fas fa-graduation-cap"></i>
        <h3>Kết tinh tri thức</h3>
    </div>
    <div class="value-item">
        <i class="fas fa-lightbulb"></i>
        <h3>Kiến tạo cơ hội</h3>
    </div>
    <div class="value-item">
        <i class="fas fa-handshake"></i>
        <h3>Chia sẻ thành công</h3>
    </div>
</section>

<section class="events-section">
    <h2 class="section-title">TIN TỨC & SỰ KIỆN</h2>
    <div class="event-cards">
        <%
            if (infoList != null && !infoList.isEmpty()) {
                for (addtintucsukien info : infoList) { %>
                <div class="event-card">
                    <img src="uploads/<%= info.getHinhanh() %>" alt="Hình ảnh sự kiện">
                    <div class="event-info">
                        <h3>Tiêu đề: <%= info.getTieude() %></h3>
                        <p>Thời gian: <%= info.getThoigian() %></p>
                    </div>
                </div>
                <%
                    }
                }%>

    </div>
    <div class="event-button">
        <a href="New" class="see-more-btn">XEM THÊM </a>
    </div>
</section>
<section class="student-network">
    <h2 class="student-network-title">LIÊN KẾT SINH VIÊN</h2>
    <div class="student-cards">
        <div class="student-card">
            <i class="fas fa-users"></i>
            <h3>Nhóm Cựu Sinh Viên</h3>
            <p>Kết nối với các nhóm cựu sinh viên theo ngành, khóa hoặc sở thích.</p>
            <a href="https://www.facebook.com/groups/tennhomcuaschool" class="join-btn">Tham gia</a>
        </div>
        <div class="student-card">
            <i class="fas fa-chalkboard-teacher"></i>
            <h3>Hướng Dẫn Thực Tập</h3>
            <p>Cựu sinh viên chia sẻ kinh nghiệm, định hướng và giới thiệu nơi thực tập cho sinh viên.</p>
            <a href="Link" class="join-btn">Xem chi tiết</a>
        </div>
        <div class="student-card">
            <i class="fas fa-briefcase"></i>
            <h3>Cơ Hội Nghề Nghiệp</h3>
            <p>Khám phá các vị trí tuyển dụng từ mạng lưới cựu sinh viên và doanh nghiệp.</p>
            <a href="Link" class="join-btn">Xem việc làm</a>
        </div>
    </div>
</section>
<div class="chat-container" >
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
      <form class="chat-footer" action="User" method="POST">
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

<script>
    const slides = document.querySelectorAll('.slide');
    let currentIndex = 0;

    function showNextSlide() {
        // ẩn slide hiện tại
        slides[currentIndex].classList.remove('active');

        // chuyển sang slide tiếp theo, nếu vượt qua cuối thì quay lại slide đầu
        currentIndex = (currentIndex + 1) % slides.length;

        // hiển thị slide mới
        slides[currentIndex].classList.add('active');
    }

    // tự động chuyển slide mỗi 3 giây
    setInterval(showNextSlide, 3000);
</script>

<footer style="background-color: #00796b; color: white; padding: 40px 20px;">
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
