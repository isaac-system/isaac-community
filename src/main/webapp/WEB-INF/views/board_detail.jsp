<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${path}/a01_comlib/summernote-0.8.18-dist/summernote-lite.min.css">
</head>
<body class="nav-fixed px-2 py-4 bg-white">
	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<form id="boardForm">
				<%-- 게시판 헤더 --%>
					<input type="hidden" name="board_no" value="${board.board_no}">
					<div class="mt-4 d-flex justify-content-between">
						<div>
							<div class="d-flex align-items-center mb-1">
								<a href='/users/articles?user_id=${board.user_id}' class='btn btn-icon btn-transparent-dark'>
									<img class='img-fluid' src="${board.user_image}" >
								</a>
								<h5 class="m-0">
									${board.user_nickName}
								</h5>
							</div>
							<div>
								<span>조회수 ${board.views}</span>
								<span> · </span>
								<span>수정일 <fmt:formatDate value="${board.updated_at}" pattern="YYYY-MM-dd"/></span>
								<span id="calDate"></span>
							</div>
						</div>
						
						<c:if test="${board.user_id eq user.user_id}">
							<div class="dropdown">
								<button class="btn btn-light " type="button" data-bs-toggle="dropdown" aria-expanded="false">
									<i data-feather="more-horizontal"></i>
								</button>
								<ul class="dropdown-menu dropdown-menu-end">
									<li><button id="deleteboardBtn" class="dropdown-item text-danger" type="button">삭제하기</button></li>
									<li><div class="dropdown-divider"></div></li>
									<li><button id="updateboardBtn" class="dropdown-item" type="button">수정하기</button></li>
								</ul>
							</div>
						</c:if>
					</div>
				</form>
				<%-- 타이틀 --%>
				<p class="text-dark fs-1 fw-bolder ">
					${board.board_title}
				</p>
				
				<%-- 콘텐츠 --%>
				<div class="mb-4" style="min-height: 400px">
					${board.board_contents}
				</div>
				
				<div class="d-flex justify-content-between align-items-center mb-5">
					<%-- 태그 --%>
					<div class="d-flex align-items-center">
						<c:forEach items="${board.tags}" var="tags">
							<h2 class="me-3">
								<a href="/tagged?tags=${tags}">
									<span class="badge bg-primary-soft text-primary">
										${tags}
									</span>
								</a>
							</h2>
						</c:forEach>
					</div>
					<%-- 좋아요 & 싫어요 --%>
					<div class="d-flex">
						<button id="likeDownBtn" class="btn btn-light border border-dark" 
						style="padding: 4px;margin-right:-10;
							border-bottom-right-radius: 0; border-top-right-radius: 0">
							<i data-feather="chevron-down" style="width:32px; height:32px;"></i>
						</button>
						<input id="likeCount" readonly="readonly" class="text-center" >
						<button id="likeUpBtn" class="btn btn-light border border-dark" 
						style="padding: 4px;margin-left:-10;
							border-bottom-left-radius: 0; border-top-left-radius: 0">
							<i data-feather="chevron-up" style="width:32px; height:32px;"></i>
						</button>
					</div>
				</div>
				
				<%-- 첨부 파일 --%>
				<c:if test="${not empty board.file_name}">
					<div class="mb-5">
						<span class="text-center input-group">첨부파일</span>
						<c:forEach items="${board.file_name}" var="file_name">
							<input type="hidden" name="file_name" class="form-control mb-2" value="${file_name}">
						</c:forEach>
						<c:forEach items="${board.file_original_name}" var="file_original_name">
							<input class="form-control mb-2 original_name bg-white" value="${file_original_name}" readonly="readonly">
						</c:forEach>
						
					</div>
				</c:if>
				
				<%-- 지도 --%>
				<c:if test="${not empty board.address_name}">
					<div class="mb-5">
						<span class="text-center input-group">위치</span>
						<jsp:include page="../util/kakaoMapResult.jsp"/>
					</div>
				</c:if>
				
				<div class="divider mb-5">
				</div>
				
				<%-- 댓글 수 --%>
				<div class="mb-5">
					<h2 id="commentCnt"></h2>	
				</div>
				<%-- 댓글 쓰기 --%>
				<div class="card border-1 rounded-lg mb-5 p-4">
					<div class="mb-4">
						<sec:authorize access="isAuthenticated()">
							<textarea id="summernote" name="comments"></textarea>
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<div class="form-control border border-dark-soft">
								<span>댓글을 쓰려면 <a href="/login">로그인</a>이 필요합니다.</span>
							</div>
						</sec:authorize>
					</div>
					<div class="d-flex justify-content-end">
						<sec:authorize access="isAuthenticated()">
							<button id="regCommentBtn" class="btn btn-primary-soft">댓글 쓰기</button>
						</sec:authorize>
						<sec:authorize access="!isAuthenticated()">
							<button id="regCommentBtn" class="btn btn-primary-soft" disabled="disabled">댓글 쓰기</button>
						</sec:authorize>
					</div>
				</div>
				<%-- 댓글 리스트--%>
				<div>
					<ul id="commentList" class="card list-group my-4 bg-white">
					</ul>
				</div>
			</div>
		</main>
		<%@include  file="../comViews/footer.jsp"%>
	</div>
</div>
	
<script src="${path}/a01_comlib/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${path}/a01_comlib/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		// 좋아요 수
		asyncLikeCount()
		// 댓글 수
		asyncCommentCount()
		// 댓글 리스트
		asyncCommentList()
		// 썸머노트
		$('#summernote').summernote({
			placeholder: '내용을 작성해주세요',
			tabsize: 2,
			height: 80,
			lang : "ko-KR",
			callbacks : {
            	onImageUpload : function(files, editor, welEditable) {
	            	// 파일 업로드(다중업로드를 위해 반복문 사용)
	            	for (var i = files.length - 1; i >= 0; i--) {
			            uploadSummernoteImageFile(files[i], this);
	            	}
	            }
            }
		});
		
		function uploadSummernoteImageFile(file, editor) {
			data = new FormData();
			data.append("file", file);
			console.log(file);
			$.ajax({
				data : data,
				type : "POST",
				url : "/uploadSummernoteImageFile",
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(data) {
					$(editor).summernote('insertImage', data.url);
				}
			});
		}
		
		$("#deleteboardBtn").click(function () {
			if(confirm("정말 게시물을 삭제 하시겠습니까?")) {
				$("#boardForm").attr("action", "/deleteBoard").submit()
			}
		})
		
		$("#updateboardBtn").click(function () {
			$("#boardForm").attr("action", "/board_update").submit()
		})
		
		$("#likeUpBtn").click(function () {
			if("${user.user_id}" == null || "${user.user_id}" == "") {
				if(confirm("로그인이 필요한 기능입니다. 로그인 페이지로 이동 하시겠습니까?")) {
					location.href = "/login"
					return
				}
				return
			}
			$.ajax({
				type: "POST",
				url: "/likeUp",
				data: "user_id="+"${user.user_id}"+"&board_no="+"${board.board_no}",
				success: function() {
					asyncLikeCount()
				},
				error : function (err) {
					console.log(err)
					alert("좋아요 기능 에러")
				}
			})			

			
			
		})
		
		$("#likeDownBtn").click(function () {
			if("${user.user_id}" == null || "${user.user_id}" == "") {
				if(confirm("로그인이 필요한 기능입니다. 로그인 페이지로 이동 하시겠습니까?")) {
					location.href = "/login"
					return
				}
				return
			}
			$.ajax({
				type: "POST",
				url: "/likeDown",
				data: "user_id="+"${user.user_id}"+"&board_no="+"${board.board_no}",
				success: function() {
					asyncLikeCount()
				},
				error : function (err) {
					console.log(err)
					alert("싫어요 기능 에러")
				}
				
			})
		})
		
		$("[name=file_name]").click(function(){
			if(confirm("다운로드하시겠습니까?")){
				location.href="${path}/board_download?file_name="+$(this).val()
			}
		});
		
		$("#regCommentBtn").click( function () {regCommentHandler()})
		
		function regCommentHandler() {
			
			if($("#summernote").summernote('isEmpty')) {
				alert("댓글 내용을 작성해주세요.")
				$("#summernote").summernote({ focus : true })
				return
			}
			
			$.ajax({
				type : "POST",
				url: "/insertComment",
				data: "user_id="+"${user.user_id}"+"&board_no="+"${board.board_no}"+"&comments="+$("[name=comments]").val(),
				success: function () {
					$('#summernote').summernote('reset');
					asyncCommentCount()
				},
				error: function (err) {
					alert("댓글 등록 에러")
					console.log(err)
					console.log($("[name=comments]").val())
				},
				complete: function () {
					asyncCommentList()
				}
			})
		}
		
		function asyncLikeCount() {
			$.ajax({
				type : "POST",
				url: "/likeCount",
				data: "user_id="+"${user.user_id}"+"&board_no="+"${board.board_no}",
				dataType: "json",
				success: function(data) {
					var proc = data.proc;
					if (proc == 0) {
						$("#likeUpBtn").css("color","")
						$("#likeDownBtn").css("color","")
					} else if (proc == 1) {
						$("#likeUpBtn").css("color", "#0061f2")
					} else if (proc == -1) {
						$("#likeDownBtn").css("color", "#0061f2")
					}
					
					$("#likeCount").val(data.count)
				},
				error: function (err) {
					alert("좋아요 수 에러")
					console.log(err)
				}
			})
		}
		
		function asyncCommentCount() {
			$.ajax({
				type: "POST",
				url: "/countComment",
				data: "board_no="+"${board.board_no}",
				dataType: "json",
				success: function (data) {
					$("#commentCnt").text(data+"개의 댓글")
				},
				error: function (err) {
					
				}
			})
		}
		
		function calDate(updateDate) {
			
			var today = new Date()
			var timeValue = new Date(updateDate)
			
			var betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
			
	        if (betweenTime < 1) return '방금전';
	        if (betweenTime < 60) {
	            return betweenTime + " 분전";
	        }

	        var betweenTimeHour = Math.floor(betweenTime / 60);
	        if (betweenTimeHour < 24) {
	            return betweenTimeHour + " 시간전";
	        }

	        var betweenTimeDay = Math.floor(betweenTime / 60 / 24);
	        if (betweenTimeDay < 365) {
	            return betweenTimeDay + " 일전";
	        }
		}
		
		var commentIdArry = []
		var parentArry = []
		var countArry = []
		var existCom
		var existComCount
		var originText
		
		function asyncCommentList() {
			$.ajax({
				type: "GET",
				url: "/commentList",
				data: "board_no="+"${board.board_no}",
				dataType: "json",
				success: function (commentList) {
					var addHTML = ""
					
					/*
					$(commentList).each(function(idx, comment) {
						commentIdArry.push(comment.comment_id)
						parentArry.push(comment.parent)
						countArry.push(comment.commentCount)
					})
					existCom = commentIdArry.filter(x => parentArry.includes(x))
					existComCount = countArry.filter(x => x!=0)
					console.log(existCom)
					console.log(existComCount)
					*/
					
					$(commentList).each(function(idx, comment) {
						var update_at = comment.updated_at
						
						addHTML += "<li class='list-group-item row-"+idx+"'>"
						addHTML += "<input type='hidden' name='parent' value='" + comment.comment_id + "'>"
						addHTML += "<div id='comment' class='mb-2'>"
						addHTML += "<div class='d-flex align-items-center'>" 
						addHTML += "<div class='me-3'>"
						addHTML += "<a href='/users/articles?user_id=" + comment.user_id + "' class='btn btn-icon btn-transparent-dark'>"
						addHTML += "<img class='img-fluid' src=" + comment.user_image + " withd='80' >"
						addHTML += "</a>"
						addHTML += "</div>"
						addHTML += "<div class='me-3'>"
						addHTML += "<a href='/users/articles?user_id=" + comment.user_id + "' class='text-dark'>" 
						addHTML += comment.user_nickName
						addHTML += "</a>"
						addHTML += "</div>"
						addHTML += "<div>" + calDate(update_at) +  "</div>"
						addHTML +="<c:if test='${board.user_id eq user.user_id}'>"
						
						addHTML +="<div class='dropdown'>"
						addHTML +=	"<button class='btn btn-light' type='button' data-bs-toggle='dropdown' aria-expanded='false'>"
						addHTML +=		"더 보기"
						addHTML +=	"</button>"
						addHTML +=	"<ul class='dropdown-menu dropdown-menu-end'>"
						addHTML +=		"<li><button id='deleteComment' class='dropdown-item text-danger' type='button'>삭제하기</button></li>"
						addHTML +=		"<li><div class='dropdown-divider'></div></li>"
						addHTML +=		"<li><button id='updateComment' class='dropdown-item' type='button'>수정하기</button></li>"
						addHTML +=	"</ul>"
						addHTML +="</div>"
						addHTML +="</c:if>"
						
						addHTML += "</div>"
						addHTML += "<div class='my-3'>" + comment.comments + "</div>"
							addHTML += "<button class='btn text-primary p-0 me-3' id='showRecommentBtn'>"
							addHTML += comment.commentCount + "개 댓글 보이기"
							addHTML += "</button>"
						addHTML += "<button id='showRegBtn' class='btn p-0'>" + "댓글 쓰기" + "</button>"
						addHTML += "<div id='writeReComment'><div>"
						addHTML += "</div>" 
						addHTML += "</li>"
						
					})
					
					$("#commentList").html(addHTML)
					
				},
				error: function (err) {
					console.log(err)
				}
				
			})
		}
		
		$(document).on('click','#comment #deleteComment' ,function () {
			$.ajax({
				type: "POST",
				url:"/deleteComment",
			})
			
		})
		
		$(document).on('click','#comment #hideRecommentBtn' ,function () {
			$(this).parent().find("#writeReComment .list-group-item").detach()
			$(this).attr("id", "showRecommentBtn").text(originText)
		})
		$(document).on('click','#comment #showRecommentBtn' ,function () {
			var inputValue =  $(this).parent().siblings("input").val()
			
			$.ajax({
				type: "POST",
				url: "/reCommentList",
				data: "board_no="+"${board.board_no}"+"&parent="+inputValue,
				dataType: "json",
				context: this,
				success: function (reCommentList) {
						var addHTML = ""
						$(reCommentList).each(function(idx, comment) {
							var update_at = comment.updated_at
							addHTML += "<li class='list-group-item ms-3'>"
							addHTML += "<input type='hidden' name='parent' value='" + comment.comment_id + "'>"
							addHTML += "<div id='comment' class='mb-2'>"
							addHTML += "<div class='d-flex align-items-center'>" 
							addHTML += "<div class='me-3'>"
							addHTML += "<a href='/users/articles?user_id=" + comment.user_id + "' class='btn btn-icon btn-transparent-dark'>"
							addHTML += "<img class='img-fluid' src=" + comment.user_image + " withd='80' >"
							addHTML += "</a>"
							addHTML += "</div>"
							addHTML += "<div class='me-3'>"
							addHTML += "<a class='text-dark' href='/users/articles?user_id=" + comment.user_id + "'>" 
							addHTML += comment.user_nickName
							addHTML += "</a>"
							addHTML += "</div>"
							addHTML += "<div>" + calDate(update_at) +  "</div>" 
							addHTML += "</div>" 
							addHTML += "<div class='my-3'>" + comment.comments + "</div>"
							addHTML += "</li>"
							
						})
						originText = $(this).text()
						
						$(this).parent().find("#writeReComment").append(addHTML)
						$(this).attr("id", "hideRecommentBtn").text("댓글 숨기기")
						
				},
				error: function (err) {
					alert("대댓글 보기 에러")
					console.log(err)
				}
			})
		})
		// 댓글 숨기기 버튼 클릭 시 댓글 div 닫음
		$(document).on('click','#comment #hideRegBtn' ,function () {
			$(this).parent().find("#writeReComment .regCommentDiv").detach()
			$(this).parent().find("#writeReComment #isAuth").detach()
			$(this).attr("id", "showRegBtn").text("댓글 쓰기")
		})
		// 작성 버튼 클릭 시 댓글 insert & refresh List
		$(document).on('click','#comment #showRegBtn' ,function () {
			
			var inputValue =  $(this).parent().siblings("input").val()
				
			var addHTML = ""
			<sec:authorize access="isAuthenticated()">
				addHTML += "<div class='regCommentDiv ms-3 mt-3'>" 
				addHTML += "<textarea class='commentSummernote' name='reComments'></textarea>" 
				addHTML += "<div class='d-flex justify-content-end mt-3'>"
				addHTML += "<button id='regReCommentBtn' class='btn btn-primary-soft'>댓글 작성</button>" 
				addHTML += "</div>" 
				addHTML += "</div>" 
			</sec:authorize>
					 	
			<sec:authorize access="!isAuthenticated()">
				addHTML +=	"<div id='isAuth' class='form-control border border-dark-soft'>" +
							"<span>댓글을 쓰려면 <a href='/login'>로그인</a>이 필요합니다.</span>" +
							"</div>"
			</sec:authorize>
			
			$(this).parent().find("#writeReComment").prepend(addHTML)
			
			$(this).attr("id", "hideRegBtn").text("댓글 취소")
			
			$('.commentSummernote').summernote({
				placeholder: '내용을 작성해주세요',
				tabsize: 2,
				height: 80,
				maxHeight: 200,
				lang : "ko-KR",
				callbacks : { 
	            	onImageUpload : function(files, editor, welEditable) {
		            	// 파일 업로드(다중업로드를 위해 반복문 사용)
		            	for (var i = files.length - 1; i >= 0; i--) {
				            uploadSummernoteImageFile(files[i], this);
		            	}
		            }
	            }
			});
			
			$(this).parent().find('#regReCommentBtn').click(function () {
				console.log($(this).parent())
				if($(this).parent().parent().find(".commentSummernote").summernote('isEmpty')) {
					alert("댓글 내용을 작성해주세요.")
					$(this).parent().parent().find(".commentSummernote").summernote({ focus : true })
					return
				}
				
				$.ajax({
					type : "POST",
					url: "/insertComment",
					data: "user_id="+"${user.user_id}"+"&board_no="+"${board.board_no}"+"&comments="+$(this).parent().parent().find(".commentSummernote").val()+
					"&parent="+inputValue,
					success: function () {
						$('.commentSummernote').summernote('reset');
						asyncCommentCount()
					},
					error: function (err) {
						alert("댓글 등록 에러")
						console.log(err)
						console.log($("[name=comments]").val())
					},
					complete: function () {
						asyncCommentList()
					}
				})
			})
				
		})
		
		$(".original_name").click(function() {
			var i = $(".original_name").index(this)
			$("[name=file_name]").eq(i).click()
		})
		
		

	})
	
	
</script>
</body>
</html>