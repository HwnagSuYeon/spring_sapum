<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/include/common.css?v=1">
<link rel="stylesheet" href="${path}/resources/css/include/header.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- header -->
	<header class="header">
		<div class="heder_wrap">
			<div class="logo">
				<a href="#">
					<img src="${path}/resources/img/color_logo.svg" style="width: 70px;">
				</a>
			</div>
			<div class="index_list">
				<ul class="list">
					<c:choose>
						<c:when test="${empty sessionScope.name}">
							<li><a href="#" class="li1 login_btn">Login</a></li>
							<li><a href="${path}/member/create" class="li2">Join Us</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#" class="li3" style="color: #70D6C7; font-weight: bold; text-decoration: none;">${sessionScope.name}</a></li>
							<li><a id="logout_btn" href="#" class="li3">Logout</a></li>
							<li><a href="${path}/member/mypage" class="li2">My page</a></li>
						</c:otherwise>
					</c:choose>
					
					<li><a href="#" class="li3">Gellary</a></li>
					<li><a href="${path}/board/list" class="li4">Q&A</a></li>
				</ul>
			</div>
			<div class="controls" style="display: none;">
				<a class="menu-trigger" href="#">
				    <span></span>
				    <span></span>
				    <span></span>
				</a>
			</div>
		</div>
		<!-- 햄버거버튼 누르면 나오는 인덱스 리스트 -->
		<div class="ham_wrap" style="display: none;">
			<div class="ham_index">
				<ul class="index_wrap">
					<!-- jstl/el을 활용한 로그인유저/게스트유저 nav bar디자인 변경  -->
					<c:choose>
						<c:when test="${empty sessionScope.name}">
							<li><a href="#" class="li1 login_btn">Login</a></li>
							<li><a href="${path}/member/create" class="li2">Join Us</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="#" class="li3" style="font-weight: bold;">${sessionScope.name}</a></li>
							<li><a href="#" class="li3">My Page</a></li>
							<li><a id="logout_btn" href="#" class="li3">Logout</a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="#" class="li3">Gellary</a></li>
					<li><a href="${path}/board/list" class="li4">Q&A</a></li>
				</ul>
			</div>
			<div class="ham_footer">
				<ul class="ft">
					<li><a href="https://twitter.com/?lang=ko"><i class="fab fa-twitter in-icon1"></i></a></li>
					<li><a href="https://www.pinterest.co.kr/"><i class="fab fa-pinterest-square in-icon2"></i></a></li>
					<li><a href="https://www.instagram.com/?hl=ko"><i class="fab fa-instagram in-icon3"></i></a></li>
				</ul>
			</div>
		</div>
	</header>
	<div class="header_box"></div>
	<!-- login modal -->
	<div class="lo_modal" style="display: none;">
		<div class="modal_box">
			<form class="modal_wrap" action="" method="" name="">
				<span class="lo_modal_close"><i class="fas fa-times"></i></span>
				<h1 class="lo_modal_title">Signin</h1>
				<div class="ip_style ip_id">
					<input id="login_id" class="ip_border" type="text" name="id" placeholder="User ID">
				</div>
				<div class="ip_style ip_pw">
					<input id="login_pw" class="ip_border" type="password" name="pw" placeholder="Password">
				</div>
				<span class="modal_err_msg"></span>
				<button id="login_btn" type="button" class="lo_btn">login</button>
				<a href="#" class="forgot"><span>Forgot Password?</span></a>
			</form>
		</div>
	</div>
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script type="text/javascript">
		// --------------------header에 반드시 필요한 스크립트----------------------
		// 햄버거버튼 메뉴 동작
		var burger = $('.menu-trigger');

		burger.each(function(index){
				var $this = $(this);

    		$this.on('click', function(e){
        		e.preventDefault();
        	$(this).toggleClass('active-' + (index+1));
    		})
		});
		$(window).resize(function() {
			// 창 사이즈가 작아지면 header list가 햄버거버튼으로 바뀜
			if($(window).width() <980) {
				// 창 사이즈가 980 미만일경우
				$('.index_list').css('display','none');
				$('.controls').css('display', 'block')
							  .css('transition', '.3s');
			} else {
				// 창 사이즈가 980 이상일경우
				$('.index_list').css('display','block')
								.css('transition', '.3s');
				$('.controls').css('display', 'none');
			}
		});

		var flag = 0;
		// 햄버거버튼 누르면 나오는 인덱스
		$('.menu-trigger').on('click', function(){
			if(flag == 0) {
				$('.ham_wrap').css('display', 'block');
				$('.info').css('display', 'none');
				flag = 1;
			} else if(flag == 1){
				$('.ham_wrap').css('display', 'none');
				$('.info').css('display','block');
				flag = 0;
			}
			
		});

		// 로그인 성공시 어디로갈지 알려주는 경로(인터셉터에서 경로 보내줌)
		var message = '${message}';
		var uri = '${uri}';
		
		
		$(document).ready(function() {
			//인풋태그 focus시 라인색 바뀜
			$('.ip_style').click(function(){
				$(this).css('border-bottom','1px solid #70D6C7');
			});
			$('.ip_style').blur(function(){
				$(this).css('border-bottom','1px solid #dadada');
			});

			// login누르면 모달창 나오게
			$('.login_btn').click(function() {
				$('.lo_modal').css('display','flex');
			});
			$('.lo_modal_close').click(function(){
				$('.lo_modal').css('display','none');
			});
			
			// 햄버거버튼 누르면 나오는애스크롤 안내려가게함
			$(window).scroll(function(){
				if (flag == 1) {
					scrollTop().val(scrollVal);
				}
			});
			// 로그인 인되었을 때 
			if (message == "nologin") {
				$('.lo_modal').css('display','flex');
				$('.modal_err_msg').text('로그인이 필요한 기능입니다.');
			}
			// 로그인 버튼 눌렀을 때 동작(유효성검사 및 ajax기능실행 )
			$('#login_btn').click(function () {
				var id = $.trim($('#login_id').val());
				var pw = $.trim($('#login_pw').val());
				
				var regEmpty = /\s/g; //공백문자 정규식
				// null+공백체크 유효성 검사
				if (id==null||id.length == 0) {
					$('.modal_err_msg').text('필수정보 입니다')
								 .css('display','block');
					return false;
				} else if (id.match(regEmpty)){
					$('.modal_err_msg').text('공백없이 입력해주세요')
					 			 .css('display','block');
					return false;
				}
				
				if (pw==null||pw.length == 0) {
					$('.modal_err_msg').text('필수정보 입니다')
								 .css('display','block');
					return false;
				} else if (pw.match(regEmpty)){
					$('.modal_err_msg').text('공백없이 입력해주세요')
					 			 .css('display','block');
					return false;
				}
				// 로그인동작 실행  
				$.ajax({
					url: "${path}/member/login",
					type: "POST",
					dataType: "text",
					// return데이터의 타입. controller에서 로그인 정보를 체크한후 반환해주는 타입이 String, 즉 문자열이므로 데이터타입을 text로 써준다.
					data: "id="+id+"&pw="+pw,
					success: function(data) {
						if(data == "1") {
							if(uri == '') {
								location.reload();
							} else {
								location.href = uri;
							}
						} else if (data == "-1") {
							$('#login_id').focus();
							$('.modal_err_msg').text('아이디 또는 비밀번호가 일치하지 않습니다!')
										 	   .css('display','block');
						}
					},
					error:function(){
						alert("system error♨♨♨")
					}
				});
			});
			
			// 로그아웃 기능
			$('#logout_btn').click(function () {
				$.ajax({
					url: "${path}/member/logout",
					type: "POST",
					success: function() {
						location.reload();
					},
					error: function () {
						alert("system error♨♨♨");
					}
				});
			});
		});
		
		// 햄버거버튼 누를시 나오는 창에서 스크롤 제어
		$('.ham_wrap').on('scroll touchmove mousewheel', function(e) {
		   e.preventDefault();
		   e.stopPropagation(); 
		   return false;
		});

	</script>
</body>
</html>