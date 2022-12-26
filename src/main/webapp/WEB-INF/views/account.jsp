<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정</title>
</head>
<body class="nav-fixed px-2 py-4 bg-white">
	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<div class="mb-3">
					<h3 class="fw-bolder">
						이메일 정보
					</h3>
				</div>
				
				<div class="mb-5">
					<div class="d-flex justify-content-between mb-5">
					    <div>
				        	<input class="form-control" name="user_name" value="${user.user_email}" type="text" maxlength="20" style="width:500px;"/>
					    </div>
					    <div class="d-flex">
					    	<button id="emailValidBtn" type="button" class="btn btn-light border align-items-center"><i data-feather="mail" class="me-3"></i>
					    		이메일 인증
					    	</button>
					    </div>
					</div>
				    
				    <div id="validDiv" >
			    	</div>
				</div>
				
				<form id="deleteUserForm" method="post">
					<div class="mb-3">
						<h3 class="fw-bolder">
							계정 삭제
						</h3>
					</div>
					<div class="d-flex justify-content-end">
						<button id="deleteUserBtn" class="btn btn-danger" type="button">
							계정 탈퇴
						</button>
					</div>
				</form>
			</div>
		</main>
		<%@include  file="../comViews/footer.jsp"%>
	</div>
</div>	

</body>

<script type="text/javascript">
	$(document).ready(function () {
		var code;
		$("#deleteUserBtn").on('click', function () {
			if(confirm("정말 계정을 탈퇴하시겠습니까?")) {
				$("#deleteUserForm").append($('<input/>', {type: 'hidden', name: 'user_id', value:'${user.user_id}' })).submit();
			}
		})
		$("#emailValidBtn").attr("disabled", ${userInfo.user_validation}).on('click',function () {
			
			$(this).attr("disabled", true)
			
			$.ajax({
				type : "POST",
				url : "/validEmail",
				data : "user_id="+"${userInfo.user_id}",
				context: this,
				success: function(data) {
					alert("인증번호가 이메일에 전송되었습니다.")
					var addHTML = "";
					
					addHTML += "<div class='d-flex justify-content-end'>"	
					addHTML += "<div class='me-3'>"	
					addHTML += "<input type='text' name='validNumber' class='form-control' placeholder='인증번호 6자리'>"	
					addHTML += "</div>"	
					addHTML += "<div>"	
					addHTML += "<button id='confirmBtn' class='btn btn-primary'>인증 하기</button>"	
					addHTML += "</div>"	
					addHTML += "</div>"	
					
					$("#validDiv").html(addHTML)
					
					code = data
					
				}, 
				error : function (err) {
					console.log(err)
				}
				
			})
			
		})
		
		$(document).on('click', '#confirmBtn', function () {	
			if ( code == $('[name=validNumber]').val() ) {
				$.ajax({
					type : "POST",
					url : "/updateUserVaildation",
					data : "user_id="+"${userInfo.user_id}"+"&code="+code,
					success: function(msg) {
						alert(msg)
						location.reload()
					},
					error: function(err) {
						alert("실패")
					}
				})
				
			} else {
				alert("이메일이 인증 되지 않았습니다.")
			}
		})
		
	})
</script>
</html>