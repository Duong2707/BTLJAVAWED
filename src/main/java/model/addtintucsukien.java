package model;

public class addtintucsukien {
    private int id;
    private String tieude, hinhanh, thoigian, noidung;
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public addtintucsukien(int id1, String tieude1, String hinhanh1, String thoigian1, String noidung1) {
        this.id = id1;
        this.tieude = tieude1;
        this.hinhanh = hinhanh1;
        this.thoigian = thoigian1;
        this.noidung = noidung1;
    }
    public int getId() { return id; }
    public String getTieude() { return tieude; }
    public String getHinhanh() { return hinhanh; }
    public String getThoigian() { return thoigian; }
    public String getNoidung() { return noidung; }

    public void setId(int id) { this.id = id; }
    public void setTieude(String tieude) { this.tieude = tieude; }
    public void setHinhanh(String hinhanh) { this.hinhanh = hinhanh; }
    public void setThoigian(String thoigian) { this.thoigian = thoigian; }
    public void setNoidung(String noidung) { this.noidung = noidung; }

}
