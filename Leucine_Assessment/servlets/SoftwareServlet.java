package com.example.useraccessmanagementsystem.servlets;

import com.example.useraccessmanagementsystem.models.Software;
import com.example.useraccessmanagementsystem.utils.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/createSoftware")
public class SoftwareServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userRole = (String) request.getSession().getAttribute("role");
        if (userRole == null || !userRole.equals("Admin")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to perform this action.");
            return;
        }
        String[] accessLevels = request.getParameterValues("accessLevels");
        Software software = new Software(request.getParameter("softwareName"), request.getParameter("description"), getHighestPriorityAccess(accessLevels));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, software.getName());
                ps.setString(2, software.getDescription());
                ps.setString(3, software.getAccessLevel());
                ps.executeUpdate();
            }
            response.sendRedirect("requestSuccess.jsp");
        } catch (SQLException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage","Unable to list software. Something went wrong. Please try again later.");
            response.sendRedirect("errorPage.jsp");
            throw new ServletException(e);
        }
    }
    private String getHighestPriorityAccess(String[] accessLevels) {
        String highestPriority = "Read";
        for (String accessLevel : accessLevels) {
            if(accessLevel.equals("Admin")){
                return accessLevel;
            } else if (accessLevel.equals("Write")) {
                highestPriority = "Write";
            }
        }
        return highestPriority;
    }
}
