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
					<input class="serch_text work_search" type="GET" name="keyword" placeholder="Search works">
					<select class="select_box" name="search_option">
					    <option value="title">Title</option>
					    <option value="content">Content</option>
					    <option value="all" selected="selected">Title+Content</option>
				    	<option value="writer">Writer</option>
					</select>
				</div>
				<a href="#" id="work_search" class="serch_btn"><i class="fas fa-search"></i></a>
			</form>
		</div>
	</div>

	<!-- list정렬 anker태그 -->
	<div class="sort_all">
		<a href="${path}/work/list?sort_option=new&keyword=${map.keyword}&search_option=${map.seaarch_option}" class="sort_a"><h1 class="sort_tilte defualt">New works</h1></a>
		<a href="${path}/work/list?sort_option=best&keyword=${map.keyword}&search_option=${map.seaarch_option}" class="sort_a"><h1 class="sort_tilte popu">Best Works</h1></a>
		<a href="#" class="sort_a"><h1 class="sort_tilte reco">Recommend artist</h1></a>
	</div>
	<c:if test="${!empty map.keyword}">
		<div class="search_msg">
			<span class="keyword_col">"${map.keyword}"</span>로 검색한 결과는 총 
			<span class="keyword_col">&nbsp;${map.count}</span>건입니다.
		</div>
	</c:if>
	

	<div class="new_wrap list_wrap">
		<div class="new_content">
			<div class="new_container">
				
				<div class="grid_wrap">
					<c:forEach items="${map.list}" var="wDto">
						<div class="ne_con_wrap work_hover">
							<div class="img_wrap">
								<a href="${path}/work/view?wno=${wDto.wno}"><img class="object_container" src="${path}/resources/img/${wDto.w_img}"></a>
							</div>
							<div class="text_wrap">
								<a href="${path}/work/view?wno=${wDto.wno}"><span class="work_user">${wDto.title}</span></a><br>
								
								<!-- 시간포맷 -->
								<jsp:useBean id="now" class="java.util.Date"/>
								<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
								<fmt:formatDate value="${best.regdate}" pattern="yyyy-MM-dd" var="regdate"/>
								
								<c:choose>
									<c:when test="${today == regdate}">
										<span class="work_text"><fmt:formatDate value="${wDto.regdate}" pattern="hh:mm:ss"/></span>
									</c:when>
									<c:otherwise>
										<span class="work_text"><fmt:formatDate value="${wDto.regdate}" pattern="yyyy-MM-dd"/></span>
									</c:otherwise>
								</c:choose>
								
							</div>
						</div>
					</c:forEach>
				</div>
				

				
			</div>
		</div>
	</div>

	
	<!--  pagenation -->
	<div class="pagenation">
		<!-- 이전페이지보기 버튼을 나타내는 경우 -->
		<c:choose>
			<c:when test="${map.pager.curPage > 1}">
				<div class="prev">
					<a href="${path}/work/list?curPage=${map.pager.curPage-1}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}">
						<img class="page_icon" src="${path}/resources/img/pre_on.png">
					</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="prev">
					<a href="${path}/work/list?curPage=${map.pager.curPage-1}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}">
						<img class="page_icon" src="${path}/resources/img/pre_off.png">
					</a>
				</div>
			</c:otherwise>
		</c:choose>
		
		<div class="center_line">
			<span class="ce_line"></span>
		</div>
		
		<!-- 다음페이지보기 버튼을 나타내는 경우 -->
		<c:choose>
			<c:when test="${map.pager.curPage < map.pager.totPage}">
				<div class="next">
					<a href="${path}/work/list?curPage=${map.pager.curPage+1}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}">
						<img class="page_icon" src="${path}/resources/img/ne_on.png">
					</a>
				</div>
			</c:when>
			
			<c:otherwise>
				<div class="next">
					<a href="${path}/work/list?curPage=${map.pager.curPage+1}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}">
						<img class="page_icon" src="${path}/resources/img/ne_off.png">
					</a>
				</div>
			</c:otherwise>
		</c:choose>
		
		
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
		
		// 검색버튼 누르면 서치옵션과 키워드를 컨트롤러로 보냄
		$('#work_search').click(function () {
			var search_option = $('.select_box').val();
			var keyword = $.trim($('.work_search').val());
			
			if(keyword == null || keyword.length == 0) {
				$('.work_search').focus();
				return false;
			}
			location.href = "${path}/work/list?search_option="+search_option+"&keyword="+keyword;
		});
		
	});

	</script>
</body>
</html>