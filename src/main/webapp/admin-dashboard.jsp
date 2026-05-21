<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CSMS</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* Global Styles matching your theme */
        body { background-color: #f4f7fe; font-family: 'Segoe UI', sans-serif; overflow-x: hidden; margin: 0; }

        /* Sidebar content include လုပ်ထားတဲ့အတွက် နေရာချန်ဖို့ပဲ လိုပါတယ် */
        .main-content {
            margin-left: 260px; /* sidebar-width အတိုင်း */
            padding: 40px;
            transition: all 0.3s;
        }

        /* Dashboard specific styles */
        .stat-card {
            border: none; border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: transform 0.3s;
            background: white;
        }
        .stat-card:hover { transform: translateY(-5px); }
        
        .icon-shape {
            width: 54px; height: 54px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 14px; font-size: 22px;
        }
        
        .table-card { border: none; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .table thead th { 
            background-color: #f8f9fc; 
            text-transform: uppercase; 
            font-size: 0.8rem; 
            letter-spacing: 0.05em;
            color: #5a5c69;
            padding: 15px;
        }
    </style>
</head>
<body>

    <c:set var="pageTitle" value="Dashboard" />
    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-0 text-dark">Dashboard Overview</h3>
                <p class="text-muted small">Manage your system content and users from here.</p>
            </div>
            <div class="badge bg-white text-primary shadow-sm p-3 rounded-pill fw-bold">
                <i class="fas fa-user-shield me-2"></i> Welcome Admin!
            </div>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="card stat-card p-3">
                    <div class="d-flex align-items-center px-2">
                        <div class="icon-shape bg-primary text-white me-3 shadow-sm">
                            <i class="fas fa-folder"></i>
                        </div>
                        <div>
                            <p class="text-muted small mb-0 fw-bold">Categories</p>
                            <h3 class="fw-bold mb-0 text-dark">${totalCats}</h3>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="card stat-card p-3">
                    <div class="d-flex align-items-center px-2">
                        <div class="icon-shape bg-success text-white me-3 shadow-sm">
                            <i class="fas fa-file-code"></i>
                        </div>
                        <div>
                            <p class="text-muted small mb-0 fw-bold">Topics</p>
                            <h3 class="fw-bold mb-0 text-dark">${totalTopics}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card stat-card p-3">
                    <div class="d-flex align-items-center px-2">
                        <div class="icon-shape bg-warning text-white me-3 shadow-sm">
                            <i class="fas fa-users"></i>
                        </div>
                        <div>
                            <p class="text-muted small mb-0 fw-bold">Users</p>
                            <h3 class="fw-bold mb-0 text-dark">${totalUsers}</h3>
                        </div>
                    </div>
                </div>
            </div>

            
        </div>

        <div class="card table-card">
            <div class="card-header bg-white py-4 border-0">
                <h5 class="fw-bold mb-0 text-dark"><i class="fas fa-clock text-primary me-2"></i> Recent Topics Added</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th class="ps-4">Topic Name</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="ps-4">
                                    <div class="fw-bold text-dark">Java Stream API</div>
                                    <div class="text-muted small">Updated 2 hours ago</div>
                                </td>
                                <td><span class="badge bg-light text-primary border px-3">Java Backend</span></td>
                                <td><span class="badge bg-success-subtle text-success px-3">Active</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-light text-primary me-1"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-light text-danger"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td class="ps-4">
                                    <div class="fw-bold text-dark">Flexbox Guide</div>
                                    <div class="text-muted small">Updated 5 hours ago</div>
                                </td>
                                <td><span class="badge bg-light text-primary border px-3">CSS Styling</span></td>
                                <td><span class="badge bg-success-subtle text-success px-3">Active</span></td>
                                <td class="text-center">
                                    <button class="btn btn-sm btn-light text-primary me-1"><i class="fas fa-edit"></i></button>
                                    <button class="btn btn-sm btn-light text-danger"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer bg-white border-0 text-center py-3">
                <a href="topics" class="text-primary text-decoration-none fw-bold small">View All Topics <i class="fas fa-arrow-right ms-1"></i></a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>