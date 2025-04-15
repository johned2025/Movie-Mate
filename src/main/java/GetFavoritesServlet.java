import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/GetFavoritesServlet")
public class GetFavoritesServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/movies";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "letmein"; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"error\":\"User not logged in\"}");
            return;
        }
        
        int userId = (int) session.getAttribute("user_id");
        //System.out.println("userID:  "+userId);//
        JSONArray favoritesArray = new JSONArray();
        /*this sctipt connects to DB and fetches data from favorites table
        
        */
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT movie_id, title, poster_path, vote_average FROM favorites WHERE user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        JSONObject movie = new JSONObject();
                        movie.put("movie_id", rs.getString("movie_id"));
                        movie.put("title", rs.getString("title"));
                        movie.put("poster", rs.getString("poster_path"));
                        movie.put("rating", rs.getDouble("vote_average"));
                        favoritesArray.put(movie);
                    }
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\":\"Database error: " + e.getMessage() + "\"}");
            return;
        }

        //  JSON array output
        out.write(favoritesArray.toString());
    }
}
