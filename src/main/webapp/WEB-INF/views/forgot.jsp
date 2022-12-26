<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>회원 등록</title>
<link rel="stylesheet" href="${path}/a01_comlib/sb-admin-pro_no-source/dist/css/styles.css">
<style>
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${path}/a01_comlib/sb-admin-pro_no-source/dist/js/scripts.js"></script>

</head>
<body class="bg-light">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container-xl px-4">
		            <div class="row justify-content-center">
		                <div class="col-lg-7">
		                    <!-- Basic registration form-->
								<div class="card shadow-lg border-0 rounded-lg mt-5">
								    <div class="card-header justify-content-center"><h3 class="fw-light my-4">계정 찾기</h3></div>
								    <div class="card-body">
								        <!-- Registration form-->
										<form id="formSignUp" method="post">
										    <!-- email address -->
										    <div class="text-center" style="padding: 40px 100px">
										    	<div>
										    	회원 가입시 입력한 이메일을 입력하시면
										    	</div>
										    	<div>
										    	해당 이메일로 비밀번호 변경 링크를 보내 드립니다.
										    	</div>
										    </div>
											<div>
											    <div class="mb-3">
											        <label class="small mb-1">이메일</label>
											        <input class="form-control" name="user_email" type="text" placeholder="이메일을 입력해주세요" maxlength="20"/>
											    </div>
											</div>
										    <!-- Form Group (create account submit)-->
										    <div class="d-flex justify-content-end">
											    <button id="findAccountBtn" type="submit" class="btn btn-primary btn-block">계정 찾기</button>
										    </div>
									    </form>
								    </div>
								    <div class="card-footer text-center">
								        <div class="small"><a href="login">로그인</a></div>
								    </div>
								</div>
		                    </div>
		                </div>
		            </div>
		        </main>
		    </div>
		    
		    <div id="layoutAuthentication_footer">
		        <footer class="footer-admin mt-auto footer-dark">
		            <div class="container-xl px-4">
		                <div class="row">
		                    <div class="col-md-6 small">Copyright &copy; Your Website 2021</div>
		                    <div class="col-md-6 text-md-end small">
		                        <a href="#!">Privacy Policy</a>
		                        &middot;
		                        <a href="#!">Terms &amp; Conditions</a>
		                    </div>
		                </div>
		            </div>
		        </footer>
		    </div>
		</div>
        
<script type="text/javascript">
$(document).ready(function () {
	
})

</script>

</body>
</html>