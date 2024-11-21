package com.example.useraccessmanagementsystem.servlets;

import com.example.useraccessmanagementsystem.models.Request;
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

@WebServlet("/requestAccess")
public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userRole = (String) request.getSession().getAttribute("role");
        if (userRole == null) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to perform this action.");
            return;
        }
        Request requests = new Request((int) request.getSession().getAttribute("userId"), Integer.parseInt(request.getParameter("softwareId")), request.getParameter("accessType"), request.getParameter("reason"), "Pending");
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, requests.getUserId());
                ps.setInt(2, requests.getSoftwareId());
                ps.setString(3, requests.getAccessType());
                ps.setString(4, requests.getReason());
                ps.setString(5, requests.getStatus());
                ps.executeUpdate();
            }
            response.sendRedirect("requestSuccess.jsp");
        } catch (SQLException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage","Unable to add request. Something went wrong. Please try again later.");
            response.sendRedirect("errorPage.jsp");
            throw new ServletException(e);
        }
    }
}
