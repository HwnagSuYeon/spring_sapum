<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board/board.css?v=1">
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="list_all">
		<!-- board -->
		<div class="board_view_all">
			<h3 class="post_title">Write a post</h3>
			<div class="view_all">
				<form id="create_frm" class="board_modify_frm" action="${path}/board/create" method="POST">
					<div class="view_board">
						<div class="view_title mody_ti">
							<input type="text" name="title" class="modi_title" placeholder="Enter title">
						</div>
						
						<div class="comment_area board_content_area ">
							<textarea name="content" id="summernote"></textarea>
							<input type="hidden" name="writer" class="writer" value="${sessionScope.userid}">
						</div>
						
						<jsp:useBean id="now" class="java.util.Date"/>
						<fmt:formatDate value="${now}" pattern="hh:mm:ss" var="today"/>
						
						<div class="list_btn">
							<span class="post_time">Post time: 
								<span class="post_val">${today}</span>
							</span>
							<button id="update_btn" class="board_btn">ADD</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		$(document).ready(function () {
			$('#update_btn').click(function () {
				// 게시글 등록버튼 눌렀을 때 폼태그 유효성 검사 및 폼태그 전송
				var title = $('.modi_title').val();
				var contents =  $('textarea[name="contents"]').html($('#summernote').code());
				var writer = $('.writer').val();
				
				if (title == "" || title.length == 0) {
					alert("제목을 입력하세요");
					return false;
				}
				$('#create_frm').submit();
			}); 
			
			// SummerNote editeor실행
			$('#summernote').summernote({
				  toolbar: [
				    // [groupName, [list of button]]
				    ['style', ['bold', 'italic', 'underline', 'clear']],
				    ['font', ['strikethrough', 'superscript', 'subscript']],
				    ['fontsize', ['fontsize']],
				    ['color', ['color']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']]
				  ]
			});
			// summernote editor에서 iframe막는 코드
			$('#summernote').summernote({
				  codeviewFilter: false,
				  codeviewIframeFilter: true,
				  codeviewFilterRegex: 'custom-regex',
				  codeviewIframeWhitelistSrc: ['my-own-domainname']
			});
		});
	</script>
</body>
</html>