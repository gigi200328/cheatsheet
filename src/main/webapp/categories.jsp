<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root { 
            --sidebar-width: 260px; 
            --primary-color: #4361ee; 
            --secondary-color: #3f37c9;
            --bg-light: #f8f9fc;
            --text-dark: #2d3436;
        }

        body { 
            background-color: var(--bg-light); 
            font-family: 'Inter', sans-serif; 
            margin: 0; 
            color: var(--text-dark);
        }
        
        .main-content { 
            margin-left: var(--sidebar-width); 
            padding: 2.5rem; 
            min-height: 100vh; 
            transition: all 0.3s ease;
        }

        /* Header Section */
        .page-header {
            margin-bottom: 2rem;
        }

        .btn-add {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 10px 24px;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }

        /* Table Card Styling */
        .table-container { 
            background: white; 
            border-radius: 20px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.04); 
            border: 1px solid rgba(0,0,0,0.02);
            overflow: hidden;
        }
        
        .table thead th {
            background-color: #ffffff;
            border-bottom: 2px solid #f1f3f9;
            text-transform: uppercase;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 1px;
            color: #a0aec0;
            padding: 20px 24px;
        }

        .table tbody td {
            padding: 18px 24px;
            border-bottom: 1px solid #f8f9fa;
        }

        .category-icon {
            width: 44px;
            height: 44px;
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 1.1rem;
        }

        /* Action Buttons */
        .action-btn {
            width: 38px;
            height: 38px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
            background: #f8f9fc;
            border: none;
            margin-left: 5px;
        }

        .btn-edit-ui { color: #4361ee; }
        .btn-edit-ui:hover { background: #4361ee; color: white; }
        
        .btn-delete-ui { color: #ef233c; }
        .btn-delete-ui:hover { background: #ef233c; color: white; }

        /* Modal Customization */
        .modal-content { 
            border-radius: 24px; 
            border: none; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
        }
        
        .modal-header { border-bottom: 1px solid #f1f3f9; padding: 24px 30px; }
        .modal-footer { border-top: none; padding: 20px 30px 30px; }
        
        .form-label { font-weight: 600; color: #4a5568; margin-bottom: 8px; }
        .form-control-custom { 
            border-radius: 12px; 
            padding: 12px 16px; 
            background-color: #f8f9fc; 
            border: 2px solid #f1f3f9;
            transition: all 0.2s;
        }
        .form-control-custom:focus {
            background-color: #fff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
        }

        /* Badge Style for ID */
        .id-badge {
            background: #edf2f7;
            color: #4a5568;
            padding: 4px 10px;
            border-radius: 6px;
            font-family: 'Monaco', monospace;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>

    <%@ include file="sidebar.jsp" %>

    <div class="main-content">
        <div class="page-header d-flex justify-content-between align-items-center">
            <div>
                <h2 class="fw-bold text-dark mb-1">Categories</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="#" class="text-decoration-none text-muted">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Categories Management</li>
                    </ol>
                </nav>
            </div>
            <button class="btn btn-primary btn-add rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                <i class="fas fa-plus-circle me-2"></i>Add Category
            </button>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th># ID</th>
                            <th>Category Name</th>
                            <th class="text-end">Management</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cat" items="${categoryList}">
                            <tr>
                                <td>
                                    <span class="id-badge">ID-${cat.categoriesId}</span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="category-icon me-3">
                                            <i class="fas fa-layer-group"></i>
                                        </div>
                                        <div>
                                            <span class="fw-semibold text-dark d-block">${cat.categoriesName}</span>
                                            <span class="text-muted small">Updated recently</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-end">
                                    <button class="action-btn btn-edit-ui" 
                                            title="Edit Category"
                                            onclick="openEditModal('${cat.categoriesId}', '${cat.categoriesName}')">
                                        <i class="fas fa-pen-to-square"></i>
                                    </button>
                                    <a href="delete-category?id=${cat.categoriesId}" 
                                       class="action-btn btn-delete-ui text-decoration-none" 
                                       title="Delete Category"
                                       onclick="return confirm('Delete this category permanently?')">
                                        <i class="fas fa-trash-can"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Modal -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Create New Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="add-category" method="POST">
                    <div class="modal-body px-4 py-4">
                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" name="categoryName" class="form-control form-control-custom" placeholder="Enter name here..." required>
                            <div class="form-text mt-2">Use a unique name for each category.</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary btn-add rounded-pill px-4">Save Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Update Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="update-category" method="POST">
                    <div class="modal-body px-4 py-4">
                        <input type="hidden" name="categoryId" id="editCategoryId">
                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text" name="categoryName" id="editCategoryName" 
                                   class="form-control form-control-custom" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary btn-add rounded-pill px-4">Update Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function openEditModal(id, name) {
            document.getElementById('editCategoryId').value = id;
            document.getElementById('editCategoryName').value = name;
            var myModal = new bootstrap.Modal(document.getElementById('editCategoryModal'));
            myModal.show();
        }
    </script>
</body>
</html>