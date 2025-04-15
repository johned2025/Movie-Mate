import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/RemoveFromFavoritesServlet")
public class RemoveFromFavoritesServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/movies";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "letmein"; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get movie_id from request parameters
        String movieIdStr = request.getParameter("movie_id");

        if (movieIdStr == null || movieIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
           
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        int movieId = Integer.parseInt(movieIdStr);

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                
                String sql = "DELETE FROM favorites WHERE user_id = ? AND movie_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    stmt.setInt(2, movieId);

                    int rowsAffected = stmt.executeUpdate();
                    if (rowsAffected > 0) {
                        response.setStatus(HttpServletResponse.SC_OK);
                        
                    } else {
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        
                    }
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            
        }
    }
}
