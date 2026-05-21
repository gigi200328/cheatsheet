<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #f4f7fe; font-family: 'Segoe UI', sans-serif; margin: 0; }
        .main-content { margin-left: 260px; padding: 40px; }
        .card-form { 
            border: none; 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            background: white; 
            max-width: 550px;
            margin: auto;
        }
        .form-label { font-weight: 600; color: #5a5c69; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-control, .form-select { 
            border-radius: 12px; 
            padding: 12px 15px; 
            background-color: #f8f9fc; 
            border: 1px solid #eaecf4;
        }
        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: #4e73df;
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.1);
        }
        .input-group-text {
            background-color: #f8f9fc;
            border: 1px solid #eaecf4;
            border-radius: 12px 0 0 12px;
            color: #d1d3e2;
        }
        .form-control { border-radius: 0 12px 12px 0; }
        .btn-create {
            background: #4e73df;
            border: none;
            padding: 12px;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-create:hover { background: #2e59d9; transform: translateY(-2px); }
    </style>
</head>
<body>

    <c:set var="pageTitle" value="Users" />
    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex align-items-center mb-4">
            <a href="user-management" class="btn btn-white shadow-sm rounded-circle me-3 text-primary">
                <i class="fas fa-arrow-left"></i>
            </a>
            <div>
                <h3 class="fw-bold mb-0 text-dark">Create User Account</h3>
                <p class="text-muted small mb-0">အသုံးပြုသူအသစ်အတွက် အချက်အလက်များ ဖြည့်စွက်ပါ</p>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger border-0 shadow-sm rounded-4 mb-4 mx-auto" style="max-width: 550px;">
                <i class="fas fa-exclamation-circle me-2"></i> ${error}
            </div>
        </c:if>

        <div class="card card-form p-4 p-md-5">
            <form action="admin-add-user" method="post">
                
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" name="name" class="form-control" placeholder="Enter full name" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" name="email" class="form-control" placeholder="example@mail.com" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Assign Role</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user-shield"></i></span>
                        <select name="role" class="form-select" style="border-radius: 0 12px 12px 0;">
                            <option value="user" selected>User (Standard Access)</option>
                            <option value="admin">Admin (Full Access)</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-pill btn-create shadow mt-2">
                    <i class="fas fa-plus-circle me-2"></i> Confirm & Create User
                </button>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>