package model;

public class addcongviec {
    private int id;
    private String hinhanh, tencongty, vitrituyenchon, thoigian, noidung;
    private static final String URL = "jdbc:mysql://localhost:3306/cuusinhvien";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    public addcongviec(int id1, String hinhanh1, String tencongty1, String vitrituyenchon1, String thoigian1, String noidung1) {
        this.id = id1;
        this.hinhanh = hinhanh1;
        this.tencongty = tencongty1;
        this.vitrituyenchon = vitrituyenchon1;
        this.thoigian = thoigian1;
        this.noidung = noidung1;
    }

    public int getId() { return id; }
    public String getHinhanh() { return hinhanh; }
    public String getTencongty() { return tencongty; }
    public String getVitrituyenchon() { return vitrituyenchon; }
    public String getThoigian() { return thoigian; }
    public String getNoidung() { return noidung; }

    public void setId(int id) { this.id = id; }
    public void setHinhanh(String hinhanh) { this.hinhanh = hinhanh; }
    public void setTencongty(String tencongty) { this.tencongty = tencongty; }
    public void setVitrituyenchon(String vitrituyenchon) { this.vitrituyenchon = vitrituyenchon; }
    public void setThoigian(String thoigian) { this.thoigian = thoigian; }
    public void setNoidung(String noidung) { this.noidung = noidung; }

}
