<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 7/5/2019
  Time: 1:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-26
  Time: 오후 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="evaluation.*"%>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('sign in first');");
        script.println("location.href = 'userSignIn.jsp';");
        script.println("</script>");
        script.close();
        return;
    }

    String lectureName = null;
    String profName = null;
    int lectureYear = 0;
    String quarterDivide = null;
    String lectureDivide = null;
    String evaluationTitle = null;
    String evaluationContent = null;
    String totalScore = null;
    String comfortableScore = null;
    String creditScore = null;

    if (request.getParameter("lectureName") != null) {
        lectureName = request.getParameter("lectureName");
    }
    if (request.getParameter("profName") != null) {
        profName = request.getParameter("profName");
    }
    if (request.getParameter("lectureYear") != null) {
        try {
            lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
        } catch (Exception e) {
            System.out.println("lecture year error");
        }
    }
    if (request.getParameter("quarterDivide") != null) {
        quarterDivide = request.getParameter("quarterDivide");
    }
    if (request.getParameter("lectureDivide") != null) {
        lectureDivide = request.getParameter("lectureDivide");
    }
    if (request.getParameter("evaluationTitle") != null) {
        evaluationTitle = request.getParameter("evaluationTitle");
    }
    if (request.getParameter("evaluationContent") != null) {
        evaluationContent = request.getParameter("evaluationContent");
    }
    if (request.getParameter("totalScore") != null) {
        totalScore = request.getParameter("totalScore");
    }
    if (request.getParameter("comfortableScore") != null) {
        comfortableScore = request.getParameter("comfortableScore");
    }
    if (request.getParameter("creditScore") != null) {
        creditScore = request.getParameter("creditScore");
    }



    if (lectureYear == 0 || lectureName == null|| profName == null || quarterDivide == null || lectureDivide == null ||
            evaluationTitle == null || evaluationContent == null || totalScore == null || comfortableScore == null ||
            creditScore == null || evaluationContent.isEmpty() || evaluationTitle.isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('empty section, check again');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    EvaluationDAO evaluationDAO = new EvaluationDAO();
    int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, profName, lectureYear ,quarterDivide,
            lectureDivide, evaluationTitle, evaluationContent, totalScore, comfortableScore, creditScore, 0));
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('fail');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
    }
%>
