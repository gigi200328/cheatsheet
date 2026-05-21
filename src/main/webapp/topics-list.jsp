<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Topics List - CSMS</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
:root {
	--primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

body {
	background-color: #f3f4f7;
	font-family: 'Segoe UI', sans-serif;
}

.header-section {
	background: var(--primary-gradient);
	padding: 40px 0;
	color: white;
	margin-bottom: 30px;
	border-bottom-left-radius: 30px;
	border-bottom-right-radius: 30px;
}

.accordion-item {
	border: none;
	margin-bottom: 15px;
	border-radius: 12px !important;
	overflow: hidden;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.accordion-button {
	background-color: #ffffff;
	color: #2d3436;
	font-weight: 600;
	padding: 20px;
}

.accordion-button:not(.collapsed) {
	background-color: #2d3436;
	color: #fab1a0;
	box-shadow: none;
}

.syntax-box {
	background-color: #f8f9fa;
	border-left: 4px solid #764ba2;
	padding: 12px;
	border-radius: 8px;
	font-family: monospace;
	white-space: pre-wrap;
	margin-top: 8px;
}

.notes-section {
	background-color: #fbfbff;
	border-radius: 12px;
	padding: 25px;
	border: 1px dashed #d1d1e9;
	margin-top: 25px;
}

.note-card {
	background: white;
	border-radius: 10px;
	padding: 15px;
	margin-bottom: 12px;
	border-left: 4px solid #764ba2;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.03);
}

.private-note-card {
	border-left: 4px solid #f1c40f !important;
	background-color: #fffdf0 !important;
}

.note-user {
	font-size: 0.75rem;
	color: #764ba2;
	font-weight: bold;
}

.note-content {
	font-size: 0.85rem;
	color: #444;
	margin-top: 5px;
}

.btn-back {
	background: #764ba2;
	color: white;
	border-radius: 50px;
	padding: 10px 25px;
	text-decoration: none;
	transition: 0.3s;
}

.btn-back:hover {
	background: #5a3a8a;
	color: white;
}

.btn-reply {
	font-size: 0.7rem;
	color: #764ba2;
	cursor: pointer;
	text-decoration: none;
}

.reply-wrapper {
	margin-left: 40px !important;
	border-left: 2px solid #dee2e6;
	padding-left: 15px;
	margin-top: 8px;
	display: block;
}

.reply-card {
	background-color: #f8f9fa !important;
	border: none !important;
	border-left: 3px solid #74b9ff !important;
	margin-bottom: 5px !important;
	padding: 10px !important;
}

.code-window {
	position: relative;
	background-color: #1e1e1e;
	border-radius: 12px;
	padding: 35px 25px 25px 25px;
	color: #e6db74;
	font-size: 1rem;
	line-height: 1.7;
	min-height: 80px;
}

.code-window pre {
	white-space: pre-wrap;
	word-break: break-all;
	margin: 0;
}

.copy-btn {
	position: absolute;
	top: 12px;
	right: 12px;
	background: #343a40;
	color: #ffffff;
	border: 1px solid #495057;
	padding: 4px 8px;
	border-radius: 6px;
	font-size: 0.7rem;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 4px;
	transition: 0.3s;
}

.copy-btn:hover {
	background: rgba(255, 255, 255, 0.2);
}

/* Rating Star Style */
.rating-stars {
    font-size: 1.8rem;
    color: #dee2e6;
    cursor: pointer;
    display: inline-block;
}
.rating-stars .fa-star.checked {
    color: #f1c40f;
}
.rating-stars .fa-star:hover,
.rating-stars .fa-star:hover ~ .fa-star {
    color: #f39c12;
}
</style>
</head>
<body>

	<div class="header-section text-center">
		<div class="container">
			<h2 class="fw-bold">
				<i class="fas fa-book-open me-2"></i> Cheat Sheets
			</h2>
			<p class="small opacity-75">Select a topic to explore detailed syntax and examples.</p>
		</div>
	</div>

	<div class="container mb-5">
		<div class="row justify-content-center">
			<div class="col-lg-9">

				<%-- 🚨 REJECTED & BANNED STATUS MESSAGES SECTION --%>
				<c:if test="${param.status == 'rejected'}">
					<div class="alert alert-danger alert-dismissible fade show shadow-sm border-start border-danger border-4 rounded-3 mb-4" role="alert">
						<i class="fas fa-exclamation-triangle me-2"></i>
						<strong>Action Failed! Your request or submission has been rejected by the system.</strong> 
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				<c:if test="${param.status == 'banned'}">
					<div class="alert alert-warning alert-dismissible fade show shadow-sm border-start border-warning border-4 rounded-3 mb-4" role="alert">
						<i class="fas fa-ban me-2"></i>
						<strong>Access Restricted! You have been banned from posting notes or comments due to a violation of our terms and conditions.</strong> 
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>

				<div class="accordion shadow-sm" id="topicAccordion">

					<c:forEach var="t" items="${topics}" varStatus="status">
						<div class="accordion-item">
							<h2 class="accordion-header" id="heading${status.index}">
								<button class="accordion-button collapsed" type="button"
									data-bs-toggle="collapse"
									data-bs-target="#collapse${status.index}">
									<i class="fas fa-chevron-right me-3 small opacity-50"></i>
									${t.topicName}
								</button>
							</h2>

							<div id="collapse${status.index}" class="accordion-collapse collapse" data-bs-parent="#topicAccordion">
								<div class="accordion-body bg-white border-top">

									<%-- 💻 Content List Section --%>
									<c:forEach var="c" items="${t.contents}">
										<div class="content-item mb-4 pb-3 border-bottom">
											<h5 class="fw-bold text-dark mb-2">
												<i class="fas fa-code-branch me-2 text-primary"></i>
												${c.title}
											</h5>

											<label class="text-muted small fw-bold mb-2"> 
												<i class="fas fa-bolt me-1 text-warning"></i> QUICK SYNTAX
											</label>
											<div class="syntax-box mb-3">${c.description}</div>

											<c:if test="${not empty c.exampleCode}">
												<label class="text-muted small fw-bold mb-2">EXAMPLE CODE</label>
												<div class="code-window mb-3">
													<button class="copy-btn" onclick="copyCode(this)">
														<i class="far fa-copy fa-sm"></i> Copy
													</button>
													<pre class="mb-0"><code>${c.exampleCode}</code></pre>
												</div>
											</c:if>
										</div>
									</c:forEach>

									<%-- 🗒️ Notes & Insights Tab Section --%>
									<div class="notes-section">
										<ul class="nav nav-tabs mb-3 border-0" id="insightTab${status.index}" role="tablist">
											<li class="nav-item" role="presentation">
												<button class="nav-link active border-0 fw-bold small"
													id="community-tab-${status.index}" data-bs-toggle="tab"
													data-bs-target="#community-pane-${status.index}"
													type="button" role="tab"
													aria-controls="community-pane-${status.index}"
													aria-selected="true">
													<i class="fas fa-users me-1"></i> Community Insights
												</button>
											</li>
											<li class="nav-item" role="presentation">
												<button class="nav-link border-0 fw-bold small"
													id="personal-tab-${status.index}" data-bs-toggle="tab"
													data-bs-target="#personal-pane-${status.index}"
													type="button" role="tab"
													aria-controls="personal-pane-${status.index}"
													aria-selected="false">
													<i class="fas fa-lock me-1"></i> My Private Notes
												</button>
											</li>
											<li class="nav-item" role="presentation">
												<button class="nav-link border-0 fw-bold small"
													id="rating-tab-${status.index}" data-bs-toggle="tab"
													data-bs-target="#rating-pane-${status.index}" type="button"
													role="tab" aria-controls="rating-pane-${status.index}"
													aria-selected="false">
													<i class="fas fa-star me-1 text-warning"></i> Topic Rating
												</button>
											</li>
										</ul>

										<div class="tab-content" id="insightTabContent${status.index}">
											
											<div class="tab-pane fade show active" id="community-pane-${status.index}" role="tabpanel" aria-labelledby="community-tab-${status.index}">
												<div class="note-list">
													<c:forEach var="note" items="${t.notes}">
														<%-- 💡 ပြင်ဆင်ချက်: parentId == 0 ဖြစ်တဲ့ Main Public Note တွေကိုပဲ အပေါ်ဆုံးမှာ အရင်စစ်ထုတ်ပြသမယ် --%>
														<c:if test="${note.isPublic == 1 && note.parentId == 0}">
															<div class="note-card mb-2">
																<div class="d-flex justify-content-between">
																	<div class="note-user">@${not empty note.userName ? note.userName : 'User'}</div>
																	<c:if test="${sessionScope.user.userId == note.userId}">
																		<a href="delete-note?noteId=${note.noteId}&catId=${param.catId}"
																			class="text-danger small" onclick="return confirm('Delete?')"> 
																			<i class="fas fa-trash-can"></i>
																		</a>
																	</c:if>
																</div>

																<div class="note-content">${note.content}</div>

																<div class="mt-2">
																	<a href="javascript:void(0)" class="btn-reply fw-bold"
																		onclick="toggleReplyForm('${note.noteId}_${status.index}')">
																		<i class="fas fa-reply"></i> Reply
																	</a>
																</div>

																<%-- 💬 Reply Input Form --%>
																<div id="replyForm_${note.noteId}_${status.index}" class="mt-2" style="display: none;">
																	<form action="save-note" method="POST">
																		<input type="hidden" name="topicId" value="${t.topicId}">
																		<input type="hidden" name="catId" value="${param.catId}">
																		<input type="hidden" name="isPublic" value="1"> 
																		<input type="hidden" name="parentId" value="${note.noteId}">
																		<div class="input-group">
																			<input type="text" name="commentText" class="form-control form-control-sm" placeholder="Reply..." required>
																			<button class="btn btn-sm btn-primary" type="submit">
																				<i class="fas fa-paper-plane"></i>
																			</button>
																		</div>
																	</form>
																</div>

																<%-- 🔄 Replies List (ဒီ Note အောက်က သက်ဆိုင်ရာ ပြန်စာ/Comment များကိုသာ စစ်ထုတ်ပြသမည်) --%>
																<div id="replyList_${note.noteId}_${status.index}" class="reply-wrapper">
																	<c:forEach var="reply" items="${t.notes}">
																		<c:if var="isReply" test="${reply.parentId == note.noteId}">
																			<div class="note-card reply-card py-2 px-3">
																				<div class="d-flex justify-content-between">
																					<div class="note-user" style="color: #6c757d; font-size: 0.7rem;">
																						@${not empty reply.userName ? reply.userName : 'User'}
																					</div>
																					<c:if test="${sessionScope.user.userId == reply.userId}">
																						<a href="delete-note?noteId=${reply.noteId}&catId=${param.catId}"
																							class="text-danger small" style="font-size: 0.65rem;" onclick="return confirm('Delete Reply?')"> 
																							<i class="fas fa-trash-can"></i>
																						</a>
																					</c:if>
																				</div>
																				<div class="note-content" style="font-size: 0.8rem;">
																					${reply.content}
																				</div>
																			</div>
																		</c:if>
																	</c:forEach>
																</div>
															</div>
														</c:if>
													</c:forEach>
												</div>

												<%-- 📥 Write Main Public Note Form --%>
												<form action="save-note" method="POST" class="mt-4 border-top pt-3">
													<input type="hidden" name="topicId" value="${t.topicId}">
													<input type="hidden" name="catId" value="${param.catId}">
													<input type="hidden" name="isPublic" value="1">
													<input type="hidden" name="parentId" value="0">
													<div class="input-group">
														<input type="text" name="commentText" class="form-control" placeholder="Write a community tip..." required>
														<button class="btn btn-primary px-4" type="submit">Post Note</button>
													</div>
												</form>
											</div>

											<div class="tab-pane fade" id="personal-pane-${status.index}" role="tabpanel" aria-labelledby="personal-tab-${status.index}">
												<div class="note-list">
													<c:forEach var="note" items="${t.notes}">
														<c:if test="${note.isPublic == 0 && sessionScope.user.userId == note.userId}">
															<div class="note-card private-note-card mb-2">
																<div class="d-flex justify-content-between">
																	<div class="note-user text-warning"><i class="fas fa-lock me-1"></i>My Private Note</div>
																	<a href="delete-note?noteId=${note.noteId}&catId=${param.catId}"
																		class="text-danger small" onclick="return confirm('Delete this note?')"> 
																		<i class="fas fa-trash-can"></i>
																	</a>
																</div>
																<div class="note-content">${note.content}</div>
															</div>
														</c:if>
													</c:forEach>
												</div>

												<%-- 📥 Write Private Note Form --%>
												<form action="save-note" method="POST" class="mt-3">
													<input type="hidden" name="topicId" value="${t.topicId}">
													<input type="hidden" name="catId" value="${param.catId}">
													<input type="hidden" name="isPublic" value="0">
													<input type="hidden" name="parentId" value="0">
													<div class="input-group">
														<input type="text" name="commentText" class="form-control form-control-sm" placeholder="Save a private note for yourself..." required style="background-color: #fffdf0; border-color: #f1c40f;">
														<button class="btn btn-sm btn-warning" type="submit">
															<i class="fas fa-sticky-note"></i> Save Private
														</button>
													</div>
												</form>
											</div>

		<div class="tab-pane fade" id="rating-pane-${status.index}" role="tabpanel" aria-labelledby="rating-tab-${status.index}">
	<div class="text-center py-4 bg-light rounded-3 border">
		
		<div class="rating-summary mb-3">
			<h3 class="fw-bold text-dark mb-1">
				${t.avgRating > 0 ? String.format("%.1f", t.avgRating) : "0.0"} <span class="fs-6 text-muted">/ 5.0</span>
			</h3>
			<p class="small text-muted mb-0">
				<i class="fas fa-users me-1 text-primary"></i> Total: ${t.totalRatings} ratings
			</p>
		</div>
		
		<hr class="mx-auto my-3 opacity-25" style="max-width: 200px;">
		
		<h6 class="fw-bold text-dark mb-2">Rate this topic</h6>
		<p class="small text-muted mb-3">Your rating helps improve content quality.</p>
		
		<form action="submitRating" method="POST">
			<input type="hidden" name="topicId" value="${t.topicId}">
			<input type="hidden" name="catId" value="${param.catId}">
			
			<div class="rating-stars mb-3" data-topic="${t.topicId}">
				<i class="far fa-star" data-value="1"></i>
				<i class="far fa-star" data-value="2"></i>
				<i class="far fa-star" data-value="3"></i>
				<i class="far fa-star" data-value="4"></i>
				<i class="far fa-star" data-value="5"></i>
			</div>
			<input type="hidden" name="ratingValue" id="ratingInput_${t.topicId}" value="0">
			
			<div>
				<button type="submit" class="btn btn-sm btn-outline-primary px-4 rounded-pill">Submit Rating</button>
			</div>
		</form> </div>
</div>

										</div> <%-- End of Tab Content --%>
									</div> <%-- End of Notes Section --%>
									
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
				
				<div class="text-center mt-5">
					<a href="home" class="btn btn-back shadow-sm"> 
						<i class="fas fa-arrow-left me-2"></i>Back to home
					</a>
				</div>

			</div>
		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	function toggleReplyForm(id) {
	    var form = document.getElementById('replyForm_' + id);
	    if (form) {
	        if (form.style.display === "none" || form.style.display === "") {
	            form.style.display = "block";
	        } else {
	            form.style.display = "none";
	        }
	    }
	}

	function copyCode(button) {
	    const codeElement = button.parentElement.querySelector('code');
	    const textToCopy = codeElement.innerText;

	    navigator.clipboard.writeText(textToCopy).then(() => {
	        const originalHTML = button.innerHTML;
	        button.innerHTML = '<i class="fas fa-check fa-sm"></i> Done'; 
	        
	        setTimeout(() => {
	            button.innerHTML = originalHTML;
	        }, 2000);
	    });
	}

	// ⭐️ JavaScript for Interactive Star Rating Selection
	document.querySelectorAll('.rating-stars').forEach(container => {
	    const stars = container.querySelectorAll('.fa-star');
	    const topicId = container.getAttribute('data-topic');
	    const input = document.getElementById('ratingInput_' + topicId);

	    stars.forEach(star => {
	        star.addEventListener('click', function() {
	            const val = this.getAttribute('data-value');
	            input.value = val;
	            
	            stars.forEach(s => {
	                if(parseInt(s.getAttribute('data-value')) <= parseInt(val)) {
	                    s.classList.remove('far');
	                    s.classList.add('fas', 'checked');
	                } else {
	                    s.classList.remove('fas', 'checked');
	                    s.classList.add('far');
	                }
	            });
	        });
	    });
	});
	</script>
</body>
</html>