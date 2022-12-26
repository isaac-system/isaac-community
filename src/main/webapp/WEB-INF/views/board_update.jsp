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
<link rel="stylesheet" type="text/css" href="${path}/a01_comlib/bootstrap-tagsinput-latest/dist/bootstrap-tagsinput.css">
</head>
<body class="nav-fixed px-2 py-4 bg-white">
	<%@include file="../comViews/header.jsp" %>
	<div id="layoutSidenav_content">
		<main>
			<div class="container">
			
				<form id="boardForm" method="post" enctype="multipart/form-data" action="/updateBoard">
					<%-- 게시판 헤더 --%>
					<input type="hidden" name="board_no" value="${board.board_no}">
					<input type="hidden" name="user_id" value="${user.user_id}">
					<%-- 타이틀 --%>
					<div class="my-4">
						<label>제목</label>
						<input type="text" class="form-control" name="board_title" value="${board.board_title}"> 
					</div>
					<%-- 첨부파일 --%>
					<div class="my-4">
						<label>첨부파일</label>
						<input name="fileList" multiple="multiple" type="file" class="form-control" id="fileInput" value="${board.fileList}"> 
					</div>
					<%-- 콘텐츠 --%>
					<div class="mb-4">
						<label>내용</label>
						<textarea id="summernote" name="board_contents">${board.board_contents}</textarea> 
					</div>
					<%-- 태그 --%>
					<div class="mb-4">
						<label>태그</label>
						<div class="form-group">
							<input id="tags" type="text" class="form-control" name="tags" value="${board.tags}">
						</div>
					</div>
					<%-- 지도 --%>
					<c:if test="${board.board_type_id == 4}">
						<label>위치</label>	
						<div class="form-group mb-4">
							<input id="road_address_name" name="address_name" value="${board.address_name}" type="text" class="form-control bg-white" readonly="readonly">
						</div>
						<div>
							<jsp:include page="../util/kakaomap.jsp"></jsp:include>
						</div>
					</c:if>
				</form>
				
				<div class="mb-4 d-flex justify-content-end">
					<button type="button" class="btn btn-white border border-dark me-4">취소</button>
					<button id="uptBtn" type="button" class="btn btn-primary">수정 완료</button>
				</div>
			</div>
		</main>
		<%@include  file="../comViews/footer.jsp"%>
	</div>
</div>

<script src="${path}/a01_comlib/summernote-0.8.18-dist/summernote-lite.min.js"></script>
<script src="${path}/a01_comlib/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<script src="${path}/a01_comlib/bootstrap-tagsinput-latest/dist/bootstrap-tagsinput.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	// 로그인 상태 관리
	var user_id = '${user.user_id}';
	if(user_id == "") {
		alert("로그인이 되어있지 않습니다.")
		location.href = "login"
	}
	// 썸머 노트
	$('#summernote').summernote({
		placeholder: '내용을 작성해주세요',
		tabsize: 2,
		height: 500,
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
	
	$("#uptBtn").click(function () {
		if($("[name=board_title]").val().trim() == "") {
			alert("제목을 입력해주세요.")
			$("[name=board_title]").focus()
			return
		}
		
		if($("#summernote").summernote('isEmpty')) {
			alert("내용을 입력해주세요.")
			$("#summernote").summernote({ focus: true} )
			return
		}
		
		$("#boardForm").submit()
		
	})
	
	$("#goBackBtn").click(function () {
		if ("${param.board_type_id}" == 1) {
			location.href = "/notice" 
		}
		if ("${param.board_type_id}" == 2) {
			location.href = "/questions" 
		}
		if ("${param.board_type_id}" == 3) {
			location.href = "/knowledge" 
		}
		if ("${param.board_type_id}" == 4) {
			location.href = "/studyGroup" 
		}
	})
	
	function split( val ) {
      return val.split( /,\s*/ );
    }
    function extractLast( term ) {
      return split( term ).pop();
    }
    
	// 태그 자동 완성
	$.ajax({
		type: "POST",
		url: "/searchTags",
		data: "tags="+$("#tags").val(),
		dataType: "json",
		success: function (data) {
			$("#tags")
			.on( "keydown", function( event ) {
		        if ( event.keyCode === $.ui.keyCode.TAB && $( this ).autocomplete( "instance" ).menu.active ) {
		              event.preventDefault();
	            }
			})
			.autocomplete({ // autocomplete 구현 시작부
				source: function( request, response ) {
			        // delegate back to autocomplete, but extract the last term
			        response( $.ui.autocomplete.filter(
			        	data, extractLast( request.term ) ) );
			    },
				select : function(event, ui) { // item 선택 시 이벤트
					//$("#tags").tagsinput("add", ui.item.value);
					var terms = split( this.value );
				    // remove the current input
				    terms.pop();
				    // add the selected item
				    terms.push( ui.item.value );
				    // add placeholder to get the comma-and-space at the end
				    terms.push( "" );
				    this.value = terms.join( "," );
				    console.log(this.value)
				    console.log(terms)
				    return false;
				},
				focus : function(event, ui) { // 포커스 시 이벤트
				    return false;
				},
				minLength : 1, // 최소 글자 수
				autoFocus : true, // true로 설정 시 메뉴가 표시 될 때, 첫 번째 항목에 자동으로 초점이 맞춰짐
				delay : 500, // 입력창에 글자가 써지고 나서 autocomplete 이벤트 발생될 떄 까지 지연 시간(ms)
				disable : false, // 해당 값 true 시, 자동완성 기능 꺼짐
			})
			
		},
		error: function (err) {
			console.log(err)
		}
	})

	// 파일 용량 제한 js
	$("[name=files]").off().on("change", function(){

		if (this.files && this.files[0]) {

			var maxSize = 50 * 1024 * 1024;
			var fileSize = this.files[0].size;

			if(fileSize > maxSize){
				alert("첨부파일 사이즈는 50MB 이내로 등록 가능합니다.");
				$(this).val('');
				return false;
			}
		}
		
	});
	
})
</script>
</body>
</html>