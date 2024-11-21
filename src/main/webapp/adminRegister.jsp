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
  <title>Admin Registration</title>
  <link rel="stylesheet" href="page.css">
  <style>
    select,
    textarea {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
      margin-bottom: 15px;
    }
    .error-message {
      color: red;
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Admin Registration</h1>
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
      <label for="accessType">Role:</label>
      <select name="role" id="accessType" required>
        <option value="Manager">Manager</option>
        <option value="Admin">Admin</option>
      </select>
    </div>
    <div>
      <input type="submit" value="Register">
    </div>
    <p class="error-message"><%= errorMessage != null ? errorMessage : "" %></p>
  </form>
  <div class="login-link">
    <p>Already have an account? <a href="login.jsp">Log in here.</a></p>
  </div>
</div>
</body>
</html>
