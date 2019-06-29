<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/work/work.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 검색창& 작품추가, top버튼 -->
	<div class="btn_wrap">
		<div class="btn">
			<a class="all_btn plus_btn" href="${path}/work/create"><i class="fas fa-plus"></i></a>
			<a class="all_btn top_btn"><i class="fas fa-arrow-up"></i></a>
		</div>
	</div>
	<div class="list1_wrap">
		<div class="serch_wrap">
			<h1 class="serch_title">Search for your desired work</h1>
			<form class="search_frm" action="" method="" name="">
				<div class="se_in_div">
					<input class="serch_text" type="text" name="" placeholder="Search works">
					<select class="select_box" name="search_option">
					    <option value="title">Title</option>
					    <option value="content">Content</option>
					    <option value="all" selected="selected">Title+Content</option>
				    	<option value="writer">Writer</option>
					</select>
				</div>
				<a href="#" class="serch_btn"><i class="fas fa-search"></i></a>
			</form>
		</div>
	</div>

	<!-- list정렬 anker태그 -->
	<div class="sort_all">
		<a href="#" class="sort_a"><h1 class="sort_tilte defualt">All works</h1></a>
		<a href="#" class="sort_a"><h1 class="sort_tilte reco">Recommend artist</h1></a>
		<a href="#" class="sort_a"><h1 class="sort_tilte popu">popular works</h1></a>
		<a href="#" class="sort_a"><h1 class="sort_tilte popu">new works</h1></a>
	</div>
	

	<!-- 작품 list -->
	<div class="new_wrap list_wrap">
		<div class="new_content">
			<div class="new_container">
				<div class="ne_con_wrap work_hover">
					<div class="img_wrap">
						<a href="#"><img class="object_container" src="${path}/resources/img/main.jpg"></a>
					</div>
					<div class="text_wrap">
						<a href="#"><span class="work_user">lalla</span></a><br>
						<span class="work_text">2019-04-24 16:00:00</span>
					</div>
				</div>

				<div class="ne_con_wrap work_hover">
					<div class="img_wrap">
						<a href="#"><img class="object_container" src="${path}/resources/img/sc3.jpg"></a>
					</div>
					<div class="text_wrap">
						<a href="#"><span class="work_user">ggugguri</span></a><br>
						<span class="work_text">2019-04-24 16:00:00</span>
					</div>
				</div>

				<div class="ne_con_wrap work_hover">
					<div class="img_wrap">
						<a href="#"><img class="object_container" src="${path}/resources/img/sc3.jpg"></a>
					</div>
					<div class="text_wrap">
						<a href="#"><span class="work_user">kim</span></a><br>
						<span class="work_text">2019-04-24 16:00:00</span>
					</div>
				</div>

				<div class="ne_con_wrap work_hover">
					<div class="img_wrap">
						<a href="#"><img class="object_container" src="${path}/resources/img/main.jpg"></a>
					</div>
					<div class="text_wrap">
						<a href="#"><span class="work_user">lalla</span></a><br>
						<span class="work_text">2019-04-24 16:00:00</span>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!--  pagenation -->
	<div class="pagenation">
		<div class="prev">
			<a href="#"><img src="${path}/resources/img/pre.png"></a>
		</div>
		<div class="center_line">
			<span class="ce_line"></span>
		</div>
		<div class="next">
			<a href="#"><img src="${path}/resources/img/ne.png"></a>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	
	<script type="text/javascript">
	// 메인갤러리 스크립트
	$(document).ready(function() {
		// 검색버튼 누르면 색 들어오고 가로로 길어지게 하는 기능 수행
		$('.serch_text').click(function() {
			$('.se_in_div').css('width','300px')
				   		   .css('border', '2px solid #70D6C7');
		});
		$('.serch_text').blur(function() {
			if (search_content != null) {
				$('.se_in_div').css('width','300px')
		   		   			   .css('border', '2px solid #70D6C7');
			} else if (search_content == null || search_content == "") {
				$('.se_in_div').css('width','200px')
				   			   .css('border', '1px solid #dadada');
			}
		});
		// 정렬타입 선택시 가운데선 그어지고 없어지고
		$('.defualt').click(function() {
			$('.reco').css('text-decoration-line', 'none');
			$('.popu').css('text-decoration-line', 'none');
			$(this).css('text-decoration-line', 'line-through');
		});
		$('.reco').click(function() {
			$('.defualt').css('text-decoration-line', 'none');
			$('.popu').css('text-decoration-line', 'none');
			$(this).css('text-decoration-line', 'line-through');
		});
		$('.popu').click(function() {
			$('.defualt').css('text-decoration-line', 'none');
			$('.reco').css('text-decoration-line', 'none');
			$(this).css('text-decoration-line', 'line-through');
		});


		//타이틀 쓰는부분 클릭하면 라인 색 바뀌게
		$('.upload_title').click(function() {
			$(this).css('border-bottom','1px solid #70D6C7');
		});
		$('.upload_title').blur(function() {
			$(this).css('border-bottom','1px solid #eaeaea');
		});
		//설명쓰는 박스 크기 키웠다가 줄어들었다가
		$('.comm_inp').focus(function() {
			$(this).css('border', '1px solid #70D6C7')
				   .css('height', '90px');
		});
		$('.comm_inp').blur(function() {
			$(this).css('border', '1px solid #EAEAEA')
				   .css('height', '30px');
		});
	});

	</script>
</body>
</html>