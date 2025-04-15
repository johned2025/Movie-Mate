import com.google.gson.*;
import java.io.InputStream;
import java.io.IOException;
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
            
            Scanner scanner = new Scanner(conn.getInputStream());
            StringBuilder json = new StringBuilder();
            while (scanner.hasNext()) {
                json.append(scanner.nextLine());
            }
            scanner.close();

            request.setAttribute("moviesJson", json.toString());
            //System.out.println("Fetched JSON: " + json.toString());
            
            

        } catch (Exception e) {
            
            request.setAttribute("error", "Failed to fetch data");
            
        }
            // Pass the JSON to the JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
