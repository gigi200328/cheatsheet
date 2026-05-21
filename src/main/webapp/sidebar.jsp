<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    .sidebar {
        width: 260px;
        height: 100vh;
        background: #1a1c23;
        position: fixed;
        left: 0;
        top: 0;
        z-index: 1000;
        color: white;
        display: flex;
        flex-direction: column; /* အပေါ်အောက် အစီအစဉ်လိုက်ဖြစ်အောင် */
    }
    .sidebar .logo-area {
        padding: 30px 25px;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }
    .sidebar .nav-links-container {
        flex-grow: 1; /* ကျန်တဲ့နေရာအလွတ်တွေကို ယူထားမယ် */
        overflow-y: auto;
    }
    .sidebar .nav-link {
        color: rgba(255,255,255,0.7) !important;
        padding: 15px 25px;
        display: flex;
        align-items: center;
        text-decoration: none;
        transition: 0.3s;
    }
    .sidebar .nav-link i {
        width: 25px;
        font-size: 1.1rem;
    }
    .sidebar .nav-link:hover {
        background: rgba(255,255,255,0.05);
        color: white !important;
    }
    .sidebar .nav-link.active {
        color: white !important;
        background: rgba(255,255,255,0.1);
        border-left: 4px solid #4e73df;
    }
    
    /* Logout နဲ့ View Site အတွက် သီးသန့် Area */
    .sidebar .bottom-links {
        padding: 10px 0 20px 0;
        border-top: 1px solid rgba(255,255,255,0.1);
    }
    .sidebar .view-site-link { color: #f6c23e !important; }
    .sidebar .logout-link { color: #e74a3b !important; }
</style>

<div class="sidebar">
    <div class="logo-area">
        <h4 class="fw-bold mb-0">CSMS <span class="text-primary">ADMIN</span></h4>
    </div>
    
    <div class="nav-links-container mt-3">
        <a href="admin-dashboard" class="nav-link ${pageTitle == 'Dashboard' ? 'active' : ''}">
            <i class="fas fa-home me-2"></i> Dashboard
        </a>
        <a href="categories" class="nav-link ${pageTitle == 'Categories' ? 'active' : ''}">
            <i class="fas fa-tags me-2"></i> Categories
        </a>
        <a href="topics" class="nav-link ${pageTitle == 'Topics' ? 'active' : ''}">
            <i class="fas fa-book me-2"></i> Topics
        </a>
        <a href="user-management" class="nav-link ${pageTitle == 'Users' ? 'active' : ''}">
            <i class="fas fa-users me-2"></i> User Management
        </a>
    </div>

    <div class="bottom-links">
        <a href="home" class="nav-link view-site-link">
            <i class="fas fa-external-link-alt me-2"></i> View Site
        </a>
        <a href="LogoutServlet" class="nav-link logout-link">
            <i class="fas fa-sign-out-alt me-2"></i> Logout
        </a>
    </div>
</div>