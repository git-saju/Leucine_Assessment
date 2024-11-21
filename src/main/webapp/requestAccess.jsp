<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.useraccessmanagementsystem.utils.DatabaseConnection" %>
<%
    String userRole = (String) session.getAttribute("role");
    if (userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<String[]> softwareData = new ArrayList<>();

    try (Connection connection = DatabaseConnection.getConnection()) {
        String softwareQuery = "SELECT id, name, access_levels FROM software";
        try (PreparedStatement stmt = connection.prepareStatement(softwareQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String softwareId = rs.getString("id");
                String name = rs.getString("name");
                String accessLevelsFromDb = rs.getString("access_levels");
                softwareData.add(new String[]{softwareId, name, accessLevelsFromDb});
            }
        }
    } catch (SQLException e) {
        session.setAttribute("errorMessage", "Something went wrong. Please try again later.");
        response.sendRedirect("errorPage.jsp");
        throw new ServletException(e);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Access</title>
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
        }
        h1 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            color: #555;
        }
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 15px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Request Access to Software</h1>
    <form action="requestAccess" method="post">
        <label for="softwareId">Software:</label>
        <select name="softwareId" id="softwareId" required onchange="updateAccessLevels()">
            <option value="">Select Software</option>
            <% for (String[] software : softwareData) { %>
            <option value="<%=software[0]%>">
                <%=software[1]%>
            </option>
            <% } %>
        </select>

        <label for="accessType">Access Type:</label>
        <select name="accessType" id="accessType" required>
        </select>

        <label for="reason">Reason for Request:</label>
        <textarea name="reason" id="reason" rows="4" required></textarea>

        <input type="submit" value="Request Access">
    </form>
</div>
<script>
    const softwareAccessLevels = new Map();

    window.onload = function() {
        <% for (String[] software : softwareData) { %>
        softwareAccessLevels.set("<%=software[0]%>", "<%=software[2]%>");
        <% } %>
        updateAccessLevels();
    };
    function updateAccessLevels() {
        const softwareSelect = document.getElementById("softwareId");
        const accessSelect = document.getElementById("accessType");
        const selectedSoftwareId = softwareSelect.value;
        let accessLevels = [];
        accessSelect.innerHTML = '<option value="">Select Access Type</option>';

        if (selectedSoftwareId) {
            accessLevels.push(softwareAccessLevels.get(selectedSoftwareId));
                if (accessLevels.includes("Admin")) {
                    accessLevels.push("Read", "Write");
                } else if (accessLevels.includes("Write")) {
                    accessLevels.push("Read");
                }
            accessLevels.forEach(level => {
                const option = document.createElement("option");
                option.value = level.trim();
                option.textContent = level.trim();
                accessSelect.appendChild(option);
            });
        }
    }
</script>
</body>
</html>
