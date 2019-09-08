<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-26
  Time: 8:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.*"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String userPassword = null;
    String userEmail = null;
    if (request.getParameter("userID") != null) {
        userID = request.getParameter("userID");
    }
    if (request.getParameter("userPassword") != null) {
        userPassword = request.getParameter("userPassword");
    }
    if (request.getParameter("userEmail") != null) {
        userEmail = request.getParameter("userEmail");
    }
    if (userID.equals(null) || userEmail.equals(null) || userPassword.equals(null)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('empty section, check again');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();
    UserDTO userDTO = new UserDTO(userID,userPassword,userEmail,SHA256.getSHA256(userEmail), false);
    int result = userDAO.signUp(userDTO);
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('already exist ID');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    session.setAttribute("userID", userID);
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("location.href = 'emailSendAction.jsp'");
    script.println("</script>");
    script.close();
%>
