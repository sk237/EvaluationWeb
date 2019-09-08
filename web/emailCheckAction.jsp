<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-26
  Time: 오후 11:08
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="util.Verification" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID ;
    String code = null;
    boolean verified;
    UserDAO userDAO = new UserDAO();

    if (request.getParameter("code") != null) {
        code = request.getParameter("code");
    }
    Verification veri = new Verification(code);
    userID = veri.getUserID();
    verified =veri.getVerified();

    if (verified) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('you already verified it')");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
    }
    if (userID != null) {
        userDAO.setUserEmailChecked(userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('verified!!')");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('incorrect code");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
    }

%>
