import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addsinhvien;

import java.io.IOException;
import java.util.List;

@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        List<addsinhvien> studentList = addsinhvien.layDanhSachSinhVienTuDatabase();
        request.setAttribute("infoList", studentList); // Thiết lập danh sách vào thuộc tính
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmaila");
        System.out.println("a"+emailaaa);
        if(emailaaa=="Tadu" || emailaaa == null){
            response.sendRedirect("index.jsp");
        } else {
            request.getRequestDispatcher("ProfileController.jsp").forward(request, response);
        }
         // Chuyển tiếp đến JSP
    }
}