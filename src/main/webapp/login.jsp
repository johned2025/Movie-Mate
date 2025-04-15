<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!-- the login page is also used for creating a new account. this front-end file toggles the froms fields using JS
     wchich modifies the form according to user's selection. this including the 'action' parameter to use either 
     LoginServlet or RegisterSrvlet
-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MovieMate - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="card shadow p-4" style="width: 100%; max-width: 400px;">
    <h2 class="text-center mb-4">MovieMate</h2>
    <h4 id="formTitle" class="text-center mb-4">Login</h4>

    <% String error = request.getParameter("error");
       String registerSuccess = request.getParameter("registerSuccess");
       String registerError = request.getParameter("registerError");
       if (error != null) { %>
        <div class="alert alert-danger text-center" role="alert">
            Invalid username or password
        </div>
    <% } else if (registerSuccess != null) { %>
        <div class="alert alert-success text-center" role="alert">
            Account created successfully! Please log in.
        </div>
    <% } else if (registerError != null) { %>
        <div class="alert alert-danger text-center" role="alert">
            Username already exists.
        </div>
    <% } %>

    <!-- Login Form -->
    <form id="loginForm" action="LoginServlet" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" name="username" id="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" id="password" required>
        </div>

        <!-- Confirm password for register only -->
        <div class="mb-3 d-none" id="confirmPasswordGroup">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <input type="password" class="form-control" name="confirmPassword" id="confirmPassword">
        </div>

        <button type="submit" id="submitBtn" class="btn btn-primary w-100">Login</button>
    </form>

    <p class="text-center mt-3">
        <a href="#" id="toggleToRegister">Don't have an account? Create one</a>
        <a href="#" id="backToLogin" class="d-none">Already have an account? Login</a>
    </p>
</div>

<script>
    const formTitle = document.getElementById("formTitle");
    const loginForm = document.getElementById("loginForm");
    const confirmGroup = document.getElementById("confirmPasswordGroup");
    const submitBtn = document.getElementById("submitBtn");
    const toggleToRegister = document.getElementById("toggleToRegister");
    const backToLogin = document.getElementById("backToLogin");

    toggleToRegister.addEventListener("click", function(e) {
        e.preventDefault();
        formTitle.innerText = "Create Account";
        loginForm.action = "RegisterServlet";
        confirmGroup.classList.remove("d-none");
        submitBtn.innerText = "Register";
        toggleToRegister.classList.add("d-none");
        backToLogin.classList.remove("d-none");
    });

    backToLogin.addEventListener("click", function(e) {
        e.preventDefault();
        formTitle.innerText = "Login";
        loginForm.action = "LoginServlet";
        confirmGroup.classList.add("d-none");
        submitBtn.innerText = "Login";
        toggleToRegister.classList.remove("d-none");
        backToLogin.classList.add("d-none");
    });
</script>

</body>
</html>
