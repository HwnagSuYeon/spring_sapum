<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/include/common.css?v=1">
<link rel="stylesheet" href="${path}/resources/css/include/header.css?v=1">
<script type="text/javascript" src="${path}/resources/js/jquery.cookie.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- header -->
	<header id="header" class="header">
		<div class="heder_wrap">
			<div class="logo">
				<a href="${path}/">
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
					
					<li><a href="${path}/work/list" class="li3">Gellary</a></li>
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
							<li><a id="logout_btn" href="${path}/member/logout" class="li3">Logout</a></li>
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
				<a href="${path}/member/find" class="forgot"><span>Forgot Password?</span></a>
				<div class="id_save_wrap">
					<input type="checkbox" id="idSaveCheck">
					<span class="save_id_text">아이디 기억하기</span>
				</div>
			</form>
		</div>
	</div>
	
	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {
			 // 인덱스에만 헤더를 fixed로 주기위함
			if(${!empty code}) {
				$('#header').css('position', 'fixed');
			} else {
				$('#header').css('position', 'inherit');
			}
			// 쿠키를 활용한 아이디 저장
			// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		    var key = getCookie("key");
		    $("#login_id").val(key); 
		     
		    if($("#login_id").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		    }
		     
		    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
		            setCookie("key", $("#login_id").val(), 7); // 7일 동안 쿠키 보관
		        }else{ // ID 저장하기 체크 해제 시,
		            deleteCookie("key");
		        }
		    });
		     
		    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		    $("#login_id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
		            setCookie("key", $("#login_id").val(), 7); // 7일 동안 쿠키 보관
		        }
		    });
			
		});
		// 사용할 쿠키에 데이터와 만료일자를 정의함
		function setCookie(cookieName, value, exdays){
		    var exdate = new Date(); // 날짜 객체 생성. 데이터 객체가 exdate에 들어있음
		    exdate.setDate(exdate.getDate() + exdays); // exdate를 값 세팅 = 오늘 일자를 가져와서 일주일(exdays)을 더해줌
		    // escape(value)->받아온 로그인 아이디를 유니코드 형식으로 반환
		    // (exdays==null) -> 일주일 뒤로 세팅한 날짜가 null일때 ""(쿠키를 삭제하지 않는 이상 영구적으로 쿠키가 남아있는 경우임)
		    // null아닐때 -> exdate.toGMTString() = 일주일(exdate)을 국제 표준시로 반환해서 만료일자(expires)를 일주일 뒤로 정함
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    // 이 페이지에서 계속 물고다니는 쿠키에게 쿠키이름(key)이랑 cookieValue(로그인아이디+만료일자)를 넣어줌
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 // 쿠키를 만료시킴
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1); // 해당 쿠키의 만료일을 어제날짜로 설정해, 
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString(); // 쿠키를강제로 만료시킴
		}
		 // 쿠키에 담겨져있는 값을 사용하기 위해 유효 데이터를 빼내기 위한 과정
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName); // 홈페이지에 있는 쿠키를 전부 불러와서 원하는 쿠키를 가져옴(넘겨준 key에 해당하는 아이디)
		    var cookieValue = '';
		    if(start != -1){ // 쿠키 정보가 없을때 = -1  ---> 부정이니까 쿠키정보 있을때
		        start += cookieName.length; // 유저 아이디의 key자체의 길이를 불러와서 start에 더함
		        var end = cookieData.indexOf(';', start); // key이후로 처음으로 만나는 세미콜론. 즉, 다른 쿠키를 썼을때 구분을 위함.
		        if(end == -1)end = cookieData.length; // 쿠키를 사용하는 것이 한개일 때(end == -1), 쿠키의 길이만큼을 end에 넣어줌.
		        cookieValue = cookieData.substring(start, end); // key = user01; 을 받았었는데 여기서 'key='과 ';'를 떼서 필요한 'user01'이라는 데이터만 주기 위함.
		    }
		    return unescape(cookieValue); // 유니코드로 저장한 데이터를 다시 문자열로 반환
		}

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
				$('#login_id').focus();
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
		
		// 로그인 버튼 눌렀을 때 동작(유효성검사 및 ajax기능실행 )
		$('#login_btn').on('click', function () {
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
		
		
		

	</script>
</body>
</html>