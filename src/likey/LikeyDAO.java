package likey;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class LikeyDAO {
    public int like(String userID, String evaluationID, String userIP) {
        String SQL = "insert into likey values (?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;


        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, evaluationID);
            pstmt.setString(3, userIP);
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}

        }
        return -1;
    }
}
