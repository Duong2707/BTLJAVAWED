import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addtintucsukien;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
@WebServlet("/Controller")

public class Controller extends HttpServlet {
    private final List<addtintucsukien> infoList = new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmaila");
        System.out.println("a"+emailaaa);
        if(emailaaa=="Tadu" || emailaaa == null){
            response.sendRedirect("index.jsp");
        } else {
            infoList.clear();
            infoList.addAll(New.layDanhSachtintucsukien());
            Collections.reverse(infoList);
            List<addtintucsukien> firstFourItems = infoList.subList(0, Math.min(4, infoList.size()));
            request.setAttribute("infoList", firstFourItems);
            request.getRequestDispatcher("Controller.jsp").forward(request, response);
        }



    }
}
