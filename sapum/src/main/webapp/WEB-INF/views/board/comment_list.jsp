<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/common.jsp" %>
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
	<div class="all_comment">
		<span>${cmt_list.size()}</span>
		<span>Comment</span>
	</div>
	<!-- foreach로 댓글리스트 띄워주기 -->
	<c:forEach items="${cmt_list}" var="cmt_view">
		<div class="comment_user">
			<span class="box_text">${cmt_view.writer}</span>
			
			<jsp:useBean id="now" class="java.util.Date" />
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
			<fmt:formatDate value="${cmt_view.regdate}" pattern="yyyy-MM-dd" var="regdate" />
			<span class="cmt_wrap">
				<!-- 댓글 작성시간이 오늘이면 시분초로, 오늘 이후면 모두 년월일로 표시 -->
				<c:choose>
					<c:when test="${today == regdate}">
						<fmt:formatDate pattern="hh:mm:ss" value="${cmt_view.regdate}" />
					</c:when>
					<c:otherwise>
						<span class="cmt_time"><fmt:formatDate pattern="yyyy-MM-dd" value="${cmt_view.regdate}"/></span>
					</c:otherwise>
				</c:choose>
			
				<c:if test="${sessopnScope.userid == cmt_view.writer}">
					<a id="rno" data num="${cmt_view.rno}"><i class="fas fa-times com_del"></i></a>
				</c:if>
			</span>
		</div>
		<div class="comment_text">${cmt_view.content}</div>
	</c:forEach>
	
	
	
	<!-- 등록된 댓글이 없을경우 -->
	<c:if test="${cmt_list.size() == 0}">
		<div class="com_box no_comment">
			<i class="com_icon fas fa-exclamation-triangle"></i>
			<div class="box_text">There are no registered comments</div>
		</div>
	</c:if>
	
	<!-- 로그인 유무 판단으로 댓글 쓰는 창 제어 -->
	<c:choose>
		<c:when test="${empty sessionScope.userid}">
			<div class="com_box login_pleas">
				<i class="com_icon far fa-user-circle"></i>
				<div class="box_text"><a class="cmt_login" href="#" style="color: #70D6C7;">Login</a> to comment</div>
			</div>
		</c:when>
		
		<c:otherwise>
			<div class="comment_user">
				<span class="box_text">${sessionScope.userid}</span>
			</div>
			<div class="comment_area comment_text">
				<form class="comment_frm" action="" method="">
					<textarea id="" name="content" class="content"></textarea>
					<input type="hidden" name="writer" class="userid" value="${sessionScope.userid}">
					<input type="hidden" name="bno" id="cmt_bno">
					<span class="cmt_err_msg" style="display: none;">댓글의 내용이 없습니다! 내용을 입력해주세요.</span>
				</form>
			</div>
			<div class="com_add_btn">
				<button id="cmt_add" class="board_btn add_btn">COMMENT ADD</button>
			</div>
		</c:otherwise>
	</c:choose>
	
	
	

	
	
	
	<script type="text/javascript">
		$(document).ready(function () {
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
		
		// 로그인 하면 댓글 쓸 수 있는 창에 로그인 글씨 누르면 모달창 나오도록 제어
		$('.cmt_login').on('click', function () {
			$('.lo_modal').css('display','flex');
		});
		$('.lo_modal_close').on('click', function () {
			$('.lo_modal').css('display','none');
		});
	</script>
</body>
</html>