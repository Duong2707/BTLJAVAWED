# CĐ1_JAVAWB_XÂY DỰNG WEBSITE MẠNG LƯỚI CỰU SINH VIÊN TRƯỜNG 

## 🎯 Giới thiệu
Dự án là một ứng dụng web được phát triển với mục tiêu tạo ra một nền tảng kết nối cho cựu sinh viên của trường. Website này không chỉ giúp cựu sinh viên giữ liên lạc mà còn tạo ra một cộng đồng hỗ trợ lẫn nhau trong công việc và cuộc sống.Bằng việc sử dụng Java Web, ứng dụng được xây dựng dựa trên nền tảng Servlet và JSP, cho phép xử lý các yêu cầu từ người dùng một cách linh hoạt và hiệu quả. Người dùng có thể dễ dàng đăng ký tài khoản, đăng nhập, và truy cập vào các tính năng như tìm kiếm bạn học, chia sẻ tin tức, và kết nối với nhau. Website cũng cung cấp các thông tin hữu ích về sự kiện, cơ hội nghề nghiệp và các hoạt động của nhà trường.
Chúng tôi hy vọng rằng dự án này sẽ được tiếp tục phát triển và trở thành một công cụ hữu ích, giúp cựu sinh viên không chỉ duy trì mối quan hệ mà còn phát triển bản thân và hỗ trợ nhau trong hành trình nghề nghiệp. Với giao diện thân thiện và dễ sử dụng, dự án hướng tới việc tạo ra một trải nghiệm người dùng tốt nhất cho tất cả các thành viên trong cộng đồng.

# 📚 Mục Lục
- [🎯 Giới thiệu](#giới-thiệu)
- [🎯 Tính năng](#tính-năng)
- [📁 Cấu trúc dự án](#cấu-trúc-dự-án)
- [🛠️ Công nghệ sử dụng](#công-nghệ-sử-dụng)
- [⚙️ Yêu cầu cài đặt](#yêu-cầu-cài-đặt)
- [🚀 Hướng dẫn cài đặt dự án](#hướng-dẫn-cài-đặt-dự-án)

## 🎯 Tính năng
````
👤 Người dùng
- 🔐 Đăng ký, đăng nhập bảo mật: Hệ thống hỗ trợ đăng ký và đăng nhập an toàn cho cựu sinh viên với mật khẩu bảo mật.
- 📝 Cập nhật thông tin cá nhân: Cựu sinh viên có thể cập nhật thông tin cá nhân, chuyên ngành và nơi làm việc hiện tại để nhà trường theo dõi.
- 📰 Xem tin tức và sự kiện: Cập nhật thông tin về các tin tức và sự kiện của trường, giúp cựu sinh viên luôn nắm bắt được tình hình.
- 🤝 Kết nối và chia sẻ: Tạo mối quan hệ và liên kết với những người bạn cũ qua các nền tảng mạng xã hội hoặc thông qua bài viết tuyển dụng.
- ✉️ Liên hệ với nhà trường: Cựu sinh viên có thể liên hệ với nhà trường thông qua kênh chat để gửi câu hỏi hoặc phản hồi.
- 🛠️ Quản trị viên
- 📊 Quản lý người dùng: Quản trị viên có thể theo dõi và quản lý thông tin của cựu sinh viên.
- 📝 Cập nhật tin tức và sự kiện: Quản lý và cập nhật các tin tức, sự kiện quan trọng cho cựu sinh viên.
- 📈 Quản lý kết nối: Đăng các thông tin tuyển dụng, Xem các bài đăng tuyển thực tập sinh,...
- ✉️ Quản lí liên hệ: Trả lờ các thắc mắc của cựu sinh viên.
````
## 📁 Cấu trúc dự án
````

DOTHAODUONG_23ITB034/
│
├── .idea/                           ← Thư mục cấu hình IDE (IntelliJ)
├── .smarttomcat/                    ← Cấu hình plugin Tomcat
├── .gitignore                       ← File gitignore
├── pom.xml                          ← Cấu hình Maven: dependency, plugin,...
│
├── src/
│   └── main/
│       ├── java/
│       │   └── model/               ← Chứa lớp dữ liệu (Java Bean) + Controller + Servlet
│       │       ├── entity/         ← Các lớp thực thể (User, Profile, TinTuc,...)
│       │       │   ├── addcongviec.java
│       │       │   ├── addsinhvien.java
│       │       │   ├── addsinhviendangbaicongviec.java
│       │       │   ├── addtintucsukien.java
│       │       │   ├── chat.java
│       │       │   ├── mess.java
│       │       │   └── ...
│       │       │
│       │       ├── controller/     ← Các lớp điều khiển (Servlet hoặc Controller thường)
│       │       │   ├── AddAlumniServlet.java
│       │       │   ├── ContactLinkController.java
│       │       │   ├── Controller.java
│       │       │   ├── LinkController.java
│       │       │   ├── LoginServlet.java
│       │       │   ├── logout.java
│       │       │   ├── NewController.java
│       │       │   ├── ProfileController.java
│       │       │   └── ...
│       │       │
│       │       ├── service/        ← (nếu có xử lý logic nghiệp vụ riêng)
│       │       └── util/           ← (nếu có class tiện ích dùng chung)
│       │
│       ├── resources/              ← File cấu hình, ngôn ngữ,...
│       │   ├── application.properties
│       │   ├── messages.properties
│       │   └── ...
│       │
│       └── webapp/
│           ├── uploads/            ← Lưu file người dùng upload (ảnh, văn bản,...)
│           └── WEB-INF/
│               ├── jsp/           ← Chứa file giao diện người dùng (View)
│               │   ├── index.jsp
│               │   ├── login.jsp
│               │   ├── Link.jsp
│               │   ├── New.jsp
│               │   ├── Profile.jsp
│               │   ├── Tintuc.jsp
│               │   └── User.jsp
│               │
│               ├── controller-jsp/ ← (chứa các file .jsp tên Controller nếu dùng view chuyển tiếp nội bộ)
│               │   ├── ContactLinkController.jsp
│               │   ├── Controller.jsp
│               │   ├── LinkController.jsp
│               │   ├── NewController.jsp
│               │   └── ProfileController.jsp
│               │
│               └── web.xml         ← Cấu hình Servlet (nếu không dùng Spring)
│
├── target/                         ← Tự động sinh ra khi build Maven (chứa file WAR, class biên dịch,...)
│
└── README.md                       ← (tuỳ chọn) mô tả dự án, cách build/run,...

````

## 🛠️ Công nghệ sử dụng
````
- Backend: Java Servlet, JSP/Servlet API.
- Frontend: JSP, HTML, CSS, JavaScript.
- Database:  MySQL (qua XAMPP)
- Web Server: Apache Tomcat
- IDE: IntelliJ IDEA
````

## ⚙️ Yêu cầu cài đặt
Trước khi cài đặt, đảm bảo bạn đã cài:


| 🛠️ Công cụ              | ✅ Phiên bản khuyến nghị | 📌 Ghi chú                                      |
|--------------------------|--------------------------|------------------------------------------------|
| Java JDK                 | 17 trở lên               | Bắt buộc, nên dùng bản LTS                     |
| Maven                    | 3.8.x trở lên            | Dùng để quản lý thư viện và build dự án       |
| XAMPP                    | Mới nhất                 | Dùng làm cơ sở dữ liệu chính                   |
| phpMyAdmin (XAMPP)       | Mới nhất                 | Dễ thao tác với MySQL                          |
| IntelliJ IDEA / Eclipse | Mới nhất                 | Dùng để lập trình Java Servlet/JSP            |
| Git                      | Mới nhất                 | Clone source code từ GitHub                   |
| Apache Tomcat            | 9 hoặc 10 trở lên        | Làm web server để chạy JSP/Servlet            |

## 🚀 Hướng dẫn cài đặt dự án
1️⃣ Bước 1: Clone dự án
````
git clone https://github.com/Duong2707/BTLJAVAWED.git
cd BTLJAVAWED
````

2️⃣ Bước 2: Tạo cơ sở dữ liệu và cấu hình kết nối
🟢 Tạo database (MySQL):
````
Mở XAMPP, bật MySQL.
Truy cập http://localhost/phpmyadmin.
Tạo database tên là cuusinhvien.
Import file cuusinhvien.sql.
````
🟢 Cấu hình lại nếu mysql của bạn có sự khác biệt:
````
URL = "jdbc:mysql://localhost:3306/cuusinhvien";
USER = "root";
PASSWORD = "";
````

3️⃣ Bước 3: Build dự án bằng Maven
Cách thực hiện:
  ➡️ Mở Terminal (Linux/macOS) hoặc Command Prompt (Windows).
  ➡️ Dùng lệnh cd để chuyển vào thư mục chứa dự án.
  ````
      cd đường_dẫn_đến_thư_mục_dự_án
  ````
  ➡️ Sau đó chạy lệnh:
  ````
      mvn clean install
  ````

4️⃣ Bước 4: Cấu hình Tomcat trong IntelliJ IDEA
  1. Mở Run > Edit Configurations...
  2. Nhấn dấu + chọn Tomcat Server > Local
  3. Đặt tên cấu hình, ví dụ: Tomcat Local
  4. Phần Application Server, nhấn ... để chọn đường dẫn cài đặt Tomcat
  5. Nếu chưa có, nhấn + rồi chọn thư mục cài đặt Tomcat trên máy (ví dụ: C:\apache-tomcat-9.0.x hoặc /usr/local/apache-tomcat-9.0.x)
  6. Sang tab Deployment:
      Nhấn dấu + → chọn Artifact
      Chọn artifact dạng BTLJAVAWED:war exploded rồi nhấn OK
  7. Nhấn Apply rồi OK
     
5️⃣ Bước 5: Chạy ứng dụng
  - Quay lại IntelliJ, nhấn Run cấu hình Tomcat vừa tạo.
  - truy cập vào đường dẫn: http://localhost:8080/DOTHAODUONG_23ITB034
  
Bạn có thể điều chỉnh nội dung theo nhu cầu và thông tin cụ thể của dự án!

  
