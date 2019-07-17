<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/index.css?v=1">
<link rel="stylesheet" href="${path}/resources/css/include/fullpage.css">
<title>SAPUM</title>
</head>
<body>
	<div id="fullpage">
		<!-- scroll1: main page -->
		<div class="info_wrap section">
			<div class="info">
				<span class="info_text">This site offers<br>everyone the opportunity<br>to upload work</span>
			</div>
			<div class="info_line"></div>
			
		</div>

		
		<!-- Scroll2: all works -->
		<div class="sc2_wrap section">
			<div class="sc_title">See all Works.</div>
			<div class="sc_btn">
				<a href="${path}/work/list"><span>VIEW WORK</span></a>
			</div>
		</div>

		<!-- Scroll3: recommend artist -->
		<div class="sc3_wrap section">
			<div class="sc_title">recommend Artist.</div>
			<div class="sc_btn">
				<a href="#"><span>VIEW ARTIST</span></a>
			</div>
		</div>

		<!-- Scroll4: Popular works -->
		<div class="sc4_wrap section">
			<div class="sc_title">Popular works.</div>
			<div class="sc_btn">
				<a href="${path}/work/list?sort_option=best"><span>VIEW WORK</span></a>
			</div>
		</div>
		<%@ include file="include/footer.jsp"%>
	</div>
	<script type="text/javascript" src="${path}/resources/js/fullpage.js"></script>
	<script type="text/javascript">
		// full page를 사용하기위한 초기화코드
		$(document).ready(function() {
		    $('#fullpage').fullpage({
		        //options here
		        licenseKey: 'OPEN-SOURCE-GPLV3-LICENSE',
		        autoScrolling:true,
		        scrollHorizontally: true,
		        navigation: true,
		        navigationPosition: 'right',
		    });
		});
	</script>
</body>
</html>