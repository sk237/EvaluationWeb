<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 7/4/2019
  Time: 11:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.*"%>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String userPassword = null;
    if (request.getParameter("userID") != null) {
        userID = request.getParameter("userID");
    }
    if (request.getParameter("userPassword") != null) {
        userPassword = request.getParameter("userPassword");
    }
    if (userID == null || userPassword == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('empty section, check again');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.signIn(userID, userPassword);
    if (result == 1) {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 0) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('wrong password');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('wrong ID');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('error');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>
