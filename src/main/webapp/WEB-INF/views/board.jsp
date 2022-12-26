<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<fmt:setLocale value="ko"/>
<script src="https://unpkg.com/feather-icons"></script>
</head>
<body class="nav-fixed">

	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content" class="gx-5 my-4" style="display: flex; flex-direction: row;">
	
		<div class="col-sm-2">
			<div class="my-4">
				<h5 class="fw-bolder">
					#인기 태그
				</h5>
				<div class="divider my-3"></div>
				<c:forEach items="${tagList}" var="tag">
					<div class="d-flex justify-content-between align-item-center">
						<div>
							<h5>
								<a href="/tagged?tags=${tag.tag_name}" class="text-dark">
									#${tag.tag_name}
								</a>
							</h5>
						</div>
						<div class="mb-2">
							<h5 class="text-primary">
								${tag.tagCnt}
							</h5>
						</div>
					</div>
				</c:forEach>
			</div>
			
			<div class="mb-4">
				<h5 class="fw-bolder">
					Top Writers
				</h5>
				<div class="divider my-3"></div>
				<c:forEach items="${topUserList}" var="users">
					<div class="d-flex justify-content-between align-items-center">
						<div>
							<h5>
								<a href="/users/articles?user_id=${users.user_id}" class="text-dark">
									<div class="d-flex justify-content-center align-items-center">
										<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
											<img alt="프로필" src="${users.user_image}" style="width: 100%; height: 100%">
										</div>
										<div>
											${users.user_nickName}
										</div>
									</div>
								</a>
							</h5>
						</div>
						<div class="mb-2">
							<h5 class="text-primary">
								${users.writeCnt}
							</h5>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<main class="container col-md-8">
			<!-- notice header -->
			<header class="card bg-gradient-primary-to-secondary my-3">
				<div class="py-3">
					<div class="d-flex justify-content-center align-item-center">
					    <h1 class="text-white">
					    	${boardTitle}
					    </h1>
					</div>
			    </div>
			</header>
			<div class="mt-4">
				<form id="frm01" class="form-inline d-lg-block" method="get">
					<input type="hidden" name="tags" value="${param.tags}">
					<input type="hidden" name="sort">
					<div class="d-flex justify-content-between align-items-center mb-4">
						<div>
							<c:if test="${empty param.tags and ( (boardTitle eq 'NOTICE' and user.auth eq 'ADMIN') or (boardTitle ne 'NOTICE') )}">
								<button id="writeBoardBtn" type="button" class="btn btn-primary justify-content-center align-item-center">
									<i data-feather="edit-2" class="me-2"></i>
									<span class="text-center">작성하기</span>
								</button>
							</c:if>
						</div>
						
						<div>
							<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
								<c:choose>
									<c:when test='${param.sort eq "recommend"}'>
										추천순
									</c:when>
									<c:when test='${param.sort eq "views"}'>
										조회순
									</c:when>
									<c:when test='${param.sort eq "comments"}'>
										댓글순
									</c:when>
									<c:otherwise>
										최신순
									</c:otherwise>
								</c:choose>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="javascript:void(0)" onclick="sort(1)">최신순</a></li>
								<li><a class="dropdown-item" href="javascript:void(0)" onclick="sort(2)">조회순</a></li>
								<li><a class="dropdown-item" href="javascript:void(0)" onclick="sort(3)">추천순</a></li>
								<li><a class="dropdown-item" href="javascript:void(0)" onclick="sort(4)">댓글순</a></li>
							</ul>
						</div>
					</div>
				
					<input type="hidden" name="curPage" value="1"> 
					<!-- search -->
					<div class="mb-4 row">
						<div class="input-group col">
							<select name="pageSize" class="form-control">
								<option>5</option>
								<option>10</option>
								<option>20</option>
							</select>
						</div>
		                <div class="input-group input-group-joined col bg-white">
		                    <div class="input-group-text"><i data-feather="search"></i></div>
		                    <input class="form-control pe-0" type="search" name="title" value="${param.title}" placeholder="${boardTitle} 내에서 검색" aria-label="Search"/>
		                </div>
		                
		                <div class="input-group col justify-content-end align-items-center">
							<span style="margin-right: 20px"> ${boardPagingVO.curPage}/${boardPagingVO.pageCount} 페이지 </span>
							<button id="pageMinus" type="button" class="btn btn-light" onclick="javascript:goPage(${boardPagingVO.curPage-1})" disabled="disabled"><i data-feather="arrow-left"></i></button>
							<button id="pagePlus" type="button" class="btn btn-light" onclick="javascript:goPage(${boardPagingVO.curPage+1})"><i data-feather="arrow-right"></i></button>
						</div>
					</div>
				</form>
				
				
				<!-- notice -->
				<div class="overflow-hidden">
					<ul class="list-group mb-4">
					
						<c:if test="${boardList==null or fn:length(boardList) == 0}">
							<div class="d-flex justify-content-center">
								<h3>
									검색 결과가 존재하지 않습니다.
								</h3>
							</div>
						</c:if>
						
						<c:forEach var="board" items="${boardList}">
							<li class="list-group-item">
								<div class="d-flex justify-content-between mb-2">
									<a href="/users/articles?user_id=${board.user_id}" class="text-dark">
										<div class="d-flex justify-content-center align-items-center ">
											<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
												<img alt="프로필" src="${board.user_image}" style="width: 100%; height: 100%">
											</div>
											<div>
												${board.user_nickName}
											</div>
										</div>
									</a>
									<div>
										<fmt:formatDate value="${board.updated_at}" pattern="YYYY-MM-dd"/>
									</div>
								</div>
								<div class="mb-2">
									<a href="/notice_detail?board_no=${board.board_no}" class="fs-3 fw-bolder text-dark">
										${board.board_title}
									</a>
								</div>
								<div class="d-flex justify-content-between align-items-center text-gray-500">
									<div>
										<c:forEach items="${board.tags}" var="tags">
											<a href="/tagged?tags=${tags}" class="text-black-50">
												#${tags}
											</a>
										</c:forEach>
									</div>
									<div class="row align-items-center">
										<div class="col d-flex align-items-center">
											<i class="size-24 me-2" data-feather="thumbs-up" wid></i>
											<span>${board.likes}</span>
										</div>
										<div class="col d-flex align-items-center">
											<i class="size-24 me-2" data-feather="message-square"></i>
											<span>${board.commentCnt}</span>
										</div>
									</div>
								</div>
								<c:if test="${not empty board.address_name}">
									<div class="d-flex align-items-center justify-content-end text-gray-500">
										<i class="size-24 me-2" data-feather="map-pin" wid></i>
										<span>${board.address_name}</span>
									</div>
								</c:if>
							</li>
						</c:forEach>
					</ul>
					
					<ul class="pagination justify-content-center">
						<li class="page-item"><a class="page-link" href="javascript:goPage(${boardPagingVO.startBlock})">Previous</a></li>
							<c:forEach var="cnt" begin="${boardPagingVO.startBlock}" end="${boardPagingVO.endBlock}">
								<li class="page-item ${boardPagingVO.curPage==cnt ? 'active' : ''}">
								<a class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
							</c:forEach>
						<li class="page-item"><a class="page-link" href="javascript:goPage(${boardPagingVO.endBlock})">Next</a></li>
					</ul>
					
				</div>
			</div>
		</main>
		
		<div class="col-sm-2">
		<sec:authorize access=""/>
		</div>
	
	</div>
</div>

<%@include  file="../comViews/footer.jsp"%>

	
<script src="${path}/a00_com/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		
		// 로그인 처리 후 로그인 장석 페이지로
		var isLoggedIn;
		<sec:authorize access="isAuthenticated()">
			isLoggedIn = '<sec:authentication property="principal"/>';
		</sec:authorize>
		$("#writeBoardBtn").click(function () {
			if(isLoggedIn == null) {
				if(confirm("로그인이 필요한 서비스입니다. 로그인 페이지로 이동하시겠습니까?")) {
					location.href="/login"
				}
			} else {
				location.href="board_write?board_type_id=${boardType}"
			}
		
		})
		
		
		
		var curPage = "${boardPagingVO.curPage}"
		
		if( curPage == 1 ) {
			$("#pageMinus").attr("disabled", true)
		} else {
			$("#pageMinus").attr("disabled", false)
		}
		
		if( curPage == "${boardPagingVO.endBlock}" ) {
			$("#pagePlus").attr("disabled", true)
		} else {
			$("#pagePlus").attr("disabled", false)
		}
		
		// 선택된 페이지 크기 설정..
		$("[name=pageSize]").val("${boardPagingVO.pageSize}");
		// 페이지 크기 변경시 마다, controller 단 호출
		$("[name=pageSize]").change(function () {
			$("[name=curPage]").val("1");
			$("#frm01").submit();
		})
		
		$("[name=sort]").change(function () {
			$(this).attr("checked", true)
			$("#frm01").submit();
		})
		
	})
</script>
<script type="text/javascript">
function sort(a) {
	switch(a) {
		case 1 : 
			$("[name=sort]").val("lastest");
			$("#frm01").submit();
			break;
		case 2 : 
			$("[name=sort]").val("views")
			$("#frm01").submit();
			break;
		case 3 : 
			$("[name=sort]").val("recommend")
			$("#frm01").submit();
			break;
		case 4 : 
			$("[name=sort]").val("comments")
			$("#frm01").submit();
			break;	
		default:
			alert("정렬 이벤트 오류")
			
	}
}

function goPage(cnt) {
	// 요청값으로 현재 클릭한 페이지를 설정하고, 서버에 전달
	$("[name=curPage]").val(cnt);
	$("#frm01").submit();
}
</script>
</body>
</html>