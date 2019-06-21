<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/include/common.css?v=1">
<link rel="stylesheet" href="${path}/resources/css/include/index_header.css?v=1">
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
					<a href="#" class="li1 login_btn"><li>Login</li></a>
					<a href="${path}/member/create" class="li2"><li>Join Us</li></a>
					<a href="#" class="li3"><li>Gellary</li></a>
					<a href="#" class="li2"><li>My page</li></a>
					<a href="#" class="li4"><li>Q&A</li></a>
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
					<a href="#" class="li1 login_btn"><li>Login</li></a>
					<a href="${path}/member/create" class="li2"><li>Join Us</li></a>
					<a href="#" class="li3"><li>Gellary</li></a>
					<a href="#" class="li3"><li>My Page</li></a>
					<a href="#" class="li4"><li>Q&A</li></a>
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
					<input class="ip_border" type="text" name="id" placeholder="User ID">
					<span class="err_msg"></span>
				</div>
				<div class="ip_style ip_pw">
					<input class="ip_border" type="password" name="pw" placeholder="Password">
					<span class="err_msg"></span>
				</div>
				<span class="err_msg"></span>
				<button type="button" class="lo_btn">login</button>
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

		
		$(document).ready(function() {
			//인풋태그 focus시 라인색 바뀜
			$('.ip_border').click(function(){
				$(this).css('border-bottom','1px solid #70D6C7');
			});
			$('.ip_border').blur(function(){
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