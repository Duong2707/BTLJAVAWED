import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addcongviec;
import model.addsinhvien;
import model.mess;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/Profile")
public class Profile extends HttpServlet {
    private final List<addsinhvien> infoList = new ArrayList<>();
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private final List<mess> chatmess = new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());

        infoList.clear();
        request.setCharacterEncoding("UTF-8");

        List<addsinhvien> studentList = addsinhvien.layDanhSachSinhVienTuDatabase();
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        System.out.println("a"+emailaaa);

        for (addsinhvien student : studentList) {
            // Tạo đối tượng GraduateInfo từ thông tin sinh viên
            if(Objects.equals(emailaaa, student.getEmail())){
            addsinhvien info = new addsinhvien(
                    student.getName(),
                    student.getEmail(),
                    student.getPhone(),
                    student.getMajorCode(),
                    student.getGraduationClass(),
                    student.getUniversity(),
                    student.getCompanyName(),
                    student.getCv(),
                    student.getMatkhau());
            infoList.add(info);
            break;
        }}


        request.setAttribute("infoList", infoList);
//        if(emailaaa=="Tadu" || emailaaa == null){
//            response.sendRedirect("index.jsp");
//        } else {
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
//        }
        // Chuyển tiếp đến JSP
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        String ten = request.getParameter("ten");
        String email = request.getParameter("email");
        String sdt = request.getParameter("sdt");
        String nganhhoc = request.getParameter("nganhhoc");
        String lop = request.getParameter("lop");
        String khoa = request.getParameter("khoa");
        String congty = request.getParameter("congty");
        String chucvu = request.getParameter("chucvu");
        String matkhau = request.getParameter("matkhau");

        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        String kich = request.getParameter("mess");
        String messageInput = request.getParameter("messageInput");
        if ("chat".equals(kich)) {
            ContactLinkController.themtinnhan(emailaaa, "admin", messageInput );
            chatmess.clear();
            chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        } else {


            String sql = "UPDATE sinhvien SET ten = ?, sdt = ?, nganh = ?, lop = ?, khoa = ?, congty = ?, chucvu = ?, matkhau = ? WHERE email = ?";

            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                // Gán giá trị cho các tham số
                stmt.setString(1, ten);
                stmt.setString(2, sdt);
                stmt.setString(3, nganhhoc);
                stmt.setString(4, lop);
                stmt.setString(5, khoa);
                stmt.setString(6, congty);
                stmt.setString(7, chucvu);
                stmt.setString(8, matkhau);
                stmt.setString(9, email); // Email để xác định sinh viên cần cập nhật

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Cập nhật thành công");
                } else {
                    System.out.println("Không tìm thấy sinh viên để cập nhật");
                }

            } catch (SQLException e) {
                System.err.println("❌ Lỗi khi cập nhật thông tin sinh viên: " + e.getMessage());
            }
        }
        // Quay lại trang Profile
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        response.sendRedirect("Profile"); // Redirect để lấy thông tin mới
    }


    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }


}