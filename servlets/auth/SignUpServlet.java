package com.example.useraccessmanagementsystem.servlets.auth;


import com.example.useraccessmanagementsystem.models.User;
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

@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User(request.getParameter("username"), request.getParameter("password"), request.getParameter("role"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ps.setString(3, user.getRole());
                ps.executeUpdate();
            }
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage","Unable to sign up. Something went wrong. Please try again later.");
            response.sendRedirect("error.jsp");
        }
    }
}
