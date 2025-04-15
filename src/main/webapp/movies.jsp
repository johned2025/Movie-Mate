<%@ page import="com.google.gson.*, java.util.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Trending Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container">
    <h2 class="mt-4">Trending Movies 🎬</h2>
    <div class="row">
        <%
            String json = (String) request.getAttribute("moviesJson");
            if (json != null) {
                // Parse JSON to extract movie details
                JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();
                JsonArray movies = jsonObject.getAsJsonArray("results");

                // Loop through the movies and display them
                for (JsonElement movie : movies) {
                    JsonObject movieObj = movie.getAsJsonObject();
                    String title = movieObj.get("title").getAsString();
                    String posterPath = movieObj.has("poster_path") ? "https://image.tmdb.org/t/p/w500" + movieObj.get("poster_path").getAsString() : "";
        %>
        <div class="col-md-3 mb-4">
            <div class="card">
                <img src="<%= posterPath %>" class="card-img-top" alt="<%= title %>">
                <div class="card-body">
                    <h5 class="card-title"><%= title %></h5>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p>No movies found or error occurred.</p>
        <%
            }
        %>
    </div>
</body>
</html>
