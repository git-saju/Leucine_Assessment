<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String userRole = (String) session.getAttribute("role");
  if (userRole != null) {
    session.setAttribute("errorMessage", "You are already logged in");
    response.sendRedirect("errorPage.jsp");
    return;
  }
  String errorMessage = (String) session.getAttribute("errorMessage");
  session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registration</title>
  <link rel="stylesheet" href="page.css">
</head>
<body>
<div class="container">
  <h1>Registration</h1>
  <form action="signup" method="post">
    <div>
      <label for="username">Username:</label>
      <input type="text" id="username" name="username" required>
    </div>
    <div>
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" required>
    </div>
    <div>
      <input type="hidden" name="role" value="Employee">
    </div>
    <div>
      <input type="submit" value="Registration">
    </div>
    <p class="error-message"><%=errorMessage!=null?errorMessage:""%></p>
  </form>
  <div class="login-link">
    <p class="a">Already have an account?<a class="a" href="login.jsp"> Log in here.</a></p>
  </div>
</div>
</body>
</html>
