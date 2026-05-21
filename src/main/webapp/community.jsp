<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Global Community - CSMS</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { 
            background-color: #f8fafc; 
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: #0f172a;
        }
        .navbar {
            background-color: #ffffff !important; 
            border-bottom: 1px solid #e2e8f0;
        }
        .navbar-brand, .back-btn {
            color: #0f172a !important;
        }
        .back-btn {
            border-color: #cbd5e1 !important;
        }
        .back-btn:hover {
            background-color: #f1f5f9 !important;
        }
        .header-banner {
            background: #ffffff;
            color: #0f172a;
            padding: 50px 0 30px 0;
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 40px;
        }
        .card-custom {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.02);
            padding: 32px !important;
        }
        
        .badge-category {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 6px 16px;
            border-radius: 100px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .badge-general { background-color: #eff6ff; color: #2563eb; }
        .badge-events { background-color: #ecfdf5; color: #059669; }
        .badge-stories { background-color: #fffbeb; color: #d97706; }
        
        /* Box ပုံစံမှ Thread ပုံစံသို့ ပြောင်းလဲထားသော Replies Area */
        .replies-box {
            border-top: 1px solid #f1f5f9;
            margin-top: 30px;
            padding-top: 24px;
        }
        
        .reply-list {
            margin-bottom: 24px;
        }
        
        /* Dynamic Reply Form Styling */
        .form-wrap-style {
            margin: 16px 0;
            padding-left: 12px;
            border-left: 2px solid #e2e8f0;
        }
        
        .main-comment-input, .reply-input-field {
            border-radius: 100px !important;
            padding: 12px 20px;
            border: 1px solid #e2e8f0;
            font-size: 0.9rem;
            background-color: #f8fafc;
            transition: all 0.2s ease;
        }
        .main-comment-input:focus, .reply-input-field:focus {
            background-color: #fff;
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
        }
        .main-comment-btn, .reply-submit-btn {
            border-radius: 100px !important;
            background-color: #4f46e5;
            font-weight: 600;
            padding-left: 24px !important;
            padding-right: 24px !important;
        }
        .main-comment-btn:hover, .reply-submit-btn:hover {
            background-color: #4338ca;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg sticky-top py-3">
        <div class="container">
            <a class="navbar-brand fw-bold fs-4" href="home"><i class="fas fa-graduation-cap text-primary me-2"></i>CSMS</a>
            <a href="home" class="btn btn-sm back-btn rounded-pill px-4"><i class="fas fa-arrow-left me-2"></i>Back to Home</a>
        </div>
    </nav>

    <div class="header-banner text-center">
        <div class="container">
            <h1 class="fw-bold mb-2" style="letter-spacing: -0.5px;">Student Forum</h1>
            <p class="text-secondary mb-0" style="font-size: 1rem;">Share insights, stories, and technical discussions.</p>
        </div>
    </div>

    <div class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-9">
                
                <div class="card card-custom border-0 shadow-sm mb-4">
                    <h5 class="fw-bold mb-3" style="font-size: 1.1rem; color: #0f172a;">
                        <i class="linearicons-pencil me-2 text-primary"></i>Create a New Post
                    </h5>
                    
                    
                   <form action="community" method="POST">
    <input type="hidden" name="action" value="createPost">
    <div class="mb-3">
        <input type="text" name="title" class="form-control" placeholder="Enter post title..." required style="border-radius: 12px; padding: 12px 18px; border: 1px solid #e2e8f0; font-size: 0.95rem;">
    </div>
    <div class="mb-3">
        <textarea name="content" class="form-control" rows="3" placeholder="Share your insights, stories, or thoughts here..." required style="border-radius: 16px; padding: 16px; border: 1px solid #e2e8f0; font-size: 0.95rem; resize: none;"></textarea>
    </div>
    <div class="d-flex justify-content-between align-items-center">
        <div style="width: 200px;">
            <select name="postType" class="form-select" style="border-radius: 100px; font-size: 0.85rem; padding: 8px 16px;">
                <option value="General">🌐 General Discussion</option>
                <option value="Events">📅 Events & News</option>
                <option value="Stories">📰 Learner Stories</option>
            </select>
        </div>
        <button type="submit" class="btn text-white px-4 py-2" style="background-color: #4f46e5; border-radius: 100px; font-weight: 600; font-size: 0.9rem;">
            <i class="fas fa-paper-plane me-2"></i>Publish Post
        </button>
    </div>
</form>
                </div>

                <div class="d-flex flex-column gap-4">
                    <c:forEach var="post" items="${posts}">
                        <div class="card card-custom border-0 shadow-sm">
                            
                            <div class="mb-3">
                                <c:choose>
                                    <c:when test="${post.post_type == 'Events'}">
                                        <span class="badge-category badge-events">📅 Events & News</span>
                                    </c:when>
                                    <c:when test="${post.post_type == 'Stories'}">
                                        <span class="badge-category badge-stories">📰 Learner Stories</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-category badge-general">🌐 General Discussion</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <h3 class="fw-bold mb-2" style="font-size: 1.4rem; color: #0f172a; letter-spacing: -0.3px;">${post.title}</h3>
                            <p class="text-secondary mb-3" style="line-height: 1.6; font-size: 0.98rem;">${post.content}</p>
                            
                            <div class="text-muted small mb-1 d-flex align-items-center gap-2">
                                <div class="bg-light rounded-circle d-flex align-items-center justify-content-center" style="width: 28px; height: 28px;">
                                    <i class="far fa-user text-secondary" style="font-size: 0.85rem;"></i>
                                </div>
                                <span>Posted by <strong class="text-dark">@${post.userName}</strong></span>
                            </div>
                            
                            <div class="replies-box">
                                <h6 class="fw-bold mb-4" style="font-size: 0.9rem; color: #475569;">
                                    <i class="far fa-comments me-2"></i>Thoughts & Replies
                                </h6>
                                
                                <div class="reply-list">
                                    
                                    <c:forEach var="reply" items="${post.replies}">
                                        <c:set var="currentReply" value="${reply}" scope="request" />
                                        <c:set var="currentLevel" value="1" scope="request" />
                                        <c:set var="postId" value="${post.postId}" scope="request" />
                                        <jsp:include page="comment_item.jsp" />
                                    </c:forEach> 
                                    
                                    <div id="dynamic-reply-form-${post.postId}" class="form-wrap-style d-none">
                                        <form action="community" method="POST">
                                            <input type="hidden" name="postId" value="${post.postId}">
                                            <input type="hidden" name="parentReplyId" class="dynamic-parent-id" value="">
                                            <input type="hidden" name="type" value="${empty selectedType ? 'All' : selectedType}">
                                            
                                            <div class="input-group shadow-sm" style="border-radius: 100px; overflow: hidden; background: #fff; border: 1px solid #6366f1;">
                                                <span class="input-group-text bg-white text-muted border-0 small reply-label-text ps-3 pe-1" style="font-size: 0.85rem;">Reply to @</span>
                                                <input type="text" name="replyContent" class="form-control border-0 py-2" placeholder="Write a reply..." required style="font-size: 0.9rem; focus: none; box-shadow: none;">
                                                <button class="btn reply-submit-btn text-white px-4" type="submit">Reply</button>
                                                <button class="btn btn-link text-secondary text-decoration-none px-3" type="button" onclick="closeDynamicForm('${post.postId}')" style="font-size: 0.85rem;">Cancel</button>
                                            </div>
                                        </form>
                                    </div>

                                    <c:if test="${empty post.replies}">
                                        <p class="text-muted small my-4 text-center opacity-75">No comments yet. Start the conversation!</p>
                                    </c:if>
                                </div>
                                
                                <form action="community" method="POST" class="mt-4">
                                    <input type="hidden" name="postId" value="${post.postId}">
                                    <input type="hidden" name="parentReplyId" value="">
                                    <input type="hidden" name="type" value="${empty selectedType ? 'All' : selectedType}">
                                    <div class="input-group">
                                        <input type="text" name="replyContent" class="form-control main-comment-input" placeholder="What are your thoughts?..." required>
                                        <button class="btn text-white main-comment-btn" type="submit">Post Comment</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty posts}">
                        <div class="text-center p-5 bg-white border rounded-4 shadow-sm">
                            <i class="far fa-folder-open text-muted mb-3" style="font-size: 3rem;"></i>
                            <h5 class="fw-bold text-secondary">No Posts Yet</h5>
                            <p class="text-muted small mb-0">Be the first to share something with the community using the box above!</p>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function toggleReplyForm(buttonElement, postId, targetReplyId, userName, currentMargin) {
        var targetForm = document.getElementById('dynamic-reply-form-' + postId);
        if (targetForm) {
            var parentCommentBox = buttonElement.closest('.reply-container-block');
            if(parentCommentBox) {
                parentCommentBox.parentNode.insertBefore(targetForm, parentCommentBox.nextSibling);
                targetForm.classList.remove('d-none');
                
                var formMargin = currentMargin + 20;
                targetForm.style.marginLeft = formMargin + "px";
                
                var labelSpan = targetForm.querySelector('.reply-label-text');
                if (labelSpan) {
                    labelSpan.textContent = "Reply to @" + userName;
                }
                
                var hiddenInput = targetForm.querySelector('.dynamic-parent-id');
                if (hiddenInput) {
                    hiddenInput.value = targetReplyId;
                }
                
                var textInput = targetForm.querySelector('input[type="text"]');
                if (textInput) {
                    textInput.value = ""; 
                    textInput.focus();
                }
            }
        }
    }

    function closeDynamicForm(postId) {
        var targetForm = document.getElementById('dynamic-reply-form-' + postId);
        if (targetForm) {
            targetForm.classList.add('d-none');
        }
    }
    </script>
</body>
</html>