<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.model.LoginBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    com.library.model.LoginBean user = (com.library.model.LoginBean) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cheatography Style - Cheat Sheet Management System</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { 
            background-color: #f8fafc; 
            font-family: 'Inter', sans-serif;
            color: #1e293b;
        }
        
        /* Cheatography Style Top Header & Navbar */
        .navbar {
            background-color: #2c3e50 !important;
            border-bottom: 3px solid #34495e;
        }
        .navbar-brand { font-weight: 700; font-size: 1.4rem; color: #ecf0f1 !important; }
        
        /* Hero Search Section Like Cheatography */
        .hero-search-bg {
            background: linear-gradient(to right, #2c3e50, #3498db);
            color: white;
            padding: 60px 0;
            text-align: center;
            margin-bottom: 40px;
        }
        .search-box-large {
            max-width: 600px;
            margin: 20px auto 0 auto;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            border-radius: 30px;
            overflow: hidden;
        }
        .search-box-large .form-control {
            border: none;
            padding: 15px 25px;
            font-size: 1.1rem;
            border-radius: 30px 0 0 30px;
        }
        .search-box-large .btn {
            padding: 0 30px;
            background-color: #e67e22;
            color: white;
            font-weight: 600;
            border: none;
            border-radius: 0 30px 30px 0;
            transition: background 0.2s;
        }
        .search-box-large .btn:hover { background-color: #d35400; }

        /* Content Filter Navigation */
        .filter-nav .nav-link {
            color: #64748b;
            font-weight: 500;
            padding: 10px 20px;
            border-radius: 20px;
            margin-right: 10px;
            transition: all 0.2s;
        }
        .filter-nav .nav-link.active, .filter-nav .nav-link:hover {
            background-color: #3498db;
            color: white !important;
        }

        /* Cheatography Card Grid Layout */
        .cheat-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            transition: all 0.2s ease-in-out;
            height: 100%;
        }
        .cheat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px rgba(0,0,0,0.05);
            border-color: #3498db;
        }
        .cheat-card-header {
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 12px 15px;
            font-weight: 600;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .cheat-card-body { padding: 20px 15px; }
        .cheat-meta {
            font-size: 0.8rem;
            color: #64748b;
            display: flex;
            gap: 15px;
            margin-top: 15px;
            padding-top: 12px;
            border-top: 1px dashed #e2e8f0;
        }

        /* Tag Cloud Styling */
        .tag-badge {
            background-color: #e2e8f0;
            color: #475569;
            text-decoration: none;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
            display: inline-block;
            margin: 0 5px 8px 0;
            transition: all 0.2s;
        }
        .tag-badge:hover {
            background-color: #3498db;
            color: white;
        }
        
        .sidebar-box {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }
        .sidebar-title {
            font-size: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #334155;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 5px;
        }
        /* Custom Modern Dropdown Styling */
        .custom-dropdown-menu {
            border: none !important;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08) !important;
            border-radius: 16px !important;
            padding: 10px !important;
            margin-top: 15px !important;
            animation: fadeInDropdown 0.2s ease-out;
        }

        .custom-dropdown-item {
            padding: 12px 16px !important;
            border-radius: 10px !important;
            color: #2c3e50 !important;
            font-weight: 500 !important;
            font-size: 0.95rem !important;
            transition: all 0.2s ease;
        }

        /* Mouse တင်လိုက်ရင် ဖြစ်မယ့် Effect (Cheatography Blue Light Blue Theme) */
        .custom-dropdown-item:hover {
            background-color: #f1f5f9 !important;
            color: #3498db !important;
            transform: translateX(4px);
        }

        .custom-dropdown-item i {
            font-size: 1.1rem;
            width: 24px;
            text-align: center;
        }

        /* Dropdown ကျလာရင် Smooth ဖြစ်အောင် Animation ထည့်ခြင်း */
        @keyframes fadeInDropdown {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top py-2">
        <div class="container">
            <a class="navbar-brand" href="home"><i class="fas fa-file-alt text-warning me-2"></i>CSMS <span class="fw-light text-muted" style="font-size:1rem;">Cheatography Edition</span></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
         <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center gap-2">
                <li class="nav-item"><a class="nav-link active" href="home">Home</a></li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white-50 fw-medium" href="#" id="communityDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-users me-1"></i> Community
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end custom-dropdown-menu" aria-labelledby="communityDropdown">
                        <li>
                            <a class="dropdown-item custom-dropdown-item d-flex align-items-center" href="community?type=All">
                                <i class="fas fa-globe text-primary me-3"></i>
                                <span>Visit Community</span>
                            </a>
                        </li>
                        <li><hr class="dropdown-divider opacity-25 my-1"></li>
                        <li>
                            <a class="dropdown-item custom-dropdown-item d-flex align-items-center" href="community?type=Events">
                                <i class="far fa-calendar-alt text-success me-3"></i>
                                <span>Events</span>
                    </a>
                        </li>
                        <li><hr class="dropdown-divider opacity-25"></li>
                        <li>
                            <a class="dropdown-item custom-dropdown-item d-flex align-items-center" href="community?type=Stories">
                                <i class="far fa-newspaper text-warning me-3"></i>
                                <span>Learner Stories</span>
                            </a>
                        </li>
                    </ul>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item"><a class="nav-link text-white-50" href="profile">My Profile</a></li>
                        <li class="nav-item ms-2">
                            <a class="btn btn-sm btn-danger px-3 rounded" href="LogoutServlet">Sign Out</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-2">
                            <a class="btn btn-sm btn-outline-light px-3" href="login">Login</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        </div>
    </nav>

    <div class="hero-search-bg">
        <div class="container">
            <h1 class="fw-bold mb-2">Free Cheat Sheets & Quick References</h1>
            <p class="opacity-75 fs-5">Find, share and download programming cheat sheets efficiently</p>
            
            <div class="input-group search-box-large">
                <input type="text" id="innerSearch" onkeyup="filterCategories()" class="form-control" placeholder="Search categories (e.g. Java, Python)...">
                <button class="btn" type="button"><i class="fas fa-search me-1"></i> Search</button>
            </div>
        </div>
    </div>

    <div class="container">
        
        <!-- Alert Message စနစ်ထည့်သွင်းခြင်း (ကျန်တာမပြင်ပါ) -->
        <% if ("added".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4" role="alert" style="border-radius: 12px; background-color: #d1e7dd;">
                <i class="fas fa-check-circle text-success me-2 fa-lg"></i>
                <span><strong>Success!</strong> Successful add topic!!!</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <% if ("content_rejected".equals(request.getParameter("warning"))) { %>
            <div class="alert alert-warning alert-dismissible fade show shadow-sm border-0 mb-4" role="alert" style="border-radius: 12px; background-color: #fff3cd;">
                <i class="fas fa-exclamation-triangle text-warning me-2 fa-lg"></i>
                <span><strong>Topic Rejected!</strong> Submission Rejected! Your content contains banned words and has been declined by the system. Further violations may result in an account suspension.</span>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
            <nav class="nav filter-nav">
                <a class="nav-link active" href="#" onclick="filterByGroup(event, 'all')">All Sheets</a>
                <a class="nav-link" href="#" onclick="filterByGroup(event, 'language')">Languages</a>
                <a class="nav-link" href="#" onclick="filterByGroup(event, 'framework')">Frameworks</a>
                <a class="nav-link" href="#" onclick="filterByGroup(event, 'database')">Databases</a>
            </nav>
            <a href="user-add-topic" class="btn btn-warning px-4 fw-bold shadow-sm text-dark">
                <i class="fas fa-plus-circle me-1"></i> Create A Cheat Sheet
            </a>
        </div>

        <div class="row g-4">
            
            <div class="col-lg-8">
                <h4 class="fw-bold mb-3 text-secondary" style="font-size: 1.1rem;">BROWSE PROGRAMMING REPOSITORIES</h4>
                
                <div class="row g-3" id="categoryContainer"> 
                    <c:forEach items="${categoryList}" var="cat">
                        <div class="col-md-6 category-item" data-title="${cat.categoriesName}">
                            <div class="cheat-card">
                                <div class="cheat-card-header">
                                    <span class="text-truncate text-primary card-title"><i class="fas fa-code me-2 text-muted"></i>${cat.categoriesName}</span>
                                    <span class="badge bg-secondary rounded-pill small" style="font-size: 0.75rem;">Active</span>
                                </div>
                                <div class="cheat-card-body">
                                    <h5 class="fw-bold mb-2">
                                        <a href="ViewTopicsServlet?catId=${cat.categoriesId}" class="text-decoration-none text-dark hover-blue">${cat.categoriesName} Reference Sheet</a>
                                    </h5>
                                    <p class="text-muted small mb-0">
                                        Essential syntax, built-in methods, common code blocks and reference guides for ${cat.categoriesName}.
                                    </p>
                                    <div class="cheat-meta">
                                        <span><i class="far fa-user me-1"></i> System</span>
                                        <span><i class="far fa-eye me-1"></i> ${cat.viewsCount} Views</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div id="noResultsMessage" class="col-12 text-center py-5 bg-white border rounded" style="display: none;">
                        <i class="fas fa-search-minus fa-3x text-muted opacity-50 mb-3"></i>
                        <h5 class="text-secondary">No match found</h5>
                        <p class="text-muted mb-0">Try searching for another programming language or category.</p>
                    </div>
                </div>

                <c:if test="${empty categoryList}">
                    <div class="col-12 text-center py-5 bg-white border rounded mt-3">
                        <i class="fas fa-search fa-3x text-muted opacity-50 mb-3"></i>
                        <h5 class="text-secondary">No cheat sheets found</h5>
                        <p class="text-muted mb-0">Be the first to share a cheat sheet repository!</p>
                    </div>
                </c:if>
            </div>

            <div class="col-lg-4">
                
                <div class="sidebar-box bg-light border-0" style="border-left: 4px solid #e67e22 !important;">
                    <h6 class="fw-bold mb-1">Welcome, <%= (user != null) ? user.getName() : "Guest User" %>!</h6>
                    <p class="text-muted small mb-0">You can customize, download as PDF, or pin your favorite cheat sheets for rapid access.</p>
                </div>

                <div class="sidebar-box">
                    <h5 class="sidebar-title">Popular Tags</h5>
                    <div class="pt-1">
                        <a href="#" class="tag-badge" onclick="filterByTag('JavaScript')">JavaScript</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('Python')">Python 3</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('Git')">Git & GitHub</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('SQL')">SQL Functions</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('HTML')">HTML5/CSS3</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('Java')">Java Core</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('Docker')">Docker</a>
                        <a href="#" class="tag-badge" onclick="filterByTag('Regex')">Regex</a>
                    </div>
                </div>

                <div class="sidebar-box">
                    <h5 class="sidebar-title">Global Statistics</h5>
                    <div class="d-flex justify-content-between mb-2 small border-bottom pb-2">
                        <span class="text-muted">Total Repository</span>
                        <span class="fw-bold">${not empty totalCategories ? totalCategories : '0'} Categories</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2 small border-bottom pb-2">
                        <span class="text-muted">Live Code Snippets</span>
                        <span class="fw-bold">${not empty totalTopics ? totalTopics : '0'} Topics</span>
                    </div>
                    <div class="d-flex justify-content-between small">
                        <span class="text-muted">System Status</span>
                        <span class="text-success fw-medium"><i class="fas fa-circle me-1" style="font-size:8px"></i> Operational</span>
                    </div>
                </div>

            </div>
        </div>

        <footer class="text-center text-muted" style="margin-top: 80px; padding: 25px 0; border-top: 1px solid #e2e8f0;">
            <small>&copy; 2026 Cheat Sheet Management System. Built in Cheatography Structure.</small>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    function filterByGroup(event, groupType) {
        if (event) event.preventDefault();
        
        if (event) {
            let navLinks = document.querySelectorAll('.filter-nav .nav-link');
            navLinks.forEach(link => link.classList.remove('active'));
            event.target.classList.add('active');
        }
        
        document.getElementById('innerSearch').value = "";
        
        let cards = document.getElementsByClassName('category-item');
        let noResultsMsg = document.getElementById('noResultsMessage');
        let hasResults = false;
        
        let dbKeywords = ['sql', 'mysql', 'database', 'oracle', 'mongo', 'postgre', 'sqlite', 'mariadb'];
        let frameworkKeywords = ['framework', 'spring', 'bootstrap', 'angular', 'react', 'vue', 'laravel', 'django', 'flask', 'express', 'jquery', 'nextjs'];

        for (let i = 0; i < cards.length; i++) {
            let titleAttr = cards[i].getAttribute('data-title');
            if (!titleAttr) continue;
            
            let title = titleAttr.toLowerCase().trim();
            
            if (groupType === 'all') {
                cards[i].style.display = "";
                hasResults = true;
            } 
            else if (groupType === 'database') {
                let isDB = dbKeywords.some(keyword => title.includes(keyword));
                if (isDB) {
                    cards[i].style.display = "";
                    hasResults = true;
                } else {
                    cards[i].style.display = "none";
                }
            } 
            else if (groupType === 'framework') {
                let isFramework = frameworkKeywords.some(keyword => title.includes(keyword));
                if (isFramework) {
                    cards[i].style.display = "";
                    hasResults = true;
                } else {
                    cards[i].style.display = "none";
                }
            } 
            else if (groupType === 'language') {
                let isDB = dbKeywords.some(keyword => title.includes(keyword));
                let isFramework = frameworkKeywords.some(keyword => title.includes(keyword));
                
                if (!isDB && !isFramework) {
                    cards[i].style.display = "";
                    hasResults = true;
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
        
        noResultsMsg.style.display = hasResults ? "none" : "block";
    }

    function filterCategories() {
        let navLinks = document.querySelectorAll('.filter-nav .nav-link');
        navLinks.forEach(link => link.classList.remove('active'));
        if(navLinks[0]) navLinks[0].classList.add('active');

        let input = document.getElementById('innerSearch').value.toLowerCase().trim();
        let cards = document.getElementsByClassName('category-item');
        let noResultsMsg = document.getElementById('noResultsMessage');
        let hasResults = false;

        for (let i = 0; i < cards.length; i++) {
            let titleElement = cards[i].querySelector('.card-title');
            if (titleElement) {
                let titleText = titleElement.textContent || titleElement.innerText;
                if (titleText.toLowerCase().indexOf(input) > -1) {
                    cards[i].style.display = ""; 
                    hasResults = true;
                } else {
                    cards[i].style.display = "none"; 
                }
            }
        }

        noResultsMsg.style.display = hasResults ? "none" : "block";
    }

    function filterByTag(tagName) {
        document.getElementById('innerSearch').value = tagName;
        filterCategories();
    }
    </script>
</body>
</html>