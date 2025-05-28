package model;

public class addsinhviendangbaicongviec {
    private int id;
    private String tencongty, diachicongty, thoigianlamviec, vitrituyen, motacongviec, mucluonghotro, thoigianthuctap, emaillienhe;
    public addsinhviendangbaicongviec(int id1, String tencongty1, String diachicongty1, String thoigianlamviec1, String vitrituyen1, String motacongviec1, String mucluonghotro1, String thoigianthuctap1, String emaillienhe1) {
        this.id = id1;
        this.tencongty = tencongty1;
        this.diachicongty = diachicongty1;
        this.thoigianlamviec = thoigianlamviec1;
        this.vitrituyen = vitrituyen1;
        this.motacongviec = motacongviec1;
        this.mucluonghotro = mucluonghotro1;
        this.thoigianthuctap = thoigianthuctap1;
        this.emaillienhe = emaillienhe1;
    }
    public int getId() { return id; }
    public String getTencongty() { return tencongty; }
    public String getDiachicongty() { return diachicongty; }
    public String getThoigianlamviec() { return thoigianlamviec; }
    public String getVitrituyen() { return vitrituyen; }
    public String getMotacongviec() { return motacongviec; }
    public String getMucluonghotro() { return mucluonghotro; }
    public String getThoigianthuctap() { return thoigianthuctap; }
    public String getEmaillienhe() { return emaillienhe; }

    public void setId(int id) { this.id = id; }
    public void setTencongty(String tencongty) { this.tencongty = tencongty; }
    public void setDiachicongty(String diachicongty) { this.diachicongty = diachicongty; }
    public void setThoigianlamviec(String thoigianlamviec) { this.thoigianlamviec = thoigianlamviec; }
    public void setVitrituyen(String vitrituyen) { this.vitrituyen = vitrituyen; }
    public void setMotacongviec(String motacongviec) { this.motacongviec = motacongviec; }
    public void setMucluonghotro(String mucluonghotro) { this.mucluonghotro = mucluonghotro; }
    public void setThoigianthuctap(String thoigianthuctap) { this.thoigianthuctap = thoigianthuctap; }
    public void setEmaillienhe(String emaillienhe) { this.emaillienhe = emaillienhe; }
}
