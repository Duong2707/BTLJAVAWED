<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.addsinhviendangbaicongviec" %>
<%@ page import="model.addcongviec" %>
<%@ page import="model.mess" %>
<%
    List<addsinhviendangbaicongviec> infoList = (List<addsinhviendangbaicongviec>) request.getAttribute("infoList");
    List<addcongviec> infoList1 = (List<addcongviec>) request.getAttribute("infoList1");
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
    main {
      display: flex;
      max-width: 1200px;
      margin: 2rem auto;
      gap: 2rem;
    }
    .sidebar {
      width: 250px;
      background: #ffffff;
      padding: 1rem;
      margin-top: 2rem;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .sidebar button {
      display: block;
      width: 100%;
      margin-bottom: 1rem;
      padding: 10px;
      border: none;
      border-radius: 6px;
      background-color: #00796b;
      color: white;
      font-weight: bold;
      cursor: pointer;
    }
    .content {
      flex: 1;
      background: white;
      padding: 1rem;
      margin-top: 2rem;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .content-section {
      display: none;
    }
    .content-section.active {
      display: block;
    }
    footer {
      background-color: #004d40;
      color: white;
      padding: 1rem;
      text-align: center;
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

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        font-family: 'Arial', sans-serif;
    }
    th, td {
        text-align: left;
        padding: 12px;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f0f0f0;
        font-weight: bold;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9; /* Đổi màu hàng chẵn để dễ nhìn */
    }
    tr:hover {
        background-color: #f1f1f1; /* Hiệu ứng hover */
    }
    .action-button {
        background-color: red; /* Màu nền đỏ cho nút xóa */
        color: white; /* Màu chữ trắng */
        border: none;
        padding: 5px 10px;
        border-radius: 4px;
        cursor: pointer;
    }
    .action-button:hover {
        background-color: darkred; /* Màu nền khi hover */
    }
    .career-section {
        margin: 20px;
    }

    .job-card {
        display: flex;
        gap: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        padding: 16px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        align-items: center;
        margin-bottom: 20px; /* Khoảng cách giữa các cơ hội */
    }

    .job-card img {
        width: 120px;
        height: 80px;
        object-fit: cover;
        border-radius: 6px;
    }

    .job-card h3 {
        margin: 0 0 8px 0;
        font-size: 1.2rem;
        color: #00796b;
    }

    .job-card p {
        margin: 4px 0;
        color: #333;
        line-height: 1.5; /* Tăng khoảng cách giữa các dòng */
    }

    .job-card button {
        background-color: #00796b;
        color: white;
        padding: 10px 16px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
    }

    .job-card button:hover {
        background-color: #005b4b; /* Màu nền khi hover */
    }

    .no-data {
        background: white;
        padding: 1.5rem;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        margin-bottom: 20px; /* Khoảng cách dưới */
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
  <div class="sidebar">
    <button onclick="window.open('https://www.facebook.com/groups/tennhomcuusinhvien', '_blank')">Nhóm cựu sinh viên</button>
    <button onclick="showSection('intern')">Hướng dẫn thực tập</button>
    <button onclick="showSection('career')">Cơ hội nghề nghiệp</button>
  </div>

  <div class="content">
    <!-- Phần hướng dẫn thực tập -->
    <div id="intern" class="content-section active">
      <h2>Đăng bài tuyển thực tập sinh</h2><br>
      <form id="Link" method="POST">
        <input type="text" id="company" name="tencongty" placeholder="Tên công ty" required style="width: 100%; padding: 8px; margin-bottom: 8px;" />
        <input type="text" id="address" name="diachicongty" placeholder="Địa chỉ công ty" required style="width: 100%; padding: 8px; margin-bottom: 8px;" />
        <input type="text" id="timework" name="thoigianlamviec" placeholder="Thời gian làm việc" required style="width: 100%; padding: 8px; margin-bottom: 8px;" />
        <input type="text" id="position" name="vitrituyen" placeholder="Vị trí tuyển" required style="width: 100%; padding: 8px; margin-bottom: 8px;" />
        <textarea id="description" name="motacongviec" placeholder="Mô tả công việc" required style="width: 100%; padding: 8px; margin-bottom: 8px;"></textarea>
        <textarea id="pay" name="mucluonghotro" placeholder="Mức lương hỗ trợ" required style="width: 100%; padding: 8px; margin-bottom: 8px;"></textarea>
        <textarea id="time" name="thoigianthuctap" placeholder="Thời gian thực tập" required style="width: 100%; padding: 8px; margin-bottom: 8px;"></textarea>
        <input type="email" name="emaillienhe" id="contact" placeholder="Email liên hệ nhân sự" required style="width: 100%; padding: 8px; margin-bottom: 8px;" />
        <button type="submit" name="action" value="add" style="padding: 10px 20px; background-color: #00796b; color: white; border: none; border-radius: 4px;">Đăng bài</button>
      </form>

      <div id="internshipPosts">
      <br>
        <h3>Bài đăng tuyển thực tập</h3><br>
        <table border="1" cellspacing="0" cellpadding="8" style="width: 100%; border-collapse: collapse;">
          <thead>
            <tr style="background-color: #f0f0f0;">
              <th>Tên công ty</th>
              <th>Địa chỉ</th>
              <th>Thời gian làm việc</th>
              <th>Vị trí</th>
              <th>Mô tả</th>
              <th>Mức lương hỗ trợ</th>
              <th>Thời gian thực tập</th>
              <th>Email liên hệ</th>
              <th>Xóa</th>
            </tr>

          </thead>
          <tbody id="postList">

          <%
              if (infoList != null && !infoList.isEmpty()) {
                  for (addsinhviendangbaicongviec info : infoList) { %>
                      <tr>
                          <td><%= info.getTencongty() %></td>
                          <td><%= info.getDiachicongty() %></td>
                          <td><%= info.getThoigianlamviec() %></td>
                          <td><%= info.getVitrituyen() %></td>
                          <td><%= info.getMotacongviec() %></td>
                          <td><%= info.getMucluonghotro() %></td>
                          <td><%= info.getThoigianthuctap() %></td>
                          <td><%= info.getEmaillienhe() %></td>
                          <td>

                              <form action="Link" method="POST" style="display:inline;">
                                  <input type="hidden" name="id" value="<%= info.getId() %>"/>
                                  <button type="submit" class="action-button" name="action" value="delete">Xoá</button>
                              </form>
                          </td>

                      </tr>
          <%
                  }
              } else { %>
                  <tr>
                      <td colspan="9">Không có dữ liệu để hiển thị.</td>
                  </tr>
          <% } %>

          </tbody>
        </table>
      </div>
    </div>

    <!-- Phần cơ hội nghề nghiệp -->
    <div id="career" class="content-section">
      <h2>Cơ hội nghề nghiệp</h2>
      <!-- Cơ hội 1 -->
      <%
            if (infoList1 != null && !infoList1.isEmpty()) {
                for (addcongviec info : infoList1) { %>
      <div class="job-card">
        <img src="uploads/<%= info.getHinhanh() %>" alt="Logo công ty">
        <div style="flex: 1">
          <h3><%= info.getTencongty() %></h3>
          <p><strong>Vị trí ứng tuyển:</strong><%= info.getVitrituyenchon() %></p>
          <p><strong>Thời gian:</strong><%= info.getThoigian() %></p>
          <p><strong>Mô tả:</strong> <%= info.getNoidung() %></p>
        </div>
        <div>
          <form enctype="multipart/form-data" onsubmit="submitCV(event, 'ABC')">
            <input type="file" name="cvFile" accept=".pdf,.doc,.docx" required style="margin-bottom: 8px;" />
            <button type="submit" style="background-color: #00796b; color: white; padding: 10px 16px; border: none; border-radius: 6px;">Nộp CV</button>
          </form>
        </div>
      </div>

      <%
              }
          } else { %>
              <div class="no-data">
                  Chưa có dữ liệu
              </div>
      <% } %>
    </div>
  </div>
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
      <form class="chat-footer" action="Link" method="POST">
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

<script>
  function showSection(id) {
    const sections = document.querySelectorAll(".content-section");
    sections.forEach(sec => sec.classList.remove("active"));
    document.getElementById(id).classList.add("active");
  }

  document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('intern');
    form.addEventListener('submit', function (e) {
      e.preventDefault();

      const company = document.getElementById('company').value.trim();
      const address = document.getElementById('address').value.trim();
      const timework = document.getElementById('timework').value.trim();
      const position = document.getElementById('position').value.trim();
      const description = document.getElementById('description').value.trim();
      const pay = document.getElementById('pay').value.trim();
      const time = document.getElementById('time').value.trim();
      const contact = document.getElementById('contact').value.trim();

      if (!company || !address || !timework || !position || !description || !pay || !time || !contact) {
        alert("Vui lòng điền đầy đủ thông tin!");
        return;
      }

      const row = document.createElement('tr');
      row.innerHTML = `
        <td>${company}</td>
        <td>${address}</td>
        <td>${timework}</td>
        <td>${position}</td>
        <td>${description}</td>
        <td>${pay}</td>
        <td>${time}</td>
        <td><a href="mailto:${contact}">${contact}</a></td>
      `;

      document.getElementById('postList').appendChild(row);
      form.reset();
    });
  });
</script>

</body>
</html>
