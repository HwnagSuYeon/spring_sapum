<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/member/member.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 회원찾기내용 -->
	<div class="join_wrap">
		<div class="join">
			<div class="jo_title">
				<h1>Find Account</h1>
			</div>
			<div class="find_all">
				<span class="find_title">Forgot ID?</span>
				<form class="join_frm" action="" method="" name="">
					<div class="ip_style">
						<input class="ip_border" type="text" name="id" placeholder="Name">
						<span class="err_msg"></span>
					</div>
					<div class="ip_style">
						<input class="ip_border" type="text" name="name" placeholder="Phone">
						<span class="err_msg"></span>
					</div>
					<button id="find_id" type="button" class="find_btn">FIND USER ID</button>
				</form>
			</div>

			<div class="find_all find_pw">
				<span class="find_title">Forgot Password?</span>
				<form class="join_frm" action="" method="" name="">
					<div class="ip_style">
						<input class="ip_border" type="text" name="id" placeholder="User ID">
						<span class="err_msg"></span>
					</div>
					<button id="find_pw" type="button" class="find_btn">CHANGE PASSWORD</button>
				</form>
			</div>
			
		</div>
	</div>

	<!-- ID modal -->
	<div id="id_modal" class="lo_modal" style="display: none;">
		<div class="modal_box id_mo_box">
			<span id="id_modal_close" class="lo_modal_close id_modal_close"><i class="fas fa-times"></i></span>
			<div class="id_te">
				<span>Your ID is"<span class="find_user">ggugguri</span>"</span>
			</div>
		</div>
	</div>

	<!-- PW modal -->
	<div id="pw_modal" class="lo_modal" style="display: none;">
		<div class="modal_box">
			<form class="modal_wrap" action="" method="" name="">
				<span id="pw_modal_close" class="lo_modal_close id_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="lo_modal_title">Change Password</h1>
				<div class="ip_style ip_id">
					<input class="ip_border" type="password" name="pw" placeholder="Password">
					<span class="err_msg"></span>
				</div>
				<div class="ip_style ip_pw">
					<input class="ip_border" type="password" name="rpw" placeholder="Re-enter Password">
					<span class="err_msg"></span>
				</div>
				<span class="err_msg"></span>
				<button type="button" class="lo_btn">login</button>
			</form>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
	//계정찾기 스크립트
	$(document).ready(function() {
		// id 찾기버튼 누르면 나오는 모달창
		$('#find_id').click(function() {
			$('#id_modal').css('display', 'flex');
		});
		$('#id_modal_close').click(function() {
			$('#id_modal').css('display', 'none');
		});
		// pw 바꾸기 버튼 누르면 나오는 모달창
		$('#find_pw').click(function() {
			$('#pw_modal').css('display', 'flex');
		});
		$('#pw_modal_close').click(function() {
			$('#pw_modal').css('display', 'none');
		});
	});
	</script>
</body>
</html>