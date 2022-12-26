<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
</head>
<body class="nav-fixed px-2 py-4 bg-white">
	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content">
		<main>
			<div class="container">
				<input type="file" id="avatar" name="user_image" accept="image/png, image/jpeg" style="display: none;" data-width="300" data-height="300">
				<form id="userForm" method="post" enctype="multipart/form-data">
				<div class="card mb-4">
					<div class="card-header">
						유저 이미지
					</div>
					<div class="card-body d-flex justify-content-center align-item-center">
						<div id="userImageBtn" class="btn-transparent-dark border rounded-circle border-gray-400 border-2" style="position: relative; top: 0;left: 0;width: 200px; height: 200px; overflow: hidden;">
							<img id="userImage" alt="프로필 이미지" src="${user.user_image}" width="100%" height="100%">
						</div>
					</div>
				</div>
				<div>
					<h3 class="fw-bolder">
						회원정보	
					</h3>
				</div>
				<!-- email address -->
				<div>
				    <div class="mb-3">
				        <label class="small mb-1">이름</label>
				        <input class="form-control" name="user_name" value="${user.user_name}" type="text" maxlength="20"/>
				    </div>
				</div>
				<div>
				    <div class="mb-3">
				        <label class="small mb-1">닉네임</label>
				        <input class="form-control" name="user_nickName" value="${user.user_nickName}" type="text" maxlength="20"/>
				    </div>
				</div>
				<div>
					<div class="mb-3">
						<label>개발 유형</label>
						<div class="fw-bolder border border-black-75 rounded p-4">
							<c:forEach var="devType" items="${devList}" varStatus="sts">
								<label for="devRadio${sts.count}">${devType.dev_Name}</label>
								<input id="devRadio${sts.count}" type="radio" name="dev_id" value="${devType.dev_Id}"/>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="d-flex justify-content-end">
					<button type="submit" id="userSaveBtn" class="btn btn-primary-soft">저장</button>
				</div>
				</form>
			</div>
		</main>
		<%@include  file="../comViews/footer.jsp"%>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function () {
		var dev_id = "${user.dev_id}"
		$("input[name=dev_id][value="+dev_id+"]").prop("checked", true);
		
		$("#userImageBtn").click(function () {
			$("input[name=user_image]").click()
		})
		
		$("input[name=user_image]").off().on("change", function(){

			if (this.files && this.files[0]) {

				var maxSize = 50 * 1024 * 1024;
				var fileSize = this.files[0].size;

				if(fileSize > maxSize){
					alert("이미지 사이즈는 50MB 이내로 등록 가능합니다.");
					$(this).val('');
					return false;
				}
				
				data = new FormData();
				data.append("user_image", this.files[0] );
				
				$.ajax({
					data : data,
					type : "POST",
					url : "/uploadUserImageFile",
					contentType : false,
					enctype : "multipart/form-data",
					processData : false,
					success : function(data) {
						$("img").attr("src", data.url)
					},
					error: function (err) {
						alert("유저 이미지 에러")
					}
				});
			}
			
		});		
		
	})
</script>
</body>
</html>