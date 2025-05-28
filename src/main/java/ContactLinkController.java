import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
@WebServlet("/ContactLinkController")
public class ContactLinkController extends HttpServlet {
    private chat infoList;
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private final List<addsinhvien> infoList1 = new ArrayList<>();
    private final List<mess> chatmess = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        chatmess.clear();
        chatmess.addAll(layDanhSachtinnhan());
        infoList1.clear();
        infoList1.addAll(addsinhvien.layDanhSachSinhVienTuDatabase());



        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmaila");

        if(emailaaa=="Tadu" || emailaaa == null){
            response.sendRedirect("index.jsp");
        } else {
           // System.out.println("z" + infoList1);
            request.setAttribute("chatmess", chatmess);
            request.setAttribute("infoList1", infoList1);
            request.getRequestDispatcher("ContactLinkController.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        chatmess.clear();
        chatmess.addAll(layDanhSachtinnhan());
        infoList1.clear();
        infoList1.addAll(addsinhvien.layDanhSachSinhVienTuDatabase());
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String kich = request.getParameter("mess");
        String messageInput = request.getParameter("messageInput");
        String taikhoansinhvien = request.getParameter("taikhoansinhvien");
        //System.out.println("action " + action);
        //System.out.println("kick " + kich);
//        System.out.println("taikhoansinhvien " + taikhoansinhvien);
//        System.out.println("mess " + messageInput);
        infoList= new chat(action);
        if ("chat".equals(kich) && taikhoansinhvien != null) {
            infoList = new chat(taikhoansinhvien);
            System.out.println("Đã gửi tin nhắn: " + taikhoansinhvien);
            System.out.println("Tin nhắn: " + messageInput);
            themtinnhan("admin", taikhoansinhvien, messageInput );
            chatmess.clear();
            chatmess.addAll(layDanhSachtinnhan());
        }
//        List<mess> messenger = layDanhSachtinnhan();
//        for (mess tinnhan : messenger) {
//                    System.out.println("Tin nhắn: " + tinnhan.getTinnhan());
//
//
//        }
            System.out.println("----: " + infoList);
            request.setAttribute("chatmess", chatmess);
            request.setAttribute("infoList", infoList);
            request.setAttribute("infoList1", infoList1);
            request.getRequestDispatcher("ContactLinkController.jsp").forward(request, response);


    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }

    public static void themtinnhan(String emailgui, String emailnhan, String tinnhan) {

        String sql = "INSERT INTO chat (emailgui, emailnhan, tinnhan) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emailgui);
            stmt.setString(2, emailnhan);
            stmt.setString(3, tinnhan);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("✅ Thêm sinh viên thành công!");
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi thêm sinh viên: " + e.getMessage());
        }
    }

    public static List<mess> layDanhSachtinnhan() {

        List<mess> messenger = new ArrayList<>();
        String sql = "SELECT * FROM chat";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String emailgui = rs.getString("emailgui");
                String emailnhan = rs.getString("emailnhan");
                String tinnhan = rs.getString("tinnhan");
                messenger.add(new mess(emailgui,emailnhan,tinnhan));
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return messenger;
    }


}