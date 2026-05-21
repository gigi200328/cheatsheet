<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Topic Management - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root { --sidebar-width: 260px; }
        body { background-color: #f4f7fe; font-family: 'Segoe UI', sans-serif; }
        .main-content { margin-left: var(--sidebar-width); padding: 40px; }
        .card-table { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
       
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold">Topics Management</h3>
            <a href="add-topic-form" class="btn btn-primary rounded-pill px-4">
                <i class="fas fa-plus me-2"></i>Create New Topic
            </a>
        </div>

        <div class="card card-table p-4">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th class="border-0">ID</th>
                        <th class="border-0">TOPIC DETAILS</th>
                        <th class="border-0">CATEGORY</th>
                        <th class="border-0">STATUS</th>
                        <th class="border-0 text-end">ACTIONS</th>
                    </tr>
                </thead>
               <tbody>
    <c:forEach items="${topics}" var="topic">
        <tr>
            <td>#${topic.topicId}</td>
            <td><span class="fw-bold text-dark">${topic.topicName}</span></td>
            <td><span class="badge bg-light text-primary border">${topic.categoryName}</span></td>
            <td>
                <%-- Status အလိုက် Badge အရောင်ခွဲခြင်း --%>
                <c:choose>
                    <c:when test="${topic.status == 'Active'}">
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3">Active</span>
                    </c:when>
                    <c:when test="${topic.status == 'Rejected'}">
                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle px-3">Rejected</span>
                    </c:when>
                    <c:when test="${topic.status == 'Ban'}">
                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3">Banned</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary-subtle text-secondary px-3">${topic.status}</span>
                    </c:otherwise>
                </c:choose>
            </td>
          <td class="text-end">
    <div class="d-flex justify-content-end gap-2">
        
        <%-- ၁။ Active ဖြစ်နေရင် Reject သို့မဟုတ် Ban လို့ရမယ် --%>
        <c:if test="${topic.status == 'Active'}">
            <a href="change-topic-status?id=${topic.topicId}&status=Rejected" 
               class="btn btn-sm btn-outline-warning rounded-pill px-3" 
               onclick="return confirm('Reject this topic?')">Reject</a>

            <a href="change-topic-status?id=${topic.topicId}&status=Ban" 
               class="btn btn-sm btn-outline-danger rounded-pill px-3" 
               onclick="return confirm('Ban this user?')">Ban Now</a>
        </c:if>
        
        <%-- ၂။ Rejected သို့မဟုတ် Ban ဖြစ်နေရင် Active ပြန်လုပ်ပေးလို့ရမယ် --%>
        <c:if test="${topic.status == 'Rejected' || topic.status == 'Ban'}">
            <a href="change-topic-status?id=${topic.topicId}&status=Active" 
               class="btn btn-sm btn-outline-success rounded-pill px-3">
               Approve / Unban
            </a>
        </c:if>

        <%-- ၃။ Edit နဲ့ Delete --%>
        <a href="editTopic?id=${topic.topicId}" class="btn btn-sm btn-light border text-primary"><i class="fas fa-edit"></i></a>
        <a href="deleteTopic?id=${topic.topicId}" class="btn btn-sm btn-light border text-danger" onclick="return confirm('Delete permanently?')"><i class="fas fa-trash"></i></a>
    </div>
</td>
        </tr>
    </c:forEach>
    
    <c:if test="${empty topics}">
        <tr><td colspan="5" class="text-center py-5 text-muted">No topics found in database.</td></tr>
    </c:if>
</tbody>
            </table>
        </div>
    </div>
</body>
</html>