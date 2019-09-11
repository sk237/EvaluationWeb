package likey;

public class LikeyDTO {
    String userID;
    int evaluationID;
    String userIP;

    public LikeyDTO(String userID, int evaluationID, String userIP) {
        this.userID = userID;
        this.evaluationID = evaluationID;
        this. userIP = userIP;

    }

    public String getUserID() {
        return userID;
    }

    public String getUserIP() {
        return userIP;
    }

    public int getEvaluationID(){
        return evaluationID;
    }
}
