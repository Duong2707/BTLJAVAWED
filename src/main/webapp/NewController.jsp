<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.addtintucsukien" %>
<%
    List<addtintucsukien> infoList = (List<addtintucsukien>) request.getAttribute("infoList");
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
            background: linear-gradient(to right,#ffffff, #ffffff);
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

        .banner-slider {
            position: relative;
            width: 100%;
            height: 600px;
            overflow: hidden;
            margin-top: 0.3rem;
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
            z-index: 999;
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
            background-color: #000000;
            color: white;
            text-align: center;
            margin-top: 50px;
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
            background: #f0f0f0;;
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
        section {

            background-color: #f4f4f4;
        }

        h2 {
            text-align: center;
            font-size: 2rem;
            color: #00796b;
            margin-bottom: 2.5rem;
            font-weight: bold;
        }

        .event-list {
            max-width: 1000px;
            margin: auto;
            display: flex;
            flex-wrap: wrap; /* Cho phép các thẻ xuống dòng khi không đủ chỗ */
            gap: 20px;
        }

        .event-card {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            flex: 1 1 calc(30% - 20px);
            position: relative;
            transition: box-shadow 0.3s ease;
            min-width: 250px;/* Hiệu ứng chuyển động */
        }

        .event-card:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); /* Hiệu ứng hover */
        }

        .event-card h3 {
            margin: 0;
            font-size: 1.5rem;
            color: #003366;
        }

        .delete-button {
            padding: 0.5rem 1rem;
            font-size: 1rem;
            background-color: #ff0000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 15px;
            right: 15px; /* Đặt nút xóa ở góc phải trên */
        }

        p {
            color: #777;
            margin: 5px 0;
        }

        img {
            width: 80%; /* Đặt để hình ảnh chiếm toàn bộ chiều rộng */
            height: auto;
            border-radius: 8px;
            margin-top: 10px; /* Khoảng cách giữa nội dung và hình ảnh */
        }

        .no-data {
            background: white;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 1rem;
            text-align: center; /* Căn giữa cho thông báo không có dữ liệu */
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
<section style="padding: 4rem 2rem; background-color: #f4f4f4;">
    <h2 style="text-align: center; font-size: 2rem; color: #00796b; margin-bottom: 2.5rem; font-weight: bold;">
        Thêm Tin Tức / Sự Kiện Mới
    </h2>

    <form action="NewController" method="post" enctype="multipart/form-data"
          style="max-width: 800px; margin: auto; background: white; padding: 2rem; border-radius: 1rem; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">

        <div style="margin-bottom: 1.5rem;">
            <label for="title" style="display: block; margin-bottom: 0.5rem; font-weight: bold; color: #333;">Tiêu đề sự kiện:</label>
            <input type="text" id="title" name="title" required
                   style="width: 100%; padding: 0.75rem; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem;">
        </div>

        <div style="margin-bottom: 1.5rem;">
            <label for="image" style="display: block; margin-bottom: 0.5rem; font-weight: bold; color: #333;">Hình ảnh minh họa:</label>
            <input type="file" id="image" name="image" accept="image/*" required
                   style="width: 100%; padding: 0.75rem; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem;">
        </div>

        <div style="margin-bottom: 1.5rem;">
            <label for="date" style="display: block; margin-bottom: 0.5rem; font-weight: bold; color: #333;">Ngày đăng:</label>
            <input type="date" id="date" name="date" required
                   style="width: 100%; padding: 0.75rem; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem;">
        </div>

        <div style="margin-bottom: 1.5rem;">
            <label for="content" style="display: block; margin-bottom: 0.5rem; font-weight: bold; color: #333;">Nội dung chính:</label>
            <textarea id="content" name="content" rows="6" required
                      style="width: 100%; padding: 0.75rem; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem;"></textarea>
        </div>

        <div style="text-align: center;">
            <button type="submit" value="add" name="action"
                    style="background-color: #00796b; color: white; padding: 0.75rem 2rem; border: none; border-radius: 6px; font-weight: bold; font-size: 1rem; cursor: pointer; transition: background-color 0.3s;">
                Thêm Sự Kiện
            </button>
        </div>
    </form>

    <section>
        <h2>Danh Sách Tin Tức / Sự Kiện</h2>

        <div class="event-list">
            <%
                if (infoList != null && !infoList.isEmpty()) {
                    for (addtintucsukien info : infoList) { %>
            <div class="event-card">
                <h3>Tiêu đề: <%= info.getTieude() %></h3>
                <form action="NewController" method="POST" style="display:inline;">
                    <input type="hidden" name="id" value="<%= info.getId() %>"/>
                    <button type="submit" class="delete-button" name="action" value="delete">
                        Xoá
                    </button>
                </form>
                <p>Thời gian: <%= info.getThoigian() %></p>
                <p>Nội dung:</p>
                <p><%= info.getNoidung() %></p>
                <img src="uploads/<%= info.getHinhanh() %>" alt="Hình ảnh sự kiện">
            </div>
            <%
                }
            } else { %>
            <div class="no-data">
                Chưa có dữ liệu
            </div>
            <% } %>
        </div>
    </section>
</section>

<footer style="background-color: #000000;; color: white; padding: 40px 20px;">
    <div style="display: flex; justify-content: space-between; flex-wrap: wrap;">
        <div style="flex: 1; min-width: 300px;">
            <img src="https://upload.wikimedia.org/wikipedia/vi/thumb/5/5a/Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg/2560px-Logo_tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_C%C3%B4ng_ngh%E1%BB%87_th%C3%B4ng_tin_v%C3%A0_Truy%E1%BB%81n_th%C3%B4ng_Vi%E1%BB%87t_-_H%C3%A0n%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_%C4%90%C3%A0_N%E1%BA%B5ng.svg.png" alt="VKU Logo" style="height: 70px; width: 120px">
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

</body>
</html>
