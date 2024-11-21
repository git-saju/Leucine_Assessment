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

@WebServlet("/approveRequest")
public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userRole = (String) request.getSession().getAttribute("role");
        if (userRole == null || userRole.equals("Employee")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to perform this action.");
            return;
        }
        String action = request.getParameter("action");
        String status = action.equals("approve") ? "Approved" : "Rejected";
        Request requests = new Request(Integer.parseInt(request.getParameter("id")),status);

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, requests.getStatus());
                ps.setInt(2, requests.getId());
                ps.executeUpdate();
            }
            response.sendRedirect("pendingRequests.jsp");
        } catch (SQLException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage","Unable to sign up. Something went wrong. Please try again later.");
            response.sendRedirect("errorPage.jsp");
        }
    }
}
