<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-25
  Time: 3:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
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
<%
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('already sing in');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }

%>
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
        <form action ="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
            <input type="text" name ="search"  class="form-control mr-sm-2" type="search" placeholder="search search search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Click</button>
        </form>
    </div>
</nav>
<section class="container mt-3" style="max-width: 560px;">
    <form action="./userSignUpAction.jsp" method="post">
        <div class="form-group">
            <label for="">user name</label>
            <input type="text" name="userID" class="form-control">
        </div>
        <div class="form-group">
            <label for="">password</label>
            <input type="password" name="userPassword" class="form-control">
        </div>
        <div class="form-group">
            <label for="">email</label>
            <input type="email" name="userEmail" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">sign in</button>
    </form>

</section>


<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
    Seokjoong Kim
</footer>
<script src="./js/jquery.min.js"></script>
<script src="js/poper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>

