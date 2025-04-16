<%@ page import="com.google.gson.JsonObject, com.google.gson.JsonArray, com.google.gson.JsonElement, com.google.gson.JsonParser" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Movie Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="d-flex justify-content-between align-items-center p-3">
    <div>
        <h1 class="mb-0">MovieMate</h1>
    </div>
    <div>
        <form action="LogoutServlet" method="post">
            <button type="submit" class="btn btn-outline-secondary">Logout</button>
        </form>
    </div>
</div>

    <div class="container mt-4">
        <!-- ? Search Bar -->
        

        <!-- ? Recommended for You -->
        

        <!-- ? Trending Movies -->
        <!-- ?Trending Movies toggle button -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">Trending Movies</h2>
            <button class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#trendingMoviesSection" aria-expanded="true" aria-controls="trendingMoviesSection">
                &#9660;
            </button>
        </div>
        <div id="trendingMoviesSection" class="collapse">
        <div id="trendingMovies" class="row">
            <%--  
                String error = (String) request.getAttribute("error");
                String json = (String) request.getAttribute("moviesJson");
                if (json != null) {
                    // Parse JSON to extract movie details
                    JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();
                    JsonArray movies = jsonObject.has("results") ? jsonObject.getAsJsonArray("results") : new JsonArray();

                    // Check if movies are available
                    if (movies.size() > 0) {
                        // Loop through the movies and display them
                        for (JsonElement movie : movies) {
                            JsonObject movieObj = movie.getAsJsonObject();
                            String title = movieObj.get("title").getAsString();
                            String posterPath = movieObj.has("poster_path") ? "https://image.tmdb.org/t/p/w500" + movieObj.get("poster_path").getAsString() : "";
            %>

            <!-- Movie Card Display -->
            <div class="col-md-3">
                <div class="card mb-3">
                    <img src="<%= posterPath %>" class="card-img-top" alt="<%= title %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= title %></h5>
                        <p class="card-text">Rating: <%= movieObj.get("vote_average").getAsDouble() %></p>
                         <button class="btn btn-outline-danger add-fav-btn"
                            data-movie-id="<%= movieObj.get("id").getAsString() %>"
                            data-title="<%= title %>"
                            data-poster="<%= posterPath %>"
                            data-rating="<%= movieObj.get("vote_average").getAsDouble() %>">
                            Add to Favorites
                        </button>

                    </div>
                </div>
            </div>

            <%
                        }
                    } else {
            %>
                <p>No movies available.</p>
            <%
                    }
                } else {
            %>
                <p>No movie data found.</p>
            <%
                } 
                --%>
            
        </div>
        </div>
        <!-- ?? Your Favorites -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h2 class="mb-0">Your Favorites</h2>
            <button class="btn btn-outline-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#favoritesMoviesSection" aria-expanded="true" aria-controls="trendingMoviesSection">
                &#9660;
            </button>
        </div>
        
        <div id="favoritesMoviesSection" class ="collapse">
        <div id="favorites-container" class="row"></div>
        </div>
    </div>
    <script>
        
        document.addEventListener('click', function(e) {
            // Handle Add to Favorites
            if (e.target.classList.contains('add-fav-btn')) {
                const button = e.target;
                const movieId = button.dataset.movieId;
                const title = button.dataset.title;
                const poster = button.dataset.poster;
                const rating = button.dataset.rating;

                fetch("AddFavoriteServlet", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "movie_id=" + encodeURIComponent(movieId) +
                        "&title=" + encodeURIComponent(title) +
                        "&poster=" + encodeURIComponent(poster) +
                        "&rating=" + encodeURIComponent(rating)
                })
                .then(response => {
                    if (response.ok) {
                        loadFavorites();
                        alert("Added to favorites!");
                    } else {
                        alert("Failed to add favorite.");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                });
            }

            // Handle Remove from Favorites
            if (e.target.classList.contains('remove-fav-btn')) {
                const button = e.target;
                const movieId = button.dataset.movieId;

                fetch("RemoveFromFavoritesServlet", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "movie_id=" + encodeURIComponent(movieId)
                })
                .then(response => {
                    if (response.ok) {
                        loadFavorites();
                    } else {
                        alert("Failed to remove movie from favorites.");
                    }
                });
            }
        });
        //loading trending titles from MovieSrvlet
        function loadTrendingMovies() {
            fetch("movies")  // This calls servlet
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Network response was not ok");
                    }
                    return response.json();
                })
                .then(data => {
                    const moviesContainer = document.getElementById("trendingMovies");
                    moviesContainer.innerHTML = "";

                    // Use the same structure your servlet returns
                    const movies = data.results || [];

                    movies.forEach(movie => {
                        const posterPath = movie.poster_path 
                            ? "https://image.tmdb.org/t/p/w500"+movie.poster_path
                            : "https://via.placeholder.com/500x750?text=No+Poster+Available";

                        const card =
                               '<div class="col-md-3">' +
                                '<div class="card mb-3">' +
                                    '<img src="' + posterPath + '" class="card-img-top" alt="' + movie.title + '">' +
                                    '<div class="card-body">' +
                                        '<h5 class="card-title">' + movie.title + '</h5>' +
                                        '<p class="card-text">Rating: ' + movie.vote_average + '</p>' +
                                        '<button class="btn btn-primary add-fav-btn" ' +
                                            'data-movie-id="' + movie.id + '" ' +  
                                            'data-title="' + movie.title + '" ' +  
                                            'data-poster="' + posterPath + '" ' +  
                                            'data-rating="' + movie.vote_average + '">' +  
                                            'Add to Favorites' +
                                        '</button>'+
                                    '</div>' +
                                '</div>' +
                            '</div>';

                        moviesContainer.innerHTML += card;
                    });
                   
                })
                .catch(error => {
                    console.error("Error loading movies:", error);
                    // Show user-friendly error message
                    document.getElementById("trendingMovies").innerHTML = 
                        '<div class="alert alert-danger">Failed to load movies. Please try again later.</div>';
                });
        }

        
         
        //adding eventListener to all buttots
        document.addEventListener("DOMContentLoaded", function () {
            loadTrendingMovies();
            loadFavorites(); 
            
        });
        //used to load fields from favorites table 
        function loadFavorites() {
            fetch("GetFavoritesServlet")
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Failed to fetch favorites");
                    }
                    return response.json();
                })
                .then(data => {
                    const favoritesSection = document.getElementById("favorites-container");
                    favoritesSection.innerHTML = ""; // clear old entries

                    data.forEach(movie => {
                        const card = 
                            '<div class="col-md-3">' +
                                '<div class="card mb-3">' +
                                    '<img src="' + movie.poster + '" class="card-img-top" alt="' + movie.title + '">' +
                                    '<div class="card-body">' +
                                        '<h5 class="card-title">' + movie.title + '</h5>' +
                                        '<p class="card-text">Rating: ' + movie.rating + '</p>' +
                                        '<button class="btn btn-outline-danger remove-fav-btn" data-movie-id="' + movie.movie_id + '">' +
                                            'Remove from Favorites' +
                                        '</button>' +
                                    '</div>' +
                                '</div>' +
                            '</div>';
                        
                        favoritesSection.innerHTML += card;
                    });
                   // bindRemoveButtons();
                })
                .catch(error => {
                    console.error("Error loading favorites:", error);
                });
        }
        /*function bindRemoveButtons() {
            const removeButtons = document.querySelectorAll(".remove-fav-btn");

            removeButtons.forEach(button => {
                button.addEventListener("click", function () {
                    const movieId = this.dataset.movieId;

                    fetch("RemoveFromFavoritesServlet", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: "movie_id=" + encodeURIComponent(movieId)
                    })
                    .then(response => {
                        if (response.ok) {
                            loadFavorites(); // we need to refresh the favorites section
                        } else {
                            alert("Failed to remove movie from favorites.");
                        }
                    });
                });
            });
        }*/

       
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
