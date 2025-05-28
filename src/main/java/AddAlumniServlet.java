import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.addsinhvien;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet("/AddAlumni")
public class AddAlumniServlet extends HttpServlet {
    private final List<addsinhvien> infoList = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        super.init();



        // Lấy danh sách sinh viên từ database và thêm vào infoList
        List<addsinhvien> studentList = addsinhvien.layDanhSachSinhVienTuDatabase();
        for (addsinhvien student : studentList) {
            // Tạo đối tượng GraduateInfo từ thông tin sinh viên
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
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String emailaaa = (String) session.getAttribute("userEmail");
        System.out.println("a"+emailaaa);

        String action = request.getParameter("action");
        // Lấy thông tin cựu sinh viên từ các tham số yêu cầu
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String major = request.getParameter("major");
        String className = request.getParameter("class");
        String year = request.getParameter("year");
        String id = request.getParameter("id");
        if ("delete".equals(action)) {
            addsinhvien.xoaToanBoThongTinSinhVien(id);
            infoList.removeIf(info -> Objects.equals(info.getEmail(), id));
            System.out.println("tổng: " + id);
        } else {
            if ("add".equals(action)) {
                addsinhvien.themSinhVien(name,email,phone,major,className,year,"Chưa cập nhật","Chưa cập nhật");
                addsinhvien info = new addsinhvien(name,email,phone,major,className,year,"Chưa cập nhật","Chưa cập nhật","12345");
                boolean exists = false;
                for (addsinhvien existingInfo : infoList) {
                    if (existingInfo.getEmail().equals(info.getEmail())) {
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    infoList.add(info);
                    System.out.println("✅ Thêm sinh viên thành công!");
                } else {
                    System.err.println("❌ Lỗi: Sinh viên với email này đã tồn tại!");
                }
                System.out.println("tổng: " + name);
            }}



        request.setAttribute("infoList", infoList);
        request.getRequestDispatcher("/ProfileController.jsp").forward(request, response);
    }
}