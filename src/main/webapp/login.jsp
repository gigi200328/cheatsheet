<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Cheat Sheet System</title>
    
    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }
        .login-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        .login-card h3 {
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #ddd;
        }
        .form-control:focus {
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.2);
            border-color: #667eea;
        }
        .btn-login {
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: bold;
            color: white;
            width: 100%;
            margin-top: 20px;
            transition: transform 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            opacity: 0.9;
            color: white;
        }
        .input-group-text {
            background-color: transparent;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        .form-control.with-icon {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        .error-msg {
            color: #dc3545;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="text-center mb-4">
            <i class="fas fa-code-branch fa-3x text-primary"></i>
        </div>
        <h3>Login to CSMS</h3>

        <!-- Error နှင့် Ban Message များ ပြသမည့်နေရာ -->
        <% 
            String requestError = (String) request.getAttribute("error");
            String urlError = request.getParameter("error");
            
            if (requestError != null) { 
        %>
            <div class="error-msg">
                <i class="fas fa-exclamation-circle"></i> <%= requestError %>
            </div>
        <% 
            } else if ("account_banned".equals(urlError)) { 
        %>
            <div class="alert alert-danger text-center shadow-sm p-2 mb-3" style="border-radius: 10px; font-size: 14px;">
                <i class="fas fa-user-slash me-2"></i> Your account has been <strong>Banned</strong> due to multiple policy violations!
            </div>
        <% } %>

        <form action="login" method="post">
            <!-- Name/Email Input -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user text-muted"></i></span>
                    <input type="text" name="name" class="form-control with-icon" placeholder="Enter your name" required>
                </div>
            </div>

            <!-- Password Input -->
            <div class="mb-4">
                <label class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control with-icon" placeholder="Enter your password" required>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-login shadow">
                Sign In <i class="fas fa-sign-in-alt ms-2"></i>
            </button>
        </form>

        <div class="text-center mt-4">
            <div class="mb-2">
                <small class="text-muted">Don't have an account? 
                    <a href="register.jsp" class="text-decoration-none fw-bold">Sign Up</a>
                </small>
            </div>
            
            <div>
                <a href="home" class="text-decoration-none small text-primary fw-semibold">
                    <i class="fas fa-arrow-left me-1"></i> Go to Home
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>