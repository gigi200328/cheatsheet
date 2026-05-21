<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="level" value="${empty currentLevel ? 1 : currentLevel}" />
<!-- Reply အတွက် Space အကွာအဝေးကို ပိုမိုမျှတအောင် 28px စီချန်ထားပါမည် -->
<c:set var="marginPx" value="${(level - 1) * 28}" />

<style>
    /* Thread Line ဖန်တီးရန် စတိုင်များ */
    .reply-container-block {
        position: relative;
        padding-bottom: 8px;
    }
    .thread-line-connector {
        position: absolute;
        left: -18px;
        top: -15px;
        width: 2px;
        height: calc(100% + 15px);
        background-color: #e2e8f0;
    }
    .reply-avatar-img {
        font-size: 1.6rem;
        color: #64748b;
        background: #fff;
        z-index: 2;
        position: relative;
    }
    .action-reply-btn {
        font-size: 0.78rem;
        font-weight: 600;
        color: #64748b;
        background: none;
        border: none;
        padding: 4px 8px;
        border-radius: 6px;
        transition: all 0.2s;
    }
    .action-reply-btn:hover {
        color: #4f46e5;
        background-color: #f1f5f9;
    }
</style>

<div class="reply-container-block d-flex gap-3 align-items-start mt-3" 
     style="${currentReply.parentReplyId > 0 ? 'margin-left: '.concat(marginPx).concat('px;') : ''}">
    
    <!-- ညာဘက်သို့ရွေ့သွားသော Nested Comment များတွင် ဘယ်ဘက်၌ လိုင်းလေးများပေါ်နေစေရန် -->
    <c:if test="${currentReply.parentReplyId > 0}">
        <div class="thread-line-connector"></div>
    </c:if>
    
    <div class="reply-avatar-img">
        <i class="text-indigo-400 fas fa-user-circle" style="${currentReply.parentReplyId > 0 ? 'color: #94a3b8;' : 'color: #4f46e5;'}"></i>
    </div>
    
    <div class="w-100 pb-2" style="border-bottom: 1px solid #f8fafc;">
        <div class="d-flex justify-content-between align-items-center mb-1">
            <div>
                <strong style="color: #0f172a; font-size: 0.88rem; font-weight: 600;">@${currentReply.userName}</strong>
                <c:if test="${not empty currentReply.parentUserName}">
                    <span class="text-muted mx-1" style="font-size: 0.75rem;">
                        <i class="fas fa-long-arrow-alt-right text-muted mx-1"></i>
                        to <strong style="color: #6366f1;">@${currentReply.parentUserName}</strong>
                    </span>
                </c:if>
            </div>
            <button class="action-reply-btn" onclick="toggleReplyForm(this, '${postId}', '${currentReply.replyId}', '${currentReply.userName}', ${marginPx})">
                <i class="fas fa-reply me-1"></i>Reply
            </button>
        </div>
        <p class="text-secondary mb-0" style="font-size: 0.92rem; line-height: 1.5; color: #334155 !important;">${currentReply.replyContent}</p>
    </div>
</div>

<c:if test="${not empty currentReply.nestedReplies}">
    <c:set var="savedLevel" value="${level}" />
    <c:forEach var="childReply" items="${currentReply.nestedReplies}">
        <c:set var="currentReply" value="${childReply}" scope="request" />
        <c:set var="currentLevel" value="${savedLevel + 1}" scope="request" />
        <jsp:include page="comment_item.jsp" />
    </c:forEach>
</c:if>