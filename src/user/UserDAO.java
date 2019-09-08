package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;
//ignored ?
public class UserDAO {

   public int signIn(String userID, String userPassword) {
       String SQL = "select userPassword from user where userID = ?";
       Connection conn = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
           conn = DatabaseUtil.getConnection();
           pstmt = conn.prepareStatement(SQL);
           pstmt.setString(1, userID);
           rs = pstmt.executeQuery();
           if (rs.next()) {
               if (rs.getString("userPassword").equals(userPassword)) {
                   return 1; //sign in success
               } else {
                   return 0; // fail
               }
           }
           return -1; // wrong ID
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
           try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
           try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
       }
       return -2; // error
   }
    public int signUp(UserDTO user) {
        String SQL = "insert into user value (?, ?, ?, ?, false)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
                pstmt.setString(3, user.getUserEmail());
            pstmt.setString(4, user.getUserEmailHash());
            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
        }
        return -1;
    }

    public boolean getUserEmailChecked(String userID) {
        String SQL = "select userEmailChecked from user where userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
        }
        return false;
    }

    public String getUserEmail(String userID) {
        String SQL = "select userEmail from user where userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
        }
        return null;
    }

    public boolean setUserEmailChecked(String userID) {
        String SQL = "update user set userEmailChecked =true where userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if (conn != null) conn.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (pstmt != null) pstmt.close(); } catch (Exception e) {e.printStackTrace();}
            try {if (rs != null) rs.close(); } catch (Exception e) {e.printStackTrace();}
        }
        return false;
    }
}
