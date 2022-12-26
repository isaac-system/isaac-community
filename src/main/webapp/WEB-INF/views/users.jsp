<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 활동 내역</title>
</head>
<body class="nav-fixed px-2 py-4 bg-white">
	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				
				<div class="card mb-5">
					<div class="d-flex p-4 align-items-center">
						<div class="rounded-circle border me-4" style="overflow: hidden; width: 80px; height: 80px">
							<img src="${userInfo.user_image}" style="width: 101%;height: 101%">
						</div>
						<h1 class="text-black fw-bolder">
							${userInfo.user_nickName}
						</h1>
					</div>
					<div class="card-footer p-4">
						<div>
							<a id="activity" class="text-black" href="/users/activity?user_id=${param.user_id}">
								최근활동
							</a>
							<a id="article" class="text-black" href="/users/articles?user_id=${param.user_id}">
								게시물
							</a>
						</div>
					</div>
				</div>
				
				<ul class="list-group card">					
					<c:forEach items="${articleList}" var="article">
						<li class="list-group-item py-4">
							<div class="d-flex justify-content-between mb-4 text-black-75">
								<div>
									<span class="text-primary fw-semibold border border-gray-300 rounded-pill p-2">${article.board_type}</span>
									<span>${article.description}</span> 
								</div>
								<div>
									<fmt:formatDate value="${article.created_at}" pattern="YYYY-MM-dd HH:mm:ss"/>
								</div>
							</div>
							<div>
								<h5>
									<a href="/notice_detail?board_no=${article.board_no}" class="text-black fw-bolder">
										${article.board_title}
									</a>
								</h5>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
				
		</main>
		<%@include  file="../comViews/footer.jsp"%>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function () {
		
		var user_id = '${param.user_id}';
		
	})
	
	
</script>
</body>
</html>