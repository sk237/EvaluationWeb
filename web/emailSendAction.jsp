<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-26
  Time: 오후 9:47
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.*"%>
<%@ page import="util.*"%>
<%@ page import="javax.mail.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.internet.*" %>

<%

    UserDAO userDAO = new UserDAO();
    String userID = null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('sing in first');");
        script.println("location.href = 'userSignIn.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    boolean result = userDAO.getUserEmailChecked(userID);
    if (result == true) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('verified email');");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    String host = "http://localhost:8080/please_war_exploded/";
    String from = "joong233@gmail.com";
    String to = userDAO.getUserEmail(userID);
    String subject = "verification email";
    String content = "verify your email address" +
        "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'>" +
        "verifying email </a>";
    Properties p = new Properties();
    p.put("mail.smtp.user", from);
    p.put("mail.smtp.host", "smtp.googlemail.com");
    p.put("mail.smtp.port", "465");
    p.put("mail.smtp.starttls.enable", "true");
    p.put("mail.smtp.auth", "true");
    p.put("mail.smtp.debug", "true");
    p.put("mail.smtp.socketFactory.port", "465");
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    p.put("mail.smtp.socketFactory.fallback", "false");

    try {
        Authenticator auth = new Gmail();
        Session ses = Session.getInstance(p, auth);
        ses.setDebug(true);
        MimeMessage msg = new MimeMessage(ses);
        msg.setSubject(subject);
        Address fromAddr = new InternetAddress(from);
        msg.setFrom(fromAddr);
        Address toAddr = new InternetAddress(to);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
        msg.setContent(content, "text/html;charset=UTF-8");
        Transport.send(msg);

    } catch (Exception e) {
        e.printStackTrace();
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('Error';");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Course Evaluation Web</title>
    <link rel ="stylesheet" href="./css/bootstrap.min.css">
    <link rel ="stylesheet" href="./css/custom.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a href="index.jsp" class="navbar-brand">Course Evaluation Website</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div id="navbar" class="collapse navbar-collapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a href="index.jsp" class="nav-link">Main</a>
            </li>
            <li class="nav-item dropdown">
                <a href="" class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">Account</a>
                <div class="dropdown-menu" aria-labelledby="dropdown">
                    <%
                        if (userID == null) {

                    %>
                    <a href="userSignIn.jsp" class="dropdown-item">sign-in</a>
                    <a href="userSignUp.jsp" class="dropdown-item">sing-up</a>
                    <%
                    } else {
                    %>
                    <a href="userSignOut.jsp" class="dropdown-item">sign-out</a>
                    <%
                        }
                    %>
                </div>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="search search search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Click</button>

        </form>
    </div>
</nav>
<section class="container mt-3" style="max-width: 560px;">
    <div class="alert alert-success mt-4" role="alert">
        verify your email!
    </div>
</section>


<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
    Seokjoong Kim
</footer>
<script src="./js/jquery.min.js"></script>
<script src="js/poper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>

