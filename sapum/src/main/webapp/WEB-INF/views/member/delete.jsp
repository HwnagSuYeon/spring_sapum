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
	<!-- 회원탈퇴내용 -->
	<div class="join_wrap">
		<div class="join">
			<div class="jo_title">
				<h1>Delete account</h1>
			</div>
			<div class="delete_terms">
				<div class="box">
					<span>
						<h3>WARNING: <br>DELETION IS PERMANENT</h3>
						<span class="delete_text">if you wish to delete in order to combine this account with another one, do NOT delete tour account. You need to instead follow the procedure here.</span>
					</span>
				</div>
			</div>
			<form id="del_frm" class="join_frm" action="${path}/member/delete" method="POST">
				<span class="pl_msg">Enter your login password<br> to confirm your identity</span>
				<div class="del_ip_style">
					<input id="del_pw" class="ip_border" type="password" name="pw" placeholder="Password">
					<span class="err_msg"></span>
				</div>
				<button type="button" class="del_btn">DELETE ACCOUNT</button>
			</form>
		</div>
	</div>

	<!-- delete modal -->
	<div class="de_modal" style="display: none;">
		<div class="de_modal_box">
			<form class="de_modal_wrap">
				<span class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="de_modal_title">Delete Account</h1>
				<span class="de_icon"><i class="far fa-sad-tear"></i></span>
				<div class="de_btn_wrap">
					<div type="button" class="de_btn de_no">NO</div>
					<div id="mem_del_btn" type="button" class="de_btn de_yes">YES</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		// delete버튼을 누르면 모달창 뜨게 만든다
		$(document).ready(function() {
			// 모달창 띄우기
			$('.del_btn').click(function(){
				$('.de_modal').css('display', 'flex');
			});
			// 모달창 닫기
			$('.lo_modal_close').click(function(){
				$('.de_modal').css('display', 'none');
			});
			$('.de_no').click(function(){
				$('.de_modal').css('display', 'none');
			});
			
			
			// 비밀번호 인풋태그 클릭시 색 변경
			$('#del_pw').click(function () {
				$('.del_ip_style').css('border-bottom','1px solid #70D6C7');
			});
			$('#del_pw').blur(function () {
				$('.del_ip_style').css('border-bottom','1px solid rgb(218, 218, 218)');
			});
			
			// 모달의 삭제버튼 누르면 폼태그 전송
			$('#mem_del_btn').click(function () {
				$('#del_frm').submit();
			});
		});
	</script>
</body>
</html>