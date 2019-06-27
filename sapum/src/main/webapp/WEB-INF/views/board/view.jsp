<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board/board.css?v=1">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="list_all">
		<!-- board -->
		<div class="board_view_all">
			<div class="view_all">

				<div class="board_btn_wrap">
					<button class="board_btn" type="button">MODIFY</button>
					<button id="board_del" class="board_btn" type="button">DELETE</button>
				</div>

				<div class="view_board">
					<div class="view_title">
						<h3>${view_info.title}</h3>
					</div>
					<div class="view_option_all">
						<div class="writer optiin_one">
							<span class="option_title">Writer</span>
							<span>${view_info.writer}</span>
						</div>
						
						<!-- 현재시간과 view_info안의 날짜정보를 가져와 비교하기 위함 -->
						<jsp:useBean id="now" class="java.util.Date"/>
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
						<fmt:formatDate value="${view_info.regdate}" pattern="yyyy-MM-dd" var="regdate"/>
						
						<div class="date optiin_one">
							<span class="option_title">Date</span>
							<span>
								<c:choose>
									<c:when test="${today == regdate}">
										<fmt:formatDate pattern="hh:mm:ss" value="${view_info.regdate}"/>
									</c:when>
									<c:otherwise>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${view_info.regdate}"/>
									</c:otherwise>
								</c:choose>
							</span>
						</div>
						<div class="view optiin_one">
							<span class="option_title">View</span>
							<span>${view_info.viewcnt}</span>
						</div>
					</div>
					<div class="view_content">
						<div class="cont_text">
							${view_info.content}
						</div>
					</div>
					
					<div class="list_btn">
						<button id="list_btn" class="board_btn">LIST PAGE</button>
					</div>
				</div>
				
				<div class="comment_board">
					<div class="all_comment">
						<span>3</span>
						<span>Comment</span>
					</div>
					<div class="com_box no_comment">
						<i class="com_icon fas fa-exclamation-triangle"></i>
						<div class="box_text">There are no registered comments</div>
					</div>
					<div class="com_box login_pleas">
						<i class="com_icon far fa-user-circle"></i>
						<div class="box_text">Sign in to comment</div>
					</div>
					
					<div class="comment_user">
						<span class="box_text">user01</span>
						<i class="fas fa-times com_del"></i>
					</div>
					<div class="comment_text">
						Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
					</div>

					<div class="comment_user">
						<span class="box_text">user01</span>
					</div>
					<div class="comment_area comment_text">
						<form class="comment_frm" action="" method="">
							<textarea id="summernote" name="comment_data"></textarea>
							<input type="hidden" name="id" class="userid">
						</form>
					</div>
					<div class="com_add_btn">
						<button class="board_btn add_btn">COMMENT ADD</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- board delete modal -->
	<div id="bo_del_modal" class="lo_modal" style="display: flex;">
		<div class="modal_box delete_modal">
			<div class="modal_wrap">
				<span id="wo_de_btn" class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="de_modal_title delete_title">Are you sure to<br> delete this post?</h1>
				<span class="warring"><i class="fas fa-exclamation-circle"></i></span>
				<div class="modal_btn_wrap">
					<button id="n_btn" type="button" class="n_btn">NO</button>
					<button type="button" class="n_btn">YES</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		// board view 스크립트
		$(document).ready(function() {
			// 리스트페이지로 돌아가는 버튼 누르면 리스트 페이지로
			$('#list_btn').click (function () {
				location.href = "${path}/board/list";
			});
			// 작품삭제 누를시 모달창 나오고 들어가게 만듦
			$('#board_del').click(function() {
				$('#bo_del_modal').css('display', 'flex');
			});
			$('#wo_de_btn').click(function() {
				$('#bo_del_modal').css('display', 'none');
			});
			$('#n_btn').click(function() {
				$('#bo_del_modal').css('display', 'none');
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