<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 9/11/2019
  Time: 1:12 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="user.*"%>
<%@ page import="evaluation.*" %>
<%@ page import="likey.*" %>
<%@ page import="java.io.PrintWriter" %>

<%!
    public static String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null || ip.isEmpty()) {
        ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty()) {
        ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty()) {
        ip = request.getRemoteAddr() ;
        }
        return ip;
    }
%>

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
    LikeyDAO likeyDAO = new LikeyDAO();
    int result = likeyDAO.like(userID, evaluationID, getClientIP(request));

    if (result == 1) {
        result = evaluationDAO.like(evaluationID);
        if (result == 1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('like!!');");
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
        script.println("alert('you already like it');");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }

%>