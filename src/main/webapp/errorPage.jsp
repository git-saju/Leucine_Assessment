<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String errorMessage = (String) session.getAttribute("errorMessage");
  session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      text-align: center;
      padding: 50px;
    }
    .error {
      background: #ffdddd;
      color: #d8000c;
      padding: 20px;
      border-radius: 5px;
      display: inline-block;
      max-width: 500px;
      margin: auto;
    }
    h1 {
      color: #d8000c;
    }
    a {
      text-decoration: none;
      color: white;;
      margin: 5px;
      padding: 10px;
      border-radius: 5px;
    }
    #logout{
      background: red;
    }
    #home{
      background: blue;
    }
    a:hover {
      background: brown;
    }#button{
       margin-top: 10px;
     }
  </style>
</head>
<body>
<div class="error">
  <h1>Error</h1>
  <p><%= errorMessage != null ? errorMessage :  "An unexpected error occurred. Please Try again after sometime" %></p>
  <div class="button">
    <a id="home" href="index.jsp">Home</a>
    <a id="logout" href="logout">Logout</a>
  </div>
</div>
</body>
</html>
