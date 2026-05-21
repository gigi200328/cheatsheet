<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --sidebar-width: 260px; }
        body { background-color: #f4f7fe; font-family: 'Segoe UI', sans-serif; }
        .main-content { margin-left: var(--sidebar-width); padding: 40px; }
        .card-custom { background: white; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); padding: 30px; border: none; max-width: 600px; }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main-content d-flex justify-content-center">
        <div class="card-custom w-100">
            <h3 class="fw-bold text-dark mb-4">
                <i class="fas fa-user-edit text-primary me-2"></i> Edit User Information
            </h3>
            
            <form action="edit-user" method="post">
                
                <%-- Success Alert --%>
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <%-- Error Alert --%>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <input type="hidden" name="id" value="${user.userId}" />

                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary">Username</label>
                    <input type="text" class="form-control form-control-lg" name="name" value="${user.name}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary">Email Address</label>
                    <input type="email" class="form-control form-control-lg" name="email" value="${user.email}" required>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold text-secondary">User Role</label>
                    <select class="form-select form-control-lg" name="role">
                        <option value="user" ${user.role == 'user' ? 'selected' : ''}>User</option>
                        <option value="admin" ${user.role == 'admin' ? 'selected' : ''}>Admin</option>
                    </select>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary rounded-pill px-4 shadow-sm">
                        <i class="fas fa-save me-2"></i> Save Changes
                    </button>
                   <button type="button" class="btn btn-light border rounded-pill px-4" onclick="history.back()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>