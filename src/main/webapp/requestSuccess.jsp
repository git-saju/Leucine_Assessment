<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Submitted</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        h1 {
            color: #333;
        }
        p {
            margin: 15px 0;
            color: #555;
        }
        a {
            text-decoration: none;
            background: #007bff;
            color: white;
            border-radius: 10px;
            padding: 10px;
        }
        a:hover {
            background: blue;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Request Submitted!</h1>
    <p>Your request for access has been successfully submitted.</p>
    <p>Thank You! for using</p>
    <p><a href="index.jsp">Go Home</a></p>
</div>
</body>
</html>
