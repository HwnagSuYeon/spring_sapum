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
					<input id="email_val" class="mem_ipborder" type="email" name="email" placeholder="E-mail(ID)">
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
					<input class="mem_ipborder" type="text" name="phone" placeholder="phone">
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
			$('#email_val').blur(function () {
				//2. input(#id) value값을 가져와 memId에 담는다
				var memId = $.trim($('#email_val').val());
				//3.joinValidate의 checkId()함수를 실행, memId를 매개변수로 validation.js로 보냄
				//7.checkId()함수를 실행 후 결과값 code와 desc를 변수 checkResult에 담음.
				var checkResult = joinValidate.checkId(memId);
				
				
				if(checkResult.code != 0) {
					console.log(checkResult.desc);
					//8-1.(실패일 경우)code값이 0이 아닌경우->유효한 값이 아님(경고메세지 출력)
					$(".err_msg_eq").eq(0).text(checkResult.desc)
									   .css("display","block");
					return false;
				} else {
					//8-2.(성공일경우)code값이 0인 경우 ->유효한 값(중복값인지 Ajax로 검증 시작!)
					//9. ajaxCheck()메서드 실행, memId를 매개변수로 보냄
					// 31. ajaxCheck(memId)의 return값이 1 이면 return true;
					if(ajaxCheck(memId) == "1") {
						return true;
					}
				}
				// 중복된 값은 무조건 false를 반환하기 위해서 return flase를 맨 뒤에 써주는 것.
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
		});
	</script>
</body>
</html>