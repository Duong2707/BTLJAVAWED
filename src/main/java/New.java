import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addtintucsukien;
import model.chat;
import model.mess;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/New")
public class New extends HttpServlet {
    private final List<addtintucsukien> infoList = new ArrayList<>();
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
        System.out.println("thông tin: " + emailaaa);

        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        infoList.clear();
        List<addtintucsukien> tintucsukien = layDanhSachtintucsukien();

        for (addtintucsukien tintucsukiena : tintucsukien) {
            String noidung = tintucsukiena.getNoidung();
            String shortenedNoidung;
            if (noidung != null && noidung.length() > 50) {
                shortenedNoidung = noidung.substring(0, 50);
            } else {
                shortenedNoidung = noidung;
            }
            addtintucsukien info = new addtintucsukien(
                    tintucsukiena.getId(),
                    tintucsukiena.getTieude(),
                    tintucsukiena.getHinhanh(),
                    tintucsukiena.getThoigian(),
                    shortenedNoidung);
            infoList.add(info);
        }
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("New.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");

        infoList.clear();
        infoList.addAll(layDanhSachtintucsukien());
        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        String kich = request.getParameter("mess");
        String thongtinsukien = request.getParameter("thongtinsukien");
        String messageInput = request.getParameter("messageInput");
        String idthongtin = request.getParameter("idthongtin");
        if ("chat".equals(kich)) {
            ContactLinkController.themtinnhan(emailaaa, "admin", messageInput );
            chatmess.clear();
            chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
            request.setAttribute("ten", emailaaa);
            request.setAttribute("chatmess", chatmess);
            request.setAttribute("infoList", infoList);
            request.getRequestDispatcher("New.jsp").forward(request, response);
        }
        if ("thongtinsukien".equals(thongtinsukien)) {
            System.out.println("ai: " + idthongtin);
            session.setAttribute("idthongtin", idthongtin);
            request.setAttribute("ten", emailaaa);
            request.setAttribute("chatmess", chatmess);
            request.setAttribute("infoList", infoList);
            response.sendRedirect("Tintuc");

        }
//        request.setAttribute("ten", emailaaa);
//        request.setAttribute("chatmess", chatmess);
//        request.setAttribute("infoList", infoList);
//        request.getRequestDispatcher("New.jsp").forward(request, response);

    }


    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
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
}
