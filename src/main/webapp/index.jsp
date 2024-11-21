<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<header>
    <div>
        <h1>User Access Management System</h1>
    </div>
</header>
<div class="content">
    <div class="intro">
        <h2>Welcome to the User Access Management System!</h2>
        <p>Our platform enables seamless management of software access requests, ensuring efficiency, security, and user satisfaction.</p>
        <p>Use the navigation menu above to get started with your access management tasks.</p>
    </div>

    <div class="cards">
        <a href="signup.jsp" class="card">
            <i class="fas fa-user-plus"></i>
            <h3>Sign Up</h3>
            <p>Create your account to unlock all features of the system. Fill out the registration form with your details and choose a strong password.</p>
        </a>
        <a href="login.jsp" class="card">
            <i class="fas fa-sign-in-alt"></i>
            <h3>Login</h3>
            <p>Access your account securely with your username and password. Manage your requests and view your profile directly from the dashboard.</p>
        </a>
        <a href="createSoftware.jsp" class="card">
            <i class="fas fa-plus-square"></i>
            <h3>Create Software</h3>
            <p>Add new software applications to the management system. Specify access levels, descriptions, and other relevant details to facilitate user requests.</p>
        </a>
        <a href="pendingRequests.jsp" class="card">
            <i class="fas fa-tasks"></i>
            <h3>View Pending Requests</h3>
            <p>Monitor all access requests made by users in real-time. Review details, approve or deny requests, and manage user access efficiently.</p>
        </a>
        <a href="requestAccess.jsp" class="card">
            <i class="fas fa-paper-plane"></i>
            <h3>Request Access</h3>
            <p>Need access to software? Submit your request here. Provide necessary details and reasons for your access needs to expedite the approval process.</p>
        </a>
    </div>
</div>

<footer>
    <p>&copy; 2024 User Access Management System | All Rights Reserved</p>
</footer>
</body>
</html>
