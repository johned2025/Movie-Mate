import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        //input checking (passwords must match)
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("login.jsp?registerError=1");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/movies", "root", "letmein");

            PreparedStatement checkUser = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
            checkUser.setString(1, username);
            ResultSet rs = checkUser.executeQuery();
            if (rs.next()) {
                response.sendRedirect("login.jsp?registerError=1");
                return;
            }
//INSERT USER QUERY
            PreparedStatement insertUser = conn.prepareStatement(
                    "INSERT INTO users (username, password) VALUES (?, ?)");
            insertUser.setString(1, username);
            insertUser.setString(2, password); 
            insertUser.executeUpdate();

            response.sendRedirect("login.jsp?registerSuccess=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?registerError=1");
        }
    }
}
