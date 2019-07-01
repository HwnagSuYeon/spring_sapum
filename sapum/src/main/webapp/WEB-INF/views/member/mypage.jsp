<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/member/mypage.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- mypage -->
	<div class="my_wrap">
		<!-- 유저 정보 -->
		<div class="user_wrap">
			<div class="user_info">
				<h1 class="user_title">Hwang SuYeon</h1>
				<span class="follw_info">
					<a href="#">Follower <span>200</span></a>·
					<a href="#">Following <span>345</span></a>
				</span>
			</div>
			<div class="icon">
				<div class="i_hover">
					<a class="icon_wrap" href="${path}/member/delete"><i class="fas fa-user-slash"></i></a>
				</div>
				<div class="i_hover">
					<a class="icon_wrap" href="${path}/member/modify"><i class="fas fa-pencil-alt"></i></a>
				</div>
				<div class="i_hover">
					<a class="icon_wrap" href="#"><i class="fas fa-sign-out-alt"></i></a>
				</div>
			</div>
		</div>
		<!-- 최근본 작품 -->
		<div class="new_wrap">
			<div class="new_content">
				<h1 class="new_title">Recently watched</h1>
				<div class="new_container">
					<div class="ne_con_wrap work_hover">
						<div class="img_wrap">
							<a href="#"><img class="object_container" src="${path}/resources/img/main.jpg"></a>
						</div>
						<div class="text_wrap">
							<a href="#"><span class="work_user">lalla</span></a><br>
							<span class="work_text">2019-04-24 16:00:00</span>
						</div>
					</div>

					<div class="ne_con_wrap work_hover">
						<div class="img_wrap">
							<a href="#"><img class="object_container" src="${path}/resources/img/sc1.jpg"></a>
						</div>
						<div class="text_wrap">
							<a href="#"><span class="work_user">ggugguri</span></a><br>
							<span class="work_text">2019-04-24 16:00:00</span>
						</div>
					</div>

					<div class="ne_con_wrap work_hover">
						<div class="img_wrap">
							<a href="#"><img class="object_container" src="../img/sc3.jpg"></a>
						</div>
						<div class="text_wrap">
							<a href="#"><span class="work_user">kim</span></a><br>
							<span class="work_text">2019-04-24 16:00:00</span>
						</div>
					</div>

					<div class="ne_con_wrap work_hover">
						<div class="img_wrap">
							<a href="#"><img class="object_container" src="../img/main.jpg"></a>
						</div>
						<div class="text_wrap">
							<a href="#"><span class="work_user">lalla</span></a><br>
							<span class="work_text">2019-04-24 16:00:00</span>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- 관심 작가 -->
		<div class="new_wrap">
			<h1 class="inter_title">Interested writer</h1>
			<div class="inter_all">
				
				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">ggugguri</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">popotaze</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">pokemon</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>


				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">rita</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">ggugguri</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">popotaze</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">pokemon</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>


				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">rita</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>
				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">ggugguri</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">popotaze</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>

				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">pokemon</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>


				<div class="inter_container">
					<div class="inter_box">
						<a href="#"><span class="inter_name">rita</span></a>
						<a href="#"><i class="fas fa-times inter_del"></i></a>
					</div>
				</div>
			</div>
		</div>

		<!-- 내작품 관리 -->
		<div class="new_wrap work_margin">
			<div class="new_content">
				<h1 class="new_title">My works</h1>
				<div class="new_container">
					<div class="ne_con_wrap work_hover">
						<div class="img_wrap my_position">
							<a href="#"><img class="object_container" src="../img/main.jpg"></a>
						</div>
						<div class="text_wrap ">
							<a href="#"><span class="work_user">title</span></a><br>
							<span class="work_text">upload: 2019-04-24 16:00:00</span>
						</div>
						<div class="hover_del_btn">
							<a href="#">
								<i class="fas fa-times del_icon"></i>
							</a>
						</div>
					</div>
					
					<div class="ne_con_wrap work_hover">
						<div class="img_wrap my_position">
							<a href="#"><img class="object_container" src="../img/sc1.png"></a>
						</div>
						<div class="text_wrap ">
							<a href="#"><span class="work_user">title</span></a><br>
							<span class="work_text">upload: 2019-04-24 16:00:00</span>
						</div>
						<div class="hover_del_btn">
							<a href="#">
								<i class="fas fa-times del_icon"></i>
							</a>
						</div>
					</div>

					<div class="ne_con_wrap work_hover">
						<div class="img_wrap my_position">
							<a href="#"><img class="object_container" src="../img/main.jpg"></a>
						</div>
						<div class="text_wrap ">
							<a href="#"><span class="work_user">title</span></a><br>
							<span class="work_text">upload: 2019-04-24 16:00:00</span>
						</div>
						<div class="hover_del_btn">
							<a href="#">
								<i class="fas fa-times del_icon"></i>
							</a>
						</div>
					</div>

					<div class="ne_con_wrap work_hover">
						<div class="img_wrap my_position">
							<a href="#"><img class="object_container" src="../img/main.jpg"></a>
						</div>
						<div class="text_wrap ">
							<a href="#"><span class="work_user">title</span></a><br>
							<span class="work_text">upload: 2019-04-24 16:00:00</span>
						</div>
						<div class="hover_del_btn">
							<a href="#">
								<i class="fas fa-times del_icon"></i>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<!-- work delete modal -->
	<div id="wo_de_modal" class="del_modal" style="display: none;">
		<div class="modal_box delete_modal">
			<div class="modal_wrap">
				<span id="wo_de_btn" class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="de_modal_title delete_title">Are you sure to<br> delete this work?</h1>
				<span class="warring"><i class="fas fa-exclamation-circle"></i></span>
				<div class="btn_wrap">
					<button id="n_btn" type="button" class="n_btn">NO</button>
					<button type="button" class="n_btn">YES</button>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript">
	// 내작품 관리에서 작품 호버했을 때 작품삭제버튼 나오도록 제어
	$(document).ready(function() {
		$('.work_hover').hover(function(){
			$(this).children().eq(2).css('display','block')
							        .css('transition','.3s');
		});
		$('.work_hover').mouseleave(function(){
			$(this).children().eq(2).css('display','none')
							        .css('transition','.3s');
		});


		//작품 삭제버튼 누르면 정말 삭제할거냐 물어보는 모달창
		$('.hover_del_btn').click(function() {
			$('#wo_de_modal').css('display', 'flex');
		});
		$('#n_btn').click(function() {
			$('#wo_de_modal').css('display', 'none');
		});
		$('#wo_de_btn').click(function() {
			$('#wo_de_modal').css('display', 'none');
		});

	});

	</script>
</body>
</html>