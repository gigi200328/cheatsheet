<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Topic - Admin Dashboard</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { --sidebar-width: 260px; --dark-bg: #1a1c23; --primary-color: #4e73df; }
        body { background-color: #f4f7fe; font-family: 'Segoe UI', sans-serif; margin: 0; overflow-x: hidden; }
        
        .main-content { 
            margin-left: var(--sidebar-width); 
            padding: 40px; 
            min-height: 100vh;
            transition: all 0.3s;
        }
        
        .card-form { 
            border: none; 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            background: white; 
        }

        .code-input { 
            font-family: 'Fira Code', 'Courier New', monospace; 
            background-color: #1e1e1e; 
            color: #d4d4d4; 
            border-radius: 12px;
            padding: 20px;
            border: 2px solid #2d2d2d;
            line-height: 1.5;
            resize: vertical;
        }
        .code-input:focus {
            background-color: #1e1e1e;
            color: #ffffff;
            border-color: var(--primary-color);
            box-shadow: none;
        }
        
        .form-label { 
            font-size: 0.75rem; 
            color: #5a5c69; 
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }

        .custom-input {
            border-radius: 10px;
            background-color: #f8f9fc;
            border: 1px solid #eaecf4;
            padding: 12px 15px;
        }
        .custom-input:focus {
            background-color: #fff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.1);
        }

        @media (max-width: 768px) {
            .main-content { margin-left: 0; padding: 20px; }
        }
    </style>
</head>
<body>

    <c:set var="pageTitle" value="Topics" />
    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="row justify-content-center">
            <div class="col-lg-10"> 
                
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div class="d-flex align-items-center">
                        <a href="topics" class="btn btn-white shadow-sm rounded-circle me-3 text-primary bg-white">
                            <i class="fas fa-arrow-left"></i>
                        </a>
                        <div>
                            <h4 class="fw-bold mb-0 text-gray-800">Add New Topic</h4>
                           
                        </div>
                    </div>
                </div>

                <div class="card card-form p-4 p-md-5">
                    <form action="save-topic" method="post">
                        <input type="hidden" name="status" value="Approved">

                        <div class="row">
                            <div class="col-md-8 mb-4">
                                <label class="form-label">Main Topic Title</label>
                                <input type="text" name="topicName" class="form-control custom-input" 
                                       placeholder="e.g. Java Collection Framework" required>
                            </div>
                            
                            <div class="col-md-4 mb-4">
                                <label class="form-label">Category</label>
                                <select name="catId" class="form-select custom-input" required>
                                    <option value="" disabled selected>Select Category</option>
                                    <c:forEach items="${categoryList}" var="cat">
                                        <option value="${cat.categoriesId}">${cat.categoriesName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <hr class="my-4 opacity-25">

                        <div class="p-4 mb-4 border-0 rounded-4 bg-light shadow-sm">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 24px; height: 24px;">
                                    <small>1</small>
                                </div>
                                <h6 class="fw-bold text-primary mb-0">Initial Content Details</h6>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-5 mb-3">
                                    <label class="form-label">Content Card Title</label>
                                    <input type="text" name="contentTitle" class="form-control custom-input" 
                                           placeholder="e.g. ArrayList Overview" required>
                                </div>
                                <div class="col-md-7 mb-3">
                                    <label class="form-label">Short Explanation</label>
                                    <textarea name="contentDescription" class="form-control custom-input" 
                                              rows="2" placeholder="Explain the concept briefly..."></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label d-flex justify-content-between">
                                <span>Example Code Snippet</span>
                                <span class="text-muted text-lowercase" style="font-weight: 400;">Supports multi-line code</span>
                            </label>
                            <textarea name="exampleCode" class="form-control code-input" rows="10" 
                                      placeholder="// Paste your code example here..."></textarea>
                        </div>

                        <div class="text-end mt-5">
                            <a href="topics" class="btn btn-link text-decoration-none text-muted px-4 me-2">Discard Changes</a>
                            <button type="submit" class="btn btn-primary px-5 shadow rounded-pill fw-bold">
                                <i class="fas fa-paper-plane me-2"></i>Save & Publish
                            </button>
                        </div>
                    </form>
                </div>
                </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>