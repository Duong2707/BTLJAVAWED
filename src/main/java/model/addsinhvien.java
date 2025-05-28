package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class addsinhvien {
    private String name, email, phone,university, majorCode, graduationClass, companyName, cv, matkhau;
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    public addsinhvien(String name1, String email1, String phone1, String majorCode1, String graduationClass1, String university1, String companyName1, String cv1, String matkhau1) {
        this.name = name1;
        this.email = email1;
        this.phone = phone1;
        this.university = university1;
        this.majorCode = majorCode1;
        this.graduationClass = graduationClass1;
        this.companyName = companyName1;
        this.cv = cv1;
        this.matkhau = matkhau1;
    }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getUniversity() { return university; }
    public String getMajorCode() { return majorCode; }
    public String getGraduationClass() { return graduationClass; }
    public String getCompanyName() { return companyName; }
    public String getCv() { return cv; }
    public String getMatkhau() { return matkhau; }

    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setUniversity(String university) { this.university = university; }
    public void setMajorCode(String majorCode) { this.majorCode = majorCode; }
    public void setGraduationClass(String graduationClass) { this.graduationClass = graduationClass; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public void setCv(String cv) { this.cv = cv; }
    public void setMatkhau(String matkhau) { this.matkhau = matkhau; }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver không tìm thấy!", e);
        }
    }

    public static void themSinhVien(String name1, String email1, String phone1, String majorCode1, String graduationClass1, String university1, String companyName1, String cv1) {
        if (kiemTraTrunglap(email1)) {
            System.err.println("❌ Lỗi: Dữ liệu đã tồn tại trong cơ sở dữ liệu!");
            return;
        } else {

            String sql = "INSERT INTO sinhvien (ten, email, sdt, nganh, lop, khoa, congty, chucvu, matkhau) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name1);
                stmt.setString(2, email1);
                stmt.setString(3, phone1);
                stmt.setString(4, majorCode1);
                stmt.setString(5, graduationClass1);
                stmt.setString(6, university1);
                stmt.setString(7, companyName1);
                stmt.setString(8, cv1);
                stmt.setString(9, "12345");

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    System.out.println("✅ Thêm sinh viên thành công!");
                }
            } catch (SQLException e) {
                System.err.println("❌ Lỗi khi thêm sinh viên: " + e.getMessage());
            }
        }
    }

    public static List<addsinhvien> layDanhSachSinhVienTuDatabase() {


        List<addsinhvien> students = new ArrayList<>();
        String sql = "SELECT * FROM sinhvien";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String ten = rs.getString("ten");
                String email = rs.getString("email");
                String sdt = rs.getString("sdt");
                String nganh = rs.getString("nganh");
                String lop = rs.getString("lop");
                String khoa = rs.getString("khoa");
                String congty = rs.getString("congty");
                String chucvu = rs.getString("chucvu");
                String matkhau = rs.getString("matkhau");
                addsinhvien student = new addsinhvien(ten, email, sdt, nganh, lop, khoa, congty,chucvu, matkhau);
                students.add(student);
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách sinh viên từ database: " + e.getMessage());
        }

        return students;
    }

    public static void xoaToanBoThongTinSinhVien(String emailsql) {
        String sqlSinhVien = "DELETE FROM sinhvien WHERE email = ?";

        try (Connection connection = getConnection();
             PreparedStatement stmtSinhVien = connection.prepareStatement(sqlSinhVien)) {

            stmtSinhVien.setString(1, emailsql);
            stmtSinhVien.executeUpdate();

            System.out.println("✅ Đã xóa toàn bộ thông tin cho ID Number: " + emailsql);
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa thông tin: " + e.getMessage());
        }
    }

    public static boolean kiemTraTrunglap(String email) {
        String sql = "SELECT COUNT(*) FROM sinhvien WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi kiểm tra CMND: " + e.getMessage());
        }
        return false;
    }

}
