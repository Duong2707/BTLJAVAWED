import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addcongviec;
import model.addsinhvien;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");


        if ("admin".equals(username) && "a".equals(password)) {
//            response.sendRedirect("items");
            //request.getRequestDispatcher("Controller.jsp").forward(request, response);
//            List<addsinhvien> studentList = addsinhvien.layDanhSachSinhVienTuDatabase();
//            System.out.println("Danh sách sinh viên:");
//            for (addsinhvien student : studentList) {
//
//            }

            HttpSession session = request.getSession();
            session.setAttribute("userEmaila", username);
            response.sendRedirect("Controller");
            //request.getRequestDispatcher("Controller.jsp").forward(request, response);

        } else {
            List<addsinhvien> studentList = addsinhvien.layDanhSachSinhVienTuDatabase();
            boolean isAuthenticated = false; // Biến để kiểm tra trạng thái đăng nhập

            System.out.println("Danh sách sinh viên:");
            for (addsinhvien student : studentList) {
                System.out.println("name: " + student.getName());
                if (student.getEmail().equals(username) && student.getMatkhau().equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", username);

                    isAuthenticated = true;
//                    request.getRequestDispatcher("User.jsp").forward(request, response);
                    response.sendRedirect("User");
                    break;
                }
            }
            if (!isAuthenticated) {
                request.setAttribute("errorMessage", "Đăng Nhập Thất Bại!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    }
}