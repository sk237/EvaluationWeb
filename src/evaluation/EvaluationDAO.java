package evaluation;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EvaluationDAO {


        public int write(EvaluationDTO evaluationDTO) {
            String SQL = "insert into evaluation value (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                conn = DatabaseUtil.getConnection();
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, evaluationDTO.userID.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(2, evaluationDTO.lectureName.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(3, evaluationDTO.profName.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setInt(4, evaluationDTO.lectureYear);
                pstmt.setString(5, evaluationDTO.quarterDivide.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(6, evaluationDTO.lectureDivide.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(7, evaluationDTO.evaluationTitle.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(8, evaluationDTO.evaluationContent.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(9, evaluationDTO.totalScore.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(10, evaluationDTO.comfortableScore.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                pstmt.setString(11, evaluationDTO.creditScore.replaceAll("<", "&lt;").replaceAll(">", "&gt"));
                return pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
                try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            }
            return -1; // error
        }

        public ArrayList<EvaluationDTO> getList(String lectureDivide, String searchType, String search) {
            if (lectureDivide.equals("All")) {
                lectureDivide = "";
            }

            ArrayList<EvaluationDTO>  evaluationList = new ArrayList<>();
            String SQL;
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {

                if(searchType.equals("new")) {
                    SQL = "select * from evaluation where lectureDivide like ? and concat(lectureName, profName, evaluationTitle, evaluationContent) like ? order by evaluationID desc";
                } else {
                    SQL = "select * from evaluation where lectureDivide like ? and concat(lectureName, profName, evaluationTitle, evaluationContent) like ? order by likeCount desc";
                }
                conn = DatabaseUtil.getConnection();
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, "%" + lectureDivide + "%");
                pstmt.setString(2, "%" + search + "%");
                System.out.println(pstmt.toString());
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    EvaluationDTO evaluation = new EvaluationDTO(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            rs.getInt(5),
                            rs.getString(6),
                            rs.getString(7),
                            rs.getString(8),
                            rs.getString(9),
                            rs.getString(10),
                            rs.getString(11),
                            rs.getString(12),
                            rs.getInt(13)
                    );
                    evaluationList.add(evaluation);
                }


            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
                try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
                try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
            }
            return evaluationList;
        }

        public int like(String evaluationID) {
            String SQL = "update evaluation set likeCount = likeCount + 1 where evaluationID = ?";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = DatabaseUtil.getConnection();
                pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, Integer.parseInt(evaluationID));
                return pstmt.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {if (conn != null) conn.close();
                    if (pstmt != null) pstmt.close();
                } catch (Exception e) {e.printStackTrace();}
            }
            return -1;

        }

    public int delete(String evaluationID) {
        String SQL = "delete from evaluation where evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
        }
        return -1;

    }

    public String getUserID(String evaluationID) {
        String SQL = "select userID from evaluation where evaluationID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(evaluationID));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getString(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}

        }
        return null;

    }
}
