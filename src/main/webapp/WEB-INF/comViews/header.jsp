<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ISAAC COMMUNITY</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${path}/a01_comlib/sb-admin-pro_no-source/dist/css/styles.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="icon" type="image/x-icon" href="assets/img/favicon.png" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
<script src="C:/a01_javaexp/stsworkspace/developer_comunity-2/src/main/resources/static/a02_comfun/validFun.js"></script>

<sec:authorize access="isAuthenticated()">
	<sec:authentication var="user" property="principal"/>
</sec:authorize>
</head>

<nav class="topnav navbar navbar-expand shadow justify-content-between justify-content-sm-start navbar-light bg-white">
	<div class="container">
		<a class="navbar-brand fw-bolder fs-4" href="/">ISAAC</a>
		<form id="navForm" method="post">
			<div class="shrink-0 d-flex gx-4 justify-content-between">
				<div class="text-center p-4">
					<a class="text-black" href="/notice">
						<h5 class="hover:no-underline">NOTICE</h5>
					</a>
				</div>
				<div class="text-center p-4">
					<a class="text-black" href="/questions" >
						<h5 class="hover:no-underline">Q&A</h5>
					</a>
				</div>
				<div class="text-center p-4">
					<a class="text-black" href="/knowledge">
						<h5 class="hover:no-underline">KNOWLEDGE</h5>
					</a>
				</div>
				<div class="text-center p-4">
					<a class="text-black" href="/studyGroup">
						<h5 class="hover:no-underline">STUDY GROUP</h5>
					</a>
				</div>
			</div>
		</form>
			<sec:authorize access="isAuthenticated()">
				<ul class="navbar-nav align-items-center ms-auto">
					<li class="nav-item dropdown no-caret dropdown-user me-3 me-lg-4">
					<a class="btn btn-icon btn-transparent-dark dropdown-toggle" id="navbarDropdownUserImage" href="javascript:void(0);" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img class="img-fluid" src="<sec:authentication property='principal.user_image'/>" /></a>
						<div class="dropdown-menu dropdown-menu-end border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownUserImage">
						    <h6 class="dropdown-header d-flex align-items-center">
						        <img class="dropdown-user-img" src="<sec:authentication property='principal.user_image'/>" />
						        <div class="dropdown-user-details">
						            <div class="dropdown-user-details-name"><sec:authentication property='principal.user_email'/></div>
						            <div class="dropdown-user-details-email"><sec:authentication property='principal.user_name'/></div>
						        </div>
						    </h6>
						    <div class="dropdown-divider"></div>
						    <a class="dropdown-item" href="/users/profile">
						        <div class="dropdown-item-icon"><i data-feather="user"></i></div>
						        내 프로필
						    </a>
						    <a class="dropdown-item" href="/users/account">
						        <div class="dropdown-item-icon"><i data-feather="settings"></i></div>
						        내 계정
						    </a>
						    <a class="dropdown-item" href="/users/articles?user_id=${user.user_id}">
						        <div class="dropdown-item-icon"><i data-feather="activity"></i></div>
						        활동 내역
						    </a>
						    <a id="logOutBtn" class="dropdown-item" href="/logout">
						        <div class="dropdown-item-icon"><i data-feather="log-out"></i></div>
						        Logout
						    </a>
						</div>
					</li>
				</ul>
				
			</sec:authorize>
			
			<sec:authorize access="!isAuthenticated()">
				<div class="ms-auto">
					<a href="/login" class="btn btn-outline-primary">
						로그인
					</a>
					<a href="/signUp" class="btn btn-primary">
						회원 가입
					</a>	
				</div>
			</sec:authorize>
	</div>
</nav>
<div id="layoutSidenav" class="container-xl">
	
<%-- bootstrap js --%>
<script src="${path}/a01_comlib/sb-admin-pro_no-source/dist/js/scripts.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function () {
		var pathname = location.pathname
		// header active 설정
		switch (pathname) {
			case "/notice" :
				$("h5").eq(0).addClass("text-primary")
				break;
			case "/questions" :
				$("h5").eq(1).addClass("text-primary")
				break;
			case "/knowledge" :
				$("h5").eq(2).addClass("text-primary")
				break;
			case "/studyGroup" :
				$("h5").eq(3).addClass("text-primary")
				break;
			default :
		}
				
	})
</script>
</html>