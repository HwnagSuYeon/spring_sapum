<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/member/member.css?v=1">
<title>Join</title>
</head>
<body>
	<!-- 회원가입내용 -->
	<div class="join_wrap">
		<div class="join">
			<div class="jo_title">
				<h1>Join US</h1>
			</div>
			<form class="join_frm" action="" method="" name="">
				<div class="mem_ipstyle">
					<input id="id_val" class="mem_ipborder" type="text" name="id" placeholder="User ID">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="pw_val" class="mem_ipborder" type="password" name="pw" placeholder="Password">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="pwck_val" class="mem_ipborder" type="password" placeholder="Re-enter Password">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="name_val" class="mem_ipborder" type="text" name="name" placeholder="Name">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="email_val" class="mem_ipborder" type="email" name="email" placeholder="E-mail(ID)">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="phone_val" class="mem_ipborder" type="text" name="phone" placeholder="phone">
					<span class="err_msg_eq"></span>
				</div>
				<div class="terms_wrap">
					<span class="ck_off"><i class="far fa-check-circle"></i></span>
					<span class="ck_on"><i class="fas fa-check-circle"></i></span>
					<div class="terms">
						<span>I agree</span>
						<a href="#" class="tr1">Terms of service</a>,
						<a href="#" class="tr1">Privacy Policy</a>,<br>
						<a href="#" class="tr1">Location-Based Services Terms</a>.
					</div>
				</div>
				<button id="join_btn" type="button" class="join_btn" disabled="disabled">CREATE ACCOUNT</button>
			</form>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
	<script type="text/javascript">
		//-----join 스크립트-------
		$(document).ready(function () {
			// 동의버튼 체크, 체크해제
			var flag = 0;
			$('.ck_off').click(function () {
				$(this).css('display','none');
				$('.ck_on').css('display','block');
				flag = 1;
			});
			$('.ck_on').click(function () {
				$(this).css('display','none');
				$('.ck_off').css('display','block');
				flag = 0;
			});
			
			//---- 유효성 검사: (선택자)에 값을 입력 후 blur하면 이벤트 발생  ----
			//id
			$('#id_val').blur(function () {
				var memId = $.trim($('#id_val').val());
				var checkResult = joinValidate.checkId(memId);
				
				if(checkResult.code != 0) {
					console.log(checkResult.desc);
					$(".err_msg_eq").eq(0).text(checkResult.desc)
									   	  .css("display","block");
					return false;
				} else {
					if(ajaxCheck(memId) == "1") {
						return true;
					}
				}
				return false;
			});
			
			//pw
			$('#pw_val').blur(function() {
				var memPw = $.trim($('#pw_val').val());
				var memRpw = $.trim($('#pwck_val').val());
				var checkResult = joinValidate.checkPw(memPw, memRpw);
				// 아이디값을 가져가 validation에서 검사를 실행.
				if(checkResult.code != 0) {
					$(".err_msg_eq").eq(1).text(checkResult.desc)
									   .css("display","block")
									   .css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(1).text(checkResult.desc)
									   .css("display","block")
									   .css('color','dodgerblue');
					if (memRpw != "" || memRpw.length != 0) {
						if(memPw == memRpw) {
							$(".err_msg_eq").eq(2).text("비밀번호가 일치합니다")
											   .css("display","block")
											   .css('color','dodgerblue');
						} else {
							$(".err_msg_eq").eq(2).text("입력하신 비밀번호가 일치하지 않습니다")
					   			 			   .css("display","block")
					   			 			   .css('color','tomato');
							return false;
						}
					}
					return true;
				}
				return false;
			});
			
			
			// pwck
			$("#pwck_val").blur(function() {
				var memPw = $.trim($('#pw_val').val());
				var memRpw = $.trim($('#pwck_val').val());
				var checkResult = joinValidate.checkRpw(memPw, memRpw);
				// 아이디값을 가져가 validation에서 검사를 실행.
				if(checkResult.code != 0) {
					$(".err_msg_eq").eq(2).text(checkResult.desc)
									   .css("display","block")
									   .css('color','tomato');
					return false;
				} else {
					if(memPw == memRpw) {
						$(".err_msg_eq").eq(2).text("비밀번호가 일치합니다")
										   .css("display","block")
										   .css('color','dodgerblue');
					} else {
						$(".err_msg_eq").eq(2).text("입력하신 비밀번호가 일치하지 않습니다")
				   			 			   .css("display","block")
				   			 			   .css('color','tomato');
						return false;
					}
				}
				return false;
			});
			
			//name
			$("#name_val").blur(function () {
				var name = $.trim($(this).val());
				var checkResult = joinValidate.checkName(name);
				
				if(checkResult.code != 0) {
					console.log(checkResult.desc);
					$(".err_msg_eq").eq(3).text(checkResult.desc)
									.css("display","block")
									.css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(3).text(checkResult.desc)
										  .css("display","block")
										  .css('color','dodgerblue');
					return false;
				}
				return false;
			
			});
			
			// email
			$('#email_val').blur(function () {
				var memEmail = $.trim($('#email_val').val());
				var checkResult = joinValidate.checkEmail(memEmail);
				
				if(checkResult.code != 0) {
					console.log(checkResult.desc);
					$(".err_msg_eq").eq(4).text(checkResult.desc)
									.css("display","block")
									.css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(4).text(checkResult.desc)
										  .css("display","block")
										  .css('color','dodgerblue');
					return false;
				}
				return false;
				
				
			});
			
			// phone
			$("#phone_val").blur(function () {
				var phone = $.trim($(this).val());
				var checkResult = joinValidate.checkPhone(phone);
				
				if(checkResult.code != 0) {
					$(".err_msg_eq").eq(5).text(checkResult.desc)
										  .css("display","block")
										  .css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(5).text(checkResult.desc)
										  .css("display","block")
										  .css('color','dodgerblue');
				}
			});
		});
	</script>
</body>
</html>