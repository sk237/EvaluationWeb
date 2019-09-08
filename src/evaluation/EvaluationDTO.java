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
    public EvaluationDTO(int evaluationID, int lectureYear, int likeCount, String userID, String lectureName,
                         String profName, String quarterDivide, String lectureDivide, String evaluationTitle,
                         String evaluationContent, String totalScore, String comfortableScore, String creditScore) {
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
}
