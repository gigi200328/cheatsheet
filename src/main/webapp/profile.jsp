<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.model.LoginBean" %>
<%
    LoginBean user = (LoginBean) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Servlet ကနေ သိမ်းလိုက်တဲ့ success သို့မဟုတ် error message တွေကို ဆွဲထုတ်ခြင်း
    String successMsg = (String) session.getAttribute("successMessage");
    String errorMsg = (String) session.getAttribute("errorMessage");
    
    // Message ပြပြီးရင် နောက်တစ်ခါ Refresh လုပ်တဲ့အခါ ထပ်မပေါ်နေစေဖို့ Session ထဲကနေ ပြန်ဖျက်ပေးရပါမယ်
    if (successMsg != null) session.removeAttribute("successMessage");
    if (errorMsg != null) session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - CSMS</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        body { background-color: #f3f4f7; font-family: 'Segoe UI', sans-serif; }
        .header-section {
            background: var(--primary-gradient);
            padding: 50px 0;
            color: white;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            margin-bottom: -60px;
        }
        .profile-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .avatar-circle {
            width: 100px;
            height: 100px;
            background: var(--primary-gradient);
            color: white;
            font-size: 40px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 20px;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #e1e5eb;
        }
        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(118, 75, 162, 0.1);
            border-color: #764ba2;
        }
        .btn-update {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.3);
            color: white;
        }
        /* Alert message လှလှပပလေးဖြစ်အောင် ပြင်ဆင်ထားတဲ့ CSS */
        .custom-alert {
            border-radius: 12px;
            border: none;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <div class="header-section text-center">
        <div class="container">
            <h2 class="fw-bold">My Account Settings</h2>
            <p class="opacity-75">You can edit your personal information here.</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
            
                <% if (successMsg != null) { %>
                    <div class="alert alert-success alert-dismissible fade show custom-alert shadow-sm mb-3" role="alert">
                        <i class="fas fa-check-circle me-2"></i> <%= successMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>

                <% if (errorMsg != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show custom-alert shadow-sm mb-3" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> <%= errorMsg %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <div class="card profile-card p-4 p-md-5">
                    
                    <div class="text-center mb-4">
                        <div class="avatar-circle">
                            <%= user.getName().substring(0, 1).toUpperCase() %>
                        </div>
                        <h4 class="fw-bold mb-0"><%= user.getName() %></h4>
                        <p class="text-muted small">Registered Member</p>
                    </div>

                    <form action="updateProfile" method="post">
                        <input type="hidden" name="currentPassword" value="<%= user.getPassword() %>">
                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary small">FULL NAME</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0"><i class="fas fa-user text-muted"></i></span>
                                <input type="text" name="userName" class="form-control bg-light" value="<%= user.getName() %>" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold text-secondary small">EMAIL ADDRESS</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0"><i class="fas fa-envelope text-muted"></i></span>
                                <input type="email" class="form-control bg-light opacity-75" value="<%= user.getEmail() %>" readonly>
                            </div>
                            <div class="form-text mt-1 text-info"><i class="fas fa-info-circle"></i>The email address cannot be changed.</div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold text-secondary small">NEW PASSWORD</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0"><i class="fas fa-lock text-muted"></i></span>
                                <input type="password" name="password" class="form-control bg-light" placeholder="Add a new password (only if you want to change it)">
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-update">
                                <i class="fas fa-save me-2"></i>Update Profile
                            </button>
                            <a href="home" class="btn btn-link text-muted text-decoration-none mt-2">
                                <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                            </a>
                        </div>
                    </form>

                </div>
                
                <div class="text-center mt-4">
                    <p class="text-muted small text-uppercase" style="letter-spacing: 1px;">
                        Member since 2026
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>