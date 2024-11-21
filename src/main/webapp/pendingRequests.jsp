<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.List, java.util.ArrayList, com.example.useraccessmanagementsystem.models.Request" %>
<%@ page import="com.example.useraccessmanagementsystem.utils.DatabaseConnection" %>
<%
    String userRole = (String) session.getAttribute("role");
    if (userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    } else if (userRole.equals("Employee")) {
        session.setAttribute("errorMessage","You do not have permission to perform this action.");
        response.sendRedirect("errorPage.jsp");
        return;
    }

    List<String[]> pendingRequests = new ArrayList<>();

    try (Connection connection = DatabaseConnection.getConnection()) {
        String query = "SELECT id, user_id, software_id, access_type, reason, status FROM requests WHERE status = 'Pending'";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = "";
                String softwareName = "";

                try (PreparedStatement ps = connection.prepareStatement("SELECT username FROM users WHERE id = ?")) {
                    ps.setInt(1, rs.getInt("user_id"));
                    try (ResultSet rr = ps.executeQuery()) {
                        if (rr.next()) userName = rr.getString("username");
                    }
                }

                try (PreparedStatement ps = connection.prepareStatement("SELECT name FROM software WHERE id = ?")) {
                    ps.setInt(1, rs.getInt("software_id"));
                    try (ResultSet rr = ps.executeQuery()) {
                        if (rr.next()) softwareName = rr.getString("name");
                    }
                }

                String accessType = rs.getString("access_type");
                String reason = rs.getString("reason");
                pendingRequests.add(new String[]{String.valueOf(id), userName, softwareName, accessType, reason});
            }
        }
    } catch (SQLException e) {
        session.setAttribute("errorMessage", "Error retrieving pending requests.");
        response.sendRedirect("errorPage.jsp");
        throw new ServletException(e);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Requests</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; display: flex; justify-content: center; }
        .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); width: 80%; max-width: 800px; }
        h1 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; text-align: left; border: 1px solid #ccc; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .action-buttons { display: flex; gap: 5px; }
        button { padding: 5px 10px; border: none; border-radius: 4px; cursor: pointer; }
        .approve { background-color: #28a745; color: white; }
        .approve:hover { background-color: #218838; }
        .deny { background-color: #dc3545; color: white; }
        .deny:hover { background-color: #c82333; }
    </style>
</head>
<body>
<div class="container">
    <h1>Pending Access Requests</h1>
    <table>
        <tr>
            <th>Employee Name</th>
            <th>Software</th>
            <th>Access Type</th>
            <th>Reason</th>
            <th>Action</th>
        </tr>
        <% for (String[] requests : pendingRequests) { %>
        <tr>
            <td><%= requests[1] %></td>
            <td><%= requests[2] %></td>
            <td><%= requests[3] %></td>
            <td><%= requests[4] %></td>
            <td class="action-buttons">
                <form action="approveRequest" method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= requests[0] %>">
                    <button name="action" type="submit" class="approve" value="approve">Approve</button>
                    <button name="action" type="submit" class="deny">Deny</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% if (pendingRequests.isEmpty()) { %>
        <tr>
            <td colspan="5" style="text-align:center;">No pending requests.</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
