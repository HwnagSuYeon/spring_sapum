<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board/board.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<div class="list_all">
		<!-- board -->
		<div class="board_view_all">
			<div class="view_all">

				<div class="board_btn_wrap">
					<c:if test="${sessionScope.userid == view_info.writer}">
						<button id="board_modi_btn" class="board_btn" type="button">MODIFY</button>
						<button id="board_del" class="board_btn" type="button">DELETE</button>
					</c:if>
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
						
						<div class="postno optiin_one">
							<span class="option_title">Post No.</span>
							<span>${view_info.bno}</span>
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
					<div id="commentList"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- board delete modal -->
	<div id="bo_del_modal" class="del_modal" style="display: none;">
		<div class="del_modal_box delete_modal">
			<div class="del_modal_wrap">
				<h1 class="del_modal_title delete_title">Are you sure to<br> delete this post?</h1>
				<span class="warring"><i class="fas fa-exclamation-circle"></i></span>
				<div class="modal_btn_wrap">
					<button id="n_btn" type="button" class="n_btn">NO</button>
					<button id ="board_del_btn" type="button" class="n_btn">YES</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		// board view 스크립트
		$(document).ready(function() {
			// 댓글 목록을 띄우기위한 메서드 호출
			comment_list();
			
			
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
			
			// 게시글 삭제버튼 누르면 컨트롤러로 가세요
			$('#board_del_btn').click(function () {
				location.href = "${path}/board/delete?bno="+"${view_info.bno}";
			}); 
			
			// 게시글 수정버튼 누르면 컨트롤러로 가세요
			$('#board_modi_btn').click(function () {
				location.href = "${path}/board/update?bno="+"${view_info.bno}";
			});
		});
		
		
		// Comment_list.jsp를 띄워주기위한 기능
		function comment_list() {
			$.ajax({
				type: "GET",
				url: "${path}/reply/list?bno=${view_info.bno}",
				success: function (result) {
					// comment_list.jsp를 매개변수로 보내줌
					$('#commentList').html(result);
				}
			});
		}
		
		// 댓글 등록버튼을 눌렀을 때 유효성 검사 및 컨트롤러 이동
		$(document).on('click', '#cmt_add', function (){
			var content = $('.content').val();
			
			if(content == "" ) {
				$('.cmt_err_msg').css('display', 'block');
				$('.content').focus();
				return false;
			} else {
				var bno = '${view_info.bno}';
				// 어느 게시글에 댓글이 달려졌는지 알기위해 코멘트 리스트에 숨겨져있는 선택자
				$('#cmt_bno').val(bno);
				$.ajax({
					url: "${path}/reply/create",
					type: "POST",
					data: $('.comment_frm').serialize(),
					contentType: 'application/x-www-form-urlencoded; charset+UTF-8',
					success: 
						function () {
							comment_list();
							$('.content').val("");
						},
					error: function () {
						alert("system error");
					}
					
				});
			}
		});	
		
		// 댓글 삭제기능
		$(document).on('click', '#cmt_del', function () {
			var rno = $(this).attr("data_num");
			var bno = '${view_info.bno}';
			
			$.ajax({
				url: "${path}/reply/delete",
				type: "GET",
				data: "rno="+rno+"&bno="+bno,
				success: function () {
					comment_list();
				},
				error: function () {
					alert("system erronr");
				}
			});
		});
		
		
	</script>
</body>
</html>