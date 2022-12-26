<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
	.todoContent span{
		padding : 8px 0px;
	}
</style>
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
					<div class="d-flex justify-content-between align-item-center">
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
			<div class="row">
				<div class="col">
					<a href="/studyGroup">
						<header class="card bg-gradient-primary-to-secondary my-3">
								<div class="py-3">
									<div class="d-flex justify-content-center align-item-center">
									    <h1 class="text-white">
									        STUDY GROUP
									    </h1>
									</div>
								</div>
						</header>
					</a>
					
					<div style="min-height: 300px">
						<ul class="list-group">
							<c:forEach items="${bestStudyList}" var="bestList">
								<li class="list-group-item">
									<div>
										<div class="d-flex justify-content-between align-items-center mb-3">
											<div class="d-flex align-items-center">
												<div class="me-3"> 
													<a href="/users/articles?user_id=${bestList.user_id}" class="text-dark">
														<div class="d-flex justify-content-center align-items-center">
															<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
																<img alt="프로필" src="${bestList.user_image}" style="width: 100%; height: 100%">
															</div>
															<div>
																${bestList.user_nickName}
															</div>
														</div>
													</a>
												</div>
												
												<div>
													<fmt:formatDate value="${bestList.created_at}" pattern="YYYY-MM-dd"/>
												</div>
											</div>
											
											<div class="row align-items-center">
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="thumbs-up" wid></i>
													<span>${bestList.likes}</span>
												</div>
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="message-square"></i>
													<span>${bestList.commentCnt}</span>
												</div>
											</div>
										</div>
										<div>
											<a href="/notice_detail?board_no=${bestList.board_no}" class="text-dark fs-4 fw-bolder">
												${bestList.board_title}
											</a>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col">
					<header class="bg-gradient-primary-to-secondary card my-3">
						<div>
							<div class="py-3">
								<div class="d-flex justify-content-center align-item-center">
								    <h1 class="text-white">
								        WEEKLY BEST
								    </h1>
								</div>
							</div>
					    </div>
					</header>
					<div>
						<ul class="list-group">
							<c:forEach items="${bestWeeklyList}" var="bestList">
								<li class="list-group-item">
									<div>
										<div class="d-flex justify-content-between align-items-center mb-3">
											<div class="d-flex align-items-center">
												<div class="me-3"> 
													<a href="/users/articles?user_id=${bestList.user_id}" class="text-dark">
														<div class="d-flex justify-content-center align-items-center">
															<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
																<img alt="프로필" src="${bestList.user_image}" style="width: 100%; height: 100%">
															</div>
															<div>
																${bestList.user_nickName}
															</div>
														</div>
													</a>
												</div>
												
												<div>
													<fmt:formatDate value="${bestList.created_at}" pattern="YYYY-MM-dd"/>
												</div>
											</div>
											<div class="row align-items-center">
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="thumbs-up" wid></i>
													<span>${bestList.likes}</span>
												</div>
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="message-square"></i>
													<span>${bestList.commentCnt}</span>
												</div>
											</div>
										</div>
										<div>
											<a href="/notice_detail?board_no=${bestList.board_no}" class="text-dark fs-4 fw-bolder">
												${bestList.board_title}
											</a>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				
				<div class="w-100"></div>
				
				<div class="col">
					<a href="/questions">
						<header class="bg-gradient-primary-to-secondary card my-3">
							<div>
								<div class="py-3">
									<div class="d-flex justify-content-center align-item-center">
									    <h1 class="text-white">
									        Q&A
									    </h1>
									</div>
								</div>
						    </div>
						</header>
					</a>
					<div>
						<ul class="list-group">
							<c:forEach items="${bestQnAList}" var="bestList">
								<li class="list-group-item">
									<div>
										<div class="d-flex justify-content-between align-items-center mb-3">
											<div class="d-flex align-items-center">
												<div class="me-3"> 
													<a href="/users/articles?user_id=${bestList.user_id}" class="text-dark">
														<div class="d-flex justify-content-center align-items-center">
															<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
																<img alt="프로필" src="${bestList.user_image}" style="width: 100%; height: 100%">
															</div>
															<div>
																${bestList.user_nickName}
															</div>
														</div>
													</a>
												</div>
												
												<div>
													<fmt:formatDate value="${bestList.created_at}" pattern="YYYY-MM-dd"/>
												</div>
											</div>
											<div class="row align-items-center">
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="thumbs-up" wid></i>
													<span>${bestList.likes}</span>
												</div>
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="message-square"></i>
													<span>${bestList.commentCnt}</span>
												</div>
											</div>
										</div>
										<div>
											<a href="/notice_detail?board_no=${bestList.board_no}" class="text-dark fs-4 fw-bolder">
												${bestList.board_title}
											</a>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col">
					<a href="/knowledge">
						<header class="bg-gradient-primary-to-secondary card my-3">
								<div>
									<div class="py-3">
										<div class="d-flex justify-content-center align-item-center">
										    <h1 class="text-white">
										        KNOWLEDGE
										    </h1>
										</div>
									</div>
							    </div>
						</header>
					</a>
					<div>
						<ul class="list-group">
							<c:forEach items="${bestKnowledgeList}" var="bestList">
								<li class="list-group-item">
									<div>
										<div class="d-flex justify-content-between align-items-center mb-3">
											<div class="d-flex align-items-center">
												<div class="me-3"> 
													<a href="/users/articles?user_id=${bestList.user_id}" class="text-dark">
														<div class="d-flex justify-content-center align-items-center">
															<div class="rounded-circle border me-3" style="overflow: hidden; width: 40px; height: 40px;">
																<img alt="프로필" src="${bestList.user_image}" style="width: 100%; height: 100%">
															</div>
															<div>
																${bestList.user_nickName}
															</div>
														</div>
													</a>
												</div>
												
												<div>
													<fmt:formatDate value="${bestList.created_at}" pattern="YYYY-MM-dd"/>
												</div>
											</div>
											
											<div class="row align-items-center">
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="thumbs-up" wid></i>
													<span>${bestList.likes}</span>
												</div>
												<div class="col d-flex align-items-center">
													<i class="size-24 me-2" data-feather="message-square"></i>
													<span>${bestList.commentCnt}</span>
												</div>
											</div>
										</div>
										<div>
											<a href="/notice_detail?board_no=${bestList.board_no}" class="text-dark fs-4 fw-bolder">
												${bestList.board_title}
											</a>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</main>
		
		<%-- todo List --%>
		<div class="col-sm-2 my-3">
			<sec:authorize access="isAuthenticated()">
				<div class="card p-0">
					<div class="card-header">
						Todo List
					</div>
					<div class="card-body px-1">
						<div id="todoList">
						</div>
					</div>
					<div id='regTodo' class='card-footer bg-white p-0'>
						<input name="todo_contents" class='form-control' type='text' placeholder='NEW TODO' >
					</div>
				</div>
			</sec:authorize>
		</div>
		
	</div>
</div>

<%@include  file="../comViews/footer.jsp"%>
	
<script src="/a00_com/jquery.min.js"></script>
<script src="/a00_com/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		
		var list = '${bestNoticeList}'
		
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
		
		getTodoList()

		function getTodoList() {
			<sec:authorize access="isAuthenticated()">
			$.ajax({                                                                           
				type: "POST",                                                                  
				url: "/getTodoList",
				data: "user_id="+"${user.user_id}",
				dataType: "json",
				success: function (todoList) {                                                 
					var addHTML = "";                                                          
					
					$(todoList).each(function(idx, todo) {
						addHTML += "<div class='d-flex align-items-center justify-content-between p-2'>" 
						addHTML += "<div class='d-flex'>" 
						addHTML += "<input type='hidden' name='todo_id' value='" + todo.todo_id + "'>"
						if (todo.todo_checked) {
							addHTML += "<input type='checkbox' name='todo_checked' checked>"
							addHTML += "<span class='text-decoration-line-through text-muted mx-2 todoContent'>"+ todo.todo_contents +"</span>"
						} else {
							addHTML += "<input type='checkbox' name='todo_checked'>"
							addHTML += "<span class='mx-2 todoContent' contenteditable='false'>"+ todo.todo_contents +"</span>"
						}
						addHTML += "</div>" 
						addHTML += "<button id='todoDeleteBtn' class='btn p-0' style='width:40px'>삭제</button>"
						addHTML += "</div>"
					})
					
					$("#todoList").html(addHTML)
				},
				error: function (err) {
					alert("todo 기능 에러")
				}
					
			})
			</sec:authorize>
		}
		
		// todp input에 입력시 해당 데이터 삽입
		$(document).on('keyup', '[name=todo_contents]', function (e) {
			if (e.keyCode == 13 && $(this).val().trim() ) {
				$.ajax({
					type: "POST",
					url: "/insertTodo",
					data: "user_id="+"${user.user_id}"+"&todo_contents="+$("[name=todo_contents]").val(),
					success: function () {
						$("[name=todo_contents]").val("")
						getTodoList()
						// 다시 todoList 가져오기
					},
					error: function (err) {
						alert("에러")
					}
				})
			}
		})
		
		var origin
		// 더블 클릭시 text 변경 할 수게 된다.
		$(document).on('click', '.todoContent', function () {
			origin = $(this).text()
			
			$(this).attr("contenteditable", true)
			
		})
		
		// 포커스를 잃었을 때 내용이 업데이트 된다.
		$(document).on('blur', '.todoContent', function (e) {
			if($(this).parent().find(".todoContent").text() == "") {
				$(this).parent().find(".todoContent").text(origin)
			}
			$.ajax({
				type: "POST",
				url: "/updateTodo",
				data: "user_id="+"${user.user_id}"+"&todo_contents="+$(this).parent().find(".todoContent").text()+
					"&todo_checked="+$(this).is(":checked")+"&todo_id="+$(this).parent().find("[name=todo_id]").val(),
				context: this,
				success: function () {
					getTodoList()
				},
				error: function (err) {
					alert("에러")
				}
			})
		
		})
		
		// 더블 클릭한 요소에서 변경 후 엔터 하면 업데이트 된다.
		$(document).on('keyup', '.todoContent', function (e) {
			
			if(e.keyCode == 13) {
				if($(this).parent().find(".todoContent").text() == "") {
					$(this).parent().find(".todoContent").text(origin)
				}
				$.ajax({
					type: "POST",
					url: "/updateTodo",
					data: "user_id="+"${user.user_id}"+"&todo_contents="+$(this).parent().find(".todoContent").text()+
						"&todo_checked="+$(this).is(":checked")+"&todo_id="+$(this).parent().find("[name=todo_id]").val(),
					context: this,
					success: function () {
						getTodoList()
					},
					error: function (err) {
						alert("에러")
					}
				})
			}
		
		})
		
		// 체크 박스 클릭시 값이 변경된다.
		$(document).on('click','[name=todo_checked]' ,function () {
			$.ajax({
				type: "POST",
				url: "/updateTodo",
				data: "user_id="+"${user.user_id}"+"&todo_contents="+$(this).parent().find(".todoContent").text()+
					"&todo_checked="+$(this).is(":checked")+"&todo_id="+$(this).parent().find("[name=todo_id]").val(),
				context: this,
				success: function () {
					getTodoList()
				},
				error: function (err) {
					alert("에러")
				}
			})
			
		})
		// 삭제 버튼 클릭시 todo 삭제
		$(document).on('click','#todoDeleteBtn' ,function () {
			
			$.ajax({
				type: "POST",
				url: "/deleteTodo",
				data: "todo_id="+$(this).parent().find("[name=todo_id]").val(),
				success: function () {
					getTodoList()
				},
				error: function (err) {
					alert("에러")
					console.log(err)
				}
			})
			
		})
		
		
	})
</script>

</body>
</html>