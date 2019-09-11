<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 9/11/2019
  Time: 12:58 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="user.*"%>
<%@ page import="evaluation.*" %>
<%@ page import="likey.*" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('sing in first');");
        script.println("location.href = 'userSignIn.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    request.setCharacterEncoding("UTF-8");
    String evaluationID = null;
    if (request.getParameter("evaluationID") != null) {
        evaluationID = request.getParameter("evaluationID");
    }
    EvaluationDAO evaluationDAO = new EvaluationDAO();

    if (userID.equals(evaluationDAO.getUserID(evaluationID))) {
        int result = new EvaluationDAO().delete(evaluationID);
        if (result == 1) {
            session.setAttribute("userID", userID);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('deleted');");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");
            script.close();
            return;
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('error');");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('not your rating');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>
