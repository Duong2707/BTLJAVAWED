import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.addsinhvien;
import model.addtintucsukien;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/NewController")
@MultipartConfig
public class NewController extends HttpServlet {
    private final List<addtintucsukien> infoList = new ArrayList<>();
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    @Override
    public void init() throws ServletException {
        super.init();
        List<addtintucsukien> tintucsukien = layDanhSachtintucsukien();

        for (addtintucsukien tintucsukiena : tintucsukien) {
            addtintucsukien info = new addtintucsukien(
                    tintucsukiena.getId(),
                    tintucsukiena.getTieude(),
                    tintucsukiena.getHinhanh(),
                    tintucsukiena.getThoigian(),
                    tintucsukiena.getNoidung());
            infoList.add(info);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");


        request.setAttribute("infoList", infoList);
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmaila");
        System.out.println("a"+emailaaa);
        if(emailaaa=="Tadu" || emailaaa == null){
            response.sendRedirect("index.jsp");
        } else {
            request.getRequestDispatcher("NewController.jsp").forward(request, response);
        }

    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String title = request.getParameter("title");
        String date = request.getParameter("date");
        String content = request.getParameter("content");
        String idParam = request.getParameter("id");
        if ("delete".equals(action)) {

            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                xoaToanBoThongTintintucsukien(idParam);
                infoList.removeIf(info -> Objects.equals(info.getId(), id));
                System.out.println("Đã xóa sự kiện có ID: " + id);
            }
        } else if ("add".equals(action)) {
            // Lấy đường dẫn hình ảnh
            Part imagePart = request.getPart("image");
            String imagePath = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                imagePath = imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir(); // Tạo thư mục nếu chưa tồn tại
                imagePart.write(uploadPath + File.separator + imagePath); // Lưu file vào server
            }
            themtintucsukien(title,imagePath,date,content);
            infoList.clear();
            List<addtintucsukien> tintucsukien = layDanhSachtintucsukien();
            for (addtintucsukien tintucsukiena : tintucsukien) {
                addtintucsukien info = new addtintucsukien(
                        tintucsukiena.getId(),
                        tintucsukiena.getTieude(),
                        tintucsukiena.getHinhanh(),
                        tintucsukiena.getThoigian(),
                        tintucsukiena.getNoidung());
                infoList.add(info);
            }
        }

        // In thông tin ra console


        // Chuyển tiếp về trang mới hoặc trang trước đó
        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("NewController.jsp").forward(request, response);
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }

    public static void themtintucsukien(String tieude, String hinhanh, String thoigian, String noidung) {

            String sql = "INSERT INTO tintucsukien (tieude, hinhanh, thoigian, noidung) VALUES (?, ?, ?, ?)";
            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, tieude);
                stmt.setString(2, hinhanh);
                stmt.setString(3, thoigian);
                stmt.setString(4, noidung);

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("✅ Thêm sự kiên thành công!");
                }
            } catch (SQLException e) {
                System.err.println("❌ Lỗi khi thêm sự kiện: " + e.getMessage());
            }
        }

    public static List<addtintucsukien> layDanhSachtintucsukien() {

        List<addtintucsukien> tintucsukien = new ArrayList<>();
        String sql = "SELECT * FROM tintucsukien";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String tieude = rs.getString("tieude");
                String hinhanh = rs.getString("hinhanh");
                String thoigian = rs.getString("thoigian");
                String noidung = rs.getString("noidung");
                addtintucsukien student = new addtintucsukien(id,tieude, hinhanh, thoigian, noidung);
                tintucsukien.add(student);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return tintucsukien;
    }

    public static void xoaToanBoThongTintintucsukien(String id) {
        String sqlSinhVien = "DELETE FROM tintucsukien WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmtSinhVien = connection.prepareStatement(sqlSinhVien)) {

            stmtSinhVien.setString(1, id);
            stmtSinhVien.executeUpdate();

            System.out.println("✅ Đã xóa toàn bộ thông tin cho ID Number: " + id);
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa thông tin: " + e.getMessage());
        }
    }


}