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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User(request.getParameter("username"), request.getParameter("password"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT id, role FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    user.setRole(rs.getString("role"));
                    int userId = rs.getInt("id");
                    HttpSession session = request.getSession();
                    session.setAttribute("username", user.getUsername());
                    session.setAttribute("role", user.getRole());
                    session.setAttribute("userId", userId);

                    switch (user.getRole()) {
                        case "Employee":
                            response.sendRedirect("requestAccess.jsp");
                            break;
                        case "Manager":
                            response.sendRedirect("pendingRequests.jsp");
                            break;
                        case "Admin":
                            response.sendRedirect("createSoftware.jsp");
                            break;
                        default:
                            response.sendRedirect("index.jsp");
                    }
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("errorMessage", "Invalid username or password.");
                    response.sendRedirect("login.jsp");
                }
            }
        } catch (SQLException e) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage","Unable to log in. Something went wrong. Please try again later.");
            response.sendRedirect("errorPage.jsp");
            throw new ServletException(e);
        }
    }
}
