<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/work/work.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 메인에서 작품을 눌렀을 때 모달이 뜨도록 한다(클릭이벤트) -->
	<div class="detail_all">
		<a href="${path}/work/list" class="detail_delete"><i class="fas fa-times all_close_btn"></i></a>
		<div class="board_all">
			<div class="board">
				<div class="work_wrap">
					<img class="work_img" src="${path}/resources/img/${one.w_img}">
				</div>
				<div class="work_text_wrap">
					<div class="menu_btn">
						<a class="down_icon"><i class="fas fa-file-download do_icon"></i></a>
						<a class="down_icon" id="unlike"><i class="far fa-heart do_icon"></i></a>
						<a class="down_icon" id="like"><i class="fas fa-heart do_icon"></i></a>
						<span class="sp_margin"></span>
						<button type="button" class="follow_btn">Follow</button>
					</div>
					<div class="te_user">
						<h3 class="wo_user_name">${one.title}</h3>
						<div></div>
						<span class="follower_cnt">
							<span class="work_username">${one.writer}</span>
							<span>Follower</span>
							<span class="fl_cnt">345</span></span>
						<span class="work_text_con">${one.content}</span>
					</div>
					<div class="button_wrap">
						<button type="button" class="worker_link">See this artist's work</button>
					</div>
					<div class="comment_wrap">
						<h3>Comment</h3>
						<span class="see_comm"><i class="fas fa-chevron-down"></i></span>
					</div>
					
					
					
					<div class="hidden_comment" style="display: block;">
						<div id="commentList"></div>
					</div>
					
					
					
					<div class="de_up_btn">
						<c:if test="${sessionScope.userid == one.writer}">
							<button type="button" id="work_delete_btn" class="follow_btn re_btn">Remove</button>
							<button id="work_upBtn" type="button" class="follow_btn mo_btn">Modify</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- work delete modal -->
	<div id="wo_de_modal" class="work_modal" style="display: none;">
		<div class="work_modal_box delete_modal">
			<div class="work_modal_wrap">
				<span id="wo_de_btn" class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="de_modal_title delete_title">Are you sure to<br> delete this work?</h1>
				<span class="warring"><i class="fas fa-exclamation-circle"></i></span>
				<div class="">
					<button id="n_btn" type="button" class="n_btn">NO</button>
					<button id="work_delBtn" type="button" class="n_btn">YES</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
	// 디테일페이지
	$(document).ready(function() {
		// 댓글 목록을 띄우기 위한 메서드 호출
		// comment_list();
		
		//코멘트 박스에 포커스 가면 라인 색 바뀌게
		$('.comm_inp').focus(function() {
			$(this).css('border', '1px solid #70D6C7')
				   .css('height', '90px');
			$('.cmt_add_btn').css('display','block');
		});
		$('.comm_inp').blur(function() {
			$(this).css('border', '1px solid #EAEAEA')
				   .css('height', '30px');
			$('.cmt_add_btn').css('display','none');
		});

		// 코멘트 박스 보기 아래화살표 누르면 댓글 다는 공간 나옴
		var flag = 0;
		
		$('.see_comm').click(function() {
			if(flag == 0) {
				$('.hidden_comment').css('display','block');
				$('.comment_wrap').css('border-bottom', '0px');
				flag = 1;
			} else {
				$('.hidden_comment').css('display','none');
				$('.comment_wrap').css('border-bottom', '1px solid #EAEAEA');
				flag = 0;
			}
			
		});

		// 좋아요버튼 기능
		$('#unlike').click(function() {
			$(this).css('display','none');
			$('#like').css('display','block');
		});		
		$('#like').click(function() {
			$('#unlike').css('display', 'block');
			$(this).css('display','none');
		});

		//작품 삭제버튼 누르면 정말 삭제할거냐 물어보는 모달창
		$('#work_delete_btn').click(function() {
			$('.work_modal').css('display', 'flex');
		});
		$('#n_btn').click(function() {
			$('.work_modal').css('display', 'none');
		});
		$('#wo_de_btn').click(function() {
			$('.work_modal').css('display', 'none');
		});
		
		// 작품삭제버튼 누를시 컨트롤러로 보냄
		$('#work_delBtn').click(function () {
			location.href = "${path}/work/delete?wno=${one.wno}";
		});
		
		// 작품 수정버튼 누를시 컨트롤러로 보냄
		$('#work_upBtn').click(function () {
			location.href = "${path}/work/register?wno=${one.wno}";
		})
	});
	
	// comment_list.jsp를 띄워주기위한 function
	/* function comment_list() {
		$.ajax({
			type: "GET",
			url: "${path}/work/list?bno=${one.wno}",
			success: function (result) {
				$('#commentList').html(result);
			}
		});
	} */
	</script>
</body>
</html>