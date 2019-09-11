package evaluation;

public class EvaluationDTO {

    int evaluationID;
    String userID;
    String lectureName;
    String profName;
    int lectureYear;
    String quarterDivide;
    String lectureDivide;
    String evaluationTitle;
    String evaluationContent;
    String totalScore;
    String comfortableScore;
    String creditScore;
    int likeCount;

    public EvaluationDTO() {

    }
    public EvaluationDTO(int evaluationID, String userID, String lectureName, String profName, int lectureYear,
                         String quarterDivide, String lectureDivide, String evaluationTitle,
                         String evaluationContent, String totalScore, String comfortableScore, String creditScore, int likeCount) {
        this.evaluationID = evaluationID;
        this.lectureYear = lectureYear;
        this.likeCount = likeCount;
        this.userID = userID;
        this.lectureName = lectureName;
        this.profName = profName;
        this.quarterDivide = quarterDivide;
        this.lectureDivide = lectureDivide;
        this.evaluationTitle = evaluationTitle;
        this.evaluationContent = evaluationContent;
        this.totalScore = totalScore;
        this.comfortableScore = comfortableScore;
        this.creditScore = creditScore;
    }

    public int getLikeCount() {
        return likeCount;
    }
    public String getCreditScore() {
        return creditScore;
    }
    public String getComfortableScore() {
        return comfortableScore;
    }

    public int getLectureYear() {
        return lectureYear;
    }
    public String getEvaluationTitle() {
        return evaluationTitle;
    }
    public String getEvaluationContent() {
        return evaluationContent;
    }
    public String getQuarterDivide() {
        return quarterDivide;
    }
    public String getTotalScore(){
        return totalScore;
    }
    public String getProfName() {
        return profName;
    }
    public String getLectureName() {
        return lectureName;
    }
}
