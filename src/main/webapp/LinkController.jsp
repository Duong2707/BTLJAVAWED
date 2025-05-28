<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.addcongviec" %>
<%@ page import="model.addsinhviendangbaicongviec" %>
<%
    List<addcongviec> infoList = (List<addcongviec>) request.getAttribute("infoList");
    List<addsinhviendangbaicongviec> infoList1 = (List<addsinhviendangbaicongviec>) request.getAttribute("infoList1");
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
        }

        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            width: 100%;
            background: #000000;
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 800;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            box-sizing: border-box;
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

        section {
            display: flex;
            padding: 2rem;
            gap: 2rem;
            min-height: 600px;
            margin-top: 3rem;
            background-color: #f4f4f4;
            border-radius: 8px;
        }

        aside {
            width: 250px;
            background: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 1rem;
        }

        main {
            flex: 1;
            background: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 1rem;
        }

        button {
            padding: 1rem;
            background: #00796b;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .tab-content {
            display: none;
        }

        .job-list div {
            background: #f4f4f4;
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            position: relative;
        }

        /* CSS cho phần "Cơ hội nghề nghiệp" */
        .job-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            width: 70%;
            max-width: 800px;
        }

        .job-form div {
            display: flex;
            justify-content: space-between;
        }

        .job-list {
            display: flex;
            flex-wrap: wrap; /* Cho phép xuống dòng khi không đủ chỗ */
            justify-content: space-between; /* Căn đều các thẻ */
            gap: 10px; /* Khoảng cách giữa các thẻ */
        }

        .job-list div {
            flex: 0 0 calc(45% - 20px); /* Chiếm 50% chiều rộng trừ khoảng cách */
            background: #f4f4f4;
            padding: 1rem;
            border-radius: 8px;
            position: relative;
        }
        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Căn giữa theo trục ngang */
            justify-content: center; /* Căn giữa theo trục dọc */
            gap: 2rem; /* Khoảng cách giữa form và danh sách */
            padding: 2rem; /* Padding cho container */
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

<section>
    <!-- Sidebar chọn chức năng -->
    <aside>
        <nav style="display: flex; flex-direction: column; gap: 1rem;">
            <button onclick="showTab('alumni')">Nhóm Cựu Sinh Viên</button>
            <button onclick="showTab('internship')">Hướng Dẫn Thực Tập</button>
            <button onclick="showTab('career')">Cơ Hội Nghề Nghiệp</button>
        </nav>
    </aside>

    <!-- Nội dung sẽ thay đổi -->
    <main>
        <!-- Nhóm cựu sinh viên -->
        <div id="alumni" class="tab-content" >
            <h2>Nhóm Cựu Sinh Viên</h2>
            <p>Tham gia cộng đồng VKU Alumni trên Facebook để kết nối và chia sẻ.</p>
            <a href="https://www.facebook.com/groups/tennhomcuaschool" target="_blank" style="color: #00796b; font-weight: bold;">Truy cập nhóm Facebook tại đây</a>
        </div>

        <!-- Hướng dẫn thực tập -->
        <div id="internship" class="tab-content">
            <h2>Danh sách vị trí thực tập</h2>
            <div style="display: flex; flex-direction: column; gap: 1.5rem; margin-top: 1rem;">
                <!-- Mỗi công ty là 1 card -->
                <%
                    if (infoList1 != null && !infoList1.isEmpty()) {
                        for (addsinhviendangbaicongviec info : infoList1) { %>
                <div style="padding: 1rem; background: #f0f0f0; border-radius: 1rem;">
                    <h3>Tên công ty: <%= info.getTencongty() %></h3>
                    <p><strong>Địa chỉ:</strong> <%= info.getDiachicongty() %></p>
                    <p><strong>Vị trí ứng tuyển:</strong> <%= info.getVitrituyen() %></p>
                    <p><strong>Thời gian làm việc:</strong> <%= info.getThoigianlamviec() %></p>
                    <p><strong>Mô tả:</strong> <%= info.getMotacongviec() %></p>
                    <p><strong>Lương hỗ trợ:</strong> <%= info.getMucluonghotro() %></p>
                    <p><strong>Thời gian thực tập:</strong> <%= info.getThoigianthuctap() %></p>
                    <p><strong>Email nhân sự:</strong> <%= info.getEmaillienhe() %></p>
                </div>
                <%
                    }
                } else { %>
                <div style="background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 1rem;">
                    Chưa có dữ liệu
                </div>
                <% } %>
            </div>
        </div>

        <!-- Cơ hội nghề nghiệp -->
        <div id="career" class="tab-content" style="text-align: center; display: block">
            <h2>Đăng tin tuyển dụng</h2>
            <div class="form-container">
            <form action="LinkController" method="post" enctype="multipart/form-data" class="job-form" >
                <div>
                    <label style="flex: 1;">Hình ảnh minh họa:</label>
                    <input type="file" name="image" accept="image/*" required style="flex: 2;">
                </div>
                <div>
                    <label style="flex: 1;">Tên công ty:</label>
                    <input type="text" name="company" required style="flex: 2;">
                </div>
                <div>
                    <label style="flex: 1;">Vị trí tuyển:</label>
                    <input type="text" name="position" required style="flex: 2;">
                </div>
                <div>
                    <label style="flex: 1;">Thời gian:</label>
                    <input type="text" name="duration" required style="flex: 2;">
                </div>
                <div style="display: flex; flex-direction: column;">
                    <label>Mô tả công việc:</label>
                    <textarea name="description" rows="4" required style="width: 100%;"></textarea>
                </div>
                <button type="submit" name="action" value="add" style="padding: 0.75rem; background: #00796b; color: white; border: none; border-radius: 8px;">Đăng bài</button>
            </form>

            <h2 style="margin-top: 2rem;">Danh sách tin tuyển dụng</h2>
            <div class="job-list">
                <%
                    if (infoList != null && !infoList.isEmpty()) {
                        for (addcongviec info : infoList) { %>
                <div style="background: #f4f4f4; padding: 1rem; margin-bottom: 1rem; border-radius: 8px; position: relative;">
                    <h3 style="margin: 0;">Công ty: <%= info.getTencongty() %></h3>
                    <form action="LinkController" method="POST" style="display: inline; position: absolute; top: 10px; right: 10px;">
                        <input type="hidden" name="id" value="<%= info.getId() %>"/>
                        <button type="submit" class="action-button" name="action" value="delete" style="padding: 0.5rem 1rem; font-size: 1rem; background-color: #ff0000; color: white; border: none; border-radius: 5px; cursor: pointer;">
                            Xoá
                        </button>
                    </form>
                    <p><strong>Vị trí: <%= info.getVitrituyenchon() %></strong></p>
                    <p><strong>Thời gian: <%= info.getThoigian() %></strong></p>
                    <p><strong>Mô tả: <%= info.getNoidung() %></strong></p>
                    <img src="uploads/<%= info.getHinhanh() %>" alt="Hình ảnh công việc" style="width: 50%; height: auto; border-radius: 8px;">
                </div>
                <%
                    }
                } else { %>
                <div style="background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 1rem;">
                    Chưa có dữ liệu
                </div>
                <% } %>
            </div>
            </div>
        </div>
    </main>
</section>

<script>
    function showTab(id) {
        const tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(tab => tab.style.display = 'none');
        document.getElementById(id).style.display = 'block';
    }
</script>

<footer style="background-color: #000000;; color: white; padding: 40px 20px;text-align: center">
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

</body>
</html>