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
    <title>Login</title>
    <link rel="stylesheet" href="page.css">
</head>
<body>
<div class="container">
    <h1>Login</h1>
    <form action="login" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required>
        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required>
        <input type="submit" value="Login">
        <p class="error-message"><%=errorMessage!=null?errorMessage:""%></p>
    </form>
    <div class="signup-link">
        <p>Don't have an account? <a href="signup.jsp">Sign up here.</a></p>
    </div>
</div>
</body>
</html>
