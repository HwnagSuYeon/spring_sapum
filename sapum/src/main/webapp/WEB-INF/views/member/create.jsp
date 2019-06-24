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
			<form class="join_frm" action="${path}/member/create" method="POST">
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
					<input id="ck_box" type="checkbox" style="display: none;">
					<div class="terms">
						<span>I agree</span>
						<a href="#" class="tr1">Terms of service</a>,
						<a href="#" class="tr1">Privacy Policy</a>,<br>
						<a href="#" class="tr1">Location-Based Services Terms</a>.
					</div>
				</div>
				<div id="join_btn" class="join_btn">CREATE ACCOUNT</div>
			</form>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
	<script type="text/javascript">
		//-----join 스크립트-------
		$(document).ready(function () {
			// 동의버튼 체크, 체크해제
			
			$('.ck_off').click(function () {
				$(this).css('display','none');
				$('.ck_on').css('display','block');
				$('#ck_box').click();
			});
			$('.ck_on').click(function () {
				$(this).css('display','none');
				$('.ck_off').css('display','block');
				$('#ck_box').click();
			});
			// 체크박스 체크시 변수에 1값을 넣어줌 
			var result_termsCk = 0;
			$('#ck_box').change(function () {
				if ($(this).is(':checked')) {
					result_termsCk = 1;
				} else {
					result_termsCk = 0;
				}
			});
			
			//---- 유효성 검사: (선택자)에 값을 입력 후 blur하면 이벤트 발생  ----
			//유효성검사가 다 끝났다는 것을 알게 해주는변수가 필요
			var result_id = 0;
			var result_pw = 0;
			var result_name = 0;
			var result_email = 0;
			var result_phone = 0;
			//id
			$('#id_val').blur(function () {
				var memId = $.trim($('#id_val').val());
				var checkResult = joinValidate.checkId(memId);
				result_id = 0;
				if(checkResult.code != 0) {
					console.log(checkResult.code);
					$(".err_msg_eq").eq(0).text(checkResult.desc)
									   	  .css("display","block");
					return false;
				} else { console.log("ajax: "+ajaxCheck(memId));
					if(ajaxCheck(memId) == 1) {
						result_id = 1;
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
				result_pw = 0;
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
							result_pw = 1;
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
				result_pw = 0;
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
						result_pw = 1;
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
				result_name = 0;
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
					result_name = 1;
					return false;
				}
				return false;
			
			});
			
			// email
			$('#email_val').blur(function () {
				var memEmail = $.trim($('#email_val').val());
				var checkResult = joinValidate.checkEmail(memEmail);
				result_email = 0;
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
					result_email = 1;
					return false;
				}
				return false;
				
				
			});
			
			// phone
			$("#phone_val").blur(function () {
				var phone = $.trim($(this).val());
				var checkResult = joinValidate.checkPhone(phone);
				result_phone = 0;
				if(checkResult.code != 0) {
					$(".err_msg_eq").eq(5).text(checkResult.desc)
										  .css("display","block")
										  .css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(5).text(checkResult.desc)
										  .css("display","block")
										  .css('color','dodgerblue');
					result_phone = 1;
				}
			});
			
			
			// 위의 모든 결과값
			$('#join_btn').click(function () {
				var result_all = result_id + result_pw + result_name + result_email + result_phone + result_termsCk;
				console.log("id :"+result_id);
				console.log("pw :"+result_pw);
				console.log("name :"+result_name);
				console.log("email :"+result_email);
				console.log("phone :"+result_phone);
				console.log("termsCk :"+result_termsCk);
				if (result_all == 6) {
					$('.join_frm').submit();
				}
				
			});
		});
	</script>
</body>
</html>