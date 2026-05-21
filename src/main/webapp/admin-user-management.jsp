<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --sidebar-width: 260px; --dark-bg: #1a1c23; }
        body { background-color: #f4f7fe; margin: 0; font-family: 'Segoe UI', sans-serif; }
        
        .main-content { 
            margin-left: var(--sidebar-width); 
            padding: 40px; 
            min-height: 100vh;
        }

        .card-custom { 
            background: white; 
            border-radius: 15px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            padding: 30px;
            border: none;
        }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="card-custom">
           <div class="d-flex justify-content-between align-items-center mb-4">
    <h3 class="fw-bold text-dark">
        <i class="fas fa-users-cog text-primary me-2"></i> User Management
    </h3>
    
    <a href="add-user-form.jsp" class="btn btn-primary rounded-pill px-4 shadow-sm d-flex align-items-center">
        <i class="fas fa-plus me-2"></i> Add New User
    </a>
</div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="ps-3">User ID</th>
                            <th>Username</th>
                            <th>Email Address</th>
                            <th>Role</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td class="ps-3 fw-bold text-muted">#${user.userId}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light p-2 rounded-circle me-2 text-center" style="width: 35px; height: 35px;">
                                            <i class="fas fa-user text-primary small"></i>
                                        </div>
                                        <span class="fw-bold text-dark">${user.name}</span>
                                    </div>
                                </td>
                                <td>${user.email}</td>
                                <td>
                                    <span class="badge rounded-pill ${user.role == 'admin' ? 'bg-danger' : 'bg-info'} px-3">
                                        ${user.role}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="edit-user?id=${user.userId}" class="btn btn-sm btn-outline-primary border-0 me-1"><i class="fas fa-edit"></i></a>
                                    <a href="delete-user?id=${user.userId}" class="btn btn-sm btn-outline-danger border-0" onclick="return confirm('Are you sure?')"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty userList}">
                            <tr>
                                <td colspan="5" class="text-center p-5 text-muted">No users found in database.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>