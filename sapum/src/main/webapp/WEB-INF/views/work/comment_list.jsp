<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/work/workAll.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 등록된 댓글이 하나도 없을 경우 -->
	<c:choose>
		<c:when test="${cmt_list.size() == 0}">
			<span class="com_text">There are no registered comments</span>
		</c:when>
		<c:otherwise>
			<!-- foreach로 댓글 리스트 띄워줌 -->
			<c:forEach items="${cmt_list}" var="cmt_view">
				<span class="com_text">
					<span class="cmt_user">
						<span class="user_name">
							<span class="dot"></span>
							<span id="cmt_writer" data_num2="${cmt_view.writer}">${cmt_view.writer}</span>
							
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
							<fmt:formatDate value="${cmt_view.regdate}" pattern="yyyy-MM-dd" var="regdate" />
							<span class="user_time">
								<c:choose>
									<c:when test="${today == regdate}">
										<fmt:formatDate pattern="hh:mm:ss" value="${cmt_view.regdate}" />
									</c:when>
									<c:otherwise>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${cmt_view.regdate}"/>
									</c:otherwise>
								</c:choose>
							</span>
							
						</span>
						<c:if test="${sessionScope.userid == cmt_view.writer}">
							<i id="cmt_del" class="cmt_del_btn fas fa-backspace" data_num="${cmt_view.wrno}"></i>
						</c:if>
					</span>
					<span class="cmt_content">
						${cmt_view.content}
					</span>
				</span>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	
	<!-- 로그인 유무 판단으로 댓글 쓰는 창 제어 -->
	<c:choose>
		<c:when test="${empty sessionScope.userid}">
			<span class="com_text"><a class="cmt_login" href="#" style="color: #70D6C7;">Login</a> to comment</span>
		</c:when>
		<c:otherwise>
			<form class="comment_frm">
				<span class="user_wrap">
					<span class="user_dot"></span>
					<span class="comm_user">${sessionScope.userid}</span>
				</span>
				<div class="conn_inp">
					<textarea class="comm_inp" placeholder="write your comment" name="content"></textarea>
				</div>
				<span class="cmt_err_msg" style="display: none;">댓글의 내용이 없습니다!</span>
				<input type="hidden" name="writer" class="comment_userid">
				<input type="hidden" name="wno" id="cmt_wno">
				<button id="cmt_add_btn" type="button" class="cmt_add_btn"><i class="fas fa-plus"></i></button>
			</form>
		</c:otherwise>
	</c:choose>
	
	
	<script type="text/javascript">
		$(document).ready(function () {
			//코멘트 박스에 포커스 가면 라인 색 바뀌게
			$('.comm_inp').click(function() {
				$(this).css('border', '1px solid #70D6C7')
					   .css('height', '90px');
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