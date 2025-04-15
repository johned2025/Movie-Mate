# MovieMate - Movie Recommendation Web App
 Movie mate is movie manager that allows users to create  a profile to manage their favorite movies and keep up to date with trending titles

A dynamic web application built with **JSP**, **Java Servlets**, and **MySQL**, showcasing user authentication and personalized movie dashboard manager.

##  Features

- **User Authentication**: Sign up and log in with secure credentials.
- **Recommended Movies**: Fetches movies from an external API and displays them in responsive Bootstrap cards.
- **Favorites System**: Users can add movies to their favorites; favorites are saved in the database and displayed in a dedicated section.

## Tech Stack

- **Frontend**: JSP, HTML, CSS, JavaScript, Bootstrap
- **Backend**: Java Servlets
- **Database**: MySQL
- **Server**: Apache Tomcat
- **JDK**: Java 21

## How to Run the Project

To run this project locally:

1. **Set up your environment**:
   - Install [JDK 21](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
   - Install [Apache Tomcat](https://tomcat.apache.org/)
   - Install [MySQL Server](https://dev.mysql.com/downloads/mysql/)

2. **Configure your tools**:
   - Use any IDE that supports Java Maven Web Apps (e.g. NetBeans, IntelliJ IDEA with Tomcat plugin)
   - Set Tomcat as your server in the IDE
   - Connect to your MySQL database (you’ll need to create the schema and tables used by the app)

3. **Deploy the project**:
   - Import the project into your IDE
   - Build and deploy to the configured Tomcat server
   - Access the web app via `http://localhost:8080/YourProjectName`

4. **Database setup**:
   - Import the provided `.sql` file (if available) to create necessary tables
   - Make sure your DB connection settings in the code match your local MySQL credentials



