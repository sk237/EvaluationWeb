package user;

public class UserDTO {
    private String userID;
    private String userPassword;
    private String userEmail;
    private String userEmailHash;
    private boolean userEmailChecked;

    public UserDTO(String userID, String userPassword, String userEmail, String userEmailHash, boolean userEmailChecked) {
        this.userID = userID;
        this.userEmail = userEmail;
        this.userPassword = userPassword;
        this.userEmailHash = userEmailHash;
        this.userEmailChecked = userEmailChecked;
    }

    public String getUserID() {
        return userID;
    }
    public String getUserPassword() {
        return userPassword;
    }
    public String getUserEmail() {
        return userEmail;
    }
    public String getUserEmailHash() {
        return userEmailHash;
    }
}
