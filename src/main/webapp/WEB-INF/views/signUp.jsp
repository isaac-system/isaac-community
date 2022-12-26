<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>회원 등록</title>
<link rel="stylesheet"
	href="${path}/a01_comlib/sb-admin-pro_no-source/dist/css/styles.css">
<style>
</style>
<script src="${path}/a00_com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>
<script
	src="${path}/a01_comlib/sb-admin-pro_no-source/dist/js/scripts.js"></script>

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
								<div class="card-header justify-content-center">
									<h3 class="fw-light my-4">회원 등록</h3>
								</div>
								<div class="card-body">
									<!-- Registration form-->
									<form id="formSignUp" method="post">
										<!-- id  -->
										<div class="row gx-3">
											<label class="small mb-1" for="user_id">아이디</label>
											<div class="col-md-6 align-items-center mb-3">
												<input class="form-control" id="user_id" name="user_id"
													type="text" placeholder="아이디를 입력해 주세요." />
											</div>
											<div class="col-md-6 mb-3">
												<button id="idCheckBtn" class="btn btn-primary btn-block"
													type="button">중복 확인</button>
											</div>
										</div>
										<!-- pass    -->
										<div class="row gx-3">
											<div class="col-md-6">
												<!-- Form Group (password)-->
												<div class="mb-3">
													<label class="small mb-1" for="user_password">비밀번호</label>
													<input class="form-control" id="user_password"
														name="user_password" type="password"
														placeholder="비밀번호를 입력해주세요" />
												</div>
											</div>
											<div class="col-md-6">
												<!-- Form Group (confirm password)-->
												<div class="mb-3">
													<label class="small mb-1" for="confirm_password">비밀번호
														확인</label> <input class="form-control" id="confirm_password"
														type="password" placeholder="비밀번호를 다시 입력해주세요" />
													<div id="checkPassText"></div>
												</div>

											</div>
										</div>
										<!-- email address -->
										<div>
											<div class="mb-3">
												<label class="small mb-1">이메일</label> <input
													class="form-control" name="user_email" type="text"
													placeholder="이메일을 입력해주세요" maxlength="20" />
											</div>
										</div>
										<!-- name -->
										<div>
											<div class="mb-3">
												<label class="small mb-1">이름</label> <input
													class="form-control" name="user_name" type="email"
													placeholder="이름을 입력해주세요" maxlength="15" />
											</div>
										</div>
										<!-- nickName -->
										<div>
											<div class="mb-3">
												<label class="small mb-1">닉네임</label> <input
													class="form-control" name="user_nickName" type="text"
													placeholder="닉네임 입력해주세요" maxlength="15" />
											</div>
										</div>
										<!-- tel -->
										<div>
											<div class="mb-3">
												<label class="small mb-1">전화번호</label> 
												<input
													name="user_tel"
													type="tel"
													class="form-control m-input"
													required
													pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}"
													maxlength="13"
													placeholder="예) 010-1234-5678"
													/>
											</div>
										</div>
										<!-- dev_type -->
										<div>
											<div class="mb-3">
												<label>개발 유형</label>
												<c:forEach var="devType" items="${devList}" varStatus="sts">
													<label for="devRadio${sts.count}">${devType.dev_Name}</label>
													<input id="devRadio${sts.count}" type="radio" name="dev_id"
														value="${devType.dev_Id}" />
												</c:forEach>
											</div>
										</div>
										<!-- Form Group (create account submit)-->
										<button id="signUpBtn" type="button"
											class="btn btn-primary btn-block float-right"
											disabled="disabled">회원 등록</button>
									</form>
								</div>
								<div class="card-footer text-center">
									<div class="small">
										<a href="login">로그인</a>
									</div>
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
						<div class="col-md-6 small">Copyright &copy; ISAAC 2022</div>
						<div class="col-md-6 text-md-end small">
							<a href="#!">Privacy Policy</a> &middot; <a href="#!">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>

	<script type="text/javascript">
$(document).ready(function () {
	
	
		
	// 전화번호 변환
	$("[name=user_tel]").keyup(function (e) {
		var event = e || window.event;
		var _val = $("[name=user_tel]").val();
		this.value = autoHypenTel(_val);
	})
	
	function autoHypenTel(str) {
	  str = str.replace(/[^0-9]/g, '');
	  var tmp = '';
	
	  if (str.substring(0, 2) == 02) {
	    // 서울 전화번호일 경우 10자리까지만 나타나고 그 이상의 자리수는 자동삭제
	    if (str.length < 3) {
	      return str;
	    } else if (str.length < 6) {
	      tmp += str.substr(0, 2);
	      tmp += '-';
	      tmp += str.substr(2);
	      return tmp;
	    } else if (str.length < 10) {
	      tmp += str.substr(0, 2);
	      tmp += '-';
	      tmp += str.substr(2, 3);
	      tmp += '-';
	      tmp += str.substr(5);
	      return tmp;
	    } else {
	      tmp += str.substr(0, 2);
	      tmp += '-';
	      tmp += str.substr(2, 4);
	      tmp += '-';
	      tmp += str.substr(6, 4);
	      return tmp;
	    }
	  } else {
	    // 핸드폰 및 다른 지역 전화번호 일 경우
	    if (str.length < 4) {
	      return str;
	    } else if (str.length < 7) {
	      tmp += str.substr(0, 3);
	      tmp += '-';
	      tmp += str.substr(3);
	      return tmp;
	    } else if (str.length < 11) {
	      tmp += str.substr(0, 3);
	      tmp += '-';
	      tmp += str.substr(3, 3);
	      tmp += '-';
	      tmp += str.substr(6);
	      return tmp;
	    } else {
	      tmp += str.substr(0, 3);
	      tmp += '-';
	      tmp += str.substr(3, 4);
	      tmp += '-';
	      tmp += str.substr(7);
	      return tmp;
	    }
	  }
	
	  return str;
	}
	
	// 유효성 검사
	$("#signUpBtn").click(function () {
		
		var user_id = $("[name=user_id]").val()
		
		var user_password = $("[name=user_password]").val()
		
		if( user_id.trim() == "" ) {
			alert("아이디를 입력해주세요")
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
		
		if($("[name=user_name]").val().trim() == "") {
			alert("이름을 입력해주세요")
			return
		}
		
		if($("[name=user_tel]").val().trim() == "") {
			alert("전화번호를 입력해주세요")
			return
		}
		
		if($("[name=user_tel]").val().search(/^\d{2,3}-\d{3,4}-\d{4}$/) == -1) {
			alert("전화번호 형식에 맞게 입력하세요");
	        return
	    }
		
		if($("[name=dev_id]:radio:checked").length < 1) {
			alert("개발자 유형을 선택해주세요")
			return
		}
		
		alert("회원 가입에 성공하셨습니다.")
		$("#formSignUp").submit();
		location.redirect("login");
	})
	
	var isId = 0;
	var isPass = 0;
	
	$("[name=user_id]").change(function () {
		isId=0
		BtnAble()
	})
	
	$("#idCheckBtn").click(function () {
		
		var user_id = $("[name=user_id]").val()
		
		if(user_id.search(/\s/) != -1) {
			alert("아이디에 공백이 들어 갈 수 없습니다.")
			$("[name=user_id]").focus()
		} else {
			if( user_id.trim().length != 0 ) {
				if( user_id.trim().length <= 15 && user_id.trim().length >= 6 ) {
					$.ajax({
						async: true,
						type: "POST",
						url: "/idCheck",
						data: "user_id="+user_id,
						dataType: "json",
						success: function(data) {
							if(data > 0) {
								alert("해당 아이디가 존재합니다.")
								isId = 0
								BtnAble()
							} else {
								alert("사용 가능한 아이디 입니다.")
								isId = 1
								BtnAble()
							}
						
						},
						error: function(err) {
							alert("아이디 체크 에러")
						}
					})
				} else {
					alert("아이디는 6 ~ 15 글자 사이로 입력해주세요")
				}
			} else {
				alert("아이디를 입력 해주세요.")
			}
			
		}
	
	})
	
	$("#confirm_password").blur(function () {
		checkPass()
	})
	
	$("#user_password").blur(function () {
		if($("#confirm_password").val()) {
			checkPass()	
		}
	})
	
	function checkPass() {
		
		var user_password = $("#user_password").val()
		
		var confirm_password = $("#confirm_password").val()
		
		if(user_password != confirm_password) {
			if(user_password != '') {
				$("#checkPassText").css("color", "red").text("비밀번호가 일치 하지 않습니다")
				isPass = 0
				BtnAble()
			} 
		} else {
			if (user_password.length < 6 || user_password.length > 15) {
				$("#checkPassText").css("color", "red").text("비밀번호는 6 ~ 15 글자 사이로 입력해주세요")
				isPass = 0
				BtnAble()
			} else {
				$("#checkPassText").css("color", "green").text("비밀번호가 일치 합니다")
				isPass = 1
				BtnAble()
			}
		}
	}
	
	
	function BtnAble() {
		if (isId == 1 && isPass == 1) {
			$("#signUpBtn").attr("disabled", false)
		} else {
			$("#signUpBtn").attr("disabled", true)
		}
	}
})

</script>

</body>
</html>