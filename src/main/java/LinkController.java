import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.addcongviec;
import model.addsinhvien;
import model.addsinhviendangbaicongviec;
import model.addtintucsukien;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/LinkController")
@MultipartConfig
public class LinkController extends HttpServlet {
    private final List<addcongviec> infoList = new ArrayList<>();
    private final List<addsinhviendangbaicongviec> infoList1 = new ArrayList<>();

    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    @Override
    public void init() throws ServletException {
        super.init();
        List<addcongviec> congviec = layDanhSachcongviec();

        for (addcongviec addcongviec : congviec) {
            addcongviec info = new addcongviec(
                    addcongviec.getId(),
                    addcongviec.getHinhanh(),
                    addcongviec.getTencongty(),
                    addcongviec.getVitrituyenchon(),
                    addcongviec.getThoigian(),
                    addcongviec.getNoidung());
            infoList.add(info);
            System.err.println("Data: " + addcongviec.getId());
        }
        System.err.println("Data: " + infoList);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        infoList1.clear();
        infoList1.addAll(layDanhSachcongviec1());
        request.setCharacterEncoding("UTF-8");
        request.setAttribute("infoList1", infoList1);
        request.setAttribute("infoList", infoList); // Thiết lập danh sách vào thuộc tính
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmaila");
        System.out.println("a"+emailaaa);
        if(emailaaa=="Tadu" || emailaaa == null){
            response.sendRedirect("index.jsp");
        } else {
            request.getRequestDispatcher("LinkController.jsp").forward(request, response);
        }
        // Chuyển tiếp đến JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String company = request.getParameter("company");
        String position = request.getParameter("position");
        String duration = request.getParameter("duration");
        String description = request.getParameter("description");
        String idParam = request.getParameter("id");
        // Lấy hình ảnh

        if ("delete".equals(action)) {
            int id = Integer.parseInt(idParam);
            xoaToanBoThongTincongviec(idParam);
                //infoList.removeIf(info -> Objects.equals(info.getId(), id));
                //System.out.println("Đã xóa sự kiện có ID: " + id);
            infoList.removeIf(info -> Objects.equals(info.getId(), id));

        } else if ("add".equals(action)) {
            Part imagePart = request.getPart("image");
            String imagePath = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                imagePath = imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir(); // Tạo thư mục nếu chưa tồn tại
                imagePart.write(uploadPath + File.separator + imagePath); // Lưu file vào server
            }
            themcongviec(imagePath, company, position, duration, description);
            infoList.clear();
            List<addcongviec> congviec = layDanhSachcongviec();
            for (addcongviec addcongviec : congviec) {
                addcongviec info = new addcongviec(
                        addcongviec.getId(),
                        addcongviec.getHinhanh(),
                        addcongviec.getTencongty(),
                        addcongviec.getVitrituyenchon(),
                        addcongviec.getThoigian(),
                        addcongviec.getNoidung());
                infoList.add(info);
            }


        }

        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("LinkController.jsp").forward(request, response);
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }

    public static void themcongviec(String hinhanh, String tencongty, String vitrituyenchon, String thoigian, String noidung) {

        String sql = "INSERT INTO congviec (hinhanh, tencongty, vitrituyenchon, thoigian, noidung) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hinhanh);
            stmt.setString(2, tencongty);
            stmt.setString(3, vitrituyenchon);
            stmt.setString(4, thoigian);
            stmt.setString(5, noidung);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Thêm sinh viên thành công!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thêm sinh viên: " + e.getMessage());
        }
    }

    public static List<addcongviec> layDanhSachcongviec() {

        List<addcongviec> congviec = new ArrayList<>();
        String sql = "SELECT * FROM congviec";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String hinhanh = rs.getString("hinhanh");
                String tencongty = rs.getString("tencongty");
                String vitrituyenchon = rs.getString("vitrituyenchon");
                String thoigian = rs.getString("thoigian");
                String noidung = rs.getString("noidung");
                addcongviec student = new addcongviec(id,hinhanh, tencongty, vitrituyenchon, thoigian, noidung);
                congviec.add(student);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return congviec;
    }

    public static void xoaToanBoThongTincongviec(String id) {
        String sqlSinhVien = "DELETE FROM congviec WHERE id = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmtSinhVien = connection.prepareStatement(sqlSinhVien)) {

            stmtSinhVien.setString(1, id);
            stmtSinhVien.executeUpdate();

            System.out.println("✅ Đã xóa toàn bộ thông tin cho ID Number: " + id);
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa thông tin: " + e.getMessage());
        }
    }

    public static List<addsinhviendangbaicongviec> layDanhSachcongviec1() {

        List<addsinhviendangbaicongviec> congviec = new ArrayList<>();
        String sql = "SELECT * FROM sinhviendangtai";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                    int id = rs.getInt("id");
                    String tencongty = rs.getString("tencongty");
                    String diachicongty = rs.getString("diachicongty");
                    String thoigianlamviec = rs.getString("thoigianlamviec");
                    String vitrituyen = rs.getString("vitrituyen");
                    String motacongviec = rs.getString("motacongviec");
                    String mucluonghotro = rs.getString("mucluonghotro");
                    String thoigianthuctap = rs.getString("thoigianthuctap");
                    String emaillienhe = rs.getString("emaillienhe");
                    addsinhviendangbaicongviec student = new addsinhviendangbaicongviec(
                            id,
                            tencongty,
                            diachicongty,
                            thoigianlamviec,
                            vitrituyen,
                            motacongviec,
                            mucluonghotro,
                            thoigianthuctap,
                            emaillienhe);
                    congviec.add(student);
                }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return congviec;
    }

}