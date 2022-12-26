<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${path}/a01_comlib/sb-admin-pro_no-source/dist/css/styles.css">
<style>
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${path}/a01_comlib/sb-admin-pro_no-source/dist/js/scripts.js"></script>
<script type="text/JavaScript" src="jquery.alerts.js" ></script>

</head>
<body class="bg-light">
	<div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container-xl px-4">
                    <div class="row justify-content-center">
                        <div class="col-lg-5">
                            <!-- Basic login form-->
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header justify-content-center"><h3 class="fw-light my-4">로그인</h3></div>
                                <div class="card-body">
                                    <!-- Login form-->
                                    <form id="loginForm" method="post" action="/login">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
                                        <!-- Form Group (email address)-->
                                        <div class="mb-3">
                                            <label class="small mb-1">아이디</label>
	                                        <input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해주세요." maxlength="20" required="required">
                                        </div>
                                        <!-- Form Group (user_password)-->
                                        <div class="mb-3">
                                            <label class="small mb-1" >비밀번호</label>
                                            <input class="form-control" type="password" id="user_password" name="user_password" placeholder="비밀번호를 입력해주세요." maxlength="20" required="required">
                                        </div>
                                       	<c:if test="${not empty errormsg}">
	                                        <div class="text-danger">
                                        		${errormsg}
	                                        </div>
                                       	</c:if>
                                        <!-- Form Group (remember user_password checkbox)-->
                                        <div class="mb-3">
                                            <div class="form-check">
                                            	<%-- 
                                                <input class="form-check-input" id="rememberuser_passwordCheck" type="checkbox" value="" />
                                                <label class="form-check-label" for="rememberuser_passwordCheck">Remember user_password</label>
                                            	--%>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- Form Group (login box)-->
                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                        <a class="small" href="/forgot">비밀번호를 잊어 버리셨나요?</a>
                                        <button id="loginBtn" type="button" class="btn btn-primary">로그인</button>
                                    </div>
                                </div>
                                <div class="card-footer text-center">
                                    <div class="small"><a href="signUp">회원가입</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#loginBtn").click(function () {
			loginFun()
		})
		
		$("[name=user_password]").keyup(function (e) {
			if(e.keyCode == 13) {
				loginFun()
			}
		})
		
		function loginFun() {
			var user_id = $("[name=user_id]").val()
			
			var user_password = $("[name=user_password]").val()
			
			if( user_id.trim() == "" ) {
				alert("아이디를 입력해주세요.");
				$("[name=user_id]").focus()
				return
			}
			
			if( user_id.length > 15 || user_id.length < 6 ) {
				alert("아이디는 6 ~ 15 글자 사이로 입력해주세요")
				$("[name=user_id]").focus()
				return
			}
			
			if( user_id.search(/\s/) != -1 ) {
				alert("아이디에 공백이 들어 갈 수 없습니다.")
				$("[name=user_id]").focus()
				return
			}
			
			if( user_password.trim() == "" ) {
				alert("비밀번호를 입력해주세요")
				$("[name=user_password]").focus()
				return
			}
			
			if( user_password.length > 15 || user_password.length < 6 ) {
				alert("비밀번호는 6 ~ 15 글자 사이로 입력해주세요")
				$("[name=user_password]").focus()
				return
			}
			
			if( user_password.search(/\s/) != -1 ) {
				alert("비밀번호에 공백이 들어 갈 수 없습니다.")
				$("[name=user_password]").focus()
				return
			}
			
			$("#loginForm").submit()
		}
		
		
	})
	
</script>
</body>
</html>
