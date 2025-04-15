

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddFavoriteServlet")
public class AddFavoriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // get the session info
        HttpSession session = request.getSession(false);
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        // getting the form parameters
        String movieId = request.getParameter("movie_id");
        String title = request.getParameter("title");
        String poster = request.getParameter("poster");
        String rating = request.getParameter("rating");
        
        // saving parameters to database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/movies", "root", "letmein"
            );

            String sql = "INSERT INTO favorites (user_id, movie_id, title, poster_path, vote_average) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, movieId);
            ps.setString(3, title);
            ps.setString(4, poster);
            ps.setString(5, rating);
            ps.executeUpdate();

            ps.close();
            conn.close();
            
            response.setContentType("text/plain");
            response.getWriter().write("Success");
            response.getWriter().flush(); 

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error");
            response.getWriter().flush();
        }
    }
}
