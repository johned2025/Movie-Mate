import com.google.gson.*;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Properties;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {
    
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //making API key to be an external resource
            Properties props = new Properties();
            InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties");
            props.load(input);
            String API_KEY = props.getProperty("movie.api.key");
            // here we call the API
            String API_URL = "https://api.themoviedb.org/3/trending/movie/week?api_key=" + API_KEY;
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            
            // Get HTTP response code from TMDB API first
            int responseCode = conn.getResponseCode();
            
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Success - forward the exact response
                try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()))) {
                    
                    response.setStatus(HttpServletResponse.SC_OK); // 200
                    String line;
                    while ((line = reader.readLine()) != null) {
                        response.getWriter().write(line);
                    }
                }
            } else {
                // Forward TMDB's error
                response.setStatus(responseCode);
                response.getWriter().write("{\"error\":\"TMDB API returned " + responseCode + "\"}");
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Failed to fetch data\"}");
        }

        
    }
}
