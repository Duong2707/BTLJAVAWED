import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addcongviec;
import model.addsinhvien;
import model.addtintucsukien;
import model.mess;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

@WebServlet("/User")
public class User extends HttpServlet {
    private final List<addsinhvien> infoList = new ArrayList<>();
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private final List<mess> chatmess = new ArrayList<>();
    private final List<addtintucsukien> infoList1 = new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());

        infoList.clear();
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


        infoList1.clear();
        infoList1.addAll(New.layDanhSachtintucsukien());
        Collections.reverse(infoList);
        List<addtintucsukien> firstFourItems = infoList1.subList(0, Math.min(4, infoList1.size()));
        request.setAttribute("infoList1", firstFourItems);


        request.setAttribute("infoList", infoList);
//        if(emailaaa=="Tadu" || emailaaa == null){
//            response.sendRedirect("index.jsp");
//        } else {
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.getRequestDispatcher("User.jsp").forward(request, response);
//        }
        // Chuyển tiếp đến JSP
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");

        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        String kich = request.getParameter("mess");
        String messageInput = request.getParameter("messageInput");
        if ("chat".equals(kich)) {
            ContactLinkController.themtinnhan(emailaaa, "admin", messageInput );
            chatmess.clear();
            chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        }
        // Quay lại trang Profile
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        response.sendRedirect("User"); // Redirect để lấy thông tin mới
    }

}