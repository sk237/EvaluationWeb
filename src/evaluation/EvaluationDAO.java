package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EvaluationDAO {


        public int write(EvaluationDTO evaluationDTO) {
            String SQL = "insert into evaluation value (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DatabaseUtil.getConnection();
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, evaluationDTO.userID);
                pstmt.setString(2, evaluationDTO.lectureName);
                pstmt.setString(3, evaluationDTO.profName);
                pstmt.setInt(4, evaluationDTO.lectureYear);
                pstmt.setString(5, evaluationDTO.quarterDivide);
                pstmt.setString(6, evaluationDTO.lectureDivide);
                pstmt.setString(7, evaluationDTO.evaluationTitle);
                pstmt.setString(8, evaluationDTO.evaluationContent);
                pstmt.setString(9, evaluationDTO.totalScore);
                pstmt.setString(10, evaluationDTO.comfortableScore);
                pstmt.setString(11, evaluationDTO.creditScore);
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
                try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            }
            return -1; // error
        }

}
