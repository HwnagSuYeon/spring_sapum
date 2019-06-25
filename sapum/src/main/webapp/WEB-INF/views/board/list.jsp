<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/board/board.css?v=1">
<title>Insert title here</title>
</head>
<body>
	<!-- 검색창& 작품추가, top버튼 -->
	<div class="btn_wrap">
		<div class="btn">
			<a class="all_btn plus_btn"><i class="fas fa-plus"></i></a>
			<a class="all_btn top_btn"><i class="fas fa-arrow-up"></i></a>
		</div>
	</div>
	<div class="list1_wrap">
		<div class="serch_wrap">
			<h1 class="serch_title">Search for your desired Board</h1>
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

	
	<div class="list_all">
		<!-- board -->
		<div class="board_all">
			<div class="sort_wrap">
				<div id="new" class="sort_box">
					<a href="#"><h3 class="sort_type">NEW</h3></a>
				</div>
				<div id="comment" class="sort_box">
					<a href="#"><h3 class="sort_type">COMMENT</h3></a>
				</div>
				<div id="view" class="sort_box">
					<a href="#"><h3 class="sort_type">VIEW</h3></a>
				</div>
			</div>
			<div class="table">
				<table>
					<tr id="column">
						<td>No</td>
						<td>Title</td>
						<td>Writer</td>
						<td>View</td>
						<td>Date</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>

					<tr class="board_content">
						<td>1</td>
						<td><a href="#" id="con_title">Hellow World</a></td>
						<td>ggugguri</td>
						<td>123</td>
						<td>2019-10-23</td>
					</tr>


					
				</table>
			</div>
		<!--  pagenation -->
			<div class="pagenation">
				<div class="page_all">
					<a href="#" class="num_btn arrow_btn">
						<i class="fas fa-chevron-left"></i>
						<span class="arro_text">Prev</span>
					</a>
					<a href="#" class="num_btn">
						<i class="fas fa-ellipsis-h dot"></i>
					</a>
					<a href="#" class="num_btn now_click">1</a>
					<a href="#" class="num_btn">2</a>
					<a href="#" class="num_btn">3</a>
					<a href="#" class="num_btn">4</a>
					<a href="#" class="num_btn">5</a>
					<a href="#" class="num_btn">6</a>
					<a href="#" class="num_btn">7</a>
					<a href="#" class="num_btn">8</a>
					<a href="#" class="num_btn">9</a>
					<a href="#" class="num_btn">10</a>
					<a href="#" class="num_btn">
						<i class="fas fa-ellipsis-h dot"></i>
					</a>
					<a href="#" class="num_btn arrow_btn">
						<span class="arro_text">Next</span>
						<i class="fas fa-chevron-right"></i> 
					</a>
				</div>
			</div>
		
			
		</div>
		
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		// board List 스크립트
		var search_content = $.trim($('.serch_text').val());
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
			
			//sort_type선택시 선택한것의 색만 바꾸는 기능
			$('#new').click(function() {
				$(this).css('color', '#70D6C7')
						 .css('border-bottom', '3px solid #70D6C7');
				$('.sort_box').not('#new').css('color', '#4c4c4c')
										  .css('border-bottom', '3px solid #4c4c4c');
			});
			$('#comment').click(function() {
				$(this).css('color', '#70D6C7')
					   .css('border-bottom', '3px solid #70D6C7');
				$('.sort_box').not('#comment').css('color', '#4c4c4c')
										  	  .css('border-bottom', '3px solid #4c4c4c');
			});
			$('#view').click(function() {
				$(this).css('color', '#70D6C7')
					   .css('border-bottom', '3px solid #70D6C7');
				$('.sort_box').not('#view').css('color', '#4c4c4c')
										  	  .css('border-bottom', '3px solid #4c4c4c');
			});
		});
	</script>
</body>
</html>