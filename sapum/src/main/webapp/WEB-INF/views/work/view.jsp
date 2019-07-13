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
						<c:if test="${!empty sessionScope.userid}">
							<div class="i_wrap">
								<a class="down_icon"><i class="fas fa-file-download do_icon"></i></a>
								<a class="down_icon" id="unlike"><i class="far fa-heart do_icon"></i></a>
								<a class="down_icon" id="like"><i class="fas fa-heart do_icon"></i></a>
							</div>
							<span class="sp_margin"></span>
							<c:if test="${sessionScope.userid != one.writer}">
								<button id="follow_btn" type="button" class="follow_btn">Follow</button>
							</c:if>
						</c:if>
					</div>
					<div class="te_user">
						<h3 class="wo_user_name">${one.title}</h3>
						<div></div>
						<span class="follower_cnt">
							<span class="work_username">${one.writer}</span>
							<span>Follower</span>
							<span id="follower_cnt" class="fl_cnt"></span></span>
						<span class="work_text_con">${one.content}</span>
					</div>
					<div class="button_wrap">
						<button type="button" class="worker_link">See this artist's work</button>
					</div>
					<div class="comment_wrap">
						<h3>Comment</h3>
						<span class="see_comm"><i class="fas fa-chevron-down"></i></span>
					</div>
					
					
					
					<div class="hidden_comment" style="display: none;">
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
		// 좋아요가 기존에 있는지 없는지 알기위한 메서드 호출
		check_like();
		// 댓글 목록을 띄우기 위한 메서드 호출
		comment_list();
		// 팔로우버튼을 눌렀는지 안눌렀는지 알기위한 메서드 호출
		followCk();
		

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
			check_like();
			like_switch();
		});		
		$('#like').click(function() {
			check_like();
			like_switch();
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
		
		// 팔로우/언팔로우 스위치 기능
		$('#follow_btn').click(function () {
			$.ajax({
				type: "GET",
				url: "${path}/member/follow_switch",
				data: "followingId=${one.writer}",
				success: function () {
					followCk();
				}
			});
		});
		
		
		
	});
	
	// comment_list.jsp를 띄워주기위한 function
	function comment_list() {
		$.ajax({
			type: "GET",
			url: "${path}/workReply/list?wno=${one.wno}",
			success: function (result) {
				$('#commentList').html(result);
			}
		});
	} 
	
	// 좋아요를 실질적으로 주는 기능
	function like_switch() {
		var wno = "${one.wno}";
		$.ajax({
			type: "post",
			url: "${path}/like/switch_like?wno="+wno,
			success: function(result) {
				check_like();
			}
		});
	} 
	// 기존에 좋아요를 준적 있는지 없는지 확인하는 기능
	function check_like() {
		var wno = "${one.wno}";
		$.ajax({
			type: "post",
			url: "${path}/like/check_like?wno="+wno,
			success: function(result) {
				if(result == 1) {
					$('#unlike').css('display','none');
					$('#like').css('display','block');
				} else {
					$('#unlike').css('display', 'block');	
					$('#like').css('display','none');
				}
			}
		});
	} 
	
	// 팔로우 버튼을 눌렀는지 안눌렀는지 상태를 알기위한 ajax
	function followCk() {
		$.ajax({
			type: "GET",
			url: "${path}/member/followCk",
			data: "followingId=${one.writer}",
			success: function(result) {
				if(result.followCk == 0){
					$('#follow_btn').css('background-color','#70D6C7')
									.text('Follow');
				} else {
					$('#follow_btn').css('background-color','#dadada')
								    .text('UnFollow');
				}
				$('#follower_cnt').text(result.follewr_count);
			}
		});
	}
	
	// 댓글 등록버튼을 눌렀을 때 유효성 검사 및 컨트롤러 이동
	$(document).on('click', '#cmt_add_btn', function () {
		var content = $('.comm_inp').val();
		
		if(content == "") {
			$('.cmt_err_msg').css('display', 'block');
			$('.comm_inp').focus();
			return false;
		} else {
			var wno = '${one.wno}';
			$('#cmt_wno').val(wno);
			$.ajax({
				url: "${path}/workReply/create",
				type: "POST",
				data: $('.comment_frm').serialize(),
				contentType: 'application/x-www-form-urlencoded; charset+UTF-8',
				success: 
					function () {
						comment_list();
						$('.comm_inp').val("");
					},
				error: function () {
					alert("system error");
				}
				
			});
		}
	});
	
	
	</script>
</body>
</html>