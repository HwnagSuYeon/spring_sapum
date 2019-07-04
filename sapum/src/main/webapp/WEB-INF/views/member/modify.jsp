<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<c:if test="${sessionScope.userid == null}">
	<script>
		alert("mypage는 로그인 하신 후 사용하실 수 있습니다.");
		location.href = "${path}/";
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/member/member.css?v=1">
<title>Join</title>
</head>
<body>
	<!-- 회원수정 내용 -->
	<div class="join_wrap">
		<div class="join">
			<div class="jo_title">
				<h1>Edit account</h1>
			</div>
			<form id="modify_frm" class="join_frm" action="${path}/member/modify" method="POST">
				<div class="mem_ipstyle">
					<input id="id_val" class="mem_ipborder" type="text" name="id" placeholder="User ID" readonly="readonly" style="cursor: not-allowed;" value="${info.id}">
					<span class="err_msg_eq id_err_msg"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="pw_val" class="mem_ipborder" type="password" name="pw" placeholder="Password">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="name_val" class="mem_ipborder" type="text" name="name" placeholder="Name" value="${info.name}">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="email_val" class="mem_ipborder" type="email" name="email" placeholder="E-mail(ID)" value="${info.email}">
					<span class="err_msg_eq"></span>
				</div>
				<div class="mem_ipstyle">
					<input id="phone_val" class="mem_ipborder" type="text" name="phone" placeholder="phone" value="${info.phone}">
					<span class="err_msg_eq"></span>
				</div>
				<div id="edit_btn" class="join_btn">EDIT ACCOUNT</div>
			</form>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	<script type="text/javascript" src="${path}/resources/js/validation.js"></script>
	<script type="text/javascript">
		//-----join 스크립트-------
		$(document).ready(function () {
			// 아이디 수정하려 클릭시 경고텍스트 띄어줌
			$('#id_val').click(function () {
				$('.id_err_msg').text('아이디는 수정하실 수 없습니다');
			});
			$('#id_val').blur(function () {
				$('.id_err_msg').css('display','none');
			});
			//---- 유효성 검사: (선택자)에 값을 입력 후 blur하면 이벤트 발생  ----
			//유효성검사가 다 끝났다는 것을 알게 해주는변수가 필요
			var result_pw = 0;
			var result_name = 0;
			var result_email = 0;
			var result_phone = 0;
			
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
			
			
			
			//name
			$("#name_val").blur(function () {
				var name = $.trim($(this).val());
				var checkResult = joinValidate.checkName(name);
				result_name = 0;
				if(checkResult.code != 0) {
					console.log(checkResult.desc);
					$(".err_msg_eq").eq(2).text(checkResult.desc)
									.css("display","block")
									.css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(2).text(checkResult.desc)
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
					$(".err_msg_eq").eq(3).text(checkResult.desc)
									.css("display","block")
									.css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(3).text(checkResult.desc)
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
					$(".err_msg_eq").eq(4).text(checkResult.desc)
										  .css("display","block")
										  .css('color','tomato');
					return false;
				} else {
					$(".err_msg_eq").eq(4).text(checkResult.desc)
										  .css("display","block")
										  .css('color','dodgerblue');
					result_phone = 1;
				}
			});
			
			
			// 위의 모든 결과값
			$('#join_btn').click(function () {
				var result_all = result_pw + result_name + result_email + result_phone;
				console.log("pw :"+result_pw);
				console.log("name :"+result_name);
				console.log("email :"+result_email);
				console.log("phone :"+result_phone);
				if (result_all == 4) {
					$('.join_frm').submit();
				}
				
			});
			
			// 폼태그 서브밋
			$('#edit_btn').click(function () {
				$('#modify_frm').submit();
			});
		});
	</script>
</body>
</html>