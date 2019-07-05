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
			<a href="${path}/board/create" class="all_btn plus_btn"><i class="fas fa-plus"></i></a>
			<a id="topBtn" class="all_btn top_btn"><i class="fas fa-arrow-up"></i></a>
		</div>
	</div>
	<div class="list1_wrap">
		<div class="serch_wrap">
			<h1 class="serch_title">Search for your desired Board</h1>
			<form class="search_frm" action="" method="" name="">
				<div class="se_in_div">
					<input class="serch_text" type="text" name="keyword" placeholder="Search works">
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
		<div class="board_all" id="pin">
			<div class="sort_wrap">
				<div id="new" class="sort_box">
					<a href="${path}/board/list?sort_option=new&keyword=${map.keyword}&search_option=${map.serch_option}"><h3 class="sort_type">NEW</h3></a>
				</div>
				<div id="comment" class="sort_box">
					<a href="${path}/board/list?sort_option=reply&keyword=${map.keyword}&search_option=${map.serch_option}"><h3 class="sort_type">COMMENT</h3></a>
				</div>
				<div id="view" class="sort_box">
					<a href="${path}/board/list?sort_option=view&keyword=${map.keyword}&search_option=${map.serch_option}"><h3 class="sort_type">VIEW</h3></a>
				</div>
			</div>
			<c:if test="${!empty map.keyword}">
				<div class="search_msg">
					<span class="keyword_col">"${map.keyword}"</span>로 검색한 결과는 총 
					<span class="keyword_col">&nbsp;${map.count}</span>건입니다.
				</div>
			</c:if>
			<div class="table">
				<table>
					<tr id="column">
						<td>No</td>
						<td>Title</td>
						<td>Writer</td>
						<td>View</td>
						<td>Date</td>
					</tr>
					
					<c:forEach items="${map.list}" var="bDto">
						<!-- 현재시간 구하기(변수명now) -->
						<jsp:useBean id="now" class="java.util.Date"/>
						<!-- 날짜포맷형식 변경 -->
						<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
						<!-- bDto내의 regdate(게시글 등록일)정보 포맷형식 변경 -->
						<fmt:formatDate value="${bDto.regdate}" pattern="yyyy-MM-dd" var="regdate"/>
					
						<tr class="board_content">
							<td>${bDto.bno}</td>
							<td class="list_title">
								<c:forEach begin="1" end="${bDto.re_level}">
									<i id="re_icon" class="fas fa-reply"></i>
								</c:forEach>
								<a href="${path}/board/view?bno=${bDto.bno}" id="con_title">${bDto.title}</a>
								<!-- 오늘날짜와 게시글 작성일이 일치하면 새 게시글 아이콘 띄워줌 -->
								<c:if test="${today == regdate}">
									<span class="new_icon"></span>
								</c:if>
								<!-- 댓글이 한개라도 있으면 띄워주는 아이콘 -->
								<c:if test="${bDto.replycnt > 0}">
									<span class="reply_icon"></span>
								</c:if>
							</td>
							<td>${bDto.writer}</td>
							<td>${bDto.viewcnt}</td>
							<td>
								<!-- 게시글 등록일이 오늘일경우 시분초, 오늘이 아니면 년월일로 띄워주게함 -->
								<c:choose>
									<c:when test="${today == regdate}">
										<fmt:formatDate pattern="hh:mm:ss" value="${bDto.regdate}"/>
									</c:when>
									<c:otherwise>
										<fmt:formatDate pattern="yyyy-MM-dd" value="${bDto.regdate}"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		<!--  pagenation -->
			<div class="pagenation">
				<div class="page_all">
				
					<c:if test="${map.pager.curBlock > 1}">
						<a class="num_btn arrow_btn" href="${path}/board/list?curPage=${map.pager.blockBegin-10}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}">
							<i class="fas fa-chevron-left"></i>
							<span class="arro_text">Prev</span>
						</a>
						<a href="#" class="num_btn">
							<i class="fas fa-ellipsis-h dot"></i>
						</a>
					</c:if>
					
					<c:forEach begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}" var="idx">
						<a class="num_btn <c:out value="${map.pager.curPage == idx ? 'active': '' }"/>" href="${path}/board/list?curPage=${idx}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}" >${idx}</a>
					</c:forEach>
					
					<c:if test="${map.pager.curBlock < map.pager.totBlock}">
						<a href="#" class="num_btn">
							<i class="fas fa-ellipsis-h dot"></i>
						</a>
						<a href="${path}/board/list?curPage=${map.pager.blockEnd+1}&sort_option=${map.sort_option}&keyword=${map.keyword}&search_option=${map.search_option}" class="num_btn arrow_btn">
							<span class="arro_text">Next</span>
							<i class="fas fa-chevron-right"></i> 
						</a>
					</c:if>
				</div>
			</div>
		
			
		</div>
		
	</div>
	<%@ include file="../include/footer.jsp"%>
	
	<script type="text/javascript">
		// board List 스크립트
		var search_content = $.trim($('.serch_text').val());
		$(document).ready(function() {
			// sort_option클릭시 top으로 가는 것을 막
			location.href = "#pin";
			// top버튼을 클릭하면 위로 올라감
			$(window).scroll(function () {
				var scrollValue = $(this).scrollTop();
				if(scrollValue > 100){
					$('#topBtn').fadeIn();	
				} else {
					$('#topBtn').fadeOut();
				}
			});
			$('#topBtn').click(function () {
				$('html, body').animate({scrollTop:0}, 100);
			});
			
			// 검색버튼 누르면 색 들어오고 가로로 길어지게 하는 기능 수행
			$('.serch_text').click(function() {
				$('.se_in_div').css('width','670px')
					   		   .css('border', '2px solid #70D6C7');
			});
			$('.serch_text').blur(function() {
				if (search_content != null) {
					$('.se_in_div').css('width','460px')
			   		   			   .css('border', '2px solid #70D6C7');
				} else if (search_content == null || search_content == "") {
					$('.se_in_div').css('width','460px')
					   			   .css('border', '1px solid #dadada');
				}
			});
			
			//sort_type선택시 선택한것의 색만 바꾸는 기능
			var sort_option = "${map.sort_option}"
			if (sort_option == "new") {
				$('#new').css('color', '#70D6C7')
				 	   .css('border-bottom', '3px solid #70D6C7');
			} else if (sort_option == "reply") {
				$('#comment').css('color', '#70D6C7')
			 	   .css('border-bottom', '3px solid #70D6C7');
			} else if (sort_option == "view") {
				$('#view').css('color', '#70D6C7')
			 	   .css('border-bottom', '3px solid #70D6C7');
			}
			
			$('.serch_btn').click(function () {
				// 검색버튼 누르면 검색어 유효성체크 및 데이터 넘겨주는 부분
				var search_option = $('.select_box').val();
				var keyword = $.trim($('.serch_text').val());
				
				if(keyword == null || keyword == "") {
					$('.serch_text').focus();
					return false;
				}
				location.href = "${path}/board/list?search_option="+search_option+"&keyword="+keyword;
			});
		});
	</script>
</body>
</html>