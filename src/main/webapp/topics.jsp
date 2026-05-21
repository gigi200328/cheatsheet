<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Topics - Admin</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #4e73df;
            --bg-color: #f8f9fc;
        }
        body { background-color: var(--bg-color); font-family: 'Inter', 'Segoe UI', sans-serif; color: #444; }
        
        .main-content { margin-left: 260px; padding: 30px; transition: all 0.3s; }
        
        /* Card & Table Styling */
        .card-custom { border: none; border-radius: 12px; box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1); background: white; }
        .table thead th { 
            background-color: #ffffff; 
            text-transform: uppercase; 
            font-size: 0.75rem; 
            font-weight: 700;
            color: #858796; 
            padding: 18px 15px;
            border-top: none;
        }
        .table td { padding: 18px 15px; vertical-align: middle; border-color: #f1f1f1; }
        
        /* Badge Styling */
        .status-badge { padding: 6px 12px; font-weight: 600; font-size: 0.75rem; border-radius: 6px; }
        
        /* Action Buttons */
        .btn-action { 
            width: 35px; height: 35px; 
            display: inline-flex; align-items: center; justify-content: center; 
            border-radius: 8px; transition: 0.2s; border: 1px solid #eee;
            background: #fff; color: #6e707e;
        }
        .btn-action:hover { background: var(--primary-color); color: white !important; transform: translateY(-2px); }
        .btn-delete:hover { background: #e74a3b; color: white !important; }

        /* Code Preview in Modal */
        pre { border-radius: 8px; padding: 15px; background: #2d3436; color: #fab1a0; overflow-x: auto; }
        
        @media (max-width: 992px) {
            .main-content { margin-left: 0; padding: 20px; }
        }
    </style>
</head>
<body>

    <c:set var="pageTitle" value="Topics" />
    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="row align-items-center mb-5">
            <div class="col-md-6">
                <h3 class="fw-bold text-gray-800 mb-1">Topics Management</h3>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#" class="text-decoration-none">Admin</a></li>
                        <li class="breadcrumb-item active">Topics</li>
                    </ol>
                </nav>
            </div>
            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                <a href="add-topic-form" class="btn btn-primary px-4 py-2 fw-semibold shadow-sm">
                    <i class="fas fa-plus-circle me-2"></i> Create Topic
                </a>
            </div>
        </div>

        <div class="card card-custom">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th class="ps-4">ID</th>
                                <th>Topic & Description</th>
                                <th>Category</th>
                                <th>Status Control</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="topic" items="${allTopics}">
                                <tr>
                                    <td class="ps-4">
                                        <span class="badge bg-light text-dark border">#${topic.topicId}</span>
                                    </td>
                                    
                                    <td>
                                        <div class="fw-bold text-dark mb-1">${topic.topicName}</div>
                                        <c:choose>
                                            <c:when test="${not empty topic.contents}">
                                                <a href="#" class="small text-primary fw-medium text-decoration-none" 
                                                   data-bs-toggle="modal" data-bs-target="#viewModal${topic.topicId}">
                                                   <i class="far fa-file-alt me-1"></i> Preview Content
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted small fst-italic">No details available</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <span class="text-muted fw-medium">
                                            <i class="fas fa-folder-open me-1 text-warning small"></i> ${topic.categoryName}
                                        </span>
                                    </td>
                                    
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <c:choose>
                                                <c:when test="${topic.status == 'Banned' || topic.status == 'Ban'}">
                                                    <span class="status-badge bg-danger-subtle text-danger">Banned</span>
                                                    <a href="change-topic-status?id=${topic.topicId}&status=Active" class="btn btn-sm btn-link text-success p-0 fw-bold text-decoration-none">Unban</a>
                                                </c:when>
                                                <c:when test="${topic.status == 'Rejected'}">
                                                    <span class="status-badge bg-warning-subtle text-warning">Rejected</span>
                                                    <a href="change-topic-status?id=${topic.topicId}&status=Active" class="btn btn-sm btn-link text-success p-0 fw-bold text-decoration-none">Approve</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge bg-success-subtle text-success">Active</span>
                                                    <div class="ms-2">
                                                        <a href="change-topic-status?id=${topic.topicId}&status=Rejected" class="text-warning me-2 small fw-bold text-decoration-none">Reject</a>
                                                        <a href="change-topic-status?id=${topic.topicId}&status=Banned" class="text-danger small fw-bold text-decoration-none" onclick="return confirm('Ban this topic?')">Ban</a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>

                                    <td class="text-end pe-4">
                                        <div class="d-flex justify-content-end gap-2">
                                            <a href="edit-topic?id=${topic.topicId}" class="btn-action" title="Edit">
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a href="delete-topic?id=${topic.topicId}" class="btn-action btn-delete" 
                                               onclick="return confirm('Are you sure you want to delete this?')" title="Delete">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <c:forEach var="topic" items="${allTopics}">
            <c:if test="${not empty topic.contents}">
                <div class="modal fade" id="viewModal${topic.topicId}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content border-0 shadow-lg">
                            <div class="modal-header border-0 bg-light">
                                <h5 class="modal-title fw-bold text-dark">${topic.topicName}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-4">
                                <label class="text-uppercase small fw-bold text-muted mb-2 d-block">Description</label>
                                <div class="p-3 bg-light rounded mb-4" style="white-space: pre-wrap; line-height: 1.6;">
                                    <c:out value="${topic.contents[0].description}" />
                                </div>
                                
                                <c:if test="${not empty topic.contents[0].exampleCode}">
                                    <label class="text-uppercase small fw-bold text-muted mb-2 d-block">Code Snippet</label>
                                    <pre><code><c:out value="${topic.contents[0].exampleCode}" /></code></pre>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>