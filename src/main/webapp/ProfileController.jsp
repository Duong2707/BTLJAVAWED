<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.addsinhvien" %>
<%
    List<addsinhvien> infoList = (List<addsinhvien>) request.getAttribute("infoList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin Cựu Sinh Viên</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: #ffffff;
        }

        header {
            position: fixed;
            top: 0;
            left: 0;         /* Đảm bảo header bắt đầu từ bên trái */
            right: 0;        /* Mở rộng tới hết bên phải */
            width: 100%;     /* Đảm bảo full chiều ngang */
            background: #000;
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

        section {
            padding: 2rem;
            margin-top: 5rem;
        }

        h2 {
            text-align: center;
            color: #00796b;
        }

        .input-style {
            padding: 0.5rem;
            border-radius: 5px;
            border: 1px solid #ccc;
            min-width: 180px;
        }

        button {
            padding: 0.7rem 1.5rem;
            background: #00796b;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #004d40;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            margin-top: 2rem;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        thead {
            background: #00796b;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
        }

        .search-container {
            text-align: center;
            margin-top: 2rem;
        }

        .search-container button {
            margin-left: 0.5rem;
            padding: 0.5rem 1rem;
        }
        footer {
            background-color: #000000;
            color: white;
            text-align: center;
            margin-top: 50px;
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
    <h2>Thêm Cựu Sinh Viên</h2>
    <form action="AddAlumni" method="POST">
            <div style="display: flex; flex-wrap: wrap; gap: 1rem; justify-content: center;">
                <input type="text" name="name" placeholder="Họ và tên" class="input-style" required>
                <input type="email" name="email" placeholder="Email" class="input-style" required>
                <input type="tel" name="phone" placeholder="Số điện thoại" class="input-style" required>
                <input type="text" name="major" placeholder="Ngành học" class="input-style" required>
                <input type="text" name="class" placeholder="Lớp" class="input-style" required>
                <input type="text" name="year" placeholder="Khóa" class="input-style" required>
                <button type="submit" name="action" value="add">Thêm</button>
            </div>
        </form>

    <div class="search-container">
        <input type="text" id="search" placeholder="Tìm kiếm theo tên..." class="input-style" style="width: 300px;">
        <button onclick="filterList()">Tìm kiếm</button>
    </div>

    <table id="alumniTable">
        <thead>
            <tr>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Điện thoại</th>
                <th>Ngành</th>
                <th>Lớp</th>
                <th>Khóa</th>
                <th>Công ty</th>
                <th>Chức vụ</th>
                <th>Xóa</th>
            </tr>
        </thead>
        <tbody id="alumniList">
            <%
                    if (infoList != null && !infoList.isEmpty()) {
                        for (addsinhvien info : infoList) { %>
                            <tr>
                                <td><%= info.getName() %></td>
                                <td><%= info.getEmail() %></td>
                                <td><%= info.getPhone() %></td>
                                <td><%= info.getMajorCode() %></td>
                                <td><%= info.getGraduationClass() %></td>
                                <td><%= info.getUniversity() %></td>
                                <td><%= info.getCompanyName() %></td>
                                <td><%= info.getCv() %></td>
                                <td>

                                    <form action="AddAlumni" method="POST" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= info.getEmail() %>"/>
                                        <button type="submit" class="action-button" name="action" value="delete">Xoá</button>
                                    </form>
                                </td>

                            </tr>
                <%
                        }
                    } else { %>
                        <tr>
                            <td colspan="8">Không có dữ liệu để hiển thị.</td>
                        </tr>
                <% } %>
        </tbody>
    </table>
</section>

<footer style="background-color: #000000;; color: white; padding: 40px 20px;">
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

    function filterList() {
        const query = document.getElementById("search").value.toLowerCase();
        const rows = document.querySelectorAll("#alumniList tr");
        rows.forEach(row => {
            const name = row.cells[0].textContent.toLowerCase();
            row.style.display = name.includes(query) ? "" : "none";
        });
    }
</script>

</body>
</html>
