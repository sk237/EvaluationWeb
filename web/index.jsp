<%--
  Created by IntelliJ IDEA.
  User: seokjoong
  Date: 2019-06-25
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Course Evaluation Website</title>
  <link rel ="stylesheet" href="./css/bootstrap.min.css">
  <link rel ="stylesheet" href="./css/custom.css">
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  String lectureDivide = "All";
  String searchType = "new";
  String search = "";

  if (request.getParameter("lectureDivide") != null) {
    lectureDivide = request.getParameter("lectureDivide");
  }
  if (request.getParameter("searchType") != null) {
    searchType = request.getParameter("searchType");
  }
  if (request.getParameter("search") != null) {
    search = request.getParameter("search");
  }

  String userID = null;
  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");

    boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
    if (emailChecked == false) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("location.href = 'emailSendConfirm.jsp';");
      script.println("</script>");
      script.close();
      return;
    }
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
    <section class="container">
      <form class="form-inline mt-3" method="get" action="./index.jsp">
        <select name="lectureDivide" id="" class="form-control mx-1 mt-2">
          <option value="All">All</option>
          <option value="VLPA" <% if (lectureDivide.equals("VLAP")) out.println("selected"); %>>VLPA</option>
          <option value="I&S" <% if (lectureDivide.equals("I&S")) out.println("selected"); %>>I&S</option>
          <option value="DIV" <% if (lectureDivide.equals("DIV")) out.println("selected"); %>>DIV</option>
        </select>

        <select name="searchType" id="" class="form-control mx-1 mt-2">
          <option value="new">new</option>
          <option value="like" <% if (searchType.equals("like")) out.println("selected"); %>>like</option>
        </select>

        <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="search search search">
        <button class="btn btn-primary mx-1 mt-2" type="submit">Search</button>
        <a href="#registerModal" data-toggle="modal" class="btn btn-primary mx-1 mt-2">Rating</a>
      </form>

<%
      ArrayList<EvaluationDTO> evaluationList;
      evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search);
      while (!evaluationList.isEmpty()) {
          EvaluationDTO evaluation = evaluationList.remove(0);

%>
      <div class="card bg-light mt-3">
        <div class="card-header bg-light">
          <div class="row">
            <div class="col-8 text-left"><%= evaluation.getLectureName() %>&nbsp;
              <smal> < <%=evaluation.getProfName() %> ></smal>
              <small>  <%=evaluation.getLectureYear2()%>  <%=evaluation.getQuarterDivide()%> </small>
            </div>
            <div class="col-4 text-right" >
              <span style="color: green;">like  <%=evaluation.getLikeCount()%></span>
            </div>
          </div>
        </div>
        <div class="card-body">
          <h5 class="card-title">
            <%= evaluation.getEvaluationTitle()%>
          </h5>
          <p class="card-text"><%= evaluation.getEvaluationContent()%></p>
          <div class="row">
            <div class="col-9 text-left">
              Tot <span style="color : red;"><%=evaluation.getTotalScore()%></span>
              lec <span style="color : red;"><%=evaluation.getCreditScore()%></span>
              easy <span style="color : red;"><%=evaluation.getComfortableScore()%></span>
              total <span style="color: red;"> <%= evaluation.getTotalScore()%></span>
            </div>
            <div class="col-3 text-right">
              <a onclick="return confirm('liek?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">like</a>
              <a onclick="return confirm('delete?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">delete</a>

            </div>
          </div>
        </div>
      </div>
<%

      }

%>
    </section>
    <div class="card bg-light mt-3">
      <div class="card-heade bg-lightr">
        <div class="row">
          <div class="col-8 text-left"></div>
        </div>
      </div>
    </div>

    <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal">Rating</h5>
            <button type="button" class="close" aria-label="close" data-dismiss="modal">
              <span aria-hidden="true">&times</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="courseEvalutionAction.jsp" method="post">
              <div class="form-row">
                <div class="form-group col-sm-6">
                  <label>Class</label>
                  <input type="text" name="lectureName" class="form-control" maxlength="20">
                </div>
                <div class="form-group col-sm-6">
                  <label>Prof</label>
                  <input type="text" name="profName" class="form-control" maxlength="20">
                </div>
                <div class="form-row">
                  <div class="form-group col-sm-4">
                    <label>Year</label>
                    <select name="lectureYear" class="form-control">
                      <option value="2011">2011</option>
                      <option value="2012">2012</option>
                      <option value="2013">2013</option>
                      <option value="2014">2014</option>
                      <option value="2015">2015</option>
                      <option value="2016">2016</option>
                      <option value="2017">2017</option>
                      <option value="2018">2018</option>
                      <option value="2019" selected>2019</option>
                    </select>
                  </div>
                  <div class="form-group col-sm-4">
                    <label>Quarter</label>
                    <select name="quarterDivide" class="form-control">
                      <option value="Fall">Fall</option>
                      <option value="Winter">Winter</option>
                      <option value="Spring">Spring</option>
                      <option value="Summer">Summer</option>
                    </select>
                  </div>
                  <div class="form-group col-sm-4">
                    <label>Gen ED</label>
                    <select name="lectureDivide" class="form-control">
                      <option value="VLPA">VLPA</option>
                      <option value="I&S">I&S</option>
                      <option value="Div">Div</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <label>Title</label>
                <input type="text" name="evaluationTitle" class="form-control" maxlength="30">
              </div>
              <div class="form-group">
                <label for="">Content</label>
                <textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
              </div>
              <div class="form-row">
                <div class="form-group col-sm-3">
                  <label for="">Total</label>
                  <select name="totalScore" class="form-control">
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label for="">Lecture</label>
                  <select name="creditScore" class="form-control">
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
                <div class="form-group col-sm-3">
                  <label for="">Easy</label>
                  <select name="comfortableScore" class="form-control">
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                    <option value="F">F</option>
                  </select>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-primary">Post</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF">
      Seokjoong Kim
    </footer>
    <script src="./js/jquery.min.js"></script>
    <script src="js/poper.js"></script>
    <script src="./js/bootstrap.min.js"></script>
</body>
</html>

