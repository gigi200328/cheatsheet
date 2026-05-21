<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Topic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light" style="min-height: 100vh; overflow-y: auto;">
    
    <div class="container py-5">
        <div class="card shadow-sm border-0 rounded-4 p-4">
            <h4 class="fw-bold mb-4">Edit Topic</h4>
            
            <form action="${pageContext.request.contextPath}/edit-topic" method="POST">
                
<input type="hidden" name="topicId" value="${topic.topicId}">
<input type="hidden" name="id" value="${topic.topicId}">
                <div class="mb-3">
                    <label class="form-label fw-bold">Topic Name</label>
                    <input type="text" name="topicName" class="form-control rounded-3" 
                           value="${topic.topicName}" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Category</label>
                    <select name="categoryId" class="form-select rounded-3">
                        <c:forEach var="cat" items="${allCategories}">
                            <option value="${cat.categoriesId}" 
                                ${cat.categoriesId == topic.catId ? 'selected' : ''}> 
                                ${cat.categoriesName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Description</label>
                    <textarea name="description" class="form-control rounded-3" rows="4">${topic.contents[0].description}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Example Code</label>
                    <textarea name="exampleCode" class="form-control rounded-3" rows="6" style="font-family: monospace; background-color: #f8f9fa;">${topic.contents[0].exampleCode}</textarea>
                </div>

                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn btn-primary px-4 rounded-pill">Update Changes</button>
                    
                    <a href="${pageContext.request.contextPath}/topics" class="btn btn-light px-4 rounded-pill">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>