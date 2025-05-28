import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addcongviec;
import model.addsinhviendangbaicongviec;
import model.mess;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/Link")
public class Link extends HttpServlet {
    private final List<addsinhviendangbaicongviec> infoList = new ArrayList<>();
    private final List<addcongviec> infoList1 = new ArrayList<>();
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private final List<mess> chatmess = new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        System.out.println("a"+emailaaa);
        infoList1.clear();
        infoList1.addAll(LinkController.layDanhSachcongviec());
        infoList.clear();
        List<addsinhviendangbaicongviec> congviec1 = layDanhSachcongviec(emailaaa);
        infoList.addAll(congviec1);
        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());



//        if(emailaaa=="Tadu" || emailaaa == null){
//            response.sendRedirect("index.jsp");
//        } else {
//            request.getRequestDispatcher("Link.jsp").forward(request, response);
//        }
        // Chuyển tiếp đến JSP
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.setAttribute("infoList1", infoList1);
        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("Link.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        System.out.println("a"+emailaaa);
        infoList1.clear();
        infoList1.addAll(LinkController.layDanhSachcongviec());
        infoList.clear();
        List<addsinhviendangbaicongviec> congviec1 = layDanhSachcongviec(emailaaa);
        infoList.addAll(congviec1);

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String tenCongTy = request.getParameter("tencongty");
            String diaChiCongTy = request.getParameter("diachicongty");
            String thoiGianLamViec = request.getParameter("thoigianlamviec");
            String viTriTuyen = request.getParameter("vitrituyen");
            String moTaCongViec = request.getParameter("motacongviec");
            String mucLuongHoTro = request.getParameter("mucluonghotro");
            String thoiGianThucTap = request.getParameter("thoigianthuctap");
            String emailLienHe = request.getParameter("emaillienhe");
            themcongviec(
                    emailaaa,
                    tenCongTy,
                    diaChiCongTy,
                    thoiGianLamViec,
                    viTriTuyen,
                    moTaCongViec,
                    mucLuongHoTro,
                    thoiGianThucTap,
                    emailLienHe
            );

            infoList.clear();
            List<addsinhviendangbaicongviec> congviec = layDanhSachcongviec(emailaaa);
            infoList.addAll(congviec);
        } else if ("delete".equals(action)) {
            String idParam = request.getParameter("id");
            int id = Integer.parseInt(idParam);
            xoaToanBoThongTincongviec(idParam);
            infoList.removeIf(info -> Objects.equals(info.getId(), id));
        }
        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        String kich = request.getParameter("mess");
        String messageInput = request.getParameter("messageInput");
        if ("chat".equals(kich)) {
            ContactLinkController.themtinnhan(emailaaa, "admin", messageInput );
            chatmess.clear();
            chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        }
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.setAttribute("infoList1", infoList1);
        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("Link.jsp").forward(request, response);

    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }

    public static void themcongviec(String emailcanhan, String tencongty, String diachicongty, String thoigianlamviec, String vitrituyen, String motacongviec, String mucluonghotro, String thoigianthuctap, String emaillienhe) {

        String sql = "INSERT INTO sinhviendangtai (emailcanhan, tencongty, diachicongty, thoigianlamviec, vitrituyen, motacongviec, mucluonghotro, thoigianthuctap, emaillienhe) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emailcanhan);
            stmt.setString(2, tencongty);
            stmt.setString(3, diachicongty);
            stmt.setString(4, thoigianlamviec);
            stmt.setString(5, vitrituyen);
            stmt.setString(6, motacongviec);
            stmt.setString(7, mucluonghotro);
            stmt.setString(8, thoigianthuctap);
            stmt.setString(9, emaillienhe);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Thêm sinh viên thành công!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thêm sinh viên: " + e.getMessage());
        }
    }

    public static List<addsinhviendangbaicongviec> layDanhSachcongviec(String email) {

        List<addsinhviendangbaicongviec> congviec = new ArrayList<>();
        String sql = "SELECT * FROM sinhviendangtai";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String emailcanhan = rs.getString("emailcanhan");
                if(Objects.equals(emailcanhan, email)) {
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
                }}
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return congviec;
    }

    public static void xoaToanBoThongTincongviec(String id) {
        String sqlSinhVien = "DELETE FROM sinhviendangtai WHERE id = ?";

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