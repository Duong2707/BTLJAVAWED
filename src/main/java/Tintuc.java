import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addtintucsukien;
import model.mess;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/Tintuc")
public class Tintuc extends HttpServlet {
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
        String idthongtin = (String) session.getAttribute("idthongtin");
        System.out.println("thông tin: " + idthongtin);

        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        infoList.clear();
        List<addtintucsukien> tintucsukien = New.layDanhSachtintucsukien();

        for (addtintucsukien tintucsukiena : tintucsukien) {
            String id = String.valueOf(tintucsukiena.getId());

            if (Objects.equals(idthongtin, id)) {

            addtintucsukien info = new addtintucsukien(
                    tintucsukiena.getId(),
                    tintucsukiena.getTieude(),
                    tintucsukiena.getHinhanh(),
                    tintucsukiena.getThoigian(),
                    tintucsukiena.getNoidung());
            infoList.add(info);
        }}
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("Tintuc.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        String idthongtin = (String) session.getAttribute("idthongtin");
        infoList.clear();
        List<addtintucsukien> tintucsukien = New.layDanhSachtintucsukien();

        for (addtintucsukien tintucsukiena : tintucsukien) {
            String id = String.valueOf(tintucsukiena.getId());

            if (Objects.equals(idthongtin, id)) {

                addtintucsukien info = new addtintucsukien(
                        tintucsukiena.getId(),
                        tintucsukiena.getTieude(),
                        tintucsukiena.getHinhanh(),
                        tintucsukiena.getThoigian(),
                        tintucsukiena.getNoidung());
                infoList.add(info);
            }}
        chatmess.clear();
        chatmess.addAll(ContactLinkController.layDanhSachtinnhan());
        String kich = request.getParameter("mess");
        String messageInput = request.getParameter("messageInput");
        if ("chat".equals(kich)) {
            ContactLinkController.themtinnhan(emailaaa, "admin", messageInput );
            chatmess.clear();
            chatmess.addAll(ContactLinkController.layDanhSachtinnhan());

        }
        request.setAttribute("infoList", infoList);
        request.setAttribute("ten", emailaaa);
        request.setAttribute("chatmess", chatmess);
        request.getRequestDispatcher("Tintuc.jsp").forward(request, response);

    }
}
