<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - CSMS</title>
    
    <!-- Bootstrap 5 CSS -->
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
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }
        .register-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
        }
        .register-card h3 {
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ddd;
        }
        .form-control:focus {
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.2);
            border-color: #667eea;
        }
        .btn-register {
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: bold;
            color: white;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
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
    </style>
</head>
<body>

    <div class="register-card shadow-lg">
        <div class="text-center mb-3">
            <i class="fas fa-user-plus fa-3x text-primary"></i>
        </div>
        <h3>Create Account</h3>
        <p class="text-center text-muted mb-4 small">Join our Cheat Sheet Management System</p>

        <form action="register" method="post">
            <!-- Full Name -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Full Name</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user text-muted"></i></span>
                    <input type="text" name="name" class="form-control with-icon" placeholder="Enter your name" required>
                </div>
            </div>

            <!-- Email Address -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope text-muted"></i></span>
                    <input type="email" name="email" class="form-control with-icon" placeholder="name@example.com" required>
                </div>
            </div>

            <!-- Password -->
            <div class="mb-4">
                <label class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control with-icon" placeholder="Choose a strong password" required>
                </div>
            </div>

            <button type="submit" class="btn btn-register">
                Register Now <i class="fas fa-arrow-right ms-2"></i>
            </button>
        </form>
<div class="text-center mt-4">
    <div class="mb-2">
        <small class="text-muted">Already have an account? 
            <a href="login.jsp" class="text-decoration-none fw-bold">Sign In</a>
        </small>
    </div>
    
    <div>
        <a href="home" class="text-decoration-none small text-primary fw-semibold">
            <i class="fas fa-arrow-left me-1"></i> Go to Home
        </a>
    </div>
</div>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>