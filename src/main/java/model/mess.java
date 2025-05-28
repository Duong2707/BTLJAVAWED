package model;

public class mess {
    private String emailgui, emailnhan, tinnhan;
    public mess(String emailgui1, String emailnhan1, String tinnhan1) {
        this.emailgui = emailgui1;
        this.emailnhan = emailnhan1;
        this.tinnhan = tinnhan1;
    }
    public String getEmailgui() { return emailgui; }
    public String getEmailnhan() { return emailnhan; }
    public String getTinnhan() { return tinnhan; }

    public void setEmailgui(String emailgui) { this.emailgui = emailgui; }
    public void setEmailnhan(String emailnhan) { this.emailnhan = emailnhan; }
    public void setTinnhan(String tinnhan) { this.tinnhan = tinnhan; }
}
